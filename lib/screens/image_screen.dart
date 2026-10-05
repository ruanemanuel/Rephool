import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/constants/ph_info.dart';
import 'package:rephool_test/state/image_store.dart';
import 'package:rephool_test/theme/theme_controller.dart';
import 'package:zoom_color_picker/zoom_color_picker.dart';

class ImageScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Color currentColor = Color(0xFF000000);
  int phValue = 0;
  String get image => context.watch<ImageStore>().image;
  set image(String newImage) {
    image = newImage;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ThemeController>().colorsOf(context);
    
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.sizeOf(context).height) * 0.9,
            child: ZoomColorPicker(
              onColorPicked: (color, colorName) {
                setState(() {
                  currentColor = color;
                  phValue = extractPhFromColor(
                    srgbToHex(currentColor.r, currentColor.g, currentColor.b),
                  ).phValue;
                });
              },
              onImagePicked: (imageFilePath) {
                setState(() {
                  image = imageFilePath;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors.background,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(-10, -10) / 40,
                  color: Colors.white54,
                ),
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(10, 10) / 40,
                  color: colors.background2,
                ),
              ],
            ),
            child: Column(
              children: [
                Text("Valor do PH", style: GoogleFonts.inter(fontWeight: FontWeight(800), fontSize: 20),),
                Text("$phValue", style: GoogleFonts.inter(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
