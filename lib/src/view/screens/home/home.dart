import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';
import 'package:news_app/src/model/data_model/article.dart';
import 'package:news_app/src/view/routes.dart';
import 'package:news_app/src/view/widgets/loading_view.dart';
import 'package:news_app/src/view/widgets/news_card.dart';
import 'package:news_app/src/view/widgets/popup_menu.dart';
import 'package:news_app/src/view/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String _query = '';

  @override
  void initState() {
    super.initState();
    // lifecycle observer
    WidgetsBinding.instance?.addObserver(this);

    // gets the saved query value from db
    _query = Hive.box('settings').get('query', defaultValue: '');

    // calls the  bloc event when the UI is ready
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HeadlinesBloc>(context).add(Initial(_query));
    });
  }

  @override
  void dispose() {
    super.dispose();
    // removed lifecycle observer
    WidgetsBinding.instance?.removeObserver(this);
  }

  // life cycle listener
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    // stop auto refresh when app paused
    BlocProvider.of<HeadlinesBloc>(context).add(
      AutoRefresh(state == AppLifecycleState.resumed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('NEWS App'),
        actions: [PopupMenu()],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Container(
            height: kToolbarHeight,
            child: TextButton(
              onPressed: () {
                // named navigation
                Navigator.pushNamed(context, highlightPage, arguments: _query);
              },
              child: Text(
                'Interest Over Time',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
        child: Column(
          children: [
            SearchBar(
              defaultValue: _query,
              query: (value) {
                _query = value;
              },
            ),
            Expanded(
              child: BlocBuilder<HeadlinesBloc, HeadlinesState>(
                buildWhen: (prv, crr) {
                  return crr is Searching || crr is Searched;
                },
                builder: (context, state) {
                  if (state is Searching) {
                    return LoadingView();
                  }

                  if (state is Searched) {
                    if (state.articles.isEmpty) {
                      return Center(
                        child: Text('No articles found.'),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
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
          ],
        ),
      ),
    );
  }
}
