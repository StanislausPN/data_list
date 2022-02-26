import 'dart:convert';

import 'package:flutter_test_app/data/base_url/base_url.dart';
import 'package:flutter_test_app/data/models/post_models.dart';

import 'package:http/http.dart' as http;

class PostRepository {
  static Future<List<PostModels>?> getPost() async {
    try {
      var response = await http.get(
        Uri.parse(BaseUrl.postListUrl),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        List<PostModels>? list = parsePost(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<PostModels>? getPostWithId(String id) async {
    PostModels getData;
    try {
      var response = await http.get(
        Uri.parse(BaseUrl.postListUrl +
            '/' +
            id), //https://jsonplaceholder.typicode.com/posts
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        getData = PostModels.fromJson(data);
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return getData;
  }

  static List<PostModels>? parsePost(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PostModels>((json) => PostModels.fromJson(json)).toList();
  }
}
