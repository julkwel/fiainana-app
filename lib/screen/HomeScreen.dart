import 'package:flutter/material.dart';
import 'package:flutter_gridview_app/model/Item.dart';
import 'package:flutter_gridview_app/screen/ItemList.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Post> FetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');
  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.id, this.userId, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}

class HomeScreen extends StatelessWidget {
  List<Post> itemList;
  final Future<Post> post;
  HomeScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    itemList = _itemList();

    return Scaffold(
      // sidebar menu
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Fiainana be dia be',
                  style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Momba ahy', style: TextStyle(color: Colors.blue)),
              onTap: () {
                print("hahaha");
                print(post);
              },
            ),
            ListTile(
              title: Text(
                'Tenin\'Andriamanitra anio',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                print("hahaha");
              },
            ),
          ],
        ),
      ),
      // App
      appBar: AppBar(
        title: Text('Fiainana be dia be'),
        centerTitle: true,
      ),
      body: _gridView(),
    );
  }

  Widget _gridView() {
    return GridView.count(
      crossAxisCount: 1,
      padding: EdgeInsets.all(4.0),
      childAspectRatio: 8.0 / 9.0,
      children: <Widget>[
        FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  List<Post> _itemList() {
    return [
      Post(
        id: 0,
        userId: 2,
        title: 'Hello Jul',
        body: '17 Ho mandrakizay ny anarany; raha mbola maharitra koa ny masoandro, dia hanorobona ny anarany; ary izy ho fitahiana ny olona; ny firenena rehetra hanao azy ho sambatra.'
            '18 Isaorana anie Jehovah Andriamanitra, Andriamanitry ny Isiraely; Izy irery ihany no manao fahagagana;'
            '19 Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena.'
            '20 Tapitra ny fivavak’ i Davida, zanak’ i Jese.',
      ),
    
    ];
  }
}
