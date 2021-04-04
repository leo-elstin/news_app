import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';
import 'package:news_app/src/bloc/interests/interests_bloc.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? query;
  final bool interests;
  final String defaultValue;

  const SearchBar({
    Key? key,
    this.query,
    this.interests = false,
    this.defaultValue = '',
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeadlinesBloc, HeadlinesState>(
      buildWhen: (prv, cur) {
        return cur is Searched || cur is Reset || cur is NetworkState;
      },
        builder: (context, state) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
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

                // call back
                widget.query!(value);
              },
              controller: controller,
              onSubmitted: (value) {
                search(value);
              },
              // onChanged: search,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for News',
                suffixIcon: Builder(
                  builder: (context) {
                    if (state is Searched && !state.initial) {
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
          ),
          if(state is NetworkState && !state.available)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No Internet'),
            )
        ],
      );
    });
  }

  void search(String value) {
    if (widget.interests) {
      BlocProvider.of<InterestsBloc>(context).add(Fetch(query: value));
    } else {
      BlocProvider.of<HeadlinesBloc>(context).add(Search(query: value));
    }
  }

  void reset() {
    BlocProvider.of<HeadlinesBloc>(context).add(Reset());
  }
}
