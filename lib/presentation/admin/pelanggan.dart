import 'package:flutter/material.dart';
import 'package:laundream/presentation/admin/detail_pelanggan.dart';

class PelangganPage extends StatefulWidget {
  @override
  _PelangganPageState createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredPelanggan = [];

  final List<Map<String, dynamic>> pelangganList = [
    {
      'nama': 'Rama Putra',
      'nomor': '0812-3456-7890',
      'gender': 'Laki-laki',
      'alamat': 'Jl. Melati No. 1',
    },
    {
      'nama': 'Dina Ayu',
      'nomor': '0895-7325-4612',
      'gender': 'Perempuan',
      'alamat': 'Jl. Mawar No. 2',
    },
  ];

  final List<Map<String, dynamic>> orders = [
    {
      'nama': 'Rama Putra',
      'phone': '0812-3456-7890',
      'gender': 'Laki-laki',
      'layanan': 'Reguler',
      'jenis': 'Cuci Setrika',
      'beratLuas': '3 Kg',
      'harga': 15000,
      'masuk': DateTime(2025, 5, 18),
      'selesai': null,
      'status': 'Belum Diterima',
      'sudahBayar': false,
    },
    {
      'nama': 'Dina Ayu',
      'phone': '0895-7325-4612',
      'gender': 'Perempuan',
      'layanan': 'Reguler',
      'jenis': 'Cuci Setrika',
      'beratLuas': '5 Kg',
      'harga': 25000,
      'masuk': DateTime(2025, 5, 15),
      'selesai': DateTime(2025, 5, 17),
      'status': 'Selesai',
      'sudahBayar': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredPelanggan = pelangganList;
  }

  void _searchPelanggan(String query) {
    final hasil = pelangganList.where((pelanggan) {
      final nama = pelanggan['nama'].toString().toLowerCase();
      return nama.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredPelanggan = hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Pelanggan'),
        elevation: 0,
        backgroundColor: Color(0xFF0E1446),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: _searchPelanggan,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Cari nama pelanggan...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Color(0xFF0E1446),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPelanggan.length,
              itemBuilder: (_, index) {
                final p = filteredPelanggan[index];
                final genderIcon = p['gender'] == 'Laki-laki'
                    ? Icons.male
                    : Icons.female;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFF0E1446),
                        child: Icon(genderIcon, color: Colors.white),
                      ),
                      title: Text(
                        p['nama'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E1446),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text(p['nomor'], style: TextStyle(color: Colors.grey[700])),
                          Text(p['alamat'], style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right, color: Color(0xFF0E1446)),
                      onTap: () {
                        final riwayat = orders
                            .where((o) =>
                                o['nama'] == p['nama'] &&
                                o['status'] == 'Selesai')
                            .toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PelangganDetailPage(
                              pelanggan: p,
                              orders: riwayat,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


