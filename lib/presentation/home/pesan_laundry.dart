import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:laundream/presentation/home/rincian_pesanan.dart';

class PesanLaundryPage extends StatefulWidget {
  const PesanLaundryPage({Key? key}) : super(key: key);

  @override
  _PesanLaundryPageState createState() => _PesanLaundryPageState();
}

class _PesanLaundryPageState extends State<PesanLaundryPage> {
  final List<String> layananList = ['Cuci & Setrika', 'Setrika Saja', 'Cuci Karpet'];
  String selectedLayanan = 'Cuci & Setrika';
  String jenisLayanan = 'Reguler';
  double jumlah = 1;

  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  Map<String, dynamic>? selectedPromo;

  final List<Map<String, dynamic>> promoList = [
    {'label': 'Tidak Gunakan Promo', 'type': 'none', 'value': 0},
    {'label': 'Diskon 10%', 'type': 'percent', 'value': 10},
    {'label': 'Potongan 5.000', 'type': 'fixed', 'value': 5000},
  ];

  double getHargaPerUnit() {
    if (selectedLayanan == 'Cuci & Setrika') {
      return jenisLayanan == 'Reguler' ? 5000 : 10000;
    } else if (selectedLayanan == 'Setrika Saja') {
      return jenisLayanan == 'Reguler' ? 2500 : 5000;
    } else if (selectedLayanan == 'Cuci Karpet') {
      return 10000;
    }
    return 0;
  }

  double hitungTotal() {
    return jumlah * getHargaPerUnit();
  }

  double hitungTotalSetelahPromo() {
    double total = hitungTotal();
    if (selectedPromo == null || selectedPromo!['type'] == 'none') return total;

    if (selectedPromo!['type'] == 'percent') {
      return total - (total * selectedPromo!['value'] / 100);
    } else if (selectedPromo!['type'] == 'fixed') {
      return total - selectedPromo!['value'];
    }
    return total;
  }

  String getKeteranganPromo() {
    return 'Promo "${selectedPromo!['label']}" diterapkan';
  }

  bool isValidOrder() {
    if (selectedLayanan == 'Cuci Karpet') return true;
    return jumlah >= 2;
  }

  @override
  Widget build(BuildContext context) {
    final totalSebelumPromo = hitungTotal();
    final totalSetelahPromo = hitungTotalSetelahPromo();
    final keteranganPromo = (selectedPromo != null && selectedPromo!['type'] != 'none')
        ? getKeteranganPromo()
        : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan Laundry'),
        backgroundColor: const Color(0xFF0E1446),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Pilih Layanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField2(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                value: selectedLayanan,
                items: layananList.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLayanan = value!;
                    jumlah = 1;
                  });
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Jenis Layanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              Row(
                children: ['Reguler', 'Kilat'].map((tipe) {
                  final isSelected = jenisLayanan == tipe;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => jenisLayanan = tipe),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF0E1446) : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            tipe,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedLayanan == 'Cuci Karpet' ? 'Jumlah (m²)' : 'Jumlah (kg)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Slider(
                value: jumlah,
                min: 1,
                max: 20,
                divisions: 38,
                label: jumlah.toStringAsFixed(1),
                activeColor: Color(0xFF0E1446),
                onChanged: (value) {
                  setState(() {
                    jumlah = double.parse(value.toStringAsFixed(1));
                  });
                },
              ),
              if (!isValidOrder())
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: const [
                      Icon(Icons.warning, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Minimal pemesanan adalah 2 kg',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Pilih Promo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField2<Map<String, dynamic>>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                hint: Text('Pilih promo (opsional)'),
                value: selectedPromo,
                items: promoList.map((promo) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: promo,
                    child: Row(
                      children: [
                        Icon(
                          promo['type'] == 'none' ? Icons.close : Icons.local_offer,
                          color: promo['type'] == 'none' ? Colors.grey : Colors.redAccent,
                        ),
                        SizedBox(width: 8),
                        Text(promo['label']),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPromo = value!['type'] == 'none' ? null : value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shopping_bag_outlined, size: 28, color: Colors.black),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text('Total Harga', style: TextStyle(fontSize: 16)),
                        ),
                        Text(
                          formatCurrency.format(totalSebelumPromo),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    if (selectedPromo != null) ...[
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.discount, size: 25, color: Colors.blueGrey),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text('Total Harga Promo', style: TextStyle(fontSize: 16)),
                          ),
                          Text(
                            formatCurrency.format(totalSetelahPromo),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        keteranganPromo,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isValidOrder()
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RincianPesananPage(
                                layanan: selectedLayanan,
                                jenis: jenisLayanan,
                                jumlah: jumlah,
                                total: totalSetelahPromo,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0E1446),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Pesan Sekarang', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
