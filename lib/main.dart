import 'dart:math';

import 'package:flutter_simple_chat/chat_input_line.dart';
import 'package:flutter_simple_chat/chat_message.dart';
import 'package:flutter_simple_chat/god_phrases.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
          title: 'Разговоры с батюшкой (он говорит фразы из Библии)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool _textFieldEnabled = true;
  List<Map> messages = [];
  final _rnd = Random();

  void onSendButtonClick() {
    messages.add(
        {'text': textController.text, 'fromMe': true, 'date': DateTime.now()});
    triggerGod();
    textController.clear();
    setState(() {});
  }

  Future triggerGod() async {
    messages.add({'text': 'Исповедует...', 'fromMe': false, 'date': null});
    _textFieldEnabled = false;
    setState(() {});
    await Future.delayed(const Duration(seconds: 3));
    messages[messages.length - 1] = {
      'text': GodPhrases.phrases[_rnd.nextInt(GodPhrases.phrases.length)],
      'fromMe': false,
      'date': DateTime.now()
    };
    _textFieldEnabled = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: ListView(
                        reverse: true,
                        children: List.generate(
                                messages.length,
                                (index) => ChatMessage(
                                    title: messages[index]['text'],
                                    fromMe: messages[index]['fromMe'],
                                    date: messages[index]['date']))
                            .reversed
                            .toList(),
                      ))),
              ChatInputLine(
                  focusNode: focusNode,
                  controller: textController,
                  onSendButtonClick: onSendButtonClick,
                  enabled: _textFieldEnabled),
            ],
          ),
        ),
      ),
    );
  }
}
