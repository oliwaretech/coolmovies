import 'package:coolmovies/widgets/about_the_movie.dart';
import 'package:coolmovies/widgets/movie_reviews.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

class MovieDetailScreen extends StatefulWidget {
  String image, title, movieId, directId, userCreatorId, releaseDate, nodeId, creatorName, currentUserId;
  MovieDetailScreen({super.key, required this.image, required this.title, required this.movieId, required this.directId, required this.userCreatorId, required this.releaseDate, required this.nodeId, required this.creatorName, required this.currentUserId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  String currentTab = 'details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: cardBackgroundStyle,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image.network(widget.image, fit: BoxFit.cover, height: 400,)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Text(widget.title, style: textTitle,),
              ),
              Card(
                elevation: 4,
                shadowColor: AppColors.primaryBlue,
                shape: cardTopRadiusShape,
                color: AppColors.primaryWhite,
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentTab = 'details';
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                                    child: Text('About the movie', style: currentTab == 'details' ? textActive : textDisabled,),
                                  ),
                                  Visibility(
                                    visible: currentTab == 'details' ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        color: AppColors.secondaryGray,
                                        height: 2,
                                        width: double.infinity,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentTab = 'reviews';
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                                    child: Text('Reviews', style: currentTab == 'reviews' ? textActive : textDisabled,),
                                  ),
                                  Visibility(
                                    visible: currentTab == 'reviews' ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        color: AppColors.secondaryGray,
                                        height: 2,
                                        width: double.infinity,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      currentTab == 'details' ? AboutTheMovie(title: widget.title, release: widget.releaseDate, movieId: widget.movieId, creatorName: widget.creatorName) :
                      MovieReviews(movieId: widget.movieId, title: widget.title, currentUserId: widget.currentUserId),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
