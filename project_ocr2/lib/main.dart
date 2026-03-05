import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ocr2/feture/data/datasourse/id_card_remote_datasource.dart';
import 'package:project_ocr2/feture/data/repository/id_card_repository_impl.dart';
import 'package:project_ocr2/feture/data/service/encryption_service.dart';
import 'package:project_ocr2/feture/domain/usecase/scan_idcard_usecase.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_bloc.dart';
import 'package:project_ocr2/feture/presentation/page/frist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final encryption = EncryptionService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => IdCardBloc(
            ScanIdCardUseCase(
              IdCardRepositoryImpl(
                IdCardRemoteDataSourceImpl(encryption,),
              ),
            ),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FristPage(),
      ),
    );
  }
}