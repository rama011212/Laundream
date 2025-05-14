import 'package:flutter/material.dart';

class LaporanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan'),
      ),
      body: Column(
        children: <Widget>[
          Divider(thickness: 2, color: Colors.grey[300]), // Pembatas langsung di bawah AppBar
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Penambahan Kas',
                          style: TextStyle(color: Colors.white), // Warna teks putih
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0E1446), // Warna tombol
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Pengurangan Kas',
                          style: TextStyle(color: Colors.white), // Warna teks putih
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0E1446), // Warna tombol
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text('Saldo Kas'),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Saldo Tunai'),
                          Text('Rp 250.000'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Saldo Non-Tunai'),
                          Text('Rp 0'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                ListTile(
                  title: Row(
                    children: [
                      Text('Pesanan Hari Ini'),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Nilai Pesanan'),
                          Text('Rp 0'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Jumlah Pesanan'),
                          Text('0 Pesanan'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Pesanan Batal'),
                          Text('0 Pesanan'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total Belum Bayar'),
                          Text('Rp 25.000'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                ListTile(
                  title: Row(
                    children: [
                      Text('Lihat Laporan'),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18), // Jarak antara 'Lihat Laporan' dan 'Laporan Kas'
                      InkWell(
                        onTap: () {
                          // Handle tap for Laporan Kas
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF0E1446),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.attach_money_outlined, color: Colors.white),
                            ),
                            SizedBox(width: 8),
                            Text('Laporan Kas', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12), // Jarak antara 'Laporan Kas' dan 'Laporan Pesanan'
                      InkWell(
                        onTap: () {
                          // Handle tap for Laporan Pesanan
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF0E1446),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.receipt_long_outlined, color: Colors.white),
                            ),
                            SizedBox(width: 8),
                            Text('Laporan Pesanan', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
