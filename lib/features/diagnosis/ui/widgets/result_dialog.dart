import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/diagnosis_service.dart';
import '../../logic/diagnosis_cubit.dart';

class ResultDialog extends StatelessWidget {
  final DiagnosisResult result;

  const ResultDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEA4C89).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.health_and_safety, color: Color(0xFFEA4C89), size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnosis Complete',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF9E9EA7),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Here is what we found',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0D0C22),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<DiagnosisCubit>().reset();
                },
                icon: const Icon(Icons.close),
                color: const Color(0xFF0D0C22),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F8FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF3F3F4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.diagnosis,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D0C22),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Color(0xFFEA4C89), size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        result.solution,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFF3D3D4E),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<DiagnosisCubit>().reset();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6E6D7A),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report saved successfully! (Demo)')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEA4C89),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save Report',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
