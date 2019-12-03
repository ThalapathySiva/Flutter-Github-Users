import 'dart:convert' as convert;

import 'package:bloc_demo/constant/api.dart';
import 'package:bloc_demo/model/user_list.dart';
import 'package:http/http.dart' as http;

class UserListProvider {
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await http.get(api_key);
      if (response == null) {
        print("null");
        return null;
      } else {
        List jsonResponse = convert.jsonDecode(response.body);
        final userlist =
            jsonResponse.map((item) => UserModel.fromJson(item)).toList();
        return userlist;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<UserModel>> searchUser(String searchText) async {
    try {
      final response = await http.get(search_users_url + searchText);
      if (response != null) {
        Map jsonResponse = convert.jsonDecode(response.body);
        print(response.body);
        List userJson = jsonResponse["items"] ?? [];
        final userlist =
            userJson.map((item) => UserModel.fromJson(item)).toList();
        return userlist;
      } else
        return null;
    } catch (e) {
      return null;
    }
  }
}
