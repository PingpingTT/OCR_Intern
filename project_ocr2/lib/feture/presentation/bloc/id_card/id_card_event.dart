import 'dart:io';

abstract class IdCardEvent {}

class UploadIdCardEvent extends IdCardEvent {
  final File image;

  UploadIdCardEvent(this.image);
}
