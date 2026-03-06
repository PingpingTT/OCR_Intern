import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ocr2/core/di/injection.dart' as di;
import 'package:project_ocr2/core/di/injection.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_bloc.dart';
import 'package:project_ocr2/feture/presentation/page/frist_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<IdCardBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FristPage(),
      ),
    );
  }
}