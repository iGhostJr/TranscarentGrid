import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/image_result.model.dart';
import '../view_models/image_result.view_modal.dart';

class WebService {

  static const String _apiKey = "3c4e14c9c368e017611470462ab5ab00940bc02b82af2be403ffff88ab3ba3a2";

  static Future<List<ImageResultViewModel>> fetchImages(String keyword, int pageNum) async {
    final String apiUrl = "https://serpapi.com/search.json?q=$keyword&tbm=isch&ijn=$pageNum&api_key=$_apiKey";

    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body["images_results"];

      return json.map((res) {
        return ImageResultViewModel(ImageResult.fromJson(res));
      }).toList();
    } else {
      throw Exception("Error fetching photos");
    }
  }

}