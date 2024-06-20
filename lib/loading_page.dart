import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking Order',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  bool _isLoading = true;
  String _trackingData = "";
  bool _isDelivered = false;

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId('destinationMarker'),
        position: LatLng(-7.3336995, 112.7698706), // Contoh koordinat
      ),
    );
    _fetchTrackingData();
  }

  Future<void> _fetchTrackingData() async {
    final response = await http.get(Uri.parse(
        'https://restapitrack-default-rtdb.firebaseio.com/trackpengiriman.json'));

    if (response.statusCode == 200) {
      Map<String, dynamic> trackingData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        _trackingData = _formatTrackingData(trackingData);
      });
    } else {
      throw Exception('Failed to load tracking data');
    }
  }

  String _formatTrackingData(Map<String, dynamic> trackingData) {
    String formattedData = '';

    trackingData.forEach((key, value) {
      formattedData += '${key.toUpperCase()}:\n';

      if (value is Map) {
        value.forEach((subKey, subValue) {
          formattedData += '  $subKey: $subValue\n';
        });
      } else {
        formattedData += '  $value\n';
      }

      formattedData += '\n';
    });

    return formattedData.trim();
  }

  void _showTrackingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tracking Data'),
          content: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Text(_trackingData),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(Duration(seconds: 5), () {
                  setState(() {
                    _isDelivered = true;
                  });
                });
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Page'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-7.3336995, 112.7698706), // Contoh koordinat
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: _isDelivered
                  ? DeliveryCompleteInfo(onBackPressed: _navigateToHome)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://iili.io/JZURY42.png', // URL gambar logo
                              height: 60,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tenang dulu ya,',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Kita lagi nyari driver untuk kamu',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(height: 4.0),
                                if (_isLoading)
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.green.shade800),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text('Sedang mencari...'),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: _showTrackingDialog,
                          child: Text(
                            'Tracking Orderan',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade800,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
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

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
    );
  }
}

class DeliveryCompleteInfo extends StatelessWidget {
  final VoidCallback onBackPressed;

  DeliveryCompleteInfo({required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK6v5WumMGw2u-PIdo7_UX6YjNDjqGt-YvpIEkjmkgm_ly7rW1jS6Fm5f6hzAdAuyxRa4&usqp=CAU', // Gambar pesanan selesai
          height: 100,
        ),
        SizedBox(height: 16.0),
        Text(
          'Pesanan Telah Selesai',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Terima kasih telah menggunakan layanan kami.',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 24.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bukti Pengiriman',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'No. Resi: ABC123456789',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Tanggal: 08 Juni 2024',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              Image.network(
                'https://cdn.pixabay.com/photo/2024/04/01/14/43/ai-generated-8669101_1280.png', // Gambar bukti pengiriman
                height: 80,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: onBackPressed,
          child: Text(
            'Kembali ke Beranda',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade800,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
