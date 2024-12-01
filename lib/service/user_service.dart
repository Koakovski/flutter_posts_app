import 'dart:convert';

import 'package:posts_app/classes/user.dart';
import 'package:posts_app/util/result.dart';
import 'package:posts_app/service/json_place_holder_constants.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Uri _urlBuilder([Map<String, dynamic>? queryParameters]) {
    return Uri.https(
      JsonPlaceHolderConstants.url,
      '/users',
      queryParameters,
    );
  }

  Future<Result<User>> findOneByUsername(String username) async {
    try {
      Uri url = UserService._urlBuilder({'username': username});

      var response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List users = jsonDecode(response.body);

        if (users.isEmpty) {
          return Result.failure('User not found');
        }

        return Result.success(User.fromJson(users[0]));
      } else {
        return Result.failure('Request failed');
      }
    } catch (e) {
      return Result.failure('Internal Server Error');
    }
  }
}
