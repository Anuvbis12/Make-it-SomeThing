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
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: widget.isSelected 
                        ? Border.all(color: const Color(0xFFEA4C89), width: 3)
                        : Border.all(color: Colors.transparent),
                      boxShadow: isHovered && !widget.isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ]
                          : [],
                    ),
                    child: Center(
                      child: AnimatedScale(
                        scale: isHovered ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          widget.isSelected ? Icons.check_circle : Icons.computer,
                          size: 64,
                          color: widget.isSelected ? const Color(0xFFEA4C89) : widget.color,
                        ),
                      ),
                    ),
                  ),
                  // Hover Overlay (Simulated for selected)
                  if (widget.isSelected)
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEA4C89).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  // Category Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.symptom.category,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0D0C22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
                      fontSize: 14,
                      color: isHovered ? const Color(0xFFEA4C89) : const Color(0xFF0D0C22),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Hardware Team',
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
                Icon(
                  widget.isSelected ? Icons.favorite : Icons.favorite_border,
                  size: 14,
                  color: widget.isSelected ? const Color(0xFFEA4C89) : const Color(0xFF9E9EA7),
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
                  size: 14,
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
