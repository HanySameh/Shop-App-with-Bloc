part of 'cart_bloc.dart';

abstract class CartEvent {}

class CartIncrementEvent extends CartEvent {
  final ItemModel itemModel;
  CartIncrementEvent(this.itemModel);
}
