import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  String oldName = 'Rama Anandya Putra';
  String oldPhone = '0895360476161';
  String? oldGender = 'Laki-laki';
  String oldAddress = 'Jl. Merpati No. 45, Sleman';

  String? selectedGender;
  final List<String> genderOptions = ['Laki-laki', 'Perempuan'];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    selectedGender = oldGender;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      prefixIcon: Icon(icon, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    );
  }

  String formatPhone(String input) {
    if (input.startsWith('0')) {
      return input.replaceFirst('0', '62');
    } else if (input.startsWith('+62')) {
      return input.replaceFirst('+62', '62');
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Personal Info'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Hapus icon kembali
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Foto profil diperbesar
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('images/profil.jpg'),
            ),
            const SizedBox(height: 28),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Nama
                  TextFormField(
                    controller: nameController,
                    decoration: _inputDecoration(oldName, Icons.person_outline),
                  ),
                  const SizedBox(height: 16),

                  // No HP
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration(oldPhone, Icons.phone),
                    validator: (val) {
                      String value = val!.isEmpty ? oldPhone : val;
                      if (!(value.startsWith('08') || value.startsWith('62') || value.startsWith('+62'))) {
                        return 'Nomor harus diawali 08 atau 62';
                      }
                      final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                      if (digitsOnly.length < 9 || digitsOnly.length > 14) {
                        return 'Nomor HP harus 9–14 digit';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Gender
                  DropdownButtonFormField2<String>(
                    value: selectedGender,
                    isExpanded: true,
                    decoration: _inputDecoration('Pilih jenis kelamin', Icons.wc),
                    items: genderOptions
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedGender = value),
                    validator: (value) =>
                        value == null ? 'Pilih jenis kelamin' : null,
                  ),
                  const SizedBox(height: 16),

                  // Alamat
                  TextFormField(
                    controller: addressController,
                    maxLines: 1,
                    decoration: _inputDecoration(oldAddress, Icons.home_outlined),
                  ),
                  const SizedBox(height: 24),

                  // Tombol simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedName = nameController.text.isEmpty
                              ? oldName
                              : nameController.text;
                          final rawPhone = phoneController.text.isEmpty
                              ? oldPhone
                              : phoneController.text;
                          final updatedPhone = formatPhone(rawPhone);
                          final updatedGender = selectedGender ?? oldGender;
                          final updatedAddress = addressController.text.isEmpty
                              ? oldAddress
                              : addressController.text;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profil berhasil diperbarui')),
                          );

                          debugPrint('Nama: $updatedName');
                          debugPrint('No HP: +$updatedPhone');
                          debugPrint('Gender: $updatedGender');
                          debugPrint('Alamat: $updatedAddress');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 151, 245, 107),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
