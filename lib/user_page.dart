import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserPage(this.userData);

  @override
  Widget build(BuildContext context) {
    // Memisahkan data admin dan pengguna biasa
    final adminEmail = 'se@gmail.com';
    final adminPassword = '345';
    final userEmail = 'yamasensei@gmail.com';
    final userPassword = '12345';

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Admin
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'ADMIN:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          if (userData.containsKey(adminEmail))
            ListTile(
              title: Text('Email: $adminEmail'),
              subtitle: Text('Password: $adminPassword'),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Tidak ada admin terdaftar.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          Divider(),
          // Bagian User
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'USER:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          if (userData.containsKey(userEmail))
            ListTile(
              title: Text('Email: $userEmail'),
              subtitle: Text('Password: $userPassword'),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Tidak ada pengguna terdaftar.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}