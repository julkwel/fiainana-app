import 'package:flutter/material.dart';
import 'package:flutter_gridview_app/model/Item.dart';
import 'package:flutter_gridview_app/screen/ItemList.dart';

class HomeScreen extends StatelessWidget {
  List<Item> itemList;

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
                style: TextStyle(
                  color: Colors.white
                )
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Momba ahy',
              style: TextStyle(
                  color: Colors.blue
                )
              ),
              onTap: () {
                print("hahaha");
              },
            ),
            ListTile(
              title: Text('Tenin\'Andriamanitra anio',style: TextStyle(
                color: Colors.blue
              ),),
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
      children: itemList
          .map(
            (Item) => ItemList(item: Item),
          )
          .toList(),
    );
  }

  List<Item> _itemList() {
    return [
      Item(
        id: 0,
        name: 'Miarahaba an\'i Julien ',
        category: 'Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena',
        desc: '17 Ho mandrakizay ny anarany; raha mbola maharitra koa ny masoandro, dia hanorobona ny anarany; ary izy ho fitahiana ny olona; ny firenena rehetra hanao azy ho sambatra.'
'18 Isaorana anie Jehovah Andriamanitra, Andriamanitry ny Isiraely; Izy irery ihany no manao fahagagana;'
'19 Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena.'
'20 Tapitra ny fivavak’ i Davida, zanak’ i Jese.',
        releaseDate: '27 April 2018',
        trailerImg1: 'assets/images/fiainana.jpeg',
      ),
      Item(
        id: 1,
        name: 'Miarahaba an\'i Julien ',
        category: 'Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena',
        desc: '17 Ho mandrakizay ny anarany; raha mbola maharitra koa ny masoandro, dia hanorobona ny anarany; ary izy ho fitahiana ny olona; ny firenena rehetra hanao azy ho sambatra.'
'18 Isaorana anie Jehovah Andriamanitra, Andriamanitry ny Isiraely; Izy irery ihany no manao fahagagana;'
'19 Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena.'
'20 Tapitra ny fivavak’ i Davida, zanak’ i Jese.',
        releaseDate: '27 April 2018',
        trailerImg1: 'assets/images/fiainana.jpeg',
      ),
      Item(
        id: 2,
        name: 'Miarahaba an\'i Julien ',
        category: 'Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena',
        desc: '17 Ho mandrakizay ny anarany; raha mbola maharitra koa ny masoandro, dia hanorobona ny anarany; ary izy ho fitahiana ny olona; ny firenena rehetra hanao azy ho sambatra.'
'18 Isaorana anie Jehovah Andriamanitra, Andriamanitry ny Isiraely; Izy irery ihany no manao fahagagana;'
'19 Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena.'
'20 Tapitra ny fivavak’ i Davida, zanak’ i Jese.',
        releaseDate: '27 April 2018',
        trailerImg1: 'assets/images/fiainana.jpeg',
      ),
      Item(
        id: 3,
        name: 'Miarahaba an\'i Julien ',
        category: 'Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena',
        desc: '17 Ho mandrakizay ny anarany; raha mbola maharitra koa ny masoandro, dia hanorobona ny anarany; ary izy ho fitahiana ny olona; ny firenena rehetra hanao azy ho sambatra.'
'18 Isaorana anie Jehovah Andriamanitra, Andriamanitry ny Isiraely; Izy irery ihany no manao fahagagana;'
'19 Ary isaorana mandrakizay anie ny anarany malaza; ary aoka ny tany rehetra ho henika ny voninahiny. Amena dia Amena.'
'20 Tapitra ny fivavak’ i Davida, zanak’ i Jese.',
        releaseDate: '27 April 2018',
        trailerImg1: 'assets/images/fiainana.jpeg',
      ),
    ];
  }
}
