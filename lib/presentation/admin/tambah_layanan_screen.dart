import 'package:flutter/material.dart';

class TambahLayananScreen extends StatefulWidget {
  @override
  _TambahLayananScreenState createState() => _TambahLayananScreenState();
}

class _TambahLayananScreenState extends State<TambahLayananScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaLayananController = TextEditingController();
  String _selectedSatuan = "Kilogram (kg)";

  List<Map<String, String>> jenisHarga = [];

  @override
  void initState() {
    super.initState();
    _updateJenisHarga();
  }

  void _updateJenisHarga() {
    if (_selectedSatuan == "Kilogram (kg)") {
      jenisHarga = [
        {"jenis": "Reguler", "harga": "", "waktu": "3"},
        {"jenis": "Kilat", "harga": "", "waktu": "1"},
      ];
    } else {
      jenisHarga = [
        {"jenis": "Reguler", "harga": "", "waktu": "3"},
      ];
    }
    setState(() {});
  }

  @override
  void dispose() {
    namaLayananController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Layanan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama Layanan
              TextFormField(
                controller: namaLayananController,
                decoration: InputDecoration(
                  labelText: "Nama Layanan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? "Wajib diisi" : null,
              ),
              SizedBox(height: 16),
              // Dropdown Satuan
              DropdownButtonFormField<String>(
                value: _selectedSatuan,
                decoration: InputDecoration(
                  labelText: "Satuan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: [
                  "Kilogram (kg)",
                  "Meter (m)",
                  "Unit",
                ].map((satuan) {
                  return DropdownMenuItem(
                    value: satuan,
                    child: Text(satuan),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSatuan = value;
                      _updateJenisHarga();
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              Text(
                "Jenis Harga & Waktu Pengerjaan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: List.generate(jenisHarga.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        // Label Jenis
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(jenisHarga[index]["jenis"]!),
                        ),
                        SizedBox(width: 12),
                        // Harga
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Harga (Rp)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              jenisHarga[index]["harga"] = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Wajib diisi";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        // Waktu (readonly)
                        Container(
                          width: 80,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text("${jenisHarga[index]["waktu"]} hari"),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Nama Layanan: ${namaLayananController.text}");
                      print("Satuan: $_selectedSatuan");
                      print("Jenis Harga: $jenisHarga");
                      if (_selectedSatuan == "Kilogram (kg)") {
                        // Tampilkan catatan bahwa minimum pemesanan 2kg
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Catatan: Minimal pemesanan 2 kg."),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0E1446),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text("Simpan", style: TextStyle(fontSize: 16, color: Colors.white,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
