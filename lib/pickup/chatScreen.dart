import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Model/ChatModel.dart';

class ChatScreen extends StatefulWidget {
  final String passengerId, myId, name;

  ChatScreen(this.name, this.passengerId, this.myId);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        titleSpacing: -15.0,
        title: new Row(
          children: <Widget>[
            new FlatButton.icon(
              icon: Icon(Icons.cancel),
              label: new Text(
                '${widget.name}',
                style: new TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              onPressed: () => {},
            ),
            //  new Text(widget.name),
          ],
        ),
        actions: <Widget>[new Icon(Icons.more_vert)],
      ),
      body: new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new NetworkImage(
                    "https://i.pinimg.com/originals/8f/ba/cb/8fbacbd464e996966eb9d4a6b7a9c21e.jpg"),
                fit: BoxFit.fitWidth)),
        child: new Column(
          children: <Widget>[
            new Flexible(
                child: new Container(
              child: buildListMsg(),
            )),
            new Row(children: <Widget>[
              buildInput(),
            ])
          ],
        ),
      ),
    ); //modified
  }

  buildLoading() {
    return Expanded(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

  buildInput() {
    return Flexible(
        child: new Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: new Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.white),
        child: new TextField(
          controller: _controller,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.insert_emoticon, color: Colors.grey),
            hintText: "Type a message",
            suffixIcon: GestureDetector(
              onTap: () => {
                FirebaseFirestore.instance
                    .collection(widget.myId.toString())
                    .doc(widget.passengerId.toString())
                    .collection(widget.passengerId.toString())
                    .add({
                  'sender': widget.myId.toString(),
                  'message': _controller.text.toString(),
                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                }).then((val) {
                  print('sent ${val}');
                })
              },
              child: Icon(
                Icons.send,
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
    ));
  }

  buildListMsg() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.myId.toString())
            .doc(widget.passengerId.toString())
            .collection(widget.passengerId.toString())
            .orderBy('timestamp', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          } else {
            var listMsg = snapshot.data.docs;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.docs.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return msgItem(
                  index,
                  chatModel(
                    snapshot.data.docs[index].get('message').toString(),
                    snapshot.data.docs[index].get('timestamp').toString(),
                    snapshot.data.docs[index].get('sender').toString(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  msgItem(int index, chatModel data) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment:
            (data.senderId == FirebaseAuth.instance.currentUser.uid.toString()
                ? Alignment.topRight
                : Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (data.senderId ==
                    FirebaseAuth.instance.currentUser.uid.toString()
                ? Colors.blue[200]
                : Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                data.message,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
        right: 1,
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${data.message}',
          ),
          Text(
            '${data.time}',
          ),
        ],
      ),
    );
  }
}
