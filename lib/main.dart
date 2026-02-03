import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/services/diagnosis_service.dart';
import 'features/diagnosis/logic/diagnosis_cubit.dart';
import 'features/diagnosis/ui/diagnosis_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase
  // Pastikan Anda sudah menjalankan 'flutterfire configure' dan mengganti isi firebase_options.dart
  // dengan konfigurasi proyek Firebase Anda yang sebenarnya.
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Fallback jika firebase_options belum dikonfigurasi dengan benar
    // atau jika dijalankan di platform yang belum didukung
    debugPrint('Firebase initialization failed: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hardware Expert',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Dribbble Colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEA4C89), // Dribbble Pink
          primary: const Color(0xFFEA4C89),
          secondary: const Color(0xFF0D0C22), // Dribbble Black
          surface: Colors.white,
        ).copyWith(
          surface: Colors.white, // Explicitly set surface color
        ),
        useMaterial3: true,
        // Menggunakan font Inter agar mirip website modern
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: const Color(0xFF0D0C22),
          displayColor: const Color(0xFF0D0C22),
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F8FD),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0D0C22)),
        ),
      ),
      home: BlocProvider(
        create: (context) => DiagnosisCubit(DiagnosisService()),
        child: const DiagnosisPage(),
      ),
    );
  }
}
