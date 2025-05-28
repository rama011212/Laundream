import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundream/presentation/admin/tambah_kas.dart';
import 'package:laundream/presentation/admin/pengurangan_kas.dart';
import 'package:laundream/presentation/admin/laporan_kas.dart';
import 'package:laundream/presentation/admin/laporan_pesanan.dart';

class LaporanPage extends StatelessWidget {
  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0E1446),
      ),
      body: Column(
        children: <Widget>[
          Divider(thickness: 2, color: Colors.grey[300]),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TambahKasPage()),
                    );
                  },
                  child: Text(
                    'Penambahan Kas',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0E1446),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PenguranganKasPage()),
                    );
                  },
                  child: Text(
                    'Pengurangan Kas',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0E1446),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                buildCardSection(
                  title: 'Saldo Kas',
                  children: [
                    buildRow('Saldo Tunai', currencyFormatter.format(250000)),
                    buildRow('Saldo Non-Tunai', currencyFormatter.format(0)),
                  ],
                ),
                SizedBox(height: 12),
                buildCardSection(
                  title: 'Pesanan Hari Ini',
                  children: [
                    buildRow('Nilai Pesanan', currencyFormatter.format(0)),
                    buildRow('Jumlah Pesanan', '0 Pesanan'),
                    buildRow('Pesanan Batal', '0 Pesanan'),
                    buildRow(
                        'Total Belum Bayar', currencyFormatter.format(25000)),
                  ],
                ),
                SizedBox(height: 12),
                buildCardSection(
                  title: 'Lihat Laporan',
                  children: [
                    laporanItem(
                      context,
                      icon: Icons.attach_money_outlined,
                      text: 'Laporan Kas',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LaporanKasPage()),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    laporanItem(
                      context,
                      icon: Icons.receipt_long_outlined,
                      text: 'Laporan Pesanan',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LaporanPesananPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardSection(
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget laporanItem(BuildContext context,
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF0E1446),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(10),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 12),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
