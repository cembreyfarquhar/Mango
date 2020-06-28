import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureMango',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Secure Mango'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ChatBox()],
        ),
      ),
    );
  }
}

class ChatBox extends StatefulWidget {
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class Message {
  var _text;

  text() {
    return this._text;
  }

  Message(this._text, {String text});
}

class _ChatBoxState extends State<ChatBox> {
  var chatText = [Message('first message')];
  final _inputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _inputController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _inputController.addListener(() {
      final text = _inputController.text.toLowerCase();
      _inputController.value = _inputController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty);
    });
  }

  void _sendMessage() {
    setState(() {
      chatText.add(Message(_inputController.text));
      _inputController.text = '';
    });
  }

  Widget renderMessageWidgets(List<Message> messages) {
    return Expanded(
        child: ListView(
            children: messages.map((msg) => new Text(msg.text())).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(// Header text
              'Chat Box'),
          Text(chatText.last.text()),
          renderMessageWidgets(chatText),
          Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                controller: _inputController,
                autofocus: true,
                autocorrect: true,
              )),
              RaisedButton(
                onPressed: _sendMessage,
              )
            ],
          )
        ],
      ),
    );
  }
}
