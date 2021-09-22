import 'package:flutter/material.dart';
import 'package:gapo_test/values/colors.dart';

class GapoText {

  static Text smallRegular(
      String text, {
        Color color = GapoColor.lightTextColor,
        TextAlign textAlign = TextAlign.start,
      }) {
    return _small(text,
        color: color, fontWeight: FontWeight.normal, textAlign: textAlign);
  }

  static Text mediumBold(
      String text, {
        Color color = GapoColor.normalTextColor,
        TextAlign textAlign = TextAlign.start,
      }) {
    return _medium(text,
        color: color, fontWeight: FontWeight.bold, textAlign: textAlign);
  }

  static Text mediumRegular(
    String text, {
    Color color = GapoColor.normalTextColor,
    TextAlign textAlign = TextAlign.start,
  }) {
    return _medium(text,
        color: color, fontWeight: FontWeight.normal, textAlign: textAlign);
  }

  static Text h1Bold(
      String text, {
        Color color = GapoColor.blackColor,
        TextAlign textAlign = TextAlign.start,
      }) {
    return _h1(text,
        color: color, fontWeight: FontWeight.bold, textAlign: textAlign);
  }

  static Text _small(
      String text, {
        Color color = GapoColor.normalTextColor,
        FontWeight fontWeight = FontWeight.normal,
        TextAlign textAlign = TextAlign.start,
      }) {
    return _base(
      text,
      fontWeight: fontWeight,
      fontSize: 12,
      lineHeight: 14.32,
      color: color,
      textAlign: textAlign,
    );
  }

  static Text _medium(
    String text, {
    Color color = GapoColor.normalTextColor,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
  }) {
    return _base(
      text,
      fontWeight: fontWeight,
      fontSize: 14,
      lineHeight: 16.71,
      color: color,
      textAlign: textAlign,
    );
  }

  static Text _h1(
      String text, {
        Color color = GapoColor.normalTextColor,
        FontWeight fontWeight = FontWeight.normal,
        TextAlign textAlign = TextAlign.start,
      }) {
    return _base(
      text,
      fontWeight: fontWeight,
      fontSize: 28,
      lineHeight: 33.41,
      color: color,
      textAlign: textAlign,
    );
  }

  static Text _base(String text,
      {required FontWeight fontWeight,
      required Color color,
      required double fontSize,
      required double lineHeight,
      required TextAlign textAlign}) {
    final style = _BaseGapoTextStyle(
      fontSize,
      lineHeight,
      fontWeight: fontWeight,
    );
    return Text(
      text,
      textAlign: textAlign,
      style: style.textStyle.copyWith(color: color),
    );
  }
}

abstract class GapoTextStyle {
  TextStyle get textStyle;

  static GapoTextStyle h1BoldStyle() => _H1Style()..bold();

  static GapoTextStyle mediumRegularStyle() => _MediumStyle()..regular();

  static GapoTextStyle mediumBoldStyle() => _MediumStyle()..bold();

  static GapoTextStyle smallRegularStyle() => _SmallStyle()..regular();
}

class _BaseGapoTextStyle extends GapoTextStyle {
  late TextStyle _textStyle;
  @override
  TextStyle get textStyle => _textStyle;

  _BaseGapoTextStyle(
      double fontSize,
      double lineHeight, {
        FontWeight fontWeight = FontWeight.normal,
        String fontFamily = 'SF-Pro'
      }) {
    _textStyle = TextStyle(
      fontSize: fontSize,
      fontFamily: 'Roboto',
      package: 'wallet_core_ui',
      fontWeight: fontWeight,
    );
  }

  _BaseGapoTextStyle bold() {
    _textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    return this;
  }

  _BaseGapoTextStyle regular() {
    _textStyle = textStyle.copyWith(fontWeight: FontWeight.normal);
    return this;
  }
}

class _H1Style extends _BaseGapoTextStyle {
  _H1Style() : super(28, 33.41, fontFamily: 'SF-Pro-Display');
}

class _MediumStyle extends _BaseGapoTextStyle {
  _MediumStyle() : super(14, 16.71);
}

class _SmallStyle extends _BaseGapoTextStyle {
  _SmallStyle() : super(12, 14.32);
}
