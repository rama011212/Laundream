import 'package:flutter/material.dart';
import 'package:laundream/presentation/admin/utilitas/konstanta_aplikasi.dart'; // Perubahan di sini
import 'package:laundream/presentation/admin/utilitas/pembantu_aplikasi.dart'; // Perubahan di sini

class LembarGantiStatus extends StatelessWidget {
  const LembarGantiStatus({
    super.key,
    required this.statusSaatIni,
  });

  final String statusSaatIni;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: KonstantaAplikasi.daftarStatus.map((s) {
          final isSelected = s == statusSaatIni;
          final warna = KonstantaAplikasi.warnaStatus[s]!;
          return GestureDetector(
            onTap: () => Navigator.pop(context, s),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? warna.withOpacity(0.2) : Colors.grey[200],
                border: Border.all(
                  color: isSelected ? warna : Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PembantuAplikasi.ikonStatus(s),
                    color: warna,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    s,
                    style: TextStyle(
                      color: warna,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}