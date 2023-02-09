import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartIncrementEvent>(_onIncrementItemsInCart);
  }

  final List<ItemModel> _totalItemsInCart = <ItemModel>[];

  void _onIncrementItemsInCart(
      CartIncrementEvent cartIncrementEvent, Emitter<CartState> emitter) {
    _totalItemsInCart.add(cartIncrementEvent.itemModel);
    emitter(CartCountState(_totalItemsInCart.length));
  }
}
