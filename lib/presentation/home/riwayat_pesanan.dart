import 'package:flutter/material.dart';

class RiwayatPesananPage extends StatelessWidget {
  const RiwayatPesananPage({Key? key}) : super(key: key);

  final List<Map<String, String>> pesananList = const [
    {
      'layanan': 'Cuci & Setrika',
      'jumlah': '3 kg',
      'harga': 'Rp 15.000',
      'jenis': 'reguler',
    },
    {
      'layanan': 'Setrika Saja',
      'jumlah': '2 kg',
      'harga': 'Rp 10.000',
      'jenis': 'kilat',
    },
    {
      'layanan': 'Cuci Karpet',
      'jumlah': '4 m²',
      'harga': 'Rp 40.000',
      'jenis': 'reguler',
    },
    {
      'layanan': 'Cuci & Setrika',
      'jumlah': '5 kg',
      'harga': 'Rp 25.000',
      'jenis': 'reguler',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: const Color(0xFF0E1446),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pesananList.length,
        itemBuilder: (context, index) {
          final pesanan = pesananList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pesanan['layanan']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E1446),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${pesanan['jumlah']} - ${pesanan['harga']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Jenis: ${pesanan['jenis']}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 28),
                    SizedBox(height: 4),
                    Text(
                      'Selesai Diambil',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
