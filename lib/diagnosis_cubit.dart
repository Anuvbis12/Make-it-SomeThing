import 'package:flutter_bloc/flutter_bloc.dart';
import 'diagnosis_service.dart';
import 'diagnosis_state.dart';

class DiagnosisCubit extends Cubit<DiagnosisState> {
  final DiagnosisService _diagnosisService;
  final Set<String> _selectedSymptoms = {};

  DiagnosisCubit(this._diagnosisService) : super(const DiagnosisInitial());

  void toggleSymptom(String symptomCode) {
    if (_selectedSymptoms.contains(symptomCode)) {
      _selectedSymptoms.remove(symptomCode);
    } else {
      _selectedSymptoms.add(symptomCode);
    }
    emit(DiagnosisInitial(selectedSymptoms: Set.from(_selectedSymptoms)));
  }

  void diagnose() async {
    if (_selectedSymptoms.isEmpty) {
      emit(const DiagnosisFailure('Pilih setidaknya satu gejala.'));
      return;
    }

    emit(DiagnosisLoading());

    // Simulate a short delay for better UX (optional)
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final result = _diagnosisService.diagnose(_selectedSymptoms);
      emit(DiagnosisSuccess(result, Set.from(_selectedSymptoms)));
    } catch (e) {
      emit(DiagnosisFailure(e.toString()));
    }
  }
  
  void reset() {
    _selectedSymptoms.clear();
    emit(const DiagnosisInitial(selectedSymptoms: {}));
  }
}
