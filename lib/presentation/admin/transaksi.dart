import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  /// Dummy data transaksi — ambil hanya yang sudah selesai & lunas
  final List<Map<String, dynamic>> _allOrders = [
    {
      'nama': 'Rama Putra',
      'invoice': 'INV-0001',
      'status': 'Selesai',
      'sudahBayar': true,
      'metode': 'Tunai',
      'total': 50000,
      'tanggal': DateTime(2024, 4, 24),
      'layanan': 'Reguler',
      'jenis': 'Cuci Setrika',
      'beratLuas': '3 kg',
    },
    {
      'nama': 'Dian Ayu',
      'invoice': 'INV-0002',
      'status': 'Selesai',
      'sudahBayar': true,
      'metode': 'Transfer Bank',
      'total': 20000,
      'tanggal': DateTime(2024, 5, 2),
      'layanan': 'Reguler',
      'jenis': 'Gorden',
      'beratLuas': '2 pcs',
    },
    {
      'nama': 'Dani Saputra',
      'invoice': 'INV-0003',
      'status': 'Selesai',
      'sudahBayar': true,
      'metode': 'QRIS',
      'total': 20000,
      'tanggal': DateTime(2024, 5, 5),
      'layanan': 'Kilat',
      'jenis': 'Selimut',
      'beratLuas': '1 pcs',
    },
    {
      'nama': 'Dewi Lestari',
      'invoice': 'INV-0004',
      'status': 'Diproses',
      'sudahBayar': true,
      'metode': 'Tunai',
      'total': 100000,
      'tanggal': DateTime(2024, 5, 11),
      'layanan': 'Kilat',
      'jenis': 'Cuci Setrika',
      'beratLuas': '6 kg',
    },
  ];

  List<Map<String, dynamic>> get _paidTransactions => _allOrders
      .where((o) => o['status'] == 'Selesai' && o['sudahBayar'])
      .toList();

  String _idr(int v) => 'IDR ${NumberFormat.decimalPattern('id_ID').format(v)}';

  String _date(DateTime d) => DateFormat('d MMMM yyyy', 'id_ID').format(d);

  void _showDetail(Map<String, dynamic> t) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Detail Pembayaran',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Lunas',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 12)),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(t['nama'],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _row('Nomor Invoice', t['invoice']),
            _row('Metode Pembayaran', t['metode']),
            _row('Total', _idr(t['total'])),
            _row('Tanggal Transaksi', _date(t['tanggal'])),
            _row('Layanan', t['layanan']),
            _row('Jenis Barang', t['jenis']),
            _row('Berat / Unit', t['beratLuas']),
            const SizedBox(height: 20),
            const Divider(height: 1),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Center(
                  child: Text('Tutup',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600))),
            )
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Expanded(
                child: Text(label,
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 14))),
            Expanded(
                child: Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14))),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Transaksi',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0E1446),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _paidTransactions.length,
        itemBuilder: (_, i) {
          final t = _paidTransactions[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _showDetail(t),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t['nama'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(t['invoice'],
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 14)),
                            const SizedBox(height: 4),
                            const Text('Lunas',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500))
                          ]),
                    ),
                    Text(_idr(t['total']),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right_rounded)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
