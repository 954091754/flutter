import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AnimationDemoPage.dart';

class AnimationListPage extends StatelessWidget {
  const AnimationListPage({super.key});

  static const List<String> demos = [
    'Fade',
    'Scale',
    'Rotate',
    'Slide',
    'AnimatedContainer',
    'Hero',
    'Staggered',
    'AnimatedBuilder',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画示例'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: demos.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final name = demos[index];
          return ListTile(
            title: Text(name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => AnimationDemoPage(type: name),
            )),
          );
        },
      ),
    );
  }
}
