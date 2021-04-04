import 'package:flutter/material.dart';
import 'package:news_app/src/view/widgets/news_card.dart';
import 'package:news_app/src/view/widgets/shimmer.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return ShimmerLoading(
            isLoading: true,
            child: NewsCard(
              article: null,
            ),
          );
        },
      ),
    );
  }
}
