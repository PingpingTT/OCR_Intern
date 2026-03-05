import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';
import 'package:project_ocr2/feture/domain/usecase/scan_idcard_usecase.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_bloc.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_event.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_state.dart';


class MockScanIdCardUseCase extends Mock
    implements ScanIdCardUseCase {}

void main() {
  late IdCardBloc bloc;
  late MockScanIdCardUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(File('dummy.jpg'));
  });

  setUp(() {
    mockUseCase = MockScanIdCardUseCase();
    bloc = IdCardBloc(mockUseCase);
  });

  final fakeImage = File('test.jpg');

  final fakeEntity = IdCardEntity(
    idCard: '1234567890123',
    fullName: 'John Doe',
    birthDate: '12/10/2004',
    issueDate: '12/10/2004',
    expiryDate: '12/10/2004',
  );

  group('IdCardBloc', () {

    blocTest<IdCardBloc, IdCardState>(
      'emits [Loading, Success] when scan is successful',
      build: () {
        when(() => mockUseCase(fakeImage))
            .thenAnswer((_) async => fakeEntity);
        return bloc;
      },
      act: (bloc) => bloc.add(UploadIdCardEvent(fakeImage)),
      expect: () => [
        IdCardLoading(),
        IdCardSuccess(fakeEntity),
      ],
      verify: (_) {
        verify(() => mockUseCase(fakeImage)).called(1);
      },
    );

    blocTest<IdCardBloc, IdCardState>(
      'emits [Loading, Error] when scan fails',
      build: () {
        when(() => mockUseCase(fakeImage))
            .thenThrow(Exception('Server Error'));
        return bloc;
      },
      act: (bloc) => bloc.add(UploadIdCardEvent(fakeImage)),
      expect: () => [
        IdCardLoading(),
        isA<IdCardError>(),
      ],
    );

  });
}