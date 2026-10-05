import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly_plus/iconly_plus.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/constants/ph_info.dart';
import 'package:rephool_test/state/image_store.dart';
import 'package:rephool_test/theme/theme_controller.dart';
import 'package:camera_color_picker/camera_color_picker.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  Color currentColor = Color.from(alpha: 1.0, red: 0.0, green: 0.0, blue: 0.0);
  int ph = 0;

  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  bool _permissionDenied = false;
  bool _initializing = true;
  int _cameraIndex = 0;
  bool _flashOn = false;
  double _zoom = 0;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera({int? index}) async {
    setState(() {
      _initializing = true;
      _permissionDenied = false;
    });
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() {
          _permissionDenied = true;
          _initializing = false;
        });
        return;
      }
      _cameraIndex =
          index ??
          _cameras.indexWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
          );
      if (_cameraIndex < 0) _cameraIndex = 0;
      await _bindCamera(_cameras[_cameraIndex]);
    } on CameraException {
      setState(() {
        _permissionDenied = true;
        _initializing = false;
      });
    }
  }

  Future<void> _bindCamera(CameraDescription description) async {
    final previous = _controller;
    final controller = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _controller = controller;
    await previous?.dispose();
    await controller.initialize();
    await controller.setFlashMode(FlashMode.off);
    if (!mounted) return;
    setState(() {
      _flashOn = false;
      _zoom = 0;
      _initializing = false;
    });
  }

  Future<void> _toggleFacing() async {
    if (_cameras.length < 2) return;
    final next = (_cameraIndex + 1) % _cameras.length;
    setState(() {
      _cameraIndex = next;
      _initializing = true;
    });
    await _bindCamera(_cameras[next]);
  }

  Future<void> _toggleFlash() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    final next = !_flashOn;
    await controller.setFlashMode(next ? FlashMode.always : FlashMode.off);
    setState(() => _flashOn = next);
  }

  Future<void> _setZoom(double value) async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    setState(() => _zoom = value);
    final min = await controller.getMinZoomLevel();
    final max = await controller.getMaxZoomLevel();
    final mapped = min + (value / 100) * (max - min);
    await controller.setZoomLevel(mapped.clamp(min, max));
  }

  Future<void> _takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (controller.value.isTakingPicture) return;
    final photo = await controller.takePicture();
    if (!mounted) return;
    await context.read<ImageStore>().changeImage(photo.path);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ThemeController>().colorsOf(context);
    final image = context.watch<ImageStore>().image;
    final size = MediaQuery.sizeOf(context);
    final insets = MediaQuery.paddingOf(context);
    final controller = _controller;

    if (_permissionDenied) {
      return Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: GestureDetector(
            onTap: _setupCamera,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.backgroundPrimary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colors.borderPrimary),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Garantir Permissão',
                    style: GoogleFonts.inter(color: colors.text, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sua permissão é importante para identificar que você está utilizando o aplicativo e a câmera.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: colors.text,
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.8,
                  alignment: .center,
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
                  child: CameraColorPicker(
                    onColorChanged: (color) {
                      setState(() {
                        currentColor = color;
                        ph = extractPhFromColor(
                          srgbToHex(
                            currentColor.r,
                            currentColor.g,
                            currentColor.b,
                          ),
                        ).phValue;
                      });
                    },
                    currentColor: currentColor,
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          "Clique aqui para abrir o calibrador de cores.",
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: insets.top + 16,
              left: 20,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  IconlyBold.arrowLeft,
                  color: colors.iconText,
                  size: 30,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: .end,
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: colors.backgroundPrimary,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "Valor do PH",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight(700),
                      ),
                    ),
                  ),
                  Text("$ph", style: GoogleFonts.inter(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
