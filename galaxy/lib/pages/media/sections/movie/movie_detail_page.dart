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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(image, fit: BoxFit.cover, height: 280, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      MoviePageItemStars(score: rating, size: 16),
                      const SizedBox(width: 8),
                      Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 14, color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('简介', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text(
                    '这是一个占位的电影简介。可以在这里显示电影详情、演员、时长等信息。',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
