import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_bloc.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_event.dart';
import 'package:project_ocr2/feture/presentation/bloc/id_card/id_card_state.dart';
import 'package:project_ocr2/feture/presentation/page/form/form_idcard_page.dart';
import 'package:project_ocr2/feture/presentation/page/stack/document_camera_page.dart';
import 'package:project_ocr2/feture/presentation/widget/elevatedbt_template.dart';

class FristPage extends StatelessWidget {
  const FristPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<IdCardBloc, IdCardState>(
        listener: (context, state) {
          if (state is IdCardSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FormIdcardPage(idCard: state.entity),
              ),
            );
          }

          if (state is IdCardError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<IdCardBloc, IdCardState>(
          builder: (context, state) {
            if (state is IdCardLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedbtTemplate(
                    text: "บัตรประชาชน",
                    backgroundColor: Colors.blue,
                    onPressed: () async {
                      final File? image = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DocumentCameraPage(),
                        ),
                      );

                      if (image != null) {
                        context.read<IdCardBloc>().add(
                          UploadIdCardEvent(image),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedbtTemplate(
                    text: "แกลลอรี่",
                    backgroundColor: Colors.blue,
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (pickedFile != null) {
                        context.read<IdCardBloc>().add(
                          UploadIdCardEvent(File(pickedFile.path)),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
