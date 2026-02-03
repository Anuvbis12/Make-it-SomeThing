import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/services/diagnosis_service.dart';
import '../data/symptom_data.dart';
import '../logic/diagnosis_cubit.dart';
import '../logic/diagnosis_state.dart';
import 'widgets/symptom_card.dart';
import 'widgets/result_dialog.dart';

class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({super.key});

  Color _getPlaceholderColor(int index) {
    final colors = [
      const Color(0xFFFFD166), // Yellow
      const Color(0xFF06D6A0), // Green
      const Color(0xFF118AB2), // Blue
      const Color(0xFFEF476F), // Red
      const Color(0xFF8338EC), // Purple
      const Color(0xFFFF9F1C), // Orange
      const Color(0xFF2EC4B6), // Teal
      const Color(0xFF3A86FF), // Royal Blue
    ];
    return colors[index % colors.length];
  }

  void _showResultDialog(BuildContext context, DiagnosisResult result) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ResultDialog(result: result),
      ),
    );
  }

  void _showFeatureNotAvailable(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName feature is coming soon!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF0D0C22),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFF3F3F4))),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleSpacing: 24,
                title: Row(
                  children: [
                    InkWell(
                      onTap: () => context.read<DiagnosisCubit>().reset(),
                      child: Row(
                        children: [
                          Text(
                            'Hardware',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: const Color(0xFF0D0C22),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEA4C89),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Expert',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    if (MediaQuery.of(context).size.width > 900) ...[
                      _buildWebNavLink(context, 'Inspiration'),
                      _buildWebNavLink(context, 'Find Work'),
                      _buildWebNavLink(context, 'Learn Design'),
                      _buildWebNavLink(context, 'Go Pro'),
                      _buildWebNavLink(context, 'Hire Designers'),
                    ],
                  ],
                ),
                actions: [
                  if (MediaQuery.of(context).size.width > 800) ...[
                    TextButton(
                      onPressed: () => _showFeatureNotAvailable(context, 'Sign In'),
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6E6D7A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _showFeatureNotAvailable(context, 'Sign Up'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEA4C89),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                  ] else
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: IconButton(
                        icon: const Icon(Icons.menu, color: Color(0xFF0D0C22)),
                        onPressed: () => _showFeatureNotAvailable(context, 'Menu'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocListener<DiagnosisCubit, DiagnosisState>(
        listener: (context, state) {
          if (state is DiagnosisSuccess) {
            _showResultDialog(context, state.result);
          } else if (state is DiagnosisFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Stack(
          children: [
            // Background Mesh Gradient (Hiasan)
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFEA4C89).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            
            // Main Content
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    // Hero / Filter Section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
                      child: Column(
                        children: [
                          FadeInDown(
                            child: Text(
                              'Diagnose your hardware issues instantly.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 42, // Lebih besar
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0D0C22),
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeInDown(
                            delay: const Duration(milliseconds: 200),
                            child: Text(
                              'Select the symptoms below to find the best solution for your computer problems.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: const Color(0xFF6E6D7A),
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                          
                          // Search Bar
                          FadeInDown(
                            delay: const Duration(milliseconds: 300),
                            child: Container(
                              width: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                border: Border.all(color: Colors.white),
                              ),
                              child: TextField(
                                onChanged: (value) => context.read<DiagnosisCubit>().setSearchQuery(value),
                                style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFF0D0C22)),
                                decoration: InputDecoration(
                                  hintText: 'Search symptoms (e.g., "Mati", "Blue Screen")...',
                                  hintStyle: GoogleFonts.inter(color: const Color(0xFF9E9EA7)),
                                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF9E9EA7)),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                          // Filter Chips
                          BlocBuilder<DiagnosisCubit, DiagnosisState>(
                            builder: (context, state) {
                              String currentFilter = 'All Symptoms';
                              if (state is DiagnosisInitial) currentFilter = state.activeFilter;
                              if (state is DiagnosisSuccess) currentFilter = state.activeFilter;

                              return Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                alignment: WrapAlignment.center,
                                children: [
                                  _buildFilterChip(context, 'All Symptoms', currentFilter),
                                  _buildFilterChip(context, 'Power', currentFilter),
                                  _buildFilterChip(context, 'Display', currentFilter),
                                  _buildFilterChip(context, 'Performance', currentFilter),
                                  _buildFilterChip(context, 'System', currentFilter),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    // Grid Content
                    Expanded(
                      child: BlocBuilder<DiagnosisCubit, DiagnosisState>(
                        builder: (context, state) {
                          Set<String> currentSelection = {};
                          String currentFilter = 'All Symptoms';
                          String searchQuery = '';
                          
                          if (state is DiagnosisInitial) {
                            currentSelection = state.selectedSymptoms;
                            currentFilter = state.activeFilter;
                            searchQuery = state.searchQuery;
                          } else if (state is DiagnosisSuccess) {
                            currentSelection = state.selectedSymptoms;
                            currentFilter = state.activeFilter;
                            searchQuery = state.searchQuery;
                          }

                          // Filter & Search Logic
                          final filteredSymptoms = allSymptomsData.where((s) {
                            final matchesFilter = currentFilter == 'All Symptoms' || s.category == currentFilter;
                            final matchesSearch = s.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                                                  s.code.toLowerCase().contains(searchQuery.toLowerCase());
                            return matchesFilter && matchesSearch;
                          }).toList();

                          if (filteredSymptoms.isEmpty) {
                            return Center(
                              child: FadeInUp(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.search_off_rounded, size: 48, color: Colors.grey[400]),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'No symptoms found',
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0D0C22),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Try adjusting your search or filter criteria.',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: const Color(0xFF6E6D7A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // Responsive Grid Count
                          int crossAxisCount = 4;
                          double width = MediaQuery.of(context).size.width;
                          if (width < 600) crossAxisCount = 1;
                          else if (width < 900) crossAxisCount = 2;
                          else if (width < 1200) crossAxisCount = 3;

                          return GridView.builder(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 32,
                              mainAxisSpacing: 32,
                            ),
                            itemCount: filteredSymptoms.length,
                            itemBuilder: (context, index) {
                              final symptom = filteredSymptoms[index];
                              final isSelected = currentSelection.contains(symptom.code);
                              final color = _getPlaceholderColor(index);

                              return FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: index * 50), // Staggered animation
                                key: ValueKey(symptom.code), 
                                child: SymptomCard(
                                  symptom: symptom,
                                  isSelected: isSelected,
                                  color: color,
                                  onTap: () => context.read<DiagnosisCubit>().toggleSymptom(symptom.code),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<DiagnosisCubit, DiagnosisState>(
        builder: (context, state) {
          bool isButtonEnabled = false;
          if (state is DiagnosisInitial) {
            isButtonEnabled = state.selectedSymptoms.isNotEmpty;
          } else if (state is DiagnosisSuccess) {
            isButtonEnabled = state.selectedSymptoms.isNotEmpty;
          }

          if (!isButtonEnabled) return const SizedBox.shrink();

          return FadeInUp(
            child: Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: FloatingActionButton.extended(
                onPressed: () => context.read<DiagnosisCubit>().diagnose(),
                backgroundColor: const Color(0xFFEA4C89),
                elevation: 8,
                hoverColor: const Color(0xFFF082AC),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        'Analyze Selected Issues',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.analytics_outlined, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWebNavLink(BuildContext context, String label) {
    return InkWell(
      onTap: () => _showFeatureNotAvailable(context, label),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6E6D7A),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, String currentFilter) {
    final isActive = label == currentFilter;
    return InkWell(
      onTap: () => context.read<DiagnosisCubit>().setFilter(label),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF3F3F4) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            color: isActive ? const Color(0xFF0D0C22) : const Color(0xFF6E6D7A),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
