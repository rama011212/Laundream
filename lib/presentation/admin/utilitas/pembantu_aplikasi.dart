
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundream/presentation/admin/utilitas/konstanta_aplikasi.dart'; // Import KonstantaAplikasi

class PembantuAplikasi {
  static String dapatkanSatuan(String jenis) {
    if (jenis.toLowerCase().contains('karpet') ||
        jenis.toLowerCase().contains('sofa') ||
        jenis.toLowerCase().contains('gorden')) {
      return 'm²';
    }
    return 'Kg';
  }

  static String formatMataUang(int v) =>
      v.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.');

  static String formatTanggal(DateTime? d) =>
      d == null ? '-' : DateFormat('d MMM y', 'id_ID').format(d);

  static IconData ikonStatus(String s) {
    switch (s) {
      case 'Belum Diterima':
        return Icons.timelapse;
      case 'Diterima':
        return Icons.schedule;
      case 'Diproses':
        return Icons.local_laundry_service;
      case 'Selesai':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  // Fungsi baru: Dapatkan harga per satuan berdasarkan jenis layanan
  static int dapatkanHargaPerSatuan(String layanan, String jenis) {
    for (var service in KonstantaAplikasi.dataLayanan) {
      for (var type in service['jenis']) {
        if (service['title'] == jenis && type['nama'] == layanan) {
          return type['harga'] as int;
        }
      }
    }
    return 0; // Atau lempar error jika tidak ditemukan
  }

  // Fungsi baru: Hitung harga akhir dengan promo
  static int hitungHargaAkhir(
    int hargaDasarPerSatuan,
    double jumlahSatuan,
    double? potonganPersen,
    int? potonganNominal,
  ) {
    double hargaDasarTotal = hargaDasarPerSatuan * jumlahSatuan;
    double hargaSetelahPromo = hargaDasarTotal;

    if (potonganPersen != null && potonganPersen > 0) {
      hargaSetelahPromo = hargaDasarTotal * (1 - potonganPersen);
    } else if (potonganNominal != null && potonganNominal > 0) {
      hargaSetelahPromo = hargaDasarTotal - potonganNominal;
    }

    return hargaSetelahPromo.round(); // Bulatkan ke integer terdekat
  }

  // Fungsi baru: Dapatkan detail promo berdasarkan nama promo
  static Map<String, dynamic>? dapatkanDetailPromo(String? namaPromo) {
    if (namaPromo == null || namaPromo == 'Tanpa Promo') return null;
    return KonstantaAplikasi.dataPromo.firstWhere(
      (promo) => promo['nama'] == namaPromo,
      orElse: () => {}, // Mengembalikan map kosong jika tidak ditemukan
    );
  }
}