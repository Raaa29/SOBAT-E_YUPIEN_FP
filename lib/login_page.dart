import 'package:flutter/material.dart';
import 'home_page.dart';
import 'user_page.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  Map<String, dynamic> _userData = {}; // Penyimpan data pengguna

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load data pengguna dari file lokal saat aplikasi dimulai
  Future<void> _loadUserData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/userdata.json');

    if (await file.exists()) {
      final userDataJson = await file.readAsString();
      setState(() {
        _userData = json.decode(userDataJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade800, Colors.green.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        'https://iili.io/JZURY42.png', // URL gambar logo
                        height: 100,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        _isLogin ? 'Login' : 'Register',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black26,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email, color: Colors.green.shade800),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.green.shade800),
                          ),
                        ),
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon masukkan email Anda';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: Colors.green.shade800),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.green.shade800),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon masukkan password Anda';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _isLogin ? _login() : _register();
                          }
                        },
                        child: Text(
                          _isLogin ? 'Login' : 'Register',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Belum punya akun? Register'
                              : 'Sudah punya akun? Login',
                          style: TextStyle(color: Colors.green.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Simpan data pengguna ke file lokal
  Future<void> _saveUserData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/userdata.json');
    await file.writeAsString(json.encode(_userData));
  }

  // Fungsi untuk melakukan login
  void _login() {
    if (_email == 'se@gmail.com' && _password == '345') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserPage(_userData)),
      );
    } else if (_userData.containsKey(_email) && _userData[_email] == _password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Tampilkan pesan kesalahan jika kredensial tidak cocok
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Email atau password salah.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Fungsi untuk melakukan registrasi
  void _register() {
    if (!_userData.containsKey(_email)) {
      // Simpan data pengguna baru
      setState(() {
        _userData[_email] = _password;
      });
      _saveUserData(); // Simpan data ke file lokal

      // Tampilkan dialog pendaftaran berhasil
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Pendaftaran berhasil.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  setState(() {
                    _isLogin = true; // Ubah ke mode login setelah pendaftaran berhasil
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Tampilkan pesan kesalahan jika email sudah terdaftar
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Email sudah terdaftar.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}