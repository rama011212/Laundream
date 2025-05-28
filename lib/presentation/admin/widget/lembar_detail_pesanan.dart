import 'package:flutter/material.dart';
import 'package:laundream/presentation/admin/utilitas/pembantu_aplikasi.dart';
import 'package:laundream/presentation/admin/dialog/dialog_edit_pesanan.dart';

class LembarDetailPesanan extends StatelessWidget {
  const LembarDetailPesanan({
    super.key,
    required this.pesanan,
    required this.onGantiPembayaran,
    required this.onHapusPesanan, // Parameter ini masih bisa dipertahankan, atau dihilangkan jika tidak ada lagi fungsi Hapus yang dipanggil dari sini. Untuk amannya, kita pertahankan dulu.
  });

  final Map<String, dynamic> pesanan;
  final Function(Map<String, dynamic>) onGantiPembayaran;
  final VoidCallback onHapusPesanan; // Ini juga bisa dihapus jika tidak ada lagi kebutuhan untuk memanggilnya dari sini

  Widget _barisDetail(String label, String nilai) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text(nilai)),
        ]),
      );

  void _cetakNota(BuildContext context, Map<String, dynamic> pesanan) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fungsi cetak nota belum di-implementasi.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.45,
      maxChildSize: 0.9,
      builder: (ctx, ctrl) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(controller: ctrl, children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(pesanan['nama'],
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _barisDetail('No. Telp', pesanan['phone']),
          _barisDetail('Jenis Kelamin', pesanan['gender']),
          _barisDetail('Layanan', '${pesanan['layanan']} · ${pesanan['jenis']}'),
          _barisDetail('Berat/Luas', pesanan['beratLuas'] ?? '-'),
          _barisDetail('Harga', 'Rp ${PembantuAplikasi.formatMataUang(pesanan['harga'])}'),
          _barisDetail('Tanggal Masuk', PembantuAplikasi.formatTanggal(pesanan['masuk'])),
          _barisDetail('Tanggal Selesai', PembantuAplikasi.formatTanggal(pesanan['selesai'])),
          _barisDetail('Status Pembayaran',
              pesanan['sudahBayar'] ? 'Sudah Dibayar' : 'Belum Dibayar'),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _cetakNota(context, pesanan),
            icon: const Icon(Icons.print),
            label: const Text('Cetak Nota'),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48)),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => onGantiPembayaran(pesanan),
            icon: const Icon(Icons.check),
            label: Text(pesanan['sudahBayar']
                ? 'Tandai Belum Bayar'
                : 'Tandai Sudah Dibayar'),
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48)),
          ),
          const SizedBox(height: 12),
          // HANYA TOMBOL EDIT YANG TERSISA
          Align( // Menggunakan Align untuk menempatkan tombol di tengah atau kiri jika hanya ada satu
            alignment: Alignment.center, // Atau Alignment.centerLeft jika ingin di kiri
            child: SizedBox( // Memastikan tombol mengambil lebar penuh jika hanya satu
              width: double.infinity, // Membuat tombol mengisi lebar yang tersedia
              child: OutlinedButton.icon(
                onPressed: () async {
                  Navigator.pop(context); // Tutup lembar saat ini
                  await showDialog(
                    context: context,
                    builder: (ctx) => DialogEditPesanan(pesanan: pesanan),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}