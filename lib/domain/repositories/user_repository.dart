import 'package:loggy/loggy.dart';
import '../../data/datasources/user_local_datasource_sqflite.dart';
import '../../models/user_model.dart';

// here we call the corresponding local source
class UserRepository {
  late UserLocalDataSource localDataSource;

  UserRepository() {
    logInfo("Starting UserRepository");
    localDataSource = UserLocalDataSource();
  }

  Future<User> addUser(User user) async {
    return await localDataSource.addUser(user);
  }

  Future<void> updateUser(User user) async {
    await localDataSource.updateUser(user);
  }

  Future<void> deleteUser(User user) async {
    await localDataSource.deleteUser("${user.id}");
  }

  Future<User> getUser(User user) async {
    return await localDataSource.getUser("${user.id}");
  }

  Future<User> getUserByIdNumber(String idNumber) async {
    return await localDataSource.getUserByIdNumber(idNumber);
  }

  Future<User> login(String email, String password) async {
    return await localDataSource.login(email, password);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async => await localDataSource.getAllUsers();
}
