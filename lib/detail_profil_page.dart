import 'package:flutter/material.dart';
import 'userprofile.dart';

class DetailProfilPage extends StatefulWidget {
  @override
  _DetailProfilPageState createState() => _DetailProfilPageState();
}

class _DetailProfilPageState extends State<DetailProfilPage> {
  List<UserProfile> users = [
    UserProfile(
      name: 'Farraheira Panundaratrisna F',
      programStudi: 'Sistem Informasi',
      npm: '22082010006',
      phone: '081252043244',
      profilePicture:
          'https://iili.io/d9B6x4a.jpg',
    ),
    UserProfile(
      name: 'Adyatma Kevin Aryaputra Ramadhan',
      programStudi: 'Sistem Informasi',
      npm: '22082010020',
      phone: '081357558508',
      profilePicture:
          'https://iili.io/d9BP2Pn.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Profil'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: users[index].profilePicture != null
                      ? NetworkImage(users[index].profilePicture!)
                      : AssetImage('assets/default_profile.jpg'),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    users[index].name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Program Studi: ${users[index].programStudi}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text('NPM: ${users[index].npm}'),
                      SizedBox(height: 5),
                      Text('Telepon: ${users[index].phone}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editUserProfile(context, index);
                    },
                  ),
                ),
                Divider(), // Pembatas antara informasi pengguna
              ],
            ),
          );
        },
      ),
    );
  }

  void _editUserProfile(BuildContext context, int index) async {
    TextEditingController nameController =
        TextEditingController(text: users[index].name);
    TextEditingController programStudiController =
        TextEditingController(text: users[index].programStudi);
    TextEditingController npmController =
        TextEditingController(text: users[index].npm);
    TextEditingController phoneController =
        TextEditingController(text: users[index].phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nama'),
                  onChanged: (value) {
                    users[index].name = value;
                  },
                ),
                TextFormField(
                  controller: programStudiController,
                  decoration: InputDecoration(labelText: 'Program Studi'),
                  onChanged: (value) {
                    users[index].programStudi = value;
                  },
                ),
                TextFormField(
                  controller: npmController,
                  decoration: InputDecoration(labelText: 'NPM'),
                  onChanged: (value) {
                    users[index].npm = value;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Nomor Telepon'),
                  onChanged: (value) {
                    users[index].phone = value;
                  },
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
                  users[index].name = nameController.text;
                  users[index].programStudi = programStudiController.text;
                  users[index].npm = npmController.text;
                  users[index].phone = phoneController.text;
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
}