import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';
import 'package:equatable/equatable.dart';

abstract class IdCardState extends Equatable {
  const IdCardState();

  @override
  List<Object?> get props => [];
}

class IdCardInitial extends IdCardState {}

class IdCardLoading extends IdCardState {
  const IdCardLoading();

  @override
  List<Object?> get props => [];
}

class IdCardSuccess extends IdCardState {
  final IdCardEntity entity;

  const IdCardSuccess(this.entity);

  @override
  List<Object?> get props => [entity];
}

class IdCardError extends IdCardState {
  final String message;

  const IdCardError(this.message);

  @override
  List<Object?> get props => [message];
}
