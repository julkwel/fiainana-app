import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gridview_app/model/Item.dart';
import 'package:flutter_gridview_app/screen/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://www.techzara.org/garage/teny/api/');

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var appTitle = 'FIAINANA BDB';
  /**
  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'username';
    final user = prefs.getString(key) ?? 'Amis';
    if (user != null) {
      setState(() {
        appTitle = 'Fiainana BDB hoan\'i ' + user;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  } **/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(title: appTitle),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String title;
  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 1.0,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildHeaderDrawer(),
            ListTile(
              leading: Icon(Icons.add),
              title:
                  Text('Hanova anarana', style: TextStyle(color: Colors.blue)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
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
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget _buildHeaderDrawer() {
  return new DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: AssetImage('assets/images/fiainana.png'),
        fit: BoxFit.fill,
      ),
    ), child: null,
  );
}

class PhotosList extends StatefulWidget {
  final List<Photo> photos;
  PhotosList({Key key, this.photos}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new PhotosListState(photos);
  }
}

class PhotosListState extends State<PhotosList> {
  final List<Photo> photos;
  var username = "Amis";
  PhotosListState(this.photos);

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'username';
    final value = prefs.getString(key) ?? 'Amie';

    if (value != null) {
      setState(() {
        username = value ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              var id = photos[index].id;
              if (await canLaunch(
                  'https://techzara.org/garage/teny/api/' + '$id')) {
                await launch('https://techzara.org/garage/teny/api/' + '$id');
              }
            },
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 18.0 / 12.0,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/DoubleBounce.gif',
                      image: 'https://techzara.org/garage/uploads/assets/' +
                              photos[index].image ??
                          'https://i0.wp.com/www.michellewuesthoff.com/wp-content/uploads/2018/11/sasha-stories-320885-unsplash.jpg?resize=1080%2C675',
                      fit: BoxFit.cover,
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 2.0),
                        Text(
                          photos[index].dateajout ?? '',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 8.0,
                          ),
                        ),
                        Text(
                          photos[index]
                                  .title
                                  .replaceAll(r'prenom', '$username') ??
                              '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFFD73C29),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          photos[index]
                                  .description
                                  .replaceAll(r'prenom', '$username') ??
                              '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 8,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 9.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
