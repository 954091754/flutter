import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BluetoothPage.dart';
import 'AnimationPage.dart';
import 'DetailPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, String>> _items = [
    {"title": "蓝牙连接", "subtitle": "连接蓝牙设备并管理通信"},
    {"title": "动画研究", "subtitle": "探索 Flutter 动画与性能优化"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            title: Text(item['title'] ?? ''),
            subtitle: Text(item['subtitle'] ?? ''),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              final title = item['title'] ?? '';
              if (title == '蓝牙连接') {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const BluetoothPage(),
                ));
              } else if (title == '动画研究') {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const AnimationPage(),
                ));
              } else {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => DetailPage(
                    title: title.isNotEmpty ? title : 'Detail',
                  ),
                ));
              }
            },
          );
        },
      ),
    );
  }
}