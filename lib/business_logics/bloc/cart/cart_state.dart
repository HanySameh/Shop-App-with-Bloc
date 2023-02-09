part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartCountState extends CartState {
  final int totalItem;
  CartCountState(this.totalItem);
}
