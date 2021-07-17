class Item {
  final String title;
  final String shortExplanation;
  final List<dynamic> tags;

  Item(this.title, this.shortExplanation, this.tags);

  static Item staticFromJson(Map<String, dynamic> json) {
    return Item(json['title'], json['shortExplanation'], json['tag']);
  }
}
