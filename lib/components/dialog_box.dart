import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/components/components_barrell.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSave;
  final Function() onCancel;
  
  
  
  const DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Cuadro de Texto
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Añadir nueva tarea",
              ),
            ),
          
          //Botones de guardado y cancelado
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Botón para guardar
                MyButton(text: "Guardar", onPressed: onSave),
                //Espacio entre Botones
                const SizedBox(width: 7),
                //Botón para cancelar
                MyButton(text: "Cancelar", onPressed: onCancel),
              ],
            )
          ]
        ),        
      ),
    );
  }
}