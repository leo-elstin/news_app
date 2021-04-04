import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/interests/interests_bloc.dart';
import 'package:news_app/src/view/widgets/chart.dart';
import 'package:news_app/src/view/widgets/loading_view.dart';
import 'package:news_app/src/view/widgets/search_bar.dart';

class HighlightsPage extends StatefulWidget {
  static const route = '/highlights';

  @override
  _HighlightsPageState createState() => _HighlightsPageState();
}

class _HighlightsPageState extends State<HighlightsPage> {
  String query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (query.isNotEmpty)
        BlocProvider.of<InterestsBloc>(context).add(Fetch(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    query = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Interest Over Time'),
      ),
      body: Column(
        children: [
          SearchBar(
            defaultValue: query,
            interests: true,
            query: (value) {
              query = value;
            },
          ),
          Expanded(
            child: BlocBuilder<InterestsBloc, InterestsState>(
              buildWhen: (prv, cur) {
                return cur is Fetching || cur is Fetched || cur is FetchError;
              },
              builder: (context, state) {
                if (state is Fetching) {
                  return LoadingView();
                }
                if (state is Fetched) {
                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: ChartView(
                        chartData: state.interests,
                        maxCount: state.max,
                      ),
                    ),
                  );
                }

                if (state is FetchError) {
                  return Center(
                    child: Text(state.error.message),
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
    );
  }
}
