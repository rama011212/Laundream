import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LaporanKasPage extends StatelessWidget {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Dummy data riwayat kas
  final List<Map<String, dynamic>> kasData = [
    {
      'tipe': 'penambahan',
      'jumlah': 200000,
      'keterangan': 'Setoran dari owner',
      'tanggal': DateTime.now().subtract(Duration(days: 1)),
    },
    {
      'tipe': 'pengurangan',
      'jumlah': 50000,
      'keterangan': 'Beli deterjen',
      'tanggal': DateTime.now().subtract(Duration(days: 2)),
    },
    {
      'tipe': 'penambahan',
      'jumlah': 100000,
      'keterangan': 'Bayaran pelanggan',
      'tanggal': DateTime.now().subtract(Duration(days: 3)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Kas'),
        backgroundColor: Color(0xFF0E1446),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: kasData.length,
        itemBuilder: (context, index) {
          final item = kasData[index];
          final isPenambahan = item['tipe'] == 'penambahan';

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                isPenambahan ? Icons.arrow_downward : Icons.arrow_upward,
                color: isPenambahan ? Colors.green : Colors.red,
              ),
              title: Text(currencyFormatter.format(item['jumlah']),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isPenambahan ? Colors.green : Colors.red,
                  )),
              subtitle: Text(item['keterangan']),
              trailing: Text(
                DateFormat('dd MMM yyyy').format(item['tanggal']),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
