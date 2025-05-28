import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PelangganDetailPage extends StatelessWidget {
  final Map<String, dynamic> pelanggan;
  final List<Map<String, dynamic>> orders;

  const PelangganDetailPage({
    super.key,
    required this.pelanggan,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      body: Column(
        children: [
          // HERO
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0E1446), Color(0xFF1F2D7A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 36, color: Color(0xFF0E1446)),
                ),
                const SizedBox(height: 12),
                Text(
                  pelanggan['nama'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(pelanggan['nomor'], style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 2),
                Text(
                  '${pelanggan['gender']} • ${pelanggan['alamat']}',
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // RIWAYAT PESANAN
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Riwayat Pesanan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E1446),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: orders.isEmpty
                        ? const Center(child: Text('Belum ada pesanan yang selesai.'))
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: orders.length,
                            itemBuilder: (_, i) {
                              final o = orders[i];
                              final sudahBayar = o['sudahBayar'] == true;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Judul layanan
                                    Text(
                                      '${o['jenis']} • ${o['layanan']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0E1446),
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // Info
                                    _info('Berat/Luas', '${o['beratLuas']}'),
                                    _info('Harga', 'Rp ${o['harga']}'),
                                    _info('Masuk', DateFormat('dd MMM yyyy').format(o['masuk'])),
                                    _info(
                                      'Selesai',
                                      o['selesai'] != null
                                          ? DateFormat('dd MMM yyyy').format(o['selesai'])
                                          : '-',
                                    ),
                                    const SizedBox(height: 6),

                                    // Status bayar
                                    Text(
                                      sudahBayar ? 'Sudah Bayar' : 'Belum Bayar',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: sudahBayar ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
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
    );
  }

  Widget _info(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
}
