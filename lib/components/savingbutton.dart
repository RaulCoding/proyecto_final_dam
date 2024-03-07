import 'package:flutter/material.dart';
  
class SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  
  const SaveButton({
    super.key, 
    required this.text, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}