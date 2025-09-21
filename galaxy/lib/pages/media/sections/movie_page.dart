import 'dart:async';

import 'package:flutter/material.dart';

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
                        return Image.asset(
                          _banners[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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

          const Divider(height: 1),

          // Placeholder content below the menu
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                8,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(child: Text('占位卡片 ${i + 1}')),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
