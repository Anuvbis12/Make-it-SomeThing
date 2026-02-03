import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/diagnosis_service.dart';
import 'diagnosis_state.dart';

class DiagnosisCubit extends Cubit<DiagnosisState> {
  final DiagnosisService _diagnosisService;
  final Set<String> _selectedSymptoms = {};
  String _currentFilter = 'All Symptoms';
  String _currentSearchQuery = '';

  DiagnosisCubit(this._diagnosisService) : super(const DiagnosisInitial());

  void toggleSymptom(String symptomCode) {
    if (_selectedSymptoms.contains(symptomCode)) {
      _selectedSymptoms.remove(symptomCode);
    } else {
      _selectedSymptoms.add(symptomCode);
    }
    _emitState();
  }

  void setFilter(String filter) {
    _currentFilter = filter;
    _emitState();
  }

  void setSearchQuery(String query) {
    _currentSearchQuery = query;
    _emitState();
  }

  void _emitState() {
    emit(DiagnosisInitial(
      selectedSymptoms: Set.from(_selectedSymptoms),
      activeFilter: _currentFilter,
      searchQuery: _currentSearchQuery,
    ));
  }

  void diagnose() async {
    if (_selectedSymptoms.isEmpty) {
      emit(const DiagnosisFailure('Please select at least one symptom to analyze.'));
      Future.delayed(const Duration(seconds: 2), () {
        if (!isClosed) _emitState();
      });
      return;
    }

    emit(DiagnosisLoading());

    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final result = _diagnosisService.diagnose(_selectedSymptoms);
      emit(DiagnosisSuccess(
        result, 
        Set.from(_selectedSymptoms), 
        activeFilter: _currentFilter,
        searchQuery: _currentSearchQuery,
      ));
    } catch (e) {
      emit(DiagnosisFailure(e.toString()));
    }
  }
  
  void reset() {
    _selectedSymptoms.clear();
    _currentFilter = 'All Symptoms';
    _currentSearchQuery = '';
    emit(const DiagnosisInitial(selectedSymptoms: {}, activeFilter: 'All Symptoms', searchQuery: ''));
  }
}
