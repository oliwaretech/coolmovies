import 'package:carousel_slider/carousel_slider.dart';
import 'package:coolmovies/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/constants.dart';
import '../models/movie.dart';
import '../styles/styles.dart';
import '../utils.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late Future<List<Movie>> _moviesFuture;
  String currentUserName = '', currentUserId = '';

  @override
  void initState() {
    // TODO: implement initState
    _moviesFuture = fetchMovies();
    getUser();
    super.initState();
  }

  Future<List<Movie>> fetchMovies() async {
    final client = GraphQLConfig.initializeClient().value;

    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(fetchMoviesQuery),
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List movies = result.data!['allMovies']['nodes'];
    return movies.map((movieData) => Movie.fromJson(movieData)).toList();

  }

  Future getUser() async {
    final client = GraphQLConfig.initializeClient().value;

    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(getCurrentUser),
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    setState(() {
      currentUserName = result.data!['currentUser']['name'];
      currentUserId = result.data!['currentUser']['id'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List', style: textTitle,),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text('Welcome '+currentUserName.toUpperCase(), style: textActive,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Text('Select the movie you like the most', style: textDisabled,),
          ),
          FutureBuilder<List<Movie>>(
            future: _moviesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final movies = snapshot.data!;

              return CarouselSlider.builder(
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    final movie = movies[index];

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          decoration: cardBackgroundStyle,
                          child: Stack(
                            children: [
                              Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child: Image.network(movie.imgUrl, fit: BoxFit.cover,)),
                              ),
                              Center(
                                child: ElevatedButton(
                                    style: buttonStyle,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  MovieDetailScreen(image: movie.imgUrl, title: movie.title, movieId: movie.id, directId: movie.movieDirectorId, userCreatorId: movie.userCreatorId, releaseDate: movie.releaseDate, nodeId: movie.nodeId, creatorName: movie.userByUserCreatorId.name, currentUserId : currentUserId)),
                                      );
                                    }, child: Text('View', style: textButton,)),
                              )
                            ],
                          )),
                    );
                  },
                options: CarouselOptions(
                  height: 400,
                  viewportFraction: 0.7,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  scrollDirection: Axis.horizontal,
                ),
              );
              /*return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    leading: Image.network(movie.imgUrl),
                    title: Text(movie.title),
                    subtitle: Text('Director ID: ${movie.movieDirectorId}, Release Date: ${movie.releaseDate}'),
                  );
                },
              );*/
            },
          ),
        ],
      ),
    );
  }


}
