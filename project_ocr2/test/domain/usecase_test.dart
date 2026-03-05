import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';
import 'package:project_ocr2/feture/domain/usecase/scan_idcard_usecase.dart';
import 'package:project_ocr2/feture/domain/repository/id_card_repository.dart';

class MockIdCardRepository extends Mock 
    implements IdCardRepository {}

void main() {
  late ScanIdCardUseCase usecase;
  late MockIdCardRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(File('dummy.jpg'));
  });

  setUp(() {
    mockRepository = MockIdCardRepository();
    usecase = ScanIdCardUseCase(mockRepository);
  });

  test('should return IdCardEntity when scan success', () async {
    final fakeImage = File('test.jpg');

    final fakeEntity = IdCardEntity(
      idCard: '1234567890123',
      fullName: 'John Doe',
      birthDate: '12/10/2004',
      issueDate: '12/10/2004',
      expiryDate: '12/10/2004',
    );

    when(() => mockRepository.scanIdCard(any()))
        .thenAnswer((_) async => fakeEntity);

    final result = await usecase(fakeImage);

    expect(result, fakeEntity);
    verify(() => mockRepository.scanIdCard(fakeImage)).called(1);
  });
}