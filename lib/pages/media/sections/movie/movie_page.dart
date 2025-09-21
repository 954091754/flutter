import 'dart:async';

import 'package:flutter/material.dart';
import 'movie_page_item_stars.dart';
import 'movie_detail_page.dart';
import '../../../../models/movie.dart';
import '../../../../services/movie_service.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final List<String> _banners = [
    'assets/images/banner_blsj.jpeg',
    'assets/images/banner_pfzy.jpeg',
    'assets/images/banner_qz.jpeg',
  ];

  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  int _selectedSegment = 0; // 0: 影院热映, 1: 即将上映
  late final Future<List<Movie>> _moviesFuture;
  final _movieService = MovieService();

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton(String label, int idx) {
    final selected = _selectedSegment == idx;
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedSegment = idx;
        });
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: selected ? 16 : 14,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? Colors.black : Colors.black54,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // kick off loading local mock movies
    _moviesFuture = _movieService.loadLocalMovies();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % _banners.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildMovieGridItem(Map<String, dynamic> item) {
    return LayoutBuilder(builder: (context, constraints) {
      // compute available heights for image and the rest
      final totalH = constraints.maxHeight;
      // estimated heights for title and stars (tuned)
      const titleH = 18.0;
      const starH = 14.0;
      const gaps = 6.0 + 4.0 + 6.0; // top gap + between title/star + bottom breathing room
      double imageH = totalH - (titleH + starH + gaps);
      if (imageH < 40) {
        // fallback to proportional height if available space is too small
        imageH = totalH * 0.65;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: imageH,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                item['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item['title'],
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // stars aligned to the left of the title
          Row(
            children: [
              MoviePageItemStars(score: (item['rating'] as double), size: 12),
              const SizedBox(width: 6),
              Text(
                '${(item['rating'] as double).toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuItem(context, Icons.search, '找电影', () {
                  // TODO: navigate or show search
                }),
                const SizedBox(width: 8),
                _buildMenuItem(context, Icons.trending_up, '豆瓣榜单', () {
                  // TODO: open charts
                }),
                const SizedBox(width: 8),
                _buildMenuItem(context, Icons.help_outline, '豆瓣猜', () {
                  // TODO: guess feature
                }),
                const SizedBox(width: 8),
                _buildMenuItem(context, Icons.local_activity, '豆瓣票单', () {
                  // TODO: ticket list
                }),
              ],
            ),
          ),

          const SizedBox(height: 12),
          // Scrolling banner (auto-play)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _banners.length,
                      onPageChanged: (idx) => setState(() => _currentPage = idx),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            // try to get the movie for this banner index from the loaded movies
                            try {
                              final movies = await _moviesFuture;
                              if (!mounted) return; // avoid using context after dispose
                              if (movies.isNotEmpty && index < movies.length) {
                                final movie = movies[index];
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => MovieDetailPage(
                                    title: movie.title,
                                    image: movie.image,
                                    rating: movie.rating,
                                  ),
                                ));
                                return;
                              }
                            } catch (_) {
                              // ignore and fallback
                            }

                            // fallback: create a minimal MovieDetailPage using banner image
                            if (!mounted) return;
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => MovieDetailPage(
                                title: '电影',
                                image: _banners[index],
                                rating: 0.0,
                              ),
                            ));
                          },
                          child: Image.asset(
                            _banners[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // simple dots indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_banners.length, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == i ? 10 : 6,
                      height: _currentPage == i ? 10 : 6,
                      decoration: BoxDecoration(
                        color: _currentPage == i ? Colors.blue : Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Section header: left small menu (as buttons) + right '全部 >'
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // Left two toggle buttons
                Row(
                  children: [
                    _buildSegmentButton('影院热映', 0),
                    const SizedBox(width: 12),
                    _buildSegmentButton('即将上映', 1),
                  ],
                ),
                const Spacer(),
                // Right '全部 >'
                InkWell(
                  onTap: () {
                    // TODO: navigate to full list
                  },
                  child: Row(
                    children: const [
                      Text('全部', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      SizedBox(width: 6),
                      Icon(Icons.chevron_right, size: 20, color: Colors.black54),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Dynamic-height grid: compute childAspectRatio so each item is tall
          LayoutBuilder(builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            const horizontalPadding = 0.0; // match other paddings
            const crossAxisCount = 3;
            const crossAxisSpacing = 10.0;

            final availableWidth = screenWidth - horizontalPadding * 2;
            final itemWidth = (availableWidth - (crossAxisCount - 1) * crossAxisSpacing) / crossAxisCount;

            // image aspect ratio is 2:3 (width:height = 2/3), so height = width * 1.5
            final imageHeight = itemWidth * 1.5;
            const titleHeight = 16.0;
            const starHeight = 12.0;
            // vertical gaps used in _buildMovieGridItem: SizedBox(6) + SizedBox(4) + some breathing room
            const verticalGaps = 6.0 + 4.0 + 6.0;
            final totalHeight = imageHeight + titleHeight + starHeight + verticalGaps;
            final childAspectRatio = itemWidth / totalHeight;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: crossAxisSpacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: 0, // replaced by FutureBuilder below
                itemBuilder: (context, index) {
                  return const SizedBox.shrink();
                },
              ),
            );
          }),
          // Load movies from local json and display grid when ready
          FutureBuilder<List<Movie>>(
            future: _moviesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(child: Text('加载失败: ${snapshot.error}')),
                );
              }
              final movies = snapshot.data ?? <Movie>[];
              // reuse earlier grid calculation by wrapping in LayoutBuilder
              return LayoutBuilder(builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                const horizontalPadding = 0.0; // match other paddings
                const crossAxisCount = 3;
                const crossAxisSpacing = 10.0;

                final availableWidth = screenWidth - horizontalPadding * 2;
                final itemWidth = (availableWidth - (crossAxisCount - 1) * crossAxisSpacing) / crossAxisCount;

                // image aspect ratio is 2:3 (width:height = 2/3), so height = width * 1.5
                final imageHeight = itemWidth * 1.5;
                const titleHeight = 16.0;
                const starHeight = 12.0;
                // vertical gaps used in _buildMovieGridItem: SizedBox(6) + SizedBox(4) + some breathing room
                const verticalGaps = 6.0 + 4.0 + 6.0;
                final totalHeight = imageHeight + titleHeight + starHeight + verticalGaps;
                final childAspectRatio = itemWidth / totalHeight;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: crossAxisSpacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final item = movies[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => MovieDetailPage(
                              title: item.title,
                              image: item.image,
                              rating: item.rating,
                            ),
                          ));
                        },
                        child: _buildMovieGridItem({'title': item.title, 'image': item.image, 'rating': item.rating}),
                      );
                    },
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
