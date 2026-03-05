import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ocr2/feture/domain/usecase/scan_idcard_usecase.dart';
import 'id_card_event.dart';
import 'id_card_state.dart';

class IdCardBloc extends Bloc<IdCardEvent, IdCardState> {
  final ScanIdCardUseCase usecase;

  IdCardBloc(this.usecase) : super(IdCardInitial()) {
    on<UploadIdCardEvent>((event, emit) async {
      emit(IdCardLoading());

      try {
        final entity = await usecase(event.image);
        emit(IdCardSuccess(entity));
      } catch (e) {
        emit(IdCardError(e.toString()));
      }
    });
  }
}
