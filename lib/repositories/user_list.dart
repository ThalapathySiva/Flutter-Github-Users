import 'package:bloc_demo/model/user_list.dart';
import 'package:bloc_demo/providers/user_list_providers.dart';

class UserListRepository {
  final provider = UserListProvider();
  Future<List<UserModel>> getUsers() async {
    return await provider.getUsers();
  }

  Future<List<UserModel>> searchUser(String searchText) async {
    final response = await provider.searchUser(searchText);
    return response;
  }
}
