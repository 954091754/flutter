import 'package:flutter/material.dart';

import 'sections/movie_page.dart';
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
        child: Column(
          children: [
            // Search bar with horizontal padding 16
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: '用一部电影来形容您的2025',
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 48,
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

            const SizedBox(height: 12),

            Expanded(
              child: TabBarView(
                children: _sections,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
