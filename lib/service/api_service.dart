import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_copy/models/detail_model.dart';
import 'package:webtoon_copy/models/webToon_model.dart';

import '../models/episode_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebToonModel>> getToon() async {
    List<WebToonModel> webtoonInstance = [];
    final url = Uri.parse("$baseUrl/$today");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstance.add(WebToonModel.fromJson(webtoon));
      }
      return webtoonInstance;
    } else {
      throw Error();
    }
  }

  static Future<DetailModel> getDetail(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final detail = jsonDecode(response.body);
      return DetailModel.fromJson(detail);
    }
    throw Error();
  }

  static Future<EpisodeModel> getEpisode(String id) async {
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final detail = jsonDecode(response.body);
      return EpisodeModel.fromJson(detail);
    }
    throw Error();
  }
}
