import 'package:flutter/material.dart';
import 'package:flutter_gridview_app/model/Item.dart';

class GridItemDetails extends StatelessWidget {
  final Photo item;
  const GridItemDetails(this.item);
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
                  child: Image.network(image, fit: BoxFit.cover)),
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
                      item.title,
                      style: Theme.of(context).textTheme.display1,
                    ),
                    SizedBox(height: 10.0),
                    Text(item.dateajout),
                    SizedBox(height: 10.0),
                    Divider(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(item.description,
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
          print(item.id);
        },
        backgroundColor: Colors.red,
        tooltip: 'Aller vers le lien',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
