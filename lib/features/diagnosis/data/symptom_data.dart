class SymptomData {
  final String code;
  final String name;
  final String category;

  const SymptomData(this.code, this.name, this.category);
}

// Data Dummy Global
const List<SymptomData> allSymptomsData = [
  SymptomData('G01', 'Komputer tidak mau menyala', 'Power'),
  SymptomData('G02', 'Lampu indikator power mati', 'Power'),
  SymptomData('G03', 'Kipas power supply tidak berputar', 'Power'),
  SymptomData('G04', 'Bunyi beep panjang berulang', 'Performance'),
  SymptomData('G05', 'Layar monitor gelap/tidak ada tampilan', 'Display'),
  SymptomData('G06', 'Komputer sering restart sendiri', 'Performance'),
  SymptomData('G07', 'Blue Screen of Death (BSOD)', 'System'),
  SymptomData('G08', 'Kinerja komputer lambat', 'Performance'),
];
