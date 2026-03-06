import 'dart:io';
import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';
import 'package:project_ocr2/feture/domain/repository/id_card_repository.dart';


class ScanIdCardUseCase {
  final IdCardRepository repository;

  ScanIdCardUseCase(this.repository);

  Future<IdCardEntity> call(File image) {
    return repository.scanIdCard(image);
  }
}
