import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:laundream/presentation/admin/tambah_layanan_screen.dart';

class LayananPage extends StatefulWidget {
  @override
  _LayananPageState createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  List<Map<String, dynamic>> layanan = [
    {
      'title': 'Cuci Setrika',
      'satuan': 'kg',
      'jenis': [
        {'nama': 'Reguler', 'harga': 5000},
        {'nama': 'Kilat', 'harga': 10000},
      ]
    },
    {
      'title': 'Setrika Saja',
      'satuan': 'kg',
      'jenis': [
        {'nama': 'Reguler', 'harga': 2500},
        {'nama': 'Kilat', 'harga': 5000},
      ]
    },
    {
      'title': 'Cuci Lipat',
      'satuan': 'kg',
      'jenis': [
        {'nama': 'Reguler', 'harga': 3000},
        {'nama': 'Kilat', 'harga': 6000},
      ]
    },
    {
      'title': 'Cuci Karpet',
      'satuan': 'meter',
      'jenis': [
        {'nama': 'Permeter', 'harga': 10000},
      ]
    },
  ];

  void _hapusLayanan(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Layanan'),
        content: Text('Apakah Anda yakin ingin menghapus layanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                layanan.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Layanan', style: GoogleFonts.poppins()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TambahLayananScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E1446),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Tambah Layanan',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: layanan.length,
              itemBuilder: (context, index) {
                return buildLayananCard(layanan[index], index)
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.2);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLayananCard(Map<String, dynamic> layananItem, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  layananItem['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0E1446),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _hapusLayanan(index),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...layananItem['jenis'].map<Widget>((j) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        j['nama'],
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                    Text(
                      'Rp ${formatRupiah(j['harga'])}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        layananItem['satuan'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF0E1446),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String formatRupiah(int harga) {
    return harga.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}