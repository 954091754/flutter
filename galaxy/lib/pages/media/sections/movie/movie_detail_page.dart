import 'package:flutter/material.dart';
import 'movie_page_item_stars.dart';

class MovieDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final double rating;

  const MovieDetailPage({Key? key, required this.title, required this.image, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header row: left image (1/3 width), right column with title, year, summary, and rating row
              LayoutBuilder(builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final leftWidth = screenWidth / 3;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: leftWidth,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          height: leftWidth * 1.3,
                          width: leftWidth,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 3),
                          // Year - placeholder (could be passed into the page if available)
                          const Text('年份：2025', style: TextStyle(fontSize: 13, color: Colors.black54)),
                          const SizedBox(height: 3),
                          Text(
                            '这是电影的简介占位文本，显示一两行摘要以便在详情页头部预览。',
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              MoviePageItemStars(score: rating, size: 16),
                              const SizedBox(width: 8),
                              Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          // 加2个按钮，【想看、看过】，带icon的button哦，row布局，中间10
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.bookmark_border, size: 16),
                                  label: const Text('想看'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    textStyle: const TextStyle(fontSize: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check, size: 16),
                                  label: const Text('看过'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    textStyle: const TextStyle(fontSize: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              )],  
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 16),
              const Divider(),

              // Full synopsis / additional details
              const SizedBox(height: 12),
              const Text('剧情简介', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                '这里是完整的剧情简介占位文本。你可以把真实的电影简介、演职员信息、时长、类型等放在这里。'
                ' 目前用于演示页面布局，支持多行显示并随页面滚动查看。',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
