import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

const bool kUsingFutureStrategy = true;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  //future
  late Future<List<GroceryItem>> _loadedItems;

  void _loadItems() async {
    final url = Uri.https(
      'study-1a618-default-rtdb.firebaseio.com',
      'flutter/shopping-list.json',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData =
          json.decode(response.body) as Map<String, dynamic>;
      final List<GroceryItem> loadedItemList = [];

      listData.forEach((key, value) {
        final itemData = value as Map<String, dynamic>;
        final category = categories.entries.firstWhere(
          (element) => element.value.title == itemData['category'],
        );
        loadedItemList.add(
          GroceryItem(
            id: key,
            name: itemData['name'] as String,
            quantity: itemData['quantity'] as int,
            category: category.value,
          ),
        );
        _isLoading = false;
      });

      setState(() {
        _groceryItems
          ..clear()
          ..addAll(loadedItemList);
      });
    } catch (error) {
      _error = 'Failed to fetch data. Please try again later';
    }
  }

  Future<List<GroceryItem>> _loadItemsWithFuture() async {
    final url = Uri.https(
      'study-1a618-default-rtdb.firebaseio.com',
      'flutter/shopping-list.json',
    );

    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception("Failed to fetch grocery items. Please try again.");
    }

    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return [];
    }

    final Map<String, dynamic> listData =
        json.decode(response.body) as Map<String, dynamic>;
    final List<GroceryItem> loadedItemList = [];

    listData.forEach((key, value) {
      final itemData = value as Map<String, dynamic>;
      final category = categories.entries.firstWhere(
        (element) => element.value.title == itemData['category'],
      );
      loadedItemList.add(
        GroceryItem(
          id: key,
          name: itemData['name'] as String,
          quantity: itemData['quantity'] as int,
          category: category.value,
        ),
      );
      _isLoading = false;
    });

    return loadedItemList;
  }

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'study-1a618-default-rtdb.firebaseio.com',
      'flutter/shopping-list/${item.id}.json',
    );
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      //optional: show error message
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
    _loadedItems = _loadItemsWithFuture();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    if (_error != null) {
      return Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      // body: content
      body: kUsingFutureStrategy
          ? FutureBuilder(
              future: _loadedItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  String error = snapshot.error.toString();
                  return Center(child: Text(error));
                }

                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items added yet.'));
                }

                var data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) => Dismissible(
                    key: ValueKey(data[index].id),
                    onDismissed: (direction) {
                      _removeItem(data[index]);
                    },
                    child: ListTile(
                      title: Text(data[index].name),
                      leading: Container(
                        width: 24,
                        height: 24,
                        color: data[index].category.color,
                      ),
                      trailing: Text(data[index].quantity.toString()),
                    ),
                  ),
                );
              },
            )
          : content,
    );
  }
}
