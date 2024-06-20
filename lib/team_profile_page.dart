import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'userprofile.dart';
import 'detail_profil_page.dart'; // Import halaman detail profil

class TeamProfilePage extends StatefulWidget {
  @override
  _TeamProfilePageState createState() => _TeamProfilePageState();
}

class _TeamProfilePageState extends State<TeamProfilePage> {
  UserProfile userProfile = UserProfile(
    name: 'User',
    programStudi: 'Sistem Informasi',
    npm: '00000000',
    phone: '081234567890',
    profilePicture:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPuPDIjS7bafD6KDFg63D19h8QoXjEQ2LnSQ&s',
  );

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        String name = userProfile.name;
        String programStudi = userProfile.programStudi;
        String npm = userProfile.npm;
        String phone = userProfile.phone;

        return AlertDialog(
          title: Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nama'),
                  onChanged: (value) {
                    name = value;
                  },
                  controller: TextEditingController(text: userProfile.name),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Program Studi'),
                  onChanged: (value) {
                    programStudi = value;
                  },
                  controller:
                      TextEditingController(text: userProfile.programStudi),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'NPM'),
                  onChanged: (value) {
                    npm = value;
                  },
                  controller: TextEditingController(text: userProfile.npm),
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: 'Nomor Telepon'),
                  onChanged: (value) {
                    phone = value;
                  },
                  controller:
                      TextEditingController(text: userProfile.phone),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userProfile.name = name;
                  userProfile.programStudi = programStudi;
                  userProfile.npm = npm;
                  userProfile.phone = phone;
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'], // Tambahkan ekstensi yang diizinkan
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      try {
        // Simpan gambar ke dalam profil pengguna
        setState(() {
          userProfile.profilePicture = file.path;
        });
      } catch (e) {
        // Tangani kesalahan penyimpanan
        print('Error saving profile picture: $e');
      }
    } else {
      // Pengguna membatalkan pemilih
    }
  }

  void _navigateToDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProfilPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProfile,
          ),
          IconButton(
            icon: Icon(Icons.photo_camera), // Ikon untuk mengubah foto profil
            onPressed: _changeProfilePicture,
          ),
        ],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter, // Tempatkan di atas tengah
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Padding di atas CircleAvatar
                CircleAvatar(
                  radius: 90, // Perbesar radius lingkaran
                  backgroundImage: userProfile.profilePicture != null
                      ? FileImage(File(userProfile.profilePicture!))
                      : AssetImage('assets/default_profile.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  '${userProfile.name}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userProfile.programStudi,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '${userProfile.npm}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '${userProfile.phone}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20), // Spasi di bawah teks profil
                GestureDetector(
                  onTap: _navigateToDetailPage, // Navigasi ke halaman detail
                  child: Text(
                    '© 2024 Developer 2',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 70), // Spasi tambahan di bawah teks copyright
              ],
            ),
          ),
        ),
      ),
    );
  }
}
