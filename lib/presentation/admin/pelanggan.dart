import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PelangganPage extends StatefulWidget {
  @override
  _PelangganPageState createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  final List<Map<String, dynamic>> orders = [
    {
      'id': '1',
      'customer': 'Rama Anandya Putra',
      'service': 'Cuci & Setrika',
      'status': 'Dalam Proses',
      'package': 'Ekspres',
      'price': 25000,
      'orderDate': DateTime(2024, 5, 20, 15, 9),
      'completionDate': DateTime(2024, 5, 20, 21, 9),
      'paymentStatus': 'Belum Bayar',
    },
    {
      'id': '2',
      'customer': 'Putra Wijaya',
      'service': 'Cuci Saja',
      'status': 'Selesai',
      'package': 'Reguler',
      'price': 20000,
      'orderDate': DateTime(2024, 5, 21, 14, 30),
      'completionDate': DateTime(2024, 5, 24, 14, 30),
      'paymentStatus': 'Lunas',
    },
    {
      'id': '3',
      'customer': 'Robert Brown',
      'service': 'Setrika Saja',
      'status': 'Diterima',
      'package': 'Kilat',
      'price': 15000,
      'orderDate': DateTime(2024, 5, 22, 16, 0),
      'completionDate': DateTime(2024, 5, 23, 16, 0),
      'paymentStatus': 'Belum Bayar',
    },
  ];

  final List<Map<String, dynamic>> pelangganList = [
    {
      'nama': 'Rama Anandya Putra',
      'nomor': '0895360476161',
    },
    {
      'nama': 'Putra Wijaya',
      'nomor': '089573254612',
    },
    // Tambahkan pelanggan lainnya di sini
  ];

  String searchQuery = '';

  void _tambahPelanggan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahPelangganPage(
          onSave: (newPelanggan) {
            setState(() {
              pelangganList.add(newPelanggan);
            });
          },
        ),
      ),
    );
  }

  void _editPelanggan(BuildContext context, Map<String, dynamic> pelanggan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahPelangganPage(
          pelanggan: pelanggan,
          onSave: (updatedPelanggan) {
            setState(() {
              pelangganList[pelangganList.indexOf(pelanggan)] = updatedPelanggan;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredPelangganList = pelangganList.where((pelanggan) {
      final namaLower = pelanggan['nama'].toLowerCase();
      final nomorLower = pelanggan['nomor'].toLowerCase();
      final queryLower = searchQuery.toLowerCase();
      return namaLower.contains(queryLower) || nomorLower.contains(queryLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pelanggan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari nama / no handphone',
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
                  onPressed: () => _tambahPelanggan(context),
                  child: Icon(Icons.add, color: Colors.white),
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
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredPelangganList.length,
              itemBuilder: (context, index) {
                final pelanggan = filteredPelangganList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF0E1446), // Warna biru tua
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(pelanggan['nama']),
                  subtitle: Text(pelanggan['nomor']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => _editPelanggan(context, pelanggan),
                        child: Container(
                          padding: EdgeInsets.all(8.0), // Sesuaikan sesuai kebutuhan Anda
                          decoration: BoxDecoration(
                            color: Color(0xFF0E1446), // Warna biru tua
                            borderRadius: BorderRadius.circular(10.0), // Sesuaikan sesuai kebutuhan Anda
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
                          setState(() {
                            pelangganList.remove(pelanggan);
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PelangganDetailPage(
                          pelanggan: pelanggan,
                          orders: orders.where((order) => order['customer'] == pelanggan['nama'] && order['status'] == 'Selesai').toList(),
                        ),
                      ),
                    );
                  },
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
}

class PelangganDetailPage extends StatelessWidget {
  final Map<String, dynamic> pelanggan;
  final List<Map<String, dynamic>> orders;

  PelangganDetailPage({required this.pelanggan, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pelanggan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: ${pelanggan['nama']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Nomor Telepon: ${pelanggan['nomor']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Riwayat Pemesanan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0), // Kurangi margin untuk menghemat ruang
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Kurangi padding untuk menghemat ruang
                      title: Text(
                        'NOTA-${order['id']} ${order['package']}',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Sesuaikan ukuran teks
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total: Rp ${order['price']}',
                            style: TextStyle(fontSize: 12), // Sesuaikan ukuran teks
                          ),
                          Text(
                            'Tanggal Pesanan: ${DateFormat('dd MMM yyyy - HH:mm').format(order['orderDate'])}',
                            style: TextStyle(fontSize: 12), // Sesuaikan ukuran teks
                          ),
                          Text(
                            'Status: ${order['status']}',
                            style: TextStyle(fontSize: 12), // Sesuaikan ukuran teks
                          ),
                        ],
                      ),
                      trailing: Text(
                        order['status'],
                        style: TextStyle(
                          fontSize: 12, // Sesuaikan ukuran teks
                          color: order['status'] == 'Selesai' ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TambahPelangganPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? pelanggan;

  TambahPelangganPage({required this.onSave, this.pelanggan});

  @override
  _TambahPelangganPageState createState() => _TambahPelangganPageState();
}

class _TambahPelangganPageState extends State<TambahPelangganPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _nomorController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.pelanggan?['nama'] ?? '');
    _nomorController = TextEditingController(text: widget.pelanggan?['nomor'] ?? '');
  }

  void _simpanPelanggan() {
    if (_formKey.currentState!.validate()) {
      final newPelanggan = {
        'nama': _namaController.text,
        'nomor': _nomorController.text,
      };
      widget.onSave(newPelanggan);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pelanggan == null ? 'Tambah Pelanggan' : 'Edit Pelanggan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomorController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Batal'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _simpanPelanggan,
                    child: Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nomorController.dispose();
    super.dispose();
  }
}
