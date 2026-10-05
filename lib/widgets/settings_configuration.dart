import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/theme/theme_controller.dart';

class SettingsConfiguration extends StatelessWidget {
  const SettingsConfiguration({
    super.key,
    required this.title,
    required this.description,
    required this.renderer,
  });

  final String title;
  final String description;
  final Widget renderer;

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ThemeController>().colorsOf(context);
    return Container(
      padding: const EdgeInsets.all(10),
      
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(-28, -28) / 40,
            blurRadius: 5,
            color: Color.fromARGB(98, 255, 255, 255)
          ),
          BoxShadow(
            offset: Offset(28, 28) / 40,
            blurRadius: 5,
            color: colors.background2
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: colors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.inter(color: colors.text, fontSize: 15),
                ),
              ],
            ),
          ),
          renderer,
        ],
      ),
    );
  }
}
