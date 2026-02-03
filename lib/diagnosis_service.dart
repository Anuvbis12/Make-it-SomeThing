class DiagnosisResult {
  final String diagnosis;
  final String solution;

  DiagnosisResult(this.diagnosis, this.solution);
}

class DiagnosisService {
  DiagnosisResult diagnose(Set<String> selectedSymptoms) {
    // Rule 1: Jika G01 AND G02 AND G03 THEN Power Supply Rusak
    if (selectedSymptoms.contains('G01') &&
        selectedSymptoms.contains('G02') &&
        selectedSymptoms.contains('G03')) {
      return DiagnosisResult(
        'Power Supply Rusak',
        'Periksa kabel power atau ganti Power Supply Unit (PSU).',
      );
    }
    // Rule 2: Jika G01 AND G04 AND G05 THEN RAM Bermasalah
    else if (selectedSymptoms.contains('G01') &&
        selectedSymptoms.contains('G04') &&
        selectedSymptoms.contains('G05')) {
      return DiagnosisResult(
        'RAM (Memory) Bermasalah',
        'Bersihkan pin RAM atau ganti keping RAM.',
      );
    }
    // Rule 3: Jika G06 AND G07 THEN Hard Disk atau OS Bermasalah
    else if (selectedSymptoms.contains('G06') &&
        selectedSymptoms.contains('G07')) {
      return DiagnosisResult(
        'Hard Disk atau Sistem Operasi Bermasalah',
        'Cek kesehatan Hard Disk atau install ulang OS.',
      );
    }
    // Rule 4: Jika G08 THEN Kemungkinan Virus atau Overheat
    else if (selectedSymptoms.contains('G08')) {
      return DiagnosisResult(
        'Kemungkinan Virus atau Overheat',
        'Scan antivirus atau bersihkan debu pada kipas prosesor.',
      );
    }

    return DiagnosisResult(
      'Kerusakan tidak teridentifikasi atau data gejala kurang lengkap.',
      'Silakan hubungi teknisi untuk pemeriksaan lebih lanjut.',
    );
  }
}
