import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/domain/use_case/user_manager.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  late User user;
  static final _storage = GetStorage();
  final UserManager _useCase = Get.find<UserManager>();

  final users = <User>[].obs;

  Future<User> getUser(Map<String, dynamic> user) async {
    return await _useCase.getUser(User.fromJson(user));
  }

  Future<User> getUserByIdNumber(String idNumber) async {
    return await _useCase.getUserByIdNumber(idNumber);
  }

  Future<User> login(String email, String password) async {
    return await _useCase.login(email, password);
  }

  Future<User> addUser(Map<String, dynamic> user) async {
    return await _useCase.addUser(User.fromJson(user));
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    await _useCase.updateUser(User.fromJson(user));
  }

  Future<void> deleteUser(Map<String, dynamic> user) async {
    await _useCase.deleteUser(User.fromJson(user));
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return await _useCase.getAllUsers();
  }

  static saveProfileState(ProfileState pd) {
    _storage.write('profileStatus', profileStateToJson(pd));
  }

  static ProfileState getProfileState() {
    try {
      final String? profileStatus = _storage.read('profileStatus');
      return profileStateFromJson(profileStatus ?? "");
    } catch (_) {
      return ProfileState(user: currentUser);
    }
  }

  static set currentUser(User? user) {
    if (user != null) {
      _storage.write('user', userToJson(user));
    }
  }

  static User? get currentUser {
    final isUser = _storage.hasData('user');
    if (!isUser) return null;
    final String? userStr = _storage.read('user');
    return userFromJson(userStr ?? "");
  }

  static bool get isLoggedIn {
    return currentUser != null;
  }

  logout() {
    return Future.delayed(const Duration(milliseconds: 1000), () async {
      await _storage.erase();
      return true;
    });
  }
}
