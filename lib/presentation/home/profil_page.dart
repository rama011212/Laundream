import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:laundream/presentation/home/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Pangkas Foto',
            toolbarColor: const Color(0xFF0E1446),
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: 'Pangkas Foto', aspectRatioLockEnabled: true),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _profileImage = File(croppedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF9FAFB),
        surfaceTintColor: const Color(0xFFF9FAFB),
        automaticallyImplyLeading: false, // <-- ini penting!
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Foto Profil
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.15,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage('images/profil.jpg')
                                as ImageProvider,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.camera_alt, size: 20),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Nama
              const Text(
                "Rama Anandya Putra",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Tab Personal Info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Personal Info",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Info
              _infoRow(Icons.email_outlined, "Email",
                  "ramaanandyaputrapenting12@gmail.com"),
              const SizedBox(height: 14),
              _infoRow(Icons.phone, "Phone", "+62 895 3604 76161"),
              const SizedBox(height: 14),
              _infoRow(
                  Icons.home_outlined, "Alamat", "Jl. Merpati No. 45, Sleman"),
              const SizedBox(height: 14),
              _infoRow(Icons.male, "Gender", "Pria"),
              const SizedBox(height: 14),
              _infoRow(Icons.verified_user_outlined, "Status Akun", "Aktif"),
              const SizedBox(height: 14),
              _infoRow(Icons.calendar_today_outlined, "Bergabung Sejak",
                  "Maret 2024"),
              const SizedBox(height: 30),

              // Tombol Keluar
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.red),
                label:
                    const Text("Keluar", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}
