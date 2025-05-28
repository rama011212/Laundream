import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PenguranganKasPage extends StatefulWidget {
  @override
  _PenguranganKasPageState createState() => _PenguranganKasPageState();
}

class _PenguranganKasPageState extends State<PenguranganKasPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengurangan Kas', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF0E1446),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah Uang',
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _keteranganController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Keterangan (Opsional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpanDataPengeluaran,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0E1446),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Simpan', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _simpanDataPengeluaran() {
    if (_formKey.currentState!.validate()) {
      final jumlah = int.parse(_jumlahController.text);
      final keterangan = _keteranganController.text;

      // Simpan data ke database / API di sini
      print('Pengeluaran: Rp $jumlah');
      print('Keterangan: $keterangan');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data pengeluaran berhasil disimpan')),
      );

      Navigator.pop(context); // Kembali ke halaman sebelumnya
    }
  }
}
