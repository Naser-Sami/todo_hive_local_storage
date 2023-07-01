import 'package:flutter/material.dart';
import 'package:todo_hive_local_storage/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user inputs
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Add a new task",
                border: OutlineInputBorder(),
              ),
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(text: "Save", onPressed: onSave),
                const SizedBox(width: 10),

                // cancel button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
