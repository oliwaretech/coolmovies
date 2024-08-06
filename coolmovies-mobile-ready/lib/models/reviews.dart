

class Reviews {
  final String title;
  final String body;
  final num rating;

  Reviews({
    required this.title,
    required this.body,
    required this.rating,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      title: json['title'],
      body: json['body'],
      rating: json['rating'],
    );
  }
}