import 'package:flutter/material.dart';

/// A star rating widget that accepts a score from 0..10 (where 10 == 5 stars).
/// It renders 5 stars; each star can be empty, half, or full (0.5 precision).
///
/// Usage:
/// ```dart
/// MoviePageItemStars(score: 6.3, size: 12)
/// ```
class MoviePageItemStars extends StatelessWidget {
  /// Score in 0..10 (decimal allowed). Example: 6.3.
  final double score;

  /// Size of each star icon.
  final double size;

  /// Color for filled stars.
  final Color filledColor;

  /// Color for empty stars.
  final Color emptyColor;

  const MoviePageItemStars({
    Key? key,
    required this.score,
    this.size = 12.0,
    this.filledColor = Colors.orangeAccent,
    this.emptyColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert score (0..10) into 0..5 in 0.5 steps
    final normalized = (score / 2.0);
    // Round to nearest 0.5
    final rounded = (normalized * 2).round() / 2.0;

    final fullStars = rounded.floor();
    final hasHalf = (rounded - fullStars) == 0.5;

    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(Icon(Icons.star, color: filledColor, size: size));
      } else if (i == fullStars && hasHalf) {
        stars.add(Icon(Icons.star_half, color: filledColor, size: size));
      } else {
        stars.add(Icon(Icons.star_border, color: emptyColor, size: size));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
