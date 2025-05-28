import 'package:flutter/material.dart';
import 'package:laundream/presentation/admin/utilitas/pembantu_aplikasi.dart';
import 'package:laundream/presentation/admin/utilitas/konstanta_aplikasi.dart';

class ItemDaftarPesanan extends StatelessWidget {
  const ItemDaftarPesanan({
    super.key,
    required this.pesanan,
    required this.onKetuk,
    required this.onKetukStatus,
    required this.onKetukBayar,
  });

  final Map<String, dynamic> pesanan;
  final VoidCallback onKetuk;
  final Function(Map<String, dynamic>) onKetukStatus;
  final Function(Map<String, dynamic>) onKetukBayar;

  Widget _chipStatus(Map<String, dynamic> pesanan) {
    final status = pesanan['status'] as String;
    final dasarWarna = KonstantaAplikasi.warnaStatus[status]!;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onKetukStatus(pesanan),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: dasarWarna.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(PembantuAplikasi.ikonStatus(status), size: 16, color: dasarWarna),
          const SizedBox(width: 4),
          Text(status,
              style: TextStyle(color: dasarWarna, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }

  Widget _chipBayar(Map<String, dynamic> pesanan) {
    final sudahBayar = pesanan['sudahBayar'] == true;
    return InkWell(
      onTap: () => onKetukBayar(pesanan),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: (sudahBayar ? Colors.green : Colors.red).withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(width: 4),
          Text(
            sudahBayar ? 'Sudah Dibayar' : 'Belum Dibayar',
            style: TextStyle(
              color: sudahBayar ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: GestureDetector(
        onTap: onKetuk,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/icon/laundry-basket.png', width: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pesanan['nama'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('Rp ${PembantuAplikasi.formatMataUang(pesanan['harga'])}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${pesanan['layanan']} · ${pesanan['jenis']}',
                        style: TextStyle(color: Colors.grey.shade700)),
                    const SizedBox(height: 4),
                    Text('Masuk: ${PembantuAplikasi.formatTanggal(pesanan['masuk'])}'),
                    if (pesanan['selesai'] != null)
                      Text('Selesai: ${PembantuAplikasi.formatTanggal(pesanan['selesai'])}'),
                    const SizedBox(height: 6),
                    Row(children: [
                      _chipStatus(pesanan),
                      const SizedBox(width: 8),
                      _chipBayar(pesanan),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}