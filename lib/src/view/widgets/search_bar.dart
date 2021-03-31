import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 9),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 2,
            )
          ]),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: TextField(
        style: TextStyle(),
        controller: controller,
        onChanged: search,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          suffix: BlocBuilder<HeadlinesBloc, HeadlinesState>(
            builder: (context, state) {
              if (state is Searching) {
                return SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(),
                );
              }

              if (state is Searched) {
                return InkWell(
                  onTap: () {
                    controller.clear();
                    reset();
                  },
                  child: Icon(Icons.close),
                );
              }
              return Icon(Icons.search);
            },
          ),
          hintStyle: TextStyle(
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  void search(String value) {
    BlocProvider.of<HeadlinesBloc>(context).add(Search(query: value));
  }

  void reset() {
    BlocProvider.of<HeadlinesBloc>(context).add(Reset());
  }
}