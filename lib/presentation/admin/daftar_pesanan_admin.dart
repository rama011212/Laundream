import 'package:flutter/material.dart';
import 'package:laundream/presentation/admin/utilitas/konstanta_aplikasi.dart';
import 'package:laundream/presentation/admin/widget/lembar_detail_pesanan.dart';
import 'package:laundream/presentation/admin/widget/item_daftar_pesanan.dart';
import 'package:laundream/presentation/admin/widget/lembar_ganti_status.dart';
import 'package:laundream/presentation/admin/dialog/dialog_hapus_pesanan.dart'; // PASTIKAN ini diimport

class DaftarPesananAdmin extends StatefulWidget {
  const DaftarPesananAdmin({super.key});

  @override
  State<DaftarPesananAdmin> createState() => _DaftarPesananAdminState();
}

class _DaftarPesananAdminState extends State<DaftarPesananAdmin> {
  String layananTerpilih = 'Semua';
  String statusTerpilih = 'Semua';
  String pencarianQuery = '';

  // Gunakan List<Map<String, dynamic>> pesanan = KonstantaAplikasi.dataPesananDummy;
  // Jika Anda ingin data yang bisa diubah, gunakan List yang bisa di-modifikasi.
  // Untuk tujuan demo ini, kita akan membuat salinan yang bisa diubah:
  final List<Map<String, dynamic>> _pesanan = KonstantaAplikasi.dataPesananDummy.toList();


  List<Map<String, dynamic>> get pesananFilter => _pesanan // Gunakan _pesanan di sini
      .where((p) =>
          (layananTerpilih == 'Semua' || p['layanan'] == layananTerpilih) &&
          (statusTerpilih == 'Semua' || p['status'] == statusTerpilih) &&
          (p['nama'].toLowerCase().contains(pencarianQuery)))
      .toList()
    ..sort((a, b) => b['masuk'].compareTo(a['masuk']));

  void _perbaruiStatusPesanan(Map<String, dynamic> pesanan, String statusBaru) {
    setState(() {
      pesanan['status'] = statusBaru;
      if (statusBaru == 'Belum Diterima') {
        pesanan['selesai'] = null;
      } else if (pesanan['selesai'] == null) {
        final masuk = pesanan['masuk'] as DateTime;
        final durasi = pesanan['layanan'] == 'Reguler'
            ? const Duration(days: 3)
            : const Duration(days: 1);
        pesanan['selesai'] = masuk.add(durasi);
      }
    });
  }

  void _gantiStatusPembayaran(Map<String, dynamic> pesanan) {
    setState(() {
      pesanan['sudahBayar'] = !(pesanan['sudahBayar'] ?? false);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesanan['sudahBayar']
            ? 'Pesanan ditandai sudah dibayar.'
            : 'Pesanan ditandai belum dibayar.'),
      ),
    );
  }

  // Fungsi hapus pesanan yang akan dipanggil dari Dismissible
  void _hapusPesanan(Map<String, dynamic> pesananUntukDihapus) {
    setState(() {
      _pesanan.remove(pesananUntukDihapus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      appBar: AppBar(
        title: const Text('Pesanan Masuk', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0E1446),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari nama pelanggan...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              setState(() {
                pencarianQuery = value.toLowerCase();
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DropdownButton<String>(
              value: layananTerpilih,
              underline: const SizedBox(),
              items: const ['Semua', 'Reguler', 'Kilat']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                  .toList(),
              onChanged: (v) => setState(() => layananTerpilih = v!),
            ),
            DropdownButton<String>(
              value: statusTerpilih,
              underline: const SizedBox(),
              items: ['Semua', ...KonstantaAplikasi.daftarStatus]
                  .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                  .toList(),
              onChanged: (v) => setState(() => statusTerpilih = v!),
            ),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: pesananFilter.length,
            itemBuilder: (ctx, i) {
              final p = pesananFilter[i];
              return Dismissible(
                key: ValueKey(p['nama'] + p['masuk'].toString()), // Key unik untuk setiap item
                direction: DismissDirection.endToStart, // Geser hanya dari kanan ke kiri
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                confirmDismiss: (direction) async {
                  // Munculkan dialog konfirmasi saat swipe
                  final dikonfirmasi = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => const DialogHapusPesanan(),
                  );
                  return dikonfirmasi ?? false; // Mengembalikan true jika dikonfirmasi, false jika batal
                },
                onDismissed: (direction) {
                  // Hapus pesanan jika sudah dikonfirmasi
                  _hapusPesanan(p);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pesanan "${p['nama']}" dihapus.')),
                  );
                },
                child: ItemDaftarPesanan(
                  pesanan: p,
                  onKetuk: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) => LembarDetailPesanan(
                        pesanan: p,
                        onGantiPembayaran: _gantiStatusPembayaran,
                        onHapusPesanan: () {
                          // Karena _hapusPesanan sudah dikelola Dismissible,
                          // fungsi ini bisa disesuaikan atau dihapus jika tidak diperlukan lagi
                          // saat ini akan menutup sheet dan tidak melakukan penghapusan ganda.
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  onKetukStatus: (pesanan) async {
                    final statusSaatIni = pesanan['status'] as String;
                    final statusBaru = await showModalBottomSheet<String>(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (ctx) => LembarGantiStatus(
                        statusSaatIni: statusSaatIni,
                      ),
                    );
                    if (statusBaru != null && statusBaru != statusSaatIni) {
                      _perbaruiStatusPesanan(pesanan, statusBaru);
                    }
                  },
                  onKetukBayar: _gantiStatusPembayaran,
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}