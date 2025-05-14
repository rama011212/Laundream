import 'package:flutter/material.dart';

class LayananPage extends StatefulWidget {
  @override
  _LayananPageState createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  final List<Map<String, String>> layanan = [
    {'name': 'Cuci Setrika (Reguler)', 'price': 'Rp 5.000', 'category': 'KILOAN'},
    {'name': 'Cuci Setrika (Ekspres)', 'price': 'Rp 7.000', 'category': 'KILOAN'},
    {'name': 'Karpet (Reguler)', 'price': 'Rp 15.000', 'category': 'METERAN'},
    {'name': 'Bed Cover Jumbo (Reguler)', 'price': 'Rp 30.000', 'category': 'SATUAN'},
    {'name': 'Bed Cover Jumbo (Ekspres)', 'price': 'Rp 35.000', 'category': 'SATUAN'},
    {'name': 'Bed Cover Single (Reguler)', 'price': 'Rp 10.000', 'category': 'SATUAN'},
    {'name': 'Bed Cover Single (Ekspres)', 'price': 'Rp 15.000', 'category': 'SATUAN'},
    {'name': 'Boneka Besar (Reguler)', 'price': 'Rp 20.000', 'category': 'SATUAN'},
    {'name': 'Boneka Kecil (Reguler)', 'price': 'Rp 5.000', 'category': 'SATUAN'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredLayanan = layanan.where((item) {
      final nameLower = item['name']!.toLowerCase();
      final queryLower = searchQuery.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Layanan Kami'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari nama layanan',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    RawMaterialButton(
                      onPressed: () {
                        // Tambahkan logika untuk menambahkan layanan baru
                      },
                      child: Icon(Icons.add, color: Colors.white), // Mengatur warna ikon menjadi putih
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Color(0xFF0E1446), // Warna biru tua
                      constraints: BoxConstraints(
                        minWidth: 70.0,
                        minHeight: 40.0,
                      ),
                      elevation: 2.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 5.0), // Padding vertikal untuk daftar layanan
              itemCount: filteredLayanan.length,
              itemBuilder: (context, index) {
                return _buildLayananTile(
                  filteredLayanan[index]['name']!,
                  filteredLayanan[index]['price']!,
                  filteredLayanan[index]['category']!,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                  thickness: 0.0, // Sesuaikan ketebalan sesuai kebutuhan Anda
                  indent: .0, // Tidak ada indentasi
                  endIndent: .0, // Tidak ada indentasi
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayananTile(String title, String price, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding horizontal untuk konten ListTile
      child: ListTile(
        contentPadding: EdgeInsets.zero, // Hapus padding internal ListTile
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$category - $price'), // Menampilkan kategori layanan
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                // Tambahkan logika untuk mengedit layanan
              },
              child: Container(
                padding: EdgeInsets.all(8.0), // Ubah sesuai kebutuhan Anda
                decoration: BoxDecoration(
                  color: Color(0xFF0E1446), // Warna biru tua
                  borderRadius: BorderRadius.circular(10.0), // Ubah sesuai kebutuhan Anda
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white, // Warna ikon putih
                  size: 20, // Ukuran ikon edit
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.grey),
              onPressed: () {
                // Tambahkan logika untuk menghapus layanan
              },
            ),
          ],
        ),
      ),
    );
  }
}
