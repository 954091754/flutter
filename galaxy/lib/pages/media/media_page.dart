import 'package:flutter/material.dart';

import 'sections/movie/movie_page.dart';
import 'sections/tv_page.dart';
import 'sections/variety_page.dart';
import 'sections/book_page.dart';
import 'sections/music_page.dart';
import 'sections/local_page.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> with SingleTickerProviderStateMixin {

  final List<String> _titles = ['电影', '电视', '综艺', '读书', '音乐', '同城'];

  late final List<Widget> _sections = [
    const MoviePage(),
    const TvPage(),
    const VarietyPage(),
    const BookPage(),
    const MusicPage(),
    const LocalPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _titles.length,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // Sliver for the search bar that fades when scrolled
                SliverPersistentHeader(
                  pinned: false,
                  floating: false,
                  delegate: _SearchBarHeaderDelegate(
                    // reduced by ~1/3: previous (56,80) -> now approximately (40,54)
                    minExtent: 40,
                    maxExtent: 64,
                  ),
                ),

                // Pinned TabBar so it will stick to the top
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: _TabBarHeaderDelegate(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.blue,
                        indicatorWeight: 2,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black87,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                        dividerColor: Colors.transparent,
                        dividerHeight: 0,
                        tabAlignment: TabAlignment.start,
                        tabs: _titles.map((t) => Tab(text: t)).toList(),
                      ),
                    ),
                    minExtent: 48,
                    maxExtent: 48,
                  ),
                ),
              ];
            },

            body: TabBarView(
              children: _sections.map((w) {
                // Ensure each section is scrollable so NestedScrollView can coordinate
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // keep a bit of top spacing to separate from TabBar
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: w,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}


class _SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;

  _SearchBarHeaderDelegate({required this.minExtent, required this.maxExtent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (1.0 - (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0));
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Opacity(
        opacity: t,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: '用一部电影来形容您的2025',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchBarHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minExtent;
  final double maxExtent;

  _TabBarHeaderDelegate({required this.child, required this.minExtent, required this.maxExtent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
  }
}
