import 'package:fetch/data/sources/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_models.dart';

final usersControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<List<User>>>(
  (ref) => UserController(ref),
);

final usersProvider = usersControllerProvider;
