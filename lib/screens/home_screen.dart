import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly_plus/iconly_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/state/image_store.dart';
import 'package:rephool_test/theme/theme_controller.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset get distance => Offset(28, 28);
  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final result = await picker.pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    if (result == null || !context.mounted) return;
    await context.read<ImageStore>().changeImage(result.path);
    if (!context.mounted) return;
    Navigator.of(context).pushNamed('/image-viewer');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ThemeController>().colorsOf(context);
    final insets = MediaQuery.paddingOf(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, insets.top + 60, 20, 40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                'Rephool',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: colors.title,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 5),
              Divider(color: colors.borderPrimary.withValues(alpha: 0.2)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x76FFFFFF),
                      offset: Offset(-20, -20) / 40,
                    ),
                    BoxShadow(
                      blurRadius: 30,
                      color: colors.background2,
                      offset: Offset(20, 20),
                    ),
                  ],
                ),
                child: Text(
                  'Aqui no Rephool, você pode identificar o PH de uma carne ou queijo de uma embalagem inteligente a partir de um calibrador de cores integrado com o próprio aplicativo.',
                  style: GoogleFonts.inter(color: colors.text),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x76FFFFFF),
                      offset: Offset(-20, -20) / 40,
                      spreadRadius: 0.1
                    ),
                    BoxShadow(
                      blurRadius: 30,
                      color: colors.background2,
                      offset: Offset(20, 20),
                    ),
                  ],
                ),
                child: Text(
                  'Tire sua foto do queijo ou da carne ou escolhe uma foto da galeria e identifique o PH da carne ou do queijo a partir do calibrador de cores integrado com o aplicativo.',
                  style: GoogleFonts.inter(color: colors.text),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x76FFFFFF),
                        offset: -distance / 40,
                      ),
                      BoxShadow(
                        blurRadius: 30,
                        color: colors.background2,
                        offset: distance
                      ),
                    ],
                  ),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.background,
                      foregroundColor: colors.themedText,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                        Navigator.of(context).pushNamed('/photo-screen');
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(
                          IconlyBold.camera,
                          color: colors.themedText,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Tirar foto',
                          style: GoogleFonts.inter(
                            color: colors.themedText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x76FFFFFF),
                        offset: -distance / 40,
                      ),
                      BoxShadow(
                        blurRadius: 30,
                        color: colors.background2,
                        offset: distance,
                      ),
                    ],
                  ),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.background,
                      foregroundColor: colors.themedText,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/image-viewer");
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(IconlyBold.image, color: colors.themedText, size: 25),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Escolher foto da galeria',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: colors.themedText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
