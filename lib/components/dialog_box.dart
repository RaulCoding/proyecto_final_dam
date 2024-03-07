import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/components/components_barrell.dart';
import 'package:proyecto_final_dam/components/savingButton.dart';
import 'package:proyecto_final_dam/utils/firestore.dart';
import 'pack';

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
      backgroundColor: Colors.white,
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
                SaveButton(
                  text: "Guardar", 
                  onPressed: (){
                    //añadir nueva tarea
                    if (docID == null){
                      firestoreService.addTask(_controller.text);
                    }
                    //Si ya tiene un docID
                    else{
                      firestoreService.updateTask(docID, _controller.text);
                    }
                    
                    //Limpia el controlador de texto
                    _controller.clear();
                    
                    //cierra la ventana
                    Navigator.pop(context);
                    
                  }, 
                )
      //Espacio entre Botones
                // const SizedBox(width: 7),
                // Botón para cancelar
                // MyButton(text: "Cancelar", onPressed: onCancel),
              ],
            )
          ]
        ),        
      ),
    );
  }
}