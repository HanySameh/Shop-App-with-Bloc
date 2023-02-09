import 'dart:ui';

class ItemModel {
  String itemImageUrl = "";
  String itemName = "";
  String itemDescription = "";
  double itemPrice = -0.0;
  String isInFavorite = "";
  List<Color> colorOptions = [];

  ItemModel.empty();

  ItemModel.setValues({
    required this.itemName,
    required this.itemDescription,
    required this.itemImageUrl,
    required this.itemPrice,
    required this.isInFavorite,
    required this.colorOptions,
  });

  @override
  String toString() {
    return 'ItemModel{itemImageUrl: '
        '$itemImageUrl, itemName: $itemName,'
        'itemDescription: $itemDescription, itemPrice: $itemPrice,'
        'isInFavorite: $isInFavorite}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel &&
          runtimeType == other.runtimeType &&
          itemImageUrl == other.itemImageUrl &&
          itemName == other.itemName &&
          itemDescription == other.itemDescription &&
          itemPrice == other.itemPrice &&
          isInFavorite == other.isInFavorite;

  @override
  int get hashCode =>
      itemImageUrl.hashCode ^
      itemName.hashCode ^
      itemDescription.hashCode ^
      itemPrice.hashCode ^
      isInFavorite.hashCode;
}
