import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {Key? key, required this.title, this.fromMe = false, required this.date})
      : super(key: key);

  final String title;
  final bool fromMe;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
        padding: fromMe
            ? const EdgeInsets.only(left: 320, right: 16)
            : const EdgeInsets.only(right: 320),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment:
                    fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    date != null
                        ? date!
                            .toIso8601String()
                            .replaceAll('T', '\n')
                            .replaceRange(
                                date!.toIso8601String().lastIndexOf('.'),
                                date!.toIso8601String().length,
                                '')
                        : '',
                    textAlign: fromMe ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(fontSize: 10),
                  )
                ]),
          ),
        ));
  }
}
