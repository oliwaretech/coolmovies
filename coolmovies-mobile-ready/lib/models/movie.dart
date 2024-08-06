
import 'package:coolmovies/models/user.dart';

class Movie {
  final String id;
  final String imgUrl;
  final String movieDirectorId;
  final String userCreatorId;
  final String title;
  final String releaseDate;
  final String nodeId;
  final User userByUserCreatorId;

  Movie({
    required this.id,
    required this.imgUrl,
    required this.movieDirectorId,
    required this.userCreatorId,
    required this.title,
    required this.releaseDate,
    required this.nodeId,
    required this.userByUserCreatorId,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      imgUrl: json['imgUrl'],
      movieDirectorId: json['movieDirectorId'],
      userCreatorId: json['userCreatorId'],
      title: json['title'],
      releaseDate: json['releaseDate'],
      nodeId: json['nodeId'],
      userByUserCreatorId: User.fromJson(json['userByUserCreatorId']),
    );
  }
}