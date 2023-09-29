import 'dart:async';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icare_news_app/widgets/news_list.dart';
import '../provider/news_provider.dart';
import '../widgets/category.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Timer? debounceTimer;

    return Scaffold(
      appBar: EasySearchBar(
        title: Text("iCare News", style: TextStyle(color: Theme.of(context).primaryColor)),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onSearch: (newVal) {
          if (debounceTimer != null) debounceTimer!.cancel();

          debounceTimer = Timer(const Duration(milliseconds: 1000), () {
            ref.read(searchProvider.notifier).state = newVal;
            ref.read(selectedPageProvider.notifier).state = 0;
          });
        },
      ),
      body: const Column(
        children: [
          Category(),
          Expanded(child: NewsList()),
        ],
      ),
    );
  }
}
