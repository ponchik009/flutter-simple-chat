import 'package:flutter/material.dart';

class ChatInputLine extends StatelessWidget {
  ChatInputLine(
      {super.key,
      required this.controller,
      required this.onSendButtonClick,
      required this.focusNode,
      this.enabled = true});

  final TextEditingController controller;
  final FocusNode focusNode;
  void Function() onSendButtonClick;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Введите вашу исповедь...',
            prefixIcon: IconButton(
                onPressed: () {}, icon: const Icon(Icons.attach_file)),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          enabled: enabled,
        )),
        const SizedBox(width: 8),
        IconButton(
            onPressed: onSendButtonClick, icon: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
