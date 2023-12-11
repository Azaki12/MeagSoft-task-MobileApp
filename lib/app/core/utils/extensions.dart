import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' hide Svg;
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'constants.dart';

extension CustomBoxDecoration on Widget {
  Widget decorate(
      {Color? color,
      double? radius,
      double? width,
      double? height,
      double? padding}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding:
          padding == null ? const EdgeInsets.all(0) : EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color ?? Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
        boxShadow: [
          BoxShadow(
            color: Get.theme.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: this,
    );
  }
}

extension CustomInputDecoration on InputDecoration {
  static InputDecoration decorate(
      {required String hintText,
      String? prefixIcon,
      String? suffixIcon,
      String? suffixText,
      Color? suffixColor,
      VoidCallback? onSuffixTap,
      bool? filled = true}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.bodySmall!.copyWith(
        color: Get.theme.primaryColor.withOpacity(0.4),
        fontSize: 14,
      ),
      prefixIcon: prefixIcon != null
          ? prefixIcon.icon(color: Get.theme.primaryColor)
          : const SizedBox(),
      prefixIconConstraints: prefixIcon != null
          ? const BoxConstraints.expand(width: 55, height: 55)
          : const BoxConstraints.expand(width: 10, height: 10),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(22),
      fillColor: Constants.lightBlue,
      filled: filled,
      suffixIconColor: Get.theme.colorScheme.secondary,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Get.theme.colorScheme.secondary, width: 1)),
      suffixIconConstraints: (suffixIcon == null)
          ? const BoxConstraints.expand(width: 60, height: 22)
          : null,
      suffixIcon: (suffixIcon == null)
          ? (suffixText == null)
              ? null
              : suffixText.body(color: Constants.accentColor, center: true)
          : IconButton(
              onPressed: onSuffixTap,
              icon: suffixIcon.icon(color: suffixColor),
            ),
    );
  }
}

extension CustomIconProvider on String {
  Widget icon({Color? color, double? size}) => ImageIcon(
        Svg('${Constants.iconsPath}$this.svg'),
        color: color ?? Get.theme.colorScheme.secondary,
        size: size ?? 24,
      );
}

extension CustomTextStyles on String {
  Text get h1 => Text(
        this,
        style: Get.textTheme.displayMedium!.merge(
          TextStyle(
            color: Get.theme.primaryColor,
            fontFamily: 'harlow',
          ),
        ),
        softWrap: true,
        textAlign: TextAlign.center,
      );

  Text get h2 => Text(
        this,
        style: Get.textTheme.displaySmall!.merge(
          TextStyle(
            color: Get.theme.primaryColor,
            fontFamily: 'harlow',
          ),
        ),
      );

  Text title({Color? color}) => Text(
        this,
        style: Get.textTheme.titleLarge!.merge(
          TextStyle(
            color: color ?? Get.theme.primaryColor,
            fontWeight:
                (this == Constants.appName) ? FontWeight.w400 : FontWeight.bold,
            fontFamily: (this == Constants.appName)
                ? 'harlow'
                : Get.locale == const Locale('en')
                    ? 'Poppin'
                    : 'Almarai',
          ),
        ),
      );

  Text subtitle({Color? color, FontWeight? weight}) => Text(
        this,
        style: Get.textTheme.titleMedium!.merge(
          TextStyle(
            color: color ?? Get.theme.primaryColor,
            fontFamily: (this == Constants.appName)
                ? 'harlow'
                : Get.locale == const Locale('en')
                    ? 'Poppin'
                    : 'Almarai',
            fontWeight: (this == Constants.appName)
                ? FontWeight.w400
                : weight ?? FontWeight.normal,
            fontSize: (this == Constants.appName)
                ? Get.textTheme.titleMedium!.fontSize! * 1.5
                : Get.textTheme.titleMedium!.fontSize,
          ),
        ),
      );

  Text body(
          {Color? color,
          bool center = false,
          FontWeight weight = FontWeight.normal}) =>
      Text(
        this,
        style: Get.textTheme.bodyLarge!.merge(
          TextStyle(
            color: color ?? Constants.lightGrey,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
            height: 1.5,
            fontWeight: weight,
          ),
        ),
        softWrap: true,
        textAlign: center ? TextAlign.center : TextAlign.start,
      );

  Text get caption => Text(
        this,
        style: Get.textTheme.bodySmall!.merge(
          TextStyle(
            color: Constants.lightGrey,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
          ),
        ),
      );

  Text get overline => Text(
        this,
        style: Get.textTheme.labelSmall!.merge(
          TextStyle(
            color: Constants.lightGrey,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
          ),
        ),
      );

  Text button({Color? color}) => Text(
        this,
        style: Get.textTheme.labelLarge!.merge(
          TextStyle(
            color: color ?? Get.theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
          ),
        ),
      );
}

extension CustomImage on String {
  Widget image({bool? isProfile = true, bool? isTap = false}) =>
      CachedNetworkImage(
        imageUrl: this,
        alignment: Alignment.center,
        fit: isTap! ? BoxFit.contain : BoxFit.cover,
        // placeholder: (context, s) => Lottie.asset(
        //   '${Constants.lottiesPath}image-loader.json',
        //   alignment: Alignment.center,
        // ),
        errorWidget: (context, s, v) => (isProfile!)
            ? 'profile'.icon(color: Constants.accentColor)
            : const SizedBox(),
      );
  Widget get profileImage => CachedNetworkImage(
        imageUrl: this,
        alignment: Alignment.center,
        fit: BoxFit.cover,
        // placeholder: (context, s) => Lottie.asset(
        //   '${Constants.lottiesPath}image-loader.json',
        //   alignment: Alignment.center,
        // ),
        errorWidget: (context, s, v) =>
            SvgPicture.asset('${Constants.iconsPath}profile.svg'),
      );
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }

  Offset get offset {
    RenderBox renderObject = currentContext?.findRenderObject() as RenderBox;
    return renderObject.localToGlobal(Offset.zero);
  }
}
