import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';
import 'package:news_app/src/model/data_model/article.dart';
import 'package:news_app/src/view/widgets/news_card.dart';
import 'package:news_app/src/view/widgets/search_bar.dart';
import 'package:news_app/src/view/widgets/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS App'),
        bottom: PreferredSize(
          child: SearchBar(),
          preferredSize: Size.fromHeight(40),
        ),
      ),
      body: BlocListener<HeadlinesBloc, HeadlinesState>(
        listener: (context, state) {
          if (state is SearchError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message),
              ),
            );
          }
        },
        child: BlocBuilder<HeadlinesBloc, HeadlinesState>(
          buildWhen: (prv, crr) {
            return crr is! HeadlinesInitial;
          },
          builder: (context, state) {
            if (state is Searching) {
              return Shimmer(
                linearGradient: _shimmerGradient,
                child: ListView.builder(
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

            if (state is Searched) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  Article article = state.articles[index];
                  return NewsCard(
                    article: article,
                  );
                },
              );
            }
            return Offstage();
          },
        ),
      ),
    );
  }

  var _shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
