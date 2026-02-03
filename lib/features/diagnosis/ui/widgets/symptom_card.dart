import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/symptom_data.dart';

class SymptomCard extends StatefulWidget {
  final SymptomData symptom;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const SymptomCard({
    super.key,
    required this.symptom,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  State<SymptomCard> createState() => _SymptomCardState();
}

class _SymptomCardState extends State<SymptomCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Image Area
            Expanded(
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    transform: Matrix4.translationValues(0, isHovered ? -8 : 0, 0), // Efek Melayang
                    decoration: BoxDecoration(
                      color: widget.isSelected 
                          ? widget.color.withOpacity(0.1) 
                          : widget.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16), // Lebih bulat
                      border: widget.isSelected 
                        ? Border.all(color: const Color(0xFFEA4C89), width: 2)
                        : Border.all(color: Colors.transparent, width: 2),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: widget.color.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                    ),
                    child: Center(
                      child: AnimatedScale(
                        scale: isHovered ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        child: Icon(
                          widget.isSelected ? Icons.check_circle_rounded : Icons.computer_rounded,
                          size: 64,
                          color: widget.isSelected ? const Color(0xFFEA4C89) : widget.color,
                        ),
                      ),
                    ),
                  ),
                  // Category Badge
                  Positioned(
                    top: 16,
                    right: 16,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isHovered || widget.isSelected ? 1.0 : 0.0, // Muncul saat hover/select
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          widget.symptom.category,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0D0C22),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Title & Meta
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.symptom.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: isHovered ? const Color(0xFFEA4C89) : const Color(0xFF0D0C22),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/150?img=12'), // Dummy Avatar
                    ),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Tech Support',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0D0C22),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCC3E8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'PRO',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.isSelected ? Icons.favorite : Icons.favorite_border_rounded,
                    key: ValueKey(widget.isSelected),
                    size: 16,
                    color: widget.isSelected ? const Color(0xFFEA4C89) : const Color(0xFF9E9EA7),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  widget.isSelected ? '1' : '0',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9E9EA7),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.visibility_outlined,
                  size: 16,
                  color: Color(0xFF9E9EA7),
                ),
                const SizedBox(width: 4),
                Text(
                  '1.2k',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9E9EA7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
