import 'dart:ui';
import 'package:flutter/material.dart';

class Constants {
  // ASSET IMAGES
  static const String heroImg = "assets/images/girl_on_couch.png";
  static const String spline = "assets/images/spline.png";

  // ASSET ICONS
  static const String searchIcon = "assets/icons/search-icon.webp";
  static const String notificationsIcon = "assets/icons/notifications-icon.png";

  // COLOURS
  // ---- GREYS
  /*
  static const Color darkestGrey = Color(0xFF1F252F);
  static const Color darkGrey = Color(0xFFB7B4BB);
  static const Color neutralGrey = Color(0xFFE1E5E8);
  static const Color lightGrey = Color(0xFFF5F4F4);
  static const Color lightestGrey = Color(0xFFF7F8FA);
  static const Color offWhite = Color(0xFFF7F8FA);
  */
  // ---- GREYS v2
  static const Color black = Color(0xFF000000);
  static const Color darkest = Color(0xFF373248); // Formely "eggplant"
  static const Color darker = Color(0xFF47516B);
  static const Color dark = Color(0xFF79819A);
  static const Color neutral = Color(0xFFAEB7D3);
  static const Color light = Color(0xFFD9DFE8); // ou 0xFFACB1C3
  static const Color lighter = Color(0xFFE2E6EE);
  static const Color lighter2 = Color(0xFFF2F4F9);
  static const Color lightest = Color(0xFFF7F9FC);
  static const Color white = Color(0xFFFFFFFF);

  // ---- COLOURFUL
  static const Color tomato = Color(0xFFFB6A68);
  static const Color lilac = Color(0xFFD796FC);
  static const Color periwinkle = Color(0xFF8A8EEF);
  static const Color pickle = Color(0xFF96DD6F);
  static const Color babyBlue = Color(0xFF6ACEF9);

  // MEASURES
  static const double paddingSmall = 20;
  static const double paddingMedium = 30;

  // RIVE ASSETS
  static const String shapes = "assets/rive_assets/shapes.riv";

  // TEXTS
  static const String landing__title = "Contrôlez votre maison à distance";
  static const String landing__description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor.";
  static const String home__title = "Ma maison";
  static const String home__subtitle = "Mes équipements";
}
