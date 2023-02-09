import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/utilities/colors.dart';

part 'color_selector_state.dart';

class ColorSelectorCubit extends Cubit<ColorSelectorState> {
  ColorSelectorCubit()
      : super(ColorSelectorState(ColorConstant.kTransparentColor));

  void changeColor(Color colorChanged) {
    emit(ColorSelectorState(colorChanged));
  }
}
