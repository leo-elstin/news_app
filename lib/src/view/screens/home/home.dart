import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';
import 'package:news_app/src/model/data_model/article.dart';
import 'package:news_app/src/view/widgets/news_card.dart';
import 'package:news_app/src/view/widgets/popup_menu.dart';
import 'package:news_app/src/view/widgets/search_bar.dart';
import 'package:news_app/src/view/widgets/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HeadlinesBloc>(context).add(Initial());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS App'),
        bottom: PreferredSize(
          child: SearchBar(),
          preferredSize: Size.fromHeight(40),
        ),
        actions: [PopupMenu()],
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
            return crr is Searching || crr is Searched;
          },
          builder: (context, state) {
            if (state is Searching) {
              return Shimmer(
                linearGradient: shimmerGradient,
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
              if (state.articles.isEmpty) {
                return Center(
                  child: Text('No articles found.'),
                );
              }
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
            return Center(
              child: Text('No articles found.'),
            );
          },
        ),
      ),
    );
  }
}
