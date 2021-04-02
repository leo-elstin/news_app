import 'package:flutter/material.dart';
import 'package:news_app/src/model/data_model/article.dart';
import 'package:timeago/timeago.dart' as ago;

class NewsCard extends StatelessWidget {
  final Article? article;

  const NewsCard({Key? key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: article?.urlToImage == null
                ? Container(
                    color: Colors.white,
                    height: 150,
                  )
                : Container(
                    child: Image.network(
                      article!.urlToImage!,
                      // placeholder: (context, url) {
                      //   return Container(
                      //     color: Colors.grey,
                      //     height: 100,
                      //   );
                      // },
                    ),
                  ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: article != null ? null : size.width * 0.50,
            color: Colors.white,
            child: Text(
              '${article?.title ?? ''}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: article != null ? null : size.width * 0.75,
            color: Colors.white,
            child: Text(
              '${article?.description ?? ''}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: article != null ? null : size.width * 0.75,
            color: Colors.white,
            child: Row(
              children: [
                if (article != null)
                  Expanded(
                    child: Text(
                      '${ago.format(article!.publishedAt!)}',
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                Expanded(
                  child: Text(
                    '${article?.author ?? ''}',
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
