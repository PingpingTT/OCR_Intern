import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project_ocr2/feture/data/service/encryption_service.dart';

abstract class IdCardRemoteDataSource {
  Future<http.Response> uploadImage(File image);
}

class IdCardRemoteDataSourceImpl implements IdCardRemoteDataSource {
  final EncryptionService encryption;

  IdCardRemoteDataSourceImpl(this.encryption);

  @override
  Future<http.Response> uploadImage(File image) async {
    final uri = Uri.parse("http://127.0.0.1:8000/idcard/scan");

    final request = http.MultipartRequest("POST", uri);

    final bytes = await image.readAsBytes();

    final result = encryption.encryptBytes(bytes);

    request.fields["key"] = result["key"]!;

    request.fields["iv"] = result["iv"]!;

    request.fields["data"] = result["data"]!;

    final streamed = await request.send();

    return await http.Response.fromStream(streamed);
  }
}
