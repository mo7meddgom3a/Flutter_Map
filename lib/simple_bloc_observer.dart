import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {

  void onCreated(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: $bloc');
  }
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  void onChanged(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: $bloc, change: $change');
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error);
  }

  void onClosed(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: $bloc');
  }
}