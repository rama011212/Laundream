import 'package:flutter/material.dart';

class KonstantaAplikasi {
  static final List<Map<String, dynamic>> dataLayanan = [
    {
      'title': 'Cuci Setrika',
      'satuan': 'kg',
      'jenis': [
        {'nama': 'Reguler', 'harga': 5000},
        {'nama': 'Kilat', 'harga': 10000},
      ]
    },
    {
      'title': 'Setrika Saja',
      'satuan': 'kg',
      'jenis': [
        {'nama': 'Reguler', 'harga': 2500},
        {'nama': 'Kilat', 'harga': 5000},
      ]
    },
    {
      'title': 'Cuci Lipat',
      'satuan': 'kg',
      'jenis': [
        {'nama': 'Reguler', 'harga': 3000},
        {'nama': 'Kilat', 'harga': 6000},
      ]
    },
    {
      'title': 'Cuci Karpet',
      'satuan': 'meter',
      'jenis': [
        {'nama': 'Permeter', 'harga': 10000},
      ]
    },
  ];

  // Tambahkan data promo dummy
  static final List<Map<String, dynamic>> dataPromo = [
    {'nama': 'Diskon Awal Tahun', 'tipe': 'persentase', 'nilai': 0.30}, // 30%
    {'nama': 'Promo Member Baru', 'tipe': 'nominal', 'nilai': 5000}, // Potongan 5000
    {'nama': 'Tanpa Promo', 'tipe': 'persentase', 'nilai': 0.0}, // Tidak ada promo
  ];

  static final List<Map<String, dynamic>> dataPesananDummy = [
    {
      'nama': 'Rama Putra',
      'phone': '0812-3456-7890',
      'gender': 'Laki-laki',
      'layanan': 'Reguler',
      'jenis': 'Cuci Setrika',
      'beratLuas': '3 Kg',
      'harga': 10500, // Harga setelah promo (3kg * 5000 = 15000 - 30%)
      'masuk': DateTime(2025, 5, 18),
      'selesai': null,
      'status': 'Belum Diterima',
      'sudahBayar': false,
      'promoDigunakan': 'Diskon Awal Tahun', // Tambahkan field promo
      'potonganPersen': 0.30, // Tambahkan field potongan
      'potonganNominal': null, // Tambahkan field potongan nominal
    },
    {
      'nama': 'Dina Ayu',
      'phone': '0898-7654-3210',
      'gender': 'Perempuan',
      'layanan': 'Kilat',
      'jenis': 'Cuci Lipat',
      'beratLuas': '3 Kg',
      'harga': 18000, // Harga setelah promo (3kg * 6000 = 18000, tanpa promo)
      'masuk': DateTime(2025, 5, 18),
      'selesai': DateTime(2025, 5, 19),
      'status': 'Selesai',
      'sudahBayar': true,
      'promoDigunakan': 'Tanpa Promo',
      'potonganPersen': null,
      'potonganNominal': null,
    },
    {
      'nama': 'Dani Saputra',
      'phone': '0898-7654-3210',
      'gender': 'Perempuan',
      'layanan': 'Reguler',
      'jenis': 'Cuci Karpet',
      'beratLuas': '3 Meter',
      'harga': 25000, // Harga setelah promo (3m * 10000 = 30000 - 5000)
      'masuk': DateTime(2025, 5, 18),
      'selesai': DateTime(2025, 5, 19),
      'status': 'Selesai',
      'sudahBayar': true,
      'promoDigunakan': 'Promo Member Baru',
      'potonganPersen': null,
      'potonganNominal': 5000,
    },
  ];

  static Map<String, Color> warnaStatus = {
    'Belum Diterima': Colors.grey,
    'Diterima': Colors.orange,
    'Diproses': Colors.blue,
    'Selesai': Colors.green,
  };

  static final List<String> daftarStatus = [
    'Belum Diterima',
    'Diterima',
    'Diproses',
    'Selesai',
  ];
}