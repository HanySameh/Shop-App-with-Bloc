import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logics/bloc/cart/cart_bloc.dart';
import '../../data/models/item_model.dart';
import '../components/custom_best_selling_widget.dart';
import '../components/custom_explore_item.dart';
import '../components/custom_icon_button.dart';
import '../components/custom_text_field.dart';
import '../components/custom_text_widget.dart';
import '../route_management/routes.dart';
import '../utilities/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _removeFocus,
      child: Scaffold(
        backgroundColor: ColorConstant.kBackgroundColor,
        appBar: AppBar(
          leading: CustomIconButton(
            icon: Icons.menu,
            iconColor: ColorConstant.kBlackColor,
            buttonSize: 30.0,
            onButtonPressed: () {},
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                top: 5.0,
                bottom: 5.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ColorConstant.kBlackColor,
                ),
                padding: const EdgeInsets.all(7.5),
                child: const Icon(
                  Icons.person,
                  color: ColorConstant.kWhiteColor,
                ),
              ),
            ),
          ],
          backgroundColor: ColorConstant.kBackgroundColor,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: Platform.isIOS ? 20.0 : 10.0,
            top: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                  ),
                  child: CustomTextField(
                    textEditingController: _searchController,
                    focusNode: _focusNode,
                    prefixIcon: Icons.search_sharp,
                    elevation: 10.0,
                    borderRadius: 10.0,
                    hintText: "Search",
                  ),
                ),
              ),
              Stack(
                children: [
                  CustomIconButton(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: ColorConstant.kBlackColor,
                    buttonSize: 30.0,
                    onButtonPressed: () {},
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartCountState) {
                        return Visibility(
                          visible: state.totalItem > 0,
                          child: Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.kRedColor,
                              ),
                              padding: const EdgeInsets.all(
                                5.0,
                              ),
                              child: FittedBox(
                                child: CustomTextWidget(
                                  text: "${state.totalItem}",
                                  textColor: ColorConstant.kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CustomTextWidget(
                  text: "Explore",
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (listContext, index) {
                      ItemModel exploreItem = ItemModel.setValues(
                        itemName: "itemName",
                        itemDescription: "itemDescription",
                        itemImageUrl: "",
                        itemPrice: 100.0,
                        isInFavorite: "",
                        colorOptions: [
                          ColorConstant.kRedColor,
                          ColorConstant.kYellowColor,
                          ColorConstant.kBlackColor,
                        ],
                      );
                      return Container(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                        ),
                        alignment: Alignment.center,
                        child: CustomExploreItem(
                          exploreItem: exploreItem,
                          onAddButton: () {
                            BlocProvider.of<CartBloc>(context).add(
                              CartIncrementEvent(exploreItem),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: CustomTextWidget(
                  text: "Best Selling",
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (listContext, index) {
                      ItemModel exploreItem = ItemModel.setValues(
                        itemName: "itemName",
                        itemDescription: "itemDescription",
                        itemImageUrl:
                            "https://media.gettyimages.com/id/184944186/photo/quaid-e-azam.jpg?s=612x612&w=gi&k=20&c=Nr9cDm0BY-yx1eu7bUGN3QGk87VybswqcqTwT05S-U8=",
                        itemPrice: 100.0,
                        isInFavorite: "",
                        colorOptions: [
                          ColorConstant.kRedColor,
                          ColorConstant.kYellowColor,
                          ColorConstant.kBlackColor,
                        ],
                      );
                      return Container(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                          bottom: 10.0,
                        ),
                        alignment: Alignment.center,
                        child: CustomBestSellingWidget(
                          itemModel: exploreItem,
                          onButtonPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.kItemViewScreenRoute,
                              arguments: exploreItem,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
