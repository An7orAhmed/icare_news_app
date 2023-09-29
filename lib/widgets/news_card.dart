import 'package:flutter/material.dart';
import 'package:icare_news_app/screen/details.dart';
import '../model/article.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(article: article))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: article.urlToImage.isEmpty
                    ? Image.asset("assets/no-image.png", height: 100, width: 150, fit: BoxFit.fill)
                    : Image.network(article.urlToImage, height: 100, width: 150, fit: BoxFit.fill),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Divider(color: Colors.greenAccent),
                    Text(
                      article.description,
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
