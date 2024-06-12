import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(const SliderState(newValues: SfRangeValues(40, 60)));


  onSliderChanged(SfRangeValues newValues){
    emit(state.copyWith(status: SliderStatus.initial , newValues: const SfRangeValues(40, 60)));
    try {
      emit(state.copyWith(status: SliderStatus.editing , newValues: newValues));
    } catch (e) {
      emit(state.copyWith(status: SliderStatus.error , errorMessage: e.toString()));
    }
  }
}
