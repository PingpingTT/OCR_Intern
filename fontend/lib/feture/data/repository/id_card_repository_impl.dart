import 'dart:convert';
import 'dart:io';
import 'package:project_ocr2/feture/data/datasourse/id_card_remote_datasource.dart';
import 'package:project_ocr2/feture/data/model/id_card_model.dart';
import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';
import 'package:project_ocr2/feture/domain/repository/id_card_repository.dart';

class IdCardRepositoryImpl implements IdCardRepository {
  final IdCardRemoteDataSource remote;

  IdCardRepositoryImpl(this.remote);

  @override
  Future<IdCardEntity> scanIdCard(File image) async {
    final response = await remote.uploadImage(image);

    if (response.statusCode != 200) {
      throw Exception("Server error");
    }

    final jsonData = jsonDecode(response.body);
    final model = IdCardModel.fromJson(jsonData);

    return model.toEntity();
  }
}
