import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  Map<String,String> encryptBytes(
      Uint8List data){
    final key =
      Key.fromSecureRandom(32);
    final iv =
      IV.fromSecureRandom(16);
    final encrypter =
      Encrypter(
        AES(
          key,
          mode: AESMode.cbc,
          padding: "PKCS7",
        ),
      );

    final encrypted =
      encrypter.encryptBytes(
        data,
        iv: iv,
      );
    return {
      "key":
        base64Encode(key.bytes),

      "iv":
        base64Encode(iv.bytes),

      "data":
        base64Encode(
          encrypted.bytes),

    };
  }
}