import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';
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
      body: BlocBuilder<HeadlinesBloc, HeadlinesState>(
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
                      child: Card(
                        child: SizedBox(
                          child: ListTile(),
                        ),
                      ),
                    );
                  }),
            );
          }
          return Offstage();
        },
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
