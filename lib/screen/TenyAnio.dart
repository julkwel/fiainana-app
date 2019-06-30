import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gridview_app/model/Item.dart';
import 'package:flutter_gridview_app/screen/GridItemDetails.dart';
import 'package:flutter_gridview_app/screen/HomeScreen.dart';
import 'package:flutter_gridview_app/screen/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('https://www.fiainanabediabe.org/jour');

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class TenyAnio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TenyAnioState();
  }
}

class TenyAnioState extends State<TenyAnio> {
  var appTitle = 'FIAINANA BDB';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TenyAnioScreen(title: appTitle),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TenyAnioScreen extends StatelessWidget {
  final String title;
  TenyAnioScreen({Key key, this.title}) : super(key: key);

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
              leading: new IconTheme(
                data: new IconThemeData(color: Colors.blueAccent),
                child: new Icon(Icons.settings),
              ),
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
              leading: new IconTheme(
                data: new IconThemeData(color: Colors.redAccent),
                child: new Icon(Icons.book),
              ),
              title: Text(
                'Hiverina',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute<HomePage>(
                          builder: (BuildContext context) => HomePage()),
                    );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red,
      ),
      body: _handlerefresh(),
    );
  }
}

Widget _handlerefresh() {
  return FutureBuilder<List<Photo>>(
    future: fetchPhotos(http.Client()),
    builder: (context, snapshot) {
      if (snapshot.hasError) print(snapshot.error);
      return snapshot.hasData
          ? new PhotosList(photos: snapshot.data)
          : Center(child: CircularProgressIndicator());
    },
  );
}

Widget _buildHeaderDrawer() {
  return new DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: AssetImage('assets/images/logof.png'),
        fit: BoxFit.fitWidth,
      ),
    ),
    child: null,
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
  List<Photo> photos;
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

  Future<List<Photo>> _onRefresh() {
    return fetchPhotos(http.Client()).then((_user) {
      setState(() => photos = _user);
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: _gridView(),
      ),
    );
  }

  Widget _gridView() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _buildListItem(photos[index]);
            },
            childCount: photos.length,
          ),
        )
      ],
    );
  }

  Widget _buildListItem(photos) {
    var text = photos.description.replaceAll(new RegExp(r'zanaku'), username);
    return Container(
        height: 100,
        child: Card(
            elevation: 2.0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GridItemDetails(photos,username)),
                );
              },
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(photos.image),
                  ),
                  title: Text(
                    photos.title.replaceAll(new RegExp(r'zanaku'), username),
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),
                  ),
                  subtitle: Text(
                    text.replaceAll(new RegExp('\\*'), ' '),
                    maxLines: 2,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
            )));
  }
}
