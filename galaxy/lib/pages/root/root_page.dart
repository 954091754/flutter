import 'package:flutter/material.dart';
import '../media/media_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('首页', style: TextStyle(fontSize: 20))),
    const MediaPage(),
    const Center(child: Text('小组', style: TextStyle(fontSize: 20))),
    const Center(child: Text('市集', style: TextStyle(fontSize: 20))),
    const Center(child: Text('我', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: '书影音'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '小组'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: '市集'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我'),
        ],
      ),
    );
  }
}
