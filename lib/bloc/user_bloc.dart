import 'dart:async';

import 'package:bloc_demo/model/user_list.dart';
import 'package:bloc_demo/repositories/user_list.dart';

class Userbloc {
  final controller = StreamController<List<UserModel>>.broadcast();
  final userRepo = UserListRepository();
  Future getUser() async {
    final userList = await userRepo.getUsers();
    controller.sink.add(userList);
  }

  Future searchUser(String searchText) async {
    final userList = await userRepo.searchUser(searchText);
    controller.sink.add(userList);
  }

  Stream<List<UserModel>> get userlist => controller.stream;

  void dispose() {
    controller.close();
  }
}

final userbloc = Userbloc();
