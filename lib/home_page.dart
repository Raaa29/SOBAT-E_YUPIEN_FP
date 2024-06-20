import 'package:flutter/material.dart';
import 'food_page.dart';
import 'service_page.dart';
import 'team_profile_page.dart';
import 'riwayat_page.dart';
import 'chat_page.dart';
import 'ride_page.dart';
import 'map_cek_page.dart'; // Import the new MapPage

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.green,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePageContent(),
    RiwayatPage(),
    ChatPage(),
    TeamProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobat-e-Yupien'),
        backgroundColor: Colors.green[700],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 16),
            _buildWelcomeMessage(),
            SizedBox(height: 16),
            _buildServiceButtons(context),
            SizedBox(height: 16),
            _buildLocationCheck(context),
            SizedBox(height: 16),
            _buildPromotionalBanners(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Sedang ingin mencari apa',
        prefixIcon: Icon(Icons.search, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green[700]!),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Text(
      'Selamat datang SOBATE YUPIEN',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildServiceButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildServiceButton(
            context,
            Icons.motorcycle,
            'Nebeng',
            RidePage(
              pickupLocation: 'Default Pickup Location',
              destinationLocation: 'Default Destination Location',
            )),
        _buildServiceButton(
            context, Icons.local_shipping_outlined, 'Kirim', ServicePage()),
        _buildServiceButton(context, Icons.restaurant, 'Makanan', FoodPage()),
      ],
    );
  }

  Widget _buildServiceButton(
      BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green[700],
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildLocationCheck(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.green[700], size: 30),
              SizedBox(width: 10),
              Text(
                'Cek Lokasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapPage()),
              );
            },
            icon: Icon(Icons.map, color: Colors.white),
            label: Text(
              'Cek Lokasi',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalBanners() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPromotionalBanner(
          'https://img.freepik.com/free-vector/hand-drawn-fast-food-sale-banner-template_23-2150992555.jpg?t=st=1717693126~exp=1717696726~hmac=c4a8bcaee1e2d27fbce9867e93d5b495f932012851d2b8ffe5f6f1d810eaeb5e&w=1060',
        ),
        SizedBox(height: 16),
        _buildPromotionalBanner(
          'https://img.freepik.com/free-vector/hand-drawn-fast-food-sale-banner_23-2150970567.jpg?t=st=1717693176~exp=1717696776~hmac=2e359bb376f0a201bd54662a7d22f353080fc0ca808948e53fc8078a10a9c873&w=1060',
        ),
        SizedBox(height: 16),
        _buildPromotionalBanner(
          'https://img.freepik.com/free-vector/flat-design-fast-food-sale-banner_23-2149165450.jpg?t=st=1717693244~exp=1717696844~hmac=92f395cb154d84b66b63f7c22ed0fa89d1d5766d90780bd1404a2cb1b0f8a435&w=1060',
        ),
      ],
    );
  }

  Widget _buildPromotionalBanner(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      height: 200, // Anda bisa menyesuaikan tinggi sesuai kebutuhan
    );
  }
}