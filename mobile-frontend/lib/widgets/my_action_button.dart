import 'package:flutter/material.dart';

class MyActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSmall;

  const MyActionButton({
    super.key,
    required this.icon,
    required this.text,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 12 : 16,
        vertical: isSmall ? 8 : 12,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(isSmall ? 20 : 25),
      ),
      child: Row(
        mainAxisSize: isSmall ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Icon(icon, color: Colors.white70, size: isSmall ? 16 : 18),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isSmall ? 12 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
