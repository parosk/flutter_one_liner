import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_one_liner/data/item.dart';

class ItemModel extends ChangeNotifier {
  List<Item> _items = [];
  List<Item> _filteredItems = [];

  bool isNew = true;

  get itemList {
    return [..._items];
  }

  get filteredItemList {
    return [..._filteredItems];
  }

  void refresh() {
    notifyListeners();
  }

  void getFilteredItems(String title) {
    isNew = title.isEmpty;
    _filteredItems = _items.where((element) => element.title.contains(title)).toList();
    refresh();
  }

  Future<bool> getItems() async {
    try {
      var data = await rootBundle.loadString('widgets.json');
      var dataJson = json.decode(data);

      _items = List<Item>.from(
          (dataJson['widgets']).map((e) => Item.staticFromJson(e)).toList());

      refresh();
      return true;
    } on Exception catch (err) {
      throw err;
    }
  }
}
