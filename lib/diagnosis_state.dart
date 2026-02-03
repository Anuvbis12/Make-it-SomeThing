import 'package:equatable/equatable.dart';
import 'diagnosis_service.dart';

abstract class DiagnosisState extends Equatable {
  const DiagnosisState();

  @override
  List<Object?> get props => [];
}

class DiagnosisInitial extends DiagnosisState {
  final Set<String> selectedSymptoms;

  const DiagnosisInitial({this.selectedSymptoms = const {}});

  @override
  List<Object?> get props => [selectedSymptoms];
}

class DiagnosisLoading extends DiagnosisState {}

class DiagnosisSuccess extends DiagnosisState {
  final DiagnosisResult result;
  final Set<String> selectedSymptoms;

  const DiagnosisSuccess(this.result, this.selectedSymptoms);

  @override
  List<Object?> get props => [result, selectedSymptoms];
}

class DiagnosisFailure extends DiagnosisState {
  final String message;

  const DiagnosisFailure(this.message);

  @override
  List<Object?> get props => [message];
}
