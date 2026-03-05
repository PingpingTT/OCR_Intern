import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_ocr2/feture/presentation/page/stack/crop_image_helper.dart';
import 'package:project_ocr2/feture/presentation/page/stack/oveerlay_painter.dart';

class DocumentCameraPage extends StatefulWidget {
  const DocumentCameraPage({super.key});
  @override
  State<DocumentCameraPage> createState() => _DocumentCameraPageState();
}

class _DocumentCameraPageState extends State<DocumentCameraPage> {
  late CameraController _controller;
  bool _ready = false;
  Rect? scanRect;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller.initialize();
    setState(() => _ready = true);
  }

  @override
  void dispose() {
    _controller.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  Future<void> _capture() async {
    final file = await _controller.takePicture();
    final cropped = await cropImage(file.path, scanRect!, _controller);

    if (!mounted) return;
    Navigator.pop(context, cropped);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: CameraPreview(_controller)),

            LayoutBuilder(
              builder: (_, constraints) {
                // ทำกรอบสแกนให้เล็กลง
                final width = constraints.maxWidth * 0.55;
                final height = width / 1.6;

                scanRect = Rect.fromCenter(
                  center: Offset(
                    constraints.maxWidth / 2,
                    constraints.maxHeight / 2,
                  ),
                  width: width,
                  height: height,
                );

                return CustomPaint(
                  size: constraints.biggest,
                  painter: OverlayPainter(scanRect!),
                );
              },
            ),

            // ปุ่มถ่ายรูปอยู่ด้านขวา
            Positioned(
              right: 30,
              top: 0,
              bottom: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _capture,
                  child: Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
