import 'package:equatable/equatable.dart';
import '../../../core/services/diagnosis_service.dart';

abstract class DiagnosisState extends Equatable {
  const DiagnosisState();

  @override
  List<Object?> get props => [];
}

class DiagnosisInitial extends DiagnosisState {
  final Set<String> selectedSymptoms;
  final String activeFilter;
  final String searchQuery;

  const DiagnosisInitial({
    this.selectedSymptoms = const {},
    this.activeFilter = 'All Symptoms',
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [selectedSymptoms, activeFilter, searchQuery];
}

class DiagnosisLoading extends DiagnosisState {}

class DiagnosisSuccess extends DiagnosisState {
  final DiagnosisResult result;
  final Set<String> selectedSymptoms;
  final String activeFilter;
  final String searchQuery;

  const DiagnosisSuccess(
    this.result, 
    this.selectedSymptoms, {
    this.activeFilter = 'All Symptoms',
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [result, selectedSymptoms, activeFilter, searchQuery];
}

class DiagnosisFailure extends DiagnosisState {
  final String message;

  const DiagnosisFailure(this.message);

  @override
  List<Object?> get props => [message];
}
