import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icare_news_app/utils/strings.dart';
import '../provider/news_provider.dart';

class Category extends ConsumerWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(categories[index]),
              labelStyle: Theme.of(context).textTheme.titleSmall,
              selected: categories[index] == selectedCategory,
              selectedColor: Colors.greenAccent,
              onSelected: (value) {
                if (value) ref.read(categoryProvider.notifier).state = categories[index];
              },
            ),
          );
        },
      ),
    );
  }
}
