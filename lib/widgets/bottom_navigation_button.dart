

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/theme/theme_controller.dart';

class BottomNavigationButton extends StatelessWidget {
  
  const BottomNavigationButton({super.key, required this.icon, required this.setIndex});

  final IconData icon;
  final VoidCallback setIndex;

  @override
  Widget build(BuildContext context) {
  final colors = context.watch<ThemeController>().colorsOf(context);
    return ElevatedButton(
      onPressed: setIndex,
      style: ElevatedButton.styleFrom(

        backgroundColor: colors.tabInactiveBackground,
        
      ),
      child: Icon(
        icon,
        color: colors.tabIcon,
        size: 30,
      ),
    );
  }
}