import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String initials;
  final double radius;
  final int? colorIndex;
  final String? imageUrl;

  const AppAvatar({
    super.key,
    required this.initials,
    this.radius = 24,
    this.colorIndex,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final index = colorIndex ?? initials.hashCode.abs() % AppColors.avatarGradients.length;
    final gradient = AppColors.avatarGradients[index];

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
      ),
      child: imageUrl != null
          ? ClipOval(
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildInitials(),
              ),
            )
          : _buildInitials(),
    );
  }

  Widget _buildInitials() {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.7,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
