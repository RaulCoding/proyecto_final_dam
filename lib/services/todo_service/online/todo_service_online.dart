import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_dam/config/models/auth/auth_response.dart';
import 'package:proyecto_final_dam/config/models/auth/user_data.dart';
import 'package:proyecto_final_dam/config/models/tasks/task_list.dart';
import 'package:proyecto_final_dam/config/secure_storage/secure_storage.dart';
import 'package:proyecto_final_dam/screens/widgets/pop_ups/primary_pop_up.dart';

import '../local/local_database_provider.dart';

class ToDoServiceOnline {
  static const String baseUrl = "https://todo-node-api-red.vercel.app";

  Future<Map<String, String>> retrieveHeaders() async {
    String? authorizationToken = await SecureStorageService().readAccessToken();
    // await refreshToken();
    if (authorizationToken != null) {
      authorizationToken = "Bearer $authorizationToken";

      return {
        'Content-Type': 'application/json',
        'Authorization': authorizationToken,
      };
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }
  // Map<String, String> headers = {
  //   'Content-Type': 'application/json',
  //   'Authorization': 'Bearer YourAuthToken',
  // };

  /// Auth
  Future<bool> refreshToken() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/refreshToken'),
        body: refreshTokenToJson(
            await SecureStorageService().readRefreshToken() ?? ""),
        headers: await retrieveHeaders(),
      );
      print("refreshToken");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        AuthResponse data = authResponseFromJson(response.body);
        if (data.accessToken != null && data.refreshToken != null) {
          SecureStorageService()
              .saveTokens(data.accessToken, data.refreshToken);
        } else {
          return false;
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Register Error $e");
      return false;
    }
  }

  Future<bool> registerUser(UserData userData, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: allUserDataToJson(userData),
        headers: await retrieveHeaders(),
      );

      debugPrint(response.body);
      if (response.statusCode == 200) {
        AuthResponse data = authResponseFromJson(response.body);
        if (data.accessToken != null && data.refreshToken != null) {
          SecureStorageService()
              .saveTokens(data.accessToken, data.refreshToken);
        } else {
          return false;
        }
        return true;
      } else {
        if (response.body
            .contains("Usuario ya registrado con el email especificado")) {
          PrimaryPopUp(
            title: 'Error',
            message: 'Usuario ya registrado con el email especificado',
            // onClosePressed: () {},
          ).showPopup(context);
        }
        return false;
      }
    } catch (e) {
      debugPrint("Register Error $e");
      return false;
    }
  }

  Future<bool> loginUser(UserData userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: loginDataToJson(userData),
        headers: await retrieveHeaders(),
      );

      debugPrint(response.body);
      if (response.statusCode == 200) {
        AuthResponse data = authResponseFromJson(response.body);
        if (data.accessToken != null && data.refreshToken != null) {
          SecureStorageService()
              .saveTokens(data.accessToken, data.refreshToken);
        } else {
          return false;
        }
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Login Error $e");
      return false;
    }
  }

  /// TASKS
  Future<void> createTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/'),
        body: taskToJson(task),
        headers: await retrieveHeaders(),
      );

      debugPrint(response.body);
    } catch (e) {
      debugPrint("Login Error $e");
    }
  }

  Future<List<Task>> retrieveTasks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/'),
        headers: await retrieveHeaders(),
      );

      if (response.statusCode == 200) {
        List<Task> taskList = tasksFromJson(response.body);

        await DatabaseProvider.instance.updateLocalDatabase(taskList);

        return taskList;
      } else {
        return await DatabaseProvider.instance.getTasks();
      }
    } catch (e) {
      debugPrint("Retrieve Tasks Error $e");
      return await DatabaseProvider.instance.getTasks();
    }
  }

  Future<void> updateTaskName(Task task, String newName) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${task.id}'),
        headers: await retrieveHeaders(),
        body: taskToJson(
          Task(
            taskName: newName,
            taskDescription: task.taskDescription,
            status: task.status,
          ),
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        // List<Task> taskList = tasksFromJson(response.body);
      } else {}
    } catch (e) {
      debugPrint("updateTaskName Error $e");
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await http.delete(
        Uri.parse('$baseUrl/${task.id}'),
        headers: await retrieveHeaders(),
      );
    } catch (e) {
      debugPrint("deleteTask Error $e");
    }
  }
}
