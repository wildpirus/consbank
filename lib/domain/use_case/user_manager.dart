import 'package:consbank/models/user_model.dart';
import 'package:consbank/domain/repositories/user_repository.dart';
import 'package:get/get.dart';

// this file handles the business logic, calling the corresponding repository
class UserManager {
  UserRepository repository = Get.find<UserRepository>();

  Future<User> addUser(User user) async => await repository.addUser(user);

  Future<void> updateUser(User user) async => await repository.updateUser(user);

  Future<void> deleteUser(User user) async => await repository.deleteUser(user);

  Future<User> getUser(User user) async => await repository.getUser(user);

  Future<User> getUserByIdNumber(String idNumber) async => await repository.getUserByIdNumber(idNumber);

  Future<User> login(String email, String password) async => await repository.login(email, password);

  // Future<int> countEmails(User user) async => await repository.countEmails(user);

  Future<List<Map<String, dynamic>>> getAllUsers() async => await repository.getAllUsers();
}
