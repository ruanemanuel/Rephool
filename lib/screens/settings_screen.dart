

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/theme/theme_controller.dart';
import 'package:rephool_test/widgets/settings_configuration.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {




  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();
    final colors = theme.colorsOf(context);
    final insets = MediaQuery.paddingOf(context);
    bool isDark = theme.isDark(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, insets.top + 60, 20, 40),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: colors.backgroundPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(200),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Text(
                'Configurações',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: colors.text,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: colors.borderPrimary.withValues(alpha: 0.2)),
            SettingsConfiguration(
              title: 'Modo Escuro',
              description: 'Ative o modo escuro no próprio aplicativo.',
              renderer: Switch(
                value: isDark,
                activeThumbColor: colors.settingsSwitch,
                onChanged: (bool isDark) async {
                  theme.setDark(isDark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
