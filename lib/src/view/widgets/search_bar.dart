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
      margin: EdgeInsets.only(
        left: 4,
        right: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 1,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: TextField(
        style: TextStyle(),
        onChanged: (value) {
          if (value.isEmpty) {
            reset();
          }
        },
        controller: controller,
        onSubmitted: (value) {
          search(value);
        },
        // onChanged: search,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search for News',
          suffixIcon: BlocBuilder<HeadlinesBloc, HeadlinesState>(
            builder: (context, state) {
              if (state is Searched) {
                return InkWell(
                  onTap: () {
                    controller.clear();
                    reset();
                  },
                  child: Icon(
                    Icons.close,
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  search(controller.text);
                },
                child: Icon(
                  Icons.search,
                ),
              );
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
