class Movie {
  final String title;
  final String image;
  final double rating;

  Movie({required this.title, required this.image, required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      rating: (json['rating'] is int) ? (json['rating'] as int).toDouble() : (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'rating': rating,
      };
}
