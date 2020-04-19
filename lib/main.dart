import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShoppingList(),
    );
  }
}

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final List<ShopItem> _items = <ShopItem>[];

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController itemToAdd = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add an item',
            ),
            content: TextField(
              controller: itemToAdd,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Lookin good !'),
                  textColor: Colors.green[400],
                  onPressed: () {
                    Navigator.of(context).pop(itemToAdd.text.toString());
                  }),
              MaterialButton(
                elevation: 5.0,
                child: Text('Nah I\'m fine'),
                textColor: Colors.red[400],
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shopping List'),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            createAlertDialog(context).then((value) {
              if (value.isNotEmpty) {
                setState(() {
                  _items.add(ShopItem(value, false));
                });
              }
            });
          },
          tooltip: 'Add an item',
          child: Icon(Icons.add)),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (_items.isEmpty) {
          return Text('Add something to your list 📝');
        } else {
          return _buildItem(_items[i]);
        }
      },
      itemCount: _items.isEmpty ? 1 : _items.length,
    );
  }

  Widget _buildItem(ShopItem item) {
    final TextStyle _itemStyle = TextStyle(
        fontSize: 18,
        decoration:
            item.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        color: item.isCompleted ? Colors.black38 : Colors.black87);

    return ListTile(
      title: Text(
        item.name,
        style: _itemStyle,
      ),
      trailing: Checkbox(
          value: item.isCompleted,
          onChanged: (value) {
            setState(() {
              item.isCompleted = value;
            });
          }),
    );
  }
}

class ShopItem {
  final String name;
  bool isCompleted;

  ShopItem(this.name, this.isCompleted);
}
