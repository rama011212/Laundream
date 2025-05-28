import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Model promo
class Promo {
  String judul;
  String deskripsi;
  String kode;
  String tipe; // 'persentase' atau 'nominal'
  int nilai;

  Promo({
    required this.judul,
    required this.deskripsi,
    required this.kode,
    required this.tipe,
    required this.nilai,
  });

  String get keteranganDiskon {
    if (tipe == 'persentase') {
      return '$nilai%';
    } else {
      return 'Rp${nilai.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
    }
  }
}

class PromosiPage extends StatefulWidget {
  const PromosiPage({super.key});

  @override
  State<PromosiPage> createState() => _PromosiPageState();
}

class _PromosiPageState extends State<PromosiPage> {
  final List<Promo> promosiList = [
    Promo(
      judul: 'Promo Akhir Tahun',
      deskripsi: 'Diskon spesial akhir tahun!',
      kode: 'AKHIR2024',
      tipe: 'persentase',
      nilai: 20,
    ),
    Promo(
      judul: 'Diskon Lebaran',
      deskripsi: 'Dapatkan potongan langsung.',
      kode: 'LEBARAN50K',
      tipe: 'nominal',
      nilai: 50000,
    ),
  ];

  void _tambahPromo(BuildContext context) async {
    final newPromo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TambahPromoPage()),
    );

    if (newPromo != null) {
      setState(() {
        promosiList.add(newPromo);
      });

      Fluttertoast.showToast(
        msg: "Promo berhasil ditambahkan",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  void _editPromo(int index) async {
    final editedPromo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPromoPage(promo: promosiList[index]),
      ),
    );

    if (editedPromo != null) {
      setState(() {
        promosiList[index] = editedPromo;
      });

      Fluttertoast.showToast(
        msg: "Promo berhasil diperbarui",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    }
  }

  void _hapusPromo(int index) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus promo ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (konfirmasi == true) {
      setState(() {
        promosiList.removeAt(index);
      });

      Fluttertoast.showToast(
        msg: "Promo berhasil dihapus",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1446),
        title: Text(
          'Promo Kami',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _tambahPromo(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: promosiList.length,
          itemBuilder: (context, index) {
            final promo = promosiList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFeef2f3), Color(0xFFffffff)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.local_offer_rounded,
                            color: Color(0xFF0E1446)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            promo.judul,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0E1446),
                            ),
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xFF0E1446)),
                          onPressed: () => _editPromo(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _hapusPromo(index),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      promo.deskripsi,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.code, size: 18, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          promo.kode,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            promo.keteranganDiskon,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TambahPromoPage extends StatefulWidget {
  const TambahPromoPage({super.key});

  @override
  State<TambahPromoPage> createState() => _TambahPromoPageState();
}

class _TambahPromoPageState extends State<TambahPromoPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _nilaiController = TextEditingController();
  String _selectedTipe = 'persentase';

  void _simpanPromo() {
    final judul = _judulController.text.trim();
    final deskripsi = _deskripsiController.text.trim();
    final kode = _kodeController.text.trim();
    final nilai = int.tryParse(_nilaiController.text.trim()) ?? 0;

    if (judul.isEmpty || deskripsi.isEmpty || kode.isEmpty || nilai <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua input harus diisi dengan benar')),
      );
      return;
    }

    final promo = Promo(
      judul: judul,
      deskripsi: deskripsi,
      kode: kode,
      tipe: _selectedTipe,
      nilai: nilai,
    );

    Navigator.pop(context, promo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1446),
        title: Text("Tambah Promo",
            style: GoogleFonts.poppins(color: Colors.white)),
      ),
      body: PromoForm(
        judulController: _judulController,
        deskripsiController: _deskripsiController,
        kodeController: _kodeController,
        nilaiController: _nilaiController,
        selectedTipe: _selectedTipe,
        onTipeChanged: (val) => setState(() => _selectedTipe = val),
        onSave: _simpanPromo,
      ),
    );
  }
}

class EditPromoPage extends StatefulWidget {
  final Promo promo;
  const EditPromoPage({super.key, required this.promo});

  @override
  State<EditPromoPage> createState() => _EditPromoPageState();
}

class _EditPromoPageState extends State<EditPromoPage> {
  late TextEditingController _judulController;
  late TextEditingController _deskripsiController;
  late TextEditingController _kodeController;
  late TextEditingController _nilaiController;
  late String _selectedTipe;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.promo.judul);
    _deskripsiController = TextEditingController(text: widget.promo.deskripsi);
    _kodeController = TextEditingController(text: widget.promo.kode);
    _nilaiController =
        TextEditingController(text: widget.promo.nilai.toString());
    _selectedTipe = widget.promo.tipe;
  }

  void _simpanEdit() {
    final editedPromo = Promo(
      judul: _judulController.text.trim(),
      deskripsi: _deskripsiController.text.trim(),
      kode: _kodeController.text.trim(),
      tipe: _selectedTipe,
      nilai: int.tryParse(_nilaiController.text.trim()) ?? 0,
    );

    Navigator.pop(context, editedPromo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1446),
        title:
            Text("Edit Promo", style: GoogleFonts.poppins(color: Colors.white)),
        foregroundColor: Colors.white,
      ),
      body: PromoForm(
        judulController: _judulController,
        deskripsiController: _deskripsiController,
        kodeController: _kodeController,
        nilaiController: _nilaiController,
        selectedTipe: _selectedTipe,
        onTipeChanged: (val) => setState(() => _selectedTipe = val),
        onSave: _simpanEdit,
      ),
    );
  }
}

class PromoForm extends StatelessWidget {
  final TextEditingController judulController;
  final TextEditingController deskripsiController;
  final TextEditingController kodeController;
  final TextEditingController nilaiController;
  final String selectedTipe;
  final Function(String) onTipeChanged;
  final VoidCallback onSave;

  const PromoForm({
    super.key,
    required this.judulController,
    required this.deskripsiController,
    required this.kodeController,
    required this.nilaiController,
    required this.selectedTipe,
    required this.onTipeChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Judul Promo', style: GoogleFonts.poppins()),
          const SizedBox(height: 6),
          TextFormField(
            controller: judulController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Text('Deskripsi Promo', style: GoogleFonts.poppins()),
          const SizedBox(height: 6),
          TextFormField(
            controller: deskripsiController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Text('Kode Promo', style: GoogleFonts.poppins()),
          const SizedBox(height: 6),
          TextFormField(
            controller: kodeController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Text('Tipe Promo', style: GoogleFonts.poppins()),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: selectedTipe,
            items: const [
              DropdownMenuItem(
                  value: 'persentase', child: Text('Persentase (%)')),
              DropdownMenuItem(value: 'nominal', child: Text('Nominal (Rp)')),
            ],
            onChanged: (val) => onTipeChanged(val!),
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Text(
            selectedTipe == 'persentase'
                ? 'Nilai Diskon (%)'
                : 'Nilai Diskon (Rp)',
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: nilaiController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText:
                  selectedTipe == 'persentase' ? 'Contoh: 10' : 'Contoh: 10000',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E1446),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: onSave,
            child:
                Text('Simpan', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
