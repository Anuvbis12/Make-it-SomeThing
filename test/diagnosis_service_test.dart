import 'package:flutter_test/flutter_test.dart';
import 'package:chaining/diagnosis_service.dart';

void main() {
  late DiagnosisService diagnosisService;

  setUp(() {
    diagnosisService = DiagnosisService();
  });

  group('DiagnosisService - Forward Chaining Logic', () {
    test('Should diagnose Power Supply failure when G01, G02, G03 are present', () {
      final selectedSymptoms = {'G01', 'G02', 'G03'};
      final result = diagnosisService.diagnose(selectedSymptoms);
      
      expect(result.diagnosis, contains('Power Supply Rusak'));
      expect(result.solution, contains('ganti Power Supply Unit'));
    });

    test('Should diagnose RAM failure when G01, G04, G05 are present', () {
      final selectedSymptoms = {'G01', 'G04', 'G05'};
      final result = diagnosisService.diagnose(selectedSymptoms);

      expect(result.diagnosis, contains('RAM (Memory) Bermasalah'));
      expect(result.solution, contains('Bersihkan pin RAM'));
    });

    test('Should diagnose HDD/OS failure when G06, G07 are present', () {
      final selectedSymptoms = {'G06', 'G07'};
      final result = diagnosisService.diagnose(selectedSymptoms);

      expect(result.diagnosis, contains('Hard Disk atau Sistem Operasi Bermasalah'));
    });

    test('Should diagnose Virus/Overheat when G08 is present', () {
      final selectedSymptoms = {'G08'};
      final result = diagnosisService.diagnose(selectedSymptoms);

      expect(result.diagnosis, contains('Kemungkinan Virus atau Overheat'));
    });

    test('Should return unknown when symptoms do not match any rule', () {
      final selectedSymptoms = {'G01'}; // Only one symptom, not enough for rule
      final result = diagnosisService.diagnose(selectedSymptoms);

      expect(result.diagnosis, contains('Kerusakan tidak teridentifikasi'));
    });
    
    test('Should return unknown when empty', () {
      final selectedSymptoms = <String>{};
      final result = diagnosisService.diagnose(selectedSymptoms);

      expect(result.diagnosis, contains('Kerusakan tidak teridentifikasi'));
    });
  });
}
