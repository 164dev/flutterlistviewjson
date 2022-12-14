import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List? data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      //data = JSON.decode(response.body);
      data = jsonDecode(response.body);
    });

    print('test');
    print(data![1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    print('fs');
    // this.getData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Listviews JSON"),
          backgroundColor: Color.fromARGB(255, 3, 119, 165)),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data!.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data![index]["title"]),
          );
        },
      ),
    );
  }
}
