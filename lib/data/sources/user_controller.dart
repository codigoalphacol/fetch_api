import 'dart:convert';

import 'package:fetch/data/models/user_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserController extends StateNotifier<AsyncValue<List<User>>> {
  UserController(this.ref) : super(const AsyncValue.loading());

  final StateNotifierProviderRef<UserController, AsyncValue<List<User>>> ref;

  void notifyConsumer(List<User> updatedUser) {
    state = AsyncValue.data(updatedUser);
  }

  Future<void> getUser() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<User> userList = data
            .map((item) => User(
                  id: item['id'],
                  name: item['name'],
                  email: item['email'],
                  phone: item['phone'],
                ))
            .toList();
        state = AsyncValue.data(userList);
      } else {
        throw Exception('Error load Users');
      }
    } catch (error) {
      state = AsyncValue.error(error.toString(), StackTrace.current);
    }
  }

  Future<void> reloadUsers() async {
    await getUser();
  }
}
