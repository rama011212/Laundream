import 'package:flutter/material.dart';

// Kelas model untuk promo
class Promo {
  final String judul;
  final String deskripsi;
  final String kode;

  Promo({required this.judul, required this.deskripsi, required this.kode});
}

class PromosiPage extends StatefulWidget {
  @override
  _PromosiPageState createState() => _PromosiPageState();
}

class _PromosiPageState extends State<PromosiPage> {
  final List<Promo> promosiList = [
    Promo(
      judul: 'Promo Akhir Tahun',
      deskripsi: 'Mencuci bersih hanya di Laristy Laundry aja',
      kode: 'Asdeqs12D',
    ),
  ];

  void _tambahPromo(BuildContext context) async {
    final newPromo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahPromoPage()),
    );

    if (newPromo != null) {
      setState(() {
        // Tambahkan promo baru ke dalam daftar promosi
        promosiList.add(newPromo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promo Kami'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _tambahPromo(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: promosiList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(promosiList[index].judul),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(promosiList[index].deskripsi),
                Text('Kode promo: ${promosiList[index].kode}'),
              ],
            ),
            onTap: () {
              // Tambahkan logika untuk menampilkan detail promo atau mengaktifkan promo
            },
          );
        },
      ),
    );
  }
}

class TambahPromoPage extends StatelessWidget {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Promo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Judul Promo'),
            TextFormField(
              controller: _judulController,
              decoration: InputDecoration(
                hintText: 'Masukkan judul promo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Deskripsi Promo'),
            TextFormField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                hintText: 'Masukkan deskripsi promo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Kode Promo'),
            TextFormField(
              controller: _kodeController,
              decoration: InputDecoration(
                hintText: 'Masukkan kode promo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan promo ke dalam daftar promosi
                final String judul = _judulController.text;
                final String deskripsi = _deskripsiController.text;
                final String kode = _kodeController.text;

                // Validasi input sebelum menyimpan promo
                if (judul.isNotEmpty && deskripsi.isNotEmpty && kode.isNotEmpty) {
                  // Tambahkan promo baru ke dalam daftar promosi
                  Navigator.pop(context, Promo(judul: judul, deskripsi: deskripsi, kode: kode));
                } else {
                  // Tampilkan pesan kesalahan jika ada input yang kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Harap lengkapi semua input'),
                    ),
                  );
                }
              },
              child: Text('Simpan Promo'),
            ),
          ],
        ),
      ),
    );
  }
}
