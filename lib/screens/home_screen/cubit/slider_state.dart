part of 'slider_cubit.dart';

enum SliderStatus { initial, editing, error}

class SliderState extends Equatable {
  final SliderStatus status;
  final SfRangeValues newValues;
  final String? errorMessage;

  const SliderState({
    required this.newValues ,
    this.status = SliderStatus.initial,
    this.errorMessage,
  });

  SliderState copyWith({
    SfRangeValues? newValues,
    SliderStatus? status,
    String? errorMessage,
  }) {
    return SliderState(
      newValues: newValues ?? this.newValues,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status , errorMessage , newValues];}
