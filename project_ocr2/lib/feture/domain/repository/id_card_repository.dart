import 'dart:io';
import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';

abstract class IdCardRepository {
  Future<IdCardEntity> scanIdCard(File image);
}
