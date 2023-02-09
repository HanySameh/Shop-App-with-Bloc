import 'package:flutter/material.dart';

import '../../data/models/item_model.dart';
import '../utilities/colors.dart';
import 'custom_icon_button.dart';
import 'custom_image_widget.dart';
import 'custom_text_widget.dart';

class CustomBestSellingWidget extends StatelessWidget {
  final ItemModel itemModel;
  final VoidCallback onButtonPressed;
  const CustomBestSellingWidget({
    Key? key,
    required this.itemModel,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      elevation: 10.0,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: ColorConstant.kWhiteColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CustomImageWidget(
                backgroundHeight: 70.0,
                backgroundWidth: 70.0,
                imageWidget: itemModel.itemImageUrl,
                height: 70.0,
                width: 70.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: CustomTextWidget(
                        text: itemModel.itemName,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: CustomTextWidget(
                        text: itemModel.itemDescription,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        textColor: ColorConstant.kBlackColor.withOpacity(0.4),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: CustomTextWidget(
                        text: "\$${itemModel.itemPrice}",
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomIconButton(
              radius: 15.0,
              buttonSize: 30.0,
              icon: Icons.arrow_forward_rounded,
              iconColor: ColorConstant.kWhiteColor,
              backGroundColor: ColorConstant.kBlackColor,
              onButtonPressed: onButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}
