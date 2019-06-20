import 'package:flutter/material.dart';
import 'package:flutter_gridview_app/model/Item.dart';
import 'package:url_launcher/url_launcher.dart';

class GridItemDetails extends StatelessWidget {
  final Photo item;
  final String name;

  const GridItemDetails(this.item,this.name);
  @override
  Widget build(BuildContext context) {
    String image = item.image;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(image, fit: BoxFit.fitWidth)),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title.replaceAll(new RegExp(r'zanaku'), name),
                      style: Theme.of(context).textTheme.display1,
                    ),
                    SizedBox(height: 10.0),
                    Text(item.dateajout),
                    SizedBox(height: 10.0),
                    Divider(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(item.description.replaceAll(new RegExp(r'zanaku'), name),
                        style: Theme.of(context).textTheme.body1),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchURL(item.id);
        },
        backgroundColor: Colors.red,
        tooltip: 'Aller vers le lien',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

_launchURL(id) async {
  var url = 'https://www.fiainanabediabe.org/teny/api/$id';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
