import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icare_news_app/provider/news_provider.dart';
import 'package:icare_news_app/widgets/news_card.dart';

class NewsList extends ConsumerWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(selectedPageProvider);
    final news = ref.watch(newsProvider);

    List<Widget> makePages(int totalResults) {
      List<Widget> pages = [];
      int numOfPage = (totalResults / 20).round();

      for (int i = 0; i < numOfPage; i++) {
        pages.add(ChoiceChip(
          label: Text("${i + 1}"),
          selected: page == i,
          selectedColor: Colors.greenAccent,
          onSelected: (value) {
            if (value) {
              ref.read(selectedPageProvider.notifier).state = i;
            }
          },
        ));
      }
      return pages;
    }

    return news.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data) {
        data.articles.removeWhere((article) => article.urlToImage.contains('p3'));
        if (data.articles.isEmpty) return const Center(child: Text("Sorry no data found!"));
        final pages = makePages(data.totalResults);
        return RefreshIndicator(
          onRefresh: () {
            refreshData = true;
            return ref.refresh(newsProvider.future);
          },
          child: ListView.builder(
            itemCount: data.articles.length + 1,
            itemBuilder: (context, index) {
              if (index == data.articles.length) {
                if (pages.isEmpty) return const SizedBox.shrink();
                return SizedBox(
                  height: 50,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => pages[index],
                    ),
                  ),
                );
              }
              return NewsCard(article: data.articles[index]);
            },
          ),
        );
      },
      error: (e, s) {
        //print({e, s});
        return const Center(child: Text("Error loading data!"));
      },
    );
  }
}
