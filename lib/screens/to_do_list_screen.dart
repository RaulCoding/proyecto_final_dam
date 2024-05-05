import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/config/models/tasks/task_list.dart';
import 'package:proyecto_final_dam/config/secure_storage/secure_storage.dart';
import 'package:proyecto_final_dam/screens/auth/login_screen.dart';
import 'package:proyecto_final_dam/screens/widgets/no_internet_connection_banner.dart';
import 'package:proyecto_final_dam/services/todo_service/online/todo_service_online.dart';

class TodoListScreen extends StatefulWidget {
  static const route = "TodoListScreen";

  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  //controlador de texto
  final _controller = TextEditingController();

  List<Task> taskList = [];

  @override
  void initState() {
    retrieveTaskList();
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      manageConnectivity(result);
    });
    super.initState();
  }

  bool _noInternetConnection = false;

  void manageConnectivity(List<ConnectivityResult> subscription) {
    if (!subscription.contains(ConnectivityResult.mobile) &&
        !subscription.contains(ConnectivityResult.wifi)) {
      _noInternetConnection = true;
      print("NoInternetConnection");
      setState(() {});
    } else {
      _noInternetConnection = false;
      print("Theyres internet");

      setState(() {});
    }
  }

  Future<void> retrieveTaskList() async {
    taskList = await ToDoServiceOnline().retrieveTasks();
    taskList.forEach((element) {
      print(element.status);
    });
    setState(() {});
  }

  //crear nueva tarea
  void openTaskBox(
      {Task? task, required String title, required TaskBoxType taskBoxType}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color(0xff222831),
              //text user input
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xffEEEEEE)),
                  ),
                  if (taskBoxType != TaskBoxType.delete)
                    TextFormField(
                      cursorColor: Colors.white,
                      controller: _controller,
                      style: const TextStyle(color: Color(0xFFEEEEEE)),
                    ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFEEEEEE))),
                        onPressed: () async {
                          if (taskBoxType == TaskBoxType.create ||
                              taskBoxType == TaskBoxType.updateName) {
                            if (taskBoxType == TaskBoxType.create) {
                              await ToDoServiceOnline().createTask(
                                Task(
                                  taskName: _controller.text,
                                  taskDescription: "TaskDescription Text",
                                  status: false,
                                ),
                              );
                            } else {
                              await ToDoServiceOnline()
                                  .updateTaskName(task!, _controller.text);
                            }
                            _controller.clear();
                          } else if (taskBoxType == TaskBoxType.delete) {
                            await ToDoServiceOnline().deleteTask(
                              task!,
                            );
                          }

                          retrieveTaskList();

                          //cierra la ventana
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(color: Color(0xFF222831)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFEEEEEE))),
                          onPressed: () {
                            _controller.clear();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Color(0xFF222831)),
                          )),
                    )
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style:
              TextStyle(color: Color(0xffeeeeee), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF222831),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Color(0xffeff3f5),
            ),
            onPressed: () async {
              await SecureStorageService().deleteTokens();
              Navigator.pushReplacementNamed(context, LoginScreen.route);
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xff31363f),
      floatingActionButton: _noInternetConnection
          ? null
          : FloatingActionButton(
              backgroundColor: const Color(0xFF76ABAE),
              onPressed: () => openTaskBox(
                title: "Añadir nueva tarea",
                taskBoxType: TaskBoxType.create,
              ),
              child: const Icon(
                Icons.add_box,
                color: Color(0xffeeeeee),
                shadows: [],
              ),
            ),
      body: Column(
        children: [
          NoInternetBanner(
            show: _noInternetConnection,
          ),
          taskList.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 214,
                  child: ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 15,
                            top: index == 0 ? 20 : 0),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: taskList[index].status == false
                              ? const Color(0xff76abae)
                              : const Color(0xffbb86fc),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            taskList[index].taskName ?? "-",
                            style: const TextStyle(
                                color: Color(0xff222831),
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: !_noInternetConnection
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => openTaskBox(
                                        task: taskList[index],
                                        title: "Actualizar nombre tarea",
                                        taskBoxType: TaskBoxType.updateName,
                                      ),
                                      icon: const Icon(Icons.settings),
                                    ),
                                    IconButton(
                                      onPressed: () => openTaskBox(
                                        task: taskList[index],
                                        title: "Eliminar tarea",
                                        taskBoxType: TaskBoxType.delete,
                                      ),
                                      icon: const Icon(Icons.delete),
                                    ),
                                    IconButton(
                                      color: const Color(0xFFEEEEEE),
                                      splashColor: Colors.transparent,
                                      onPressed: () async {
                                        if (taskList[index].status != null &&
                                            taskList[index].status != true) {
                                          taskList[index].status = true;
                                          await ToDoServiceOnline()
                                              .updateTaskName(
                                            taskList[index],
                                            taskList[index].taskName ?? "",
                                          );

                                          retrieveTaskList();
                                        }
                                      },
                                      icon: taskList[index].status == false
                                          ? const Icon(
                                              Icons.check,
                                              color: Color(0xFFEEEEEE),
                                            )
                                          : const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                    ),
                                  ],
                                )
                              : null,
                          //
                        ),
                      );
                    },
                  ),
                )
              : const Text(
                  "Toca el icono '+' para añadir una nota",
                  style: TextStyle(color: Color(0xFFEEEEEE)),
                ),
        ],
      ),
    );
  }
}

enum TaskBoxType {
  updateName,
  delete,
  create,
}
