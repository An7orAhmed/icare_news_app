import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/strings.dart';
import '../model/news.dart';

bool refreshData = false;
final searchProvider = StateProvider((ref) => "");
final selectedPageProvider = StateProvider((ref) => 0);
final categoryProvider = StateProvider<String>((ref) => categories.first);

final newsProvider = FutureProvider.autoDispose((ref) async {
  final searchVal = ref.watch(searchProvider);
  final page = ref.watch(selectedPageProvider);
  final selectedCategory = ref.watch(categoryProvider);

  // handle search
  if (searchVal != "") {
    String link = newsBySearchLink + searchVal;
    final response = await http.get(Uri.parse(link));
    final news = News.fromJson(response.body);
    return news;
  }

  // handle category with caching
  String link = "$newsByCategoryLink$selectedCategory&page=${page + 1}";

  final prefs = await SharedPreferences.getInstance();
  final cachedData = prefs.getString("$selectedCategory${page + 1}");

  if (cachedData != null && refreshData == false) {
    return News.fromJson(cachedData);
  } else {
    refreshData = false;
    final response = await http.get(Uri.parse(link));
    final news = News.fromJson(response.body);
    await prefs.setString("$selectedCategory${page + 1}", response.body);
    return news;
  }
});
