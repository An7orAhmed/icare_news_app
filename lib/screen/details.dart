import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/article.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.article});
  final Article article;

  _launchURL() async {
    if (await canLaunchUrl(Uri.parse(article.url))) {
      await launchUrl(Uri.parse(article.url));
    } else {
      throw 'Could not launch URL!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              child: article.urlToImage.isEmpty
                  ? Image.asset("assets/no-image.png", height: 300, width: double.maxFinite, fit: BoxFit.fill)
                  : Image.network(article.urlToImage, height: 300, width: double.maxFinite, fit: BoxFit.fill),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(label: Text("Published: ${article.publishedAt}", style: const TextStyle(color: Colors.blueGrey))),
                  Text(
                    article.title,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(article.content, textAlign: TextAlign.justify, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 15),
                  Chip(label: Text("Source: ${article.source.name}")),
                  FilledButton(onPressed: _launchURL, child: const Text("Read More")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
