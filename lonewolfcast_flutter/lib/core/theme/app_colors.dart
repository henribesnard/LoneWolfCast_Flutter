import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales
  static const primary = Color(0xFF1E88E5);
  static const secondary = Color(0xFF00B0FF);
  static const background = Color(0xFFF5F5F5);

  // Couleurs pour les prédictions
  static const predictionColors = {
    'high': Color(0xFF388E3C),    // Vert foncé
    'medium': Color(0xFF43A047),   // Vert
    'low': Color(0xFFD32F2F),      // Rouge
  };

  // Status des matchs
  static const matchStatus = {
    'live': Color(0xFFF44336),     // Rouge
    'upcoming': Color(0xFF42A5F5), // Bleu
    'finished': Color(0xFF78909C), // Gris
  };
}