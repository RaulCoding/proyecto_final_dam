import 'package:flutter/material.dart';

class TodoListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool logOutEnabled;

  const TodoListAppBar(
      {super.key, required this.title, this.logOutEnabled = true})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.blue,
      actions: [
        if (logOutEnabled)
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              // FirebaseAuth.instance.signOut();
            },
          ),
      ],
    );
  }
}
