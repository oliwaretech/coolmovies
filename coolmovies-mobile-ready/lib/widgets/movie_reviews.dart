import 'package:coolmovies/models/reviews.dart';
import 'package:coolmovies/widgets/loading.dart';
import 'package:coolmovies/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../styles/styles.dart';
import '../utils.dart';

class MovieReviews extends StatefulWidget {
  String movieId,title,currentUserId;
  MovieReviews({super.key, required this.movieId, required this.title, required this.currentUserId});

  @override
  State<MovieReviews> createState() => _MovieReviewsState();
}

class _MovieReviewsState extends State<MovieReviews> {

  late Future<List<Reviews>> _reviewFuture;
  num selectedRate = 0;
  bool isLoading = false;

  String getMovieReviewsQuery = r'''
  query GetMovieReviews($movieId: UUID!) {
    allMovieReviews(
      filter: {movieId: {equalTo: $movieId}}
    ) {
      nodes {
        title
        body
        rating
        movieByMovieId {
          id
          title
          userByUserCreatorId {
            id
            name
          }
        }
        commentsByMovieReviewId {
          nodes {
            id
            title
            body
            userByUserId {
              id
              name
            }
          }
        }
      }
    }
  }
''';


  final String createMovieReviewMutation = """
  mutation CreateMovieReview(\$title: String!, \$body: String!, \$rating: Int!, \$movieId: UUID!, \$userReviewerId: UUID!) {
    createMovieReview(input: {
      movieReview: {
        title: \$title,
        body: \$body,
        rating: \$rating,
        movieId: \$movieId,
        userReviewerId: \$userReviewerId
      }
    }) {
      movieReview {
        id
        title
        body
        rating
        movieByMovieId {
          title
        }
        userByUserReviewerId {
          name
        }
      }
    }
  }
""";

  @override
  void initState() {
    // TODO: implement initState
    _reviewFuture = getReviews();
    super.initState();
  }

  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: GraphQLConfig.httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return isLoading == true ? const Loading() : Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                showAddReviewDialog();
              }, child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                  Text('ADD NEW REVIEW', style: textButton,),
                  const SizedBox(width: 2,),
                  const Icon(Icons.add, color: Colors.white,),
                ],
              )),
        ),
        FutureBuilder<List<Reviews>>(
          future: _reviewFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final reviews = snapshot.data!;

            return SizedBox(
              height: reviews.length*116,
              child: ListView.builder(
                      itemCount: reviews.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return Card(
                          shape: cardShape,
                          elevation: 0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(Icons.star_border),
                                        ),
                                        Text(review.rating.toString(), style: textTitle,)
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(review.title, style: textActive,),
                                      const SizedBox(height: 2,),
                                      Text(review.body, style: textDescription, maxLines: 4, overflow: TextOverflow.ellipsis, )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ],
    );
  }

  Future<List<Reviews>> getReviews() async{
    final client = GraphQLConfig.initializeClient().value;

    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(getMovieReviewsQuery),
        variables: {'movieId': widget.movieId},
        pollInterval: const Duration(seconds: 2),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List reviews = result.data!['allMovieReviews']['nodes'];
    return reviews.map((movieData) => Reviews.fromJson(movieData)).toList();
  }

  void showAddReviewDialog() {
    final reviewTitleController = TextEditingController();
    final reviewBodyController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {

          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GraphQLProvider(
                client: client,
                child: Mutation(
                    options: MutationOptions(
                      document: gql(createMovieReviewMutation),
                      onCompleted: (dynamic resultData) {
                        setState(() {
                          _reviewFuture = getReviews();
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                        print('result data: '+ resultData.toString());
                      },
                      onError: (OperationException? error) {
                        if (error != null) {
                          print('Error: ${error.toString()}');
                        }
                      },
                    ),
                    builder: (RunMutation runMutation, QueryResult? result) {
                      return  Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Add a new Review for ${widget.title}', style: textTitle, textAlign: TextAlign.center,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                            child: Text('Review Title', style: textDescription,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                            child: TextField(
                              controller: reviewTitleController,
                              style: textDescription,
                              decoration: textFieldDecoration.copyWith(hintText: 'Review Title'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                            child: Text('Review Description', style: textDescription,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                            child: TextField(
                              controller: reviewBodyController,
                              style: textDescription,
                              minLines: 4,
                              maxLines: 4,
                              decoration: textFieldDecoration.copyWith(hintText: 'Review Description'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                            child: Center(child: Text('Rate', style: textDescription,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    selectedRate = rating;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: ElevatedButton(
                                  style: buttonStyle,
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Navigator.pop(context);
                                    runMutation({
                                      'title': reviewTitleController.text,
                                      'body': reviewBodyController.text,
                                      'rating': selectedRate,
                                      'movieId': widget.movieId,
                                      'userReviewerId': widget.currentUserId,
                                    });
                                  }, child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('ADD NEW REVIEW', style: textButton,),
                                  const SizedBox(width: 2,),
                                ],
                              )),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          );
        });
  }
}
