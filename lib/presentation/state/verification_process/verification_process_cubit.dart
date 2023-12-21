import 'package:bloc/bloc.dart';
part 'verification_process_state.dart';

class VerificationProcessCubit extends Cubit<VerificationProcessState> {
  VerificationProcessCubit() : super(const VerificationProcessState(0));

  void nextProcess() {
    final newIndex = state.currentIndex + 1;
    emit(VerificationProcessState(newIndex));
  }

  void setProcess(int index) {
    emit(VerificationProcessState(index));
  }
}
