import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home_page.dart'; // Pastikan Anda mengimpor home_page.dart

void main() {
  runApp(MaterialApp(
    home: LoadingNebengPage(),
  ));
}

class LoadingNebengPage extends StatefulWidget {
  @override
  _LoadingNebengPageState createState() => _LoadingNebengPageState();
}

class _LoadingNebengPageState extends State<LoadingNebengPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  bool _isLoading = true;
  String? _driverName;
  String? _driverPlate;
  String? _driverVehicleName;
  bool _isTripCompleted = false;
  bool _isDriverFound = false;
  List<Map<String, String>> _drivers = [
    {
      'name': 'Hidan Hutapea',
      'plate': 'L 4644 CD',
      'vehicle': 'Honda Beat',
    },
    {
      'name': 'Arya Damar',
      'plate': 'B 7891 AB',
      'vehicle': 'Yamaha Vixion',
    },
    {
      'name': 'Budi Santoso',
      'plate': 'D 1234 EF',
      'vehicle': 'Honda Scoopy',
    },
    {
      'name': 'Citra Lestari',
      'plate': 'G 5678 HI',
      'vehicle': 'Yamaha Nmax',
    },
    {
      'name': 'Dimas Prayoga',
      'plate': 'J 9012 KL',
      'vehicle': 'Honda Vario',
    },
    {
      'name': 'Eka Wulandari',
      'plate': 'M 3456 NO',
      'vehicle': 'Yamaha Mio',
    },
  ];
  int _currentDriverIndex = 0;

  @override
  void initState() {
    super.initState();
    // Simulate loading process for 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _currentDriverIndex = Random().nextInt(_drivers.length);
          _driverName = _drivers[_currentDriverIndex]['name'];
          _driverPlate = _drivers[_currentDriverIndex]['plate'];
          _driverVehicleName = _drivers[_currentDriverIndex]['vehicle'];
          _isDriverFound = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Pesanan'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-7.333803, 112.788124), // Contoh koordinat
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
          ),
          if (_isLoading)
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://iili.io/JZURY42.png', // URL gambar logo
                          height: 50,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tenang dulu ya,',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Kita lagi nyari driver untuk kamu',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    CircularProgressIndicator(), // Indikator loading
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      },
                      child: Text(
                        'Batalkan Pesanan',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade800,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_isDriverFound)
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Driver ditemukan:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp3oYa9BljpcyhfIwVizBrEuo4HjsWq1mNzw&s'), // URL gambar driver
                      radius: 50.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Nama: $_driverName\nPlat Motor: $_driverPlate\nNama Kendaraan: $_driverVehicleName',
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        // Aksi saat tombol "Chat dengan Driver" ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(driverName: _driverName!)),
                        ).then((value) {
                          // Setelah chat selesai, tunggu 5 detik dan tampilkan pesan pesanan selesai
                          Timer(Duration(seconds: 5), () {
                            if (mounted) {
                              setState(() {
                                _isTripCompleted = true;
                              });
                            }
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 32.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.chat,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Chat dengan Driver',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_isTripCompleted)
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK6v5WumMGw2u-PIdo7_UX6YjNDjqGt-YvpIEkjmkgm_ly7rW1jS6Fm5f6hzAdAuyxRa4&usqp=CAU', // URL gambar pesanan selesai
                      height: 100,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Pesanan Selesai',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Terima kasih telah menggunakan layanan kami!',
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                          (Route<dynamic> route) => false,
                        ); // Kembali ke halaman utama
                      },
                      child: Text(
                        'Kembali ke Homepage',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String? driverName;
  const ChatScreen({Key? key, this.driverName}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];
  bool _isFirstMessage = true;

  @override
  void initState() {
    super.initState();
    // Simulate driver's first message after a delay
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(Message(
              text: 'Halo, pesanan sesuai aplikasi ya!',
              isFromDriver: true,
              driverName: widget.driverName));
          _messages.add(Message(
              text: 'Mohon ditunggu',
              isFromDriver: true,
              driverName: widget.driverName));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat dengan ${widget.driverName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index].isFromDriver
                    ? DriverMessageBubble(
                        message: _messages[index],
                        driverName: widget.driverName,
                      )
                    : UserMessageBubble(message: _messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan Anda...',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    String message = _messageController.text;
                    if (message.isNotEmpty) {
                      setState(() {
                        _messages.add(Message(
                            text: message, isFromDriver: false));
                        if (_isFirstMessage) {
                          // Simulate driver's first response
                          _messages.add(Message(
                              text: 'Sebentar lagi sampai, kak',
                              isFromDriver: true,
                              driverName: widget.driverName));
                          _isFirstMessage = false;
                        } else {
                          // Simulate driver's response
                          _messages.add(Message(
                              text: 'Sebentar lagi sampai, kak',
                              isFromDriver: true,
                              driverName: widget.driverName));
                        }
                        _messageController.clear();
                      });
                    }
                  },
                  child: Text('Kirim Pesan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isFromDriver;
  final String? driverName;

  Message({required this.text, required this.isFromDriver, this.driverName});
}

class UserMessageBubble extends StatelessWidget {
  final Message message;

  const UserMessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class DriverMessageBubble extends StatelessWidget {
  final Message message;
  final String? driverName;

  const DriverMessageBubble({Key? key, required this.message, this.driverName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.driverName != null)
              Text(message.driverName!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              message.text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
