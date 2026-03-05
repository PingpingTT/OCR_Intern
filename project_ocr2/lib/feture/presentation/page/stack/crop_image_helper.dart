import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

Future<File> cropImage(
  String path,
  Rect rect,
  CameraController controller,
) async {
  final bytes = await File(path).readAsBytes();
  final original = img.decodeImage(bytes)!;

  final previewSize = controller.value.previewSize!;
  final previewWidth = previewSize.height;
  final previewHeight = previewSize.width;

  final scaleX = original.width / previewWidth;
  final scaleY = original.height / previewHeight;

  final cropX = (rect.left * scaleX).toInt();
  final cropY = (rect.top * scaleY).toInt();
  final cropW = (rect.width * scaleX).toInt();
  final cropH = (rect.height * scaleY).toInt();

  final cropped = img.copyCrop(
    original,
    x: cropX.clamp(0, original.width - 1),
    y: cropY.clamp(0, original.height - 1),
    width: cropW.clamp(1, original.width - cropX),
    height: cropH.clamp(1, original.height - cropY),
  );

  final dir = await getTemporaryDirectory();
  final file = File(
    '${dir.path}/crop_${DateTime.now().millisecondsSinceEpoch}.jpg',
  );

  await file.writeAsBytes(img.encodeJpg(cropped, quality: 95));

  return file;
}