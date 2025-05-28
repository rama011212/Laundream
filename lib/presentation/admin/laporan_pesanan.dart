import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LaporanPesananPage extends StatefulWidget {
  @override
  _LaporanPesananPageState createState() => _LaporanPesananPageState();
}

class _LaporanPesananPageState extends State<LaporanPesananPage> {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  DateTime? selectedDate;

  final List<Map<String, dynamic>> pesanan = [
    {
      'pelanggan': 'Rina',
      'layanan': 'Cuci Setrika',
      'harga': 25000,
      'status': 'Selesai',
      'tanggal': DateTime.now().subtract(Duration(days: 1)),
    },
    {
      'pelanggan': 'Budi',
      'layanan': 'Cuci Lipat',
      'harga': 35000,
      'status': 'Belum Bayar',
      'tanggal': DateTime.now().subtract(Duration(days: 2)),
    },
    {
      'pelanggan': 'Ani',
      'layanan': 'Setrika Saja',
      'harga': 15000,
      'status': 'Dibatalkan',
      'tanggal': DateTime.now().subtract(Duration(days: 3)),
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Belum Bayar':
        return Colors.orange;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> getFilteredPesanan() {
    if (selectedDate == null) return pesanan;
    return pesanan.where((p) {
      return DateFormat('yyyy-MM-dd').format(p['tanggal']) ==
          DateFormat('yyyy-MM-dd').format(selectedDate!);
    }).toList();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF0E1446),
              onPrimary: Colors.white,
              surface: Colors.grey[850]!,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredPesanan = getFilteredPesanan();

    return Scaffold(
      backgroundColor: Color(0xFFF2F4F7),
      appBar: AppBar(
        title: Text('Laporan Pesanan' , style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0E1446),
        foregroundColor: Colors.white,   
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'Semua Tanggal'
                      : 'Tanggal: ${DateFormat('dd MMM yyyy').format(selectedDate!)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: Icon(Icons.calendar_today, size: 18),
                  label: Text('Pilih Tanggal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0E1446),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredPesanan.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada pesanan untuk tanggal ini.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredPesanan.length,
                    itemBuilder: (context, index) {
                      final item = filteredPesanan[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: getStatusColor(item['status']),
                            child: Icon(Icons.local_laundry_service,
                                color: Colors.white),
                          ),
                          title: Text(
                            '${item['pelanggan']} - ${item['layanan']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Harga: ${currencyFormatter.format(item['harga'])}'),
                              Text('Tanggal: ${DateFormat('dd MMM yyyy').format(item['tanggal'])}'),
                            ],
                          ),
                          trailing: Text(
                            item['status'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getStatusColor(item['status']),
                            ),
                          ),
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
