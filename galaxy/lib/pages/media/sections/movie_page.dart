import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

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
