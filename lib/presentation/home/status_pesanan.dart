import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class StatusPesananBaru extends StatefulWidget {
  @override
  _StatusPesananBaruState createState() => _StatusPesananBaruState();
}

class _StatusPesananBaruState extends State<StatusPesananBaru> {
  String selectedFilter = 'Semua';

  final List<Map<String, dynamic>> pesananList = [
    {
      'layanan': 'Cuci & Setrika',
      'jumlah': 3,
      'harga': 15000,
      'jenis': 'reguler',
      'estimasi': '1 hari',
      'status': 'Diterima',
      'dibayar': false,
    },
    {
      'layanan': 'Setrika Saja',
      'jumlah': 2,
      'harga': 10000,
      'jenis': 'kilat',
      'estimasi': '1 hari',
      'status': 'Diproses',
      'dibayar': true,
    },
    {
      'layanan': 'Cuci Karpet',
      'jumlah': 4,
      'harga': 40000,
      'jenis': 'reguler',
      'estimasi': '3 hari',
      'status': 'Selesai',
      'dibayar': true,
    },
  ];

  List<String> filterOptions = ['Semua', 'Diterima', 'Diproses', 'Selesai'];

  List<Map<String, dynamic>> get filteredList {
    if (selectedFilter == 'Semua') return pesananList;
    return pesananList
        .where((item) => item['status'] == selectedFilter)
        .toList();
  }

  String formatRupiah(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  int _getStatusStep(String status) {
    switch (status) {
      case 'Diterima':
        return 0;
      case 'Diproses':
        return 1;
      case 'Selesai':
        return 2;
      default:
        return 0;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diterima':
        return Colors.green;
      case 'Diproses':
        return Colors.orange;
      case 'Selesai':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Icon _getStatusIcon(String status, bool isActive) {
    switch (status) {
      case 'Diterima':
        return Icon(Icons.check_circle,
            color: isActive ? Colors.green : Colors.grey);
      case 'Diproses':
        return Icon(Icons.local_laundry_service,
            color: isActive ? Colors.orange : Colors.grey);
      case 'Selesai':
        return Icon(Icons.done_all,
            color: isActive ? Colors.blue : Colors.grey);
      default:
        return Icon(Icons.help_outline);
    }
  }

  void _showDetailNota(BuildContext context, Map<String, dynamic> pesanan) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) {
        final bool sudahBayar = pesanan['dibayar'] ?? false;
        final String jenis = pesanan['jenis'] ?? '-';
        final String layanan = pesanan['layanan'] ?? '-';
        final int jumlah = pesanan['jumlah'] ?? 0;
        final String satuan = layanan == 'Cuci Karpet' ? 'm²' : 'kg';
        final int total = pesanan['harga'] ?? 0;
        final String status = pesanan['status'] ?? '-';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _notaItem('Layanan', layanan),
                    _notaItem('Jenis', jenis),
                    _notaItem('Berat / Luas', '$jumlah $satuan'),
                    _notaItem('Total Harga', formatRupiah(total)),
                    _notaItem('Status Pesanan', status),
                    const Divider(height: 30, thickness: 1),
                    const Text(
                      'Status Pembayaran:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          sudahBayar ? Icons.check_circle : Icons.error,
                          color: sudahBayar ? Colors.green : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          sudahBayar ? 'Sudah Dibayar' : 'Belum Dibayar',
                          style: TextStyle(
                            color: sudahBayar ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (!sudahBayar)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        pesanan['dibayar'] = true;
                      });
                      AnimatedSnackBar.material(
                        'Pembayaran berhasil!',
                        type: AnimatedSnackBarType.success,
                        duration: const Duration(seconds: 2),
                      ).show(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Bayar Sekarang',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              if (sudahBayar)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Terima kasih, pembayaran sudah dikonfirmasi.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _notaItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pesanan'),
        backgroundColor: const Color(0xFF0E1446),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filterOptions.length,
              itemBuilder: (context, index) {
                final filter = filterOptions[index];
                final isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF0E1446)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final pesanan = filteredList[index];
                final statusStep = _getStatusStep(pesanan['status']);
                final statusColor = _getStatusColor(pesanan['status']);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'images/status.png',
                            width: 35,
                            height: 60,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pesanan['layanan'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                    '${pesanan['jumlah']} ${(pesanan['layanan'] == 'Cuci Karpet') ? 'm²' : 'kg'} - ${formatRupiah(pesanan['harga'])}',
                                    style:
                                        const TextStyle(color: Colors.black54)),
                                Text(
                                  'Jenis: ${pesanan['jenis']} · Estimasi: ${pesanan['estimasi']}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: (pesanan['dibayar'] ?? false)
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              (pesanan['dibayar'] ?? false)
                                  ? 'Sudah Bayar'
                                  : 'Belum Bayar',
                              style: TextStyle(
                                color: (pesanan['dibayar'] ?? false)
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              _getStatusIcon('Diterima', statusStep >= 0),
                              const SizedBox(height: 4),
                              const Text('Diterima',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: statusStep >= 1
                                  ? statusColor
                                  : Colors.grey.shade300,
                            ),
                          ),
                          Column(
                            children: [
                              _getStatusIcon('Diproses', statusStep >= 1),
                              const SizedBox(height: 4),
                              const Text('Diproses',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: statusStep >= 2
                                  ? statusColor
                                  : Colors.grey.shade300,
                            ),
                          ),
                          Column(
                            children: [
                              _getStatusIcon('Selesai', statusStep >= 2),
                              const SizedBox(height: 4),
                              const Text('Selesai',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => _showDetailNota(context, pesanan),
                          child: const Text('Detail'),
                        ),
                      )
                    ],
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
