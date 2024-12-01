import 'dart:convert';

import 'package:posts_app/classes/comment.dart';
import 'package:posts_app/util/result.dart';
import 'package:posts_app/service/json_place_holder_constants.dart';
import 'package:http/http.dart' as http;

class CommentService {
  static Uri _urlBuilder([Map<String, dynamic>? queryParameters]) {
    return Uri.https(
      JsonPlaceHolderConstants.url,
      '/comments',
      queryParameters,
    );
  }

  Future<Result<List<Comment>>> findAllOfPost(int postId) async {
    try {
      Uri url = CommentService._urlBuilder({'postId': postId.toString()});

      var response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List comments = jsonDecode(response.body);

        return Result.success(
          comments.map((comment) => Comment.fromJson(comment)).toList(),
        );
      } else {
        return Result.failure('Request failed');
      }
    } catch (e) {
      return Result.failure('Internal Server Error');
    }
  }
}
