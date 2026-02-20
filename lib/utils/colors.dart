import 'package:flutter/material.dart';

// ── Core Palette ──────────────────────────────────────────────────────────
Color backgroundColor = const Color(0xff0D1B2A); // deep navy
Color surfaceColor = const Color(0xff1A2B3C); // charcoal card surface
Color surface2Color = const Color(0xff223344); // slightly lighter card

// ── Brand Colors ───────────────────────────────────────────────────────────
Color primaryColor = const Color(0xff00C897); // vibrant emerald
Color accentColor = const Color(0xff00E5C4); // soft teal accent
Color orderpageColor = const Color(0xff00B4D8); // sky blue for orders

// ── Text Colors ────────────────────────────────────────────────────────────
Color textColor = const Color(0xffF0F4F8); // near-white
Color subTextColor = const Color(0xff8FA3B1); // muted blue-grey
Color darkGreyColor = const Color(0xff1A2B3C); // reuse as surface

// ── Utility ────────────────────────────────────────────────────────────────
Color whiteColor = const Color(0xffFFFFFF);
Color blackColor = const Color(0xff000000);
Color inblack = Colors.black87;
Color brownColor = const Color(0xffA8A29E);
Color lightGreyColor = const Color(0xffEFF3F6);
Color lightBlueColor = const Color(0xffC8EBFF);
Color errorColor = const Color(0xffFF5B5B); // vivid coral

// ── Gradients ──────────────────────────────────────────────────────────────
const LinearGradient primaryGradient = LinearGradient(
  colors: [Color(0xff00C897), Color(0xff00E5C4)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient backgroundGradient = LinearGradient(
  colors: [Color(0xff0D1B2A), Color(0xff0A2436)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const LinearGradient bannerGradient = LinearGradient(
  colors: [Color(0xff0A2436), Color(0xff00C897)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
