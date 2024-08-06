import 'package:coolmovies/styles/styles.dart';
import 'package:flutter/material.dart';

class AboutTheMovie extends StatelessWidget {
  final String title, release, movieId, creatorName;
  const AboutTheMovie({super.key, required this.title, required this.release, required this.movieId, required this.creatorName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Here you will find all details about "+title, style: textDescription, textAlign: TextAlign.start,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.movie_filter_outlined, color: AppColors.primaryGray,),
                SizedBox(width: 2,),
                Text('Title: ', style: textActive,),
                SizedBox(width: 2,),
                Text(title, style: textDisabled,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.person, color: AppColors.primaryGray,),
                SizedBox(width: 2,),
                Text('Creator name: ', style: textActive,),
                SizedBox(width: 2,),
                Text(creatorName, style: textDisabled,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.date_range, color: AppColors.primaryGray,),
                SizedBox(width: 2,),
                Text('Release Date: ', style: textActive,),
                SizedBox(width: 2,),
                Text(release, style: textDisabled,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.movie, color: AppColors.primaryGray,),
                SizedBox(width: 2,),
                Text('Movie ID: ', style: textActive,),
                SizedBox(width: 2,),
                Expanded(child: Text(movieId, style: textDisabled, overflow: TextOverflow.ellipsis,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
