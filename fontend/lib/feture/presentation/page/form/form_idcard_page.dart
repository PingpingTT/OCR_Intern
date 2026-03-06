import 'package:flutter/material.dart';
import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';
import 'package:project_ocr2/feture/presentation/widget/elevatedbt_template.dart';
import 'package:project_ocr2/feture/presentation/widget/formfill_template.dart';

class FormIdcardPage extends StatefulWidget {
  final IdCardEntity idCard;

  const FormIdcardPage({super.key, required this.idCard});

  @override
  State<FormIdcardPage> createState() => _FormIdcardPageState();
}

class _FormIdcardPageState extends State<FormIdcardPage> {
  late TextEditingController nameCtrl;
  late TextEditingController idCtrl;
  late TextEditingController dobCtrl;
  late TextEditingController issueCtrl;
  late TextEditingController expireCtrl;

  @override
  void initState() {
    super.initState();

    nameCtrl = TextEditingController(text: widget.idCard.fullName);
    idCtrl = TextEditingController(text: widget.idCard.idCard);
    dobCtrl = TextEditingController(text: widget.idCard.birthDate);
    issueCtrl = TextEditingController(text: widget.idCard.issueDate);
    expireCtrl = TextEditingController(text: widget.idCard.expiryDate);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    idCtrl.dispose();
    dobCtrl.dispose();
    issueCtrl.dispose();
    expireCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form ID Card"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormfillTemplate(
                  hintText: "ชื่อ-นามสกุล",
                  fillColor: Colors.white,
                  controller: nameCtrl,
                ),
                const SizedBox(height: 16),
                FormfillTemplate(
                  hintText: "เลขบัตรประชาชน",
                  fillColor: Colors.white,
                  controller: idCtrl,
                ),
                const SizedBox(height: 16),
                FormfillTemplate(
                  hintText: "วัน/เดือน/ปีเกิด",
                  fillColor: Colors.white,
                  controller: dobCtrl,
                ),
                const SizedBox(height: 16),
                FormfillTemplate(
                  hintText: "วันออกบัตร",
                  fillColor: Colors.white,
                  controller: issueCtrl,
                ),
                const SizedBox(height: 16),
                FormfillTemplate(
                  hintText: "วันหมดอายุ",
                  fillColor: Colors.white,
                  controller: expireCtrl,
                ),
                const SizedBox(height: 16),
                ElevatedbtTemplate(
                  text: "บันทึก",
                  backgroundColor: Colors.lightBlue,
                  onPressed: () {
                    final updatedEntity = IdCardEntity(
                      idCard: idCtrl.text,
                      fullName: nameCtrl.text,
                      birthDate: dobCtrl.text,
                      issueDate: issueCtrl.text,
                      expiryDate: expireCtrl.text,
                    );

                    debugPrint("SAVE SUCCESS");
                    debugPrint(updatedEntity.toString());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
