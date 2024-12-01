import 'dart:convert';

import 'package:posts_app/classes/post.dart';
import 'package:posts_app/util/result.dart';
import 'package:posts_app/service/json_place_holder_constants.dart';
import 'package:http/http.dart' as http;

class PostService {
  static Uri _urlBuilder([Map<String, dynamic>? queryParameters]) {
    return Uri.https(
      JsonPlaceHolderConstants.url,
      '/posts',
      queryParameters,
    );
  }

  Future<Result<List<Post>>> findAllOfUser(int userId) async {
    try {
      Uri url = PostService._urlBuilder({'userId': userId.toString()});

      var response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List posts = jsonDecode(response.body);

        return Result.success(
          posts.map((post) => Post.fromJson(post)).toList(),
        );
      } else {
        return Result.failure('Request failed');
      }
    } catch (e) {
      return Result.failure('Internal Server Error');
    }
  }
}
