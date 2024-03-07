import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(BuildContext)? deleteFunction;
  
  const ToDoTile({
    super.key, 
    required this.taskName, 
    required this.taskCompleted,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( left:25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction, 
              icon: Icons.delete, 
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(7),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius:  BorderRadius.circular(7)
          ),
          child: Row(
            children: [
              
              //nombre de la aplicación
              Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted 
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}