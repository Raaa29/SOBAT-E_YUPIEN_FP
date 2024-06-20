import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'loadingnebeng_page.dart';

class RidePage extends StatefulWidget {
  final String pickupLocation;
  final String destinationLocation;

  RidePage({required this.pickupLocation, required this.destinationLocation});

  @override
  _RidePageState createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  String paymentMethod = '';
  TextEditingController pickupController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-7.333803, 112.788124), 
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Titik Jemput dan Tujuan'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _initialCameraPosition,
                  ),
                ),
              ),
              SizedBox(height: 16),
              buildLocationField(Icons.location_on, 'Titik Jemput', pickupController),
              SizedBox(height: 16),
              buildLocationField(Icons.location_on, 'Titik Antar', destinationController, Colors.red),
              SizedBox(height: 16),
              Text(
                'Pilih Metode Pembayaran:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              buildPaymentOptions(),
              SizedBox(height: 16),
              if (paymentMethod == 'Tunai')
                Text(
                  'Harga: Rp 3000',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              if (paymentMethod == 'QRIS')
                buildQRCodeSection(),
              SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (pickupController.text.isEmpty ||
                          destinationController.text.isEmpty ||
                          paymentMethod.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Silakan isi semua data terlebih dahulu'),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoadingNebengPage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Pesan',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocationField(IconData icon, String label, TextEditingController controller, [Color color = Colors.green]) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPaymentOptions() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text('Tunai'),
            leading: Radio(
              value: 'Tunai',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text('QRIS'),
            leading: Radio(
              value: 'QRIS',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildQRCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRosGWly6ILrzcWZIOXWKjjysKuifqXrji06g&s',
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text('Pindai QR Code untuk pembayaran'),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RidePage(
      pickupLocation: '',
      destinationLocation: '',
    ),
  ));
}
