import 'package:flutter/material.dart';
import 'konfirmasipesanan_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Kantin',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuPage(canteenName: 'Kantin Bela Negara 1'), // Default value for initial run
    );
  }
}

class MenuPage extends StatefulWidget {
  final String canteenName;

  MenuPage({required this.canteenName});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final Map<String, List<Map<String, dynamic>>> menuItems = {
    'Kantin Bela Negara 1': [
      {
        'title': 'Paket Ayam Geprek',
        'subtitle': 'Nasi dengan lauk ayam dan minuman es teh',
        'price': 12000,
        'imageUrl': 'https://images.pexels.com/photos/20371525/pexels-photo-20371525/free-photo-of-piring-hidangan-kaca-ayam.jpeg?auto=compress&cs=tinysrgb&w=600', // Network image URL
      
      },
      {
        'title': 'Paket Mie Ayam',
        'subtitle': 'Mie ayam jamur spesial jumbo dan minuman es teh',
        'price': 15000,
        'imageUrl': 'https://images.pexels.com/photos/884600/pexels-photo-884600.jpeg?auto=compress&cs=tinysrgb&w=600', // Network image URL
      },
      {
        'title': 'Paket Ayam Goreng',
        'subtitle': 'Nasi ayam goreng dan minuman es teh',
        'price': 12000,
        'imageUrl': 'https://images.pexels.com/photos/884600/pexels-photo-884600.jpeg?auto=compress&cs=tinysrgb&w=600', // Network image URL
      },
      {
        'title': 'Paket Nasi Pecel',
        'subtitle': 'Nasi pecel lauk tahu tempe ayam goreng dan minuman es teh',
        'price': 10000,
        'imageUrl': 'https://images.pexels.com/photos/884600/pexels-photo-884600.jpeg?auto=compress&cs=tinysrgb&w=600', // Network image URL
      },
    ],
    'Kantin Bela Negara 2': [
      {
        'title': 'Paket Nasi Goreng',
        'subtitle': 'Nasi goreng dengan es teh',
        'price': 12000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg', // Network image URL
      },
      {
        'title': 'Paket Mie Goreng',
        'subtitle': 'Mie Goreng dok dok dengan minuman es teh',
        'price': 12000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Capcay',
        'subtitle': 'Capcay seafood dengan minuman es teh',
        'price': 18000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Nasi Goreng Jowo',
        'subtitle': 'Nasi Goreng Jowo dengan minuman es teh',
        'price': 12000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Kwitiaw Goreng',
        'subtitle': 'Mie Kwitiaw dengan minuman es teh',
        'price': 14000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
    ],
    'Kantin Bela Negara 3': [
      {
        'title': 'Paket Seblak Cumi',
        'subtitle': 'Seblak Cumi dengan es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg', // Network image URL
      },
      {
        'title': 'Paket Seblak Lava',
        'subtitle': 'Seblak pedas menengah dengan minuman es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Seblak Keju',
        'subtitle': 'Seblak bertabur keju dengan minuman es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Seblak Demit',
        'subtitle': 'Seblak super pedas dengan minuman es teh',
        'price': 12000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Seblak Mix',
        'subtitle': 'Seblak mix bebas dengan minuman es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
    ],
    'Kantin Bela Negara 4': [
      {
        'title': 'Paket Bakaran 1',
        'subtitle': 'Usus pedas 2 tsk, sosis 2 tsk, odeng 2 tsk dengan es teh',
        'price': 10000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg', // Network image URL
      },
      {
        'title': 'Paket Bakaran 2',
        'subtitle': 'Pentol bakar 2 tsk, tahu bakar 2 tsk, telur puyuh 2 tsk dengan minuman es teh',
        'price': 10000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Bakaran 3',
        'subtitle': 'marsmellow 2 tsk, jagung bakar 2 tsk, udang bakar 2 tsk dengan minuman es teh',
        'price': 10000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Mix',
        'subtitle': 'Mix bebas dengan minuman es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
    ],
    'Kantin Bela Negara 5': [
      {
        'title': 'Paket Ayam Geprek Mania 1',
        'subtitle': 'Nasi ayam dada/paha atas dengan es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg', // Network image URL
      },
      {
        'title': 'Paket Ayam Geprek Mania 2',
        'subtitle': 'Nasi ayam paha bawah/sayap dengan minuman es teh',
        'price': 13000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Risol Mayo ',
        'subtitle': 'Risol mayo 5 pcs dengan minuman es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Ayam Keju',
        'subtitle': 'Nasi ayam berlumer keju dengan minuman es teh',
        'price': 17000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
    ],
    'Kantin Bela Negara 6': [
      {
        'title': 'Paket Western 1',
        'subtitle': 'Burger king dengan es teh',
        'price': 13000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg', // Network image URL
      },
      {
        'title': 'Paket Western 2',
        'subtitle': 'Pizza jumbo dengan minuman es teh',
        'price': 25000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Western 3',
        'subtitle': 'Ratatouille lokal dengan minuman es teh',
        'price': 18000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Western 4',
        'subtitle': 'Steak dengan minuman es teh',
        'price': 17000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
    ],
    'Kantin Bela Negara 7': [
      {
        'title': 'Paket Japan 1',
        'subtitle': 'Sushi isi 5 pcs dengan es teh',
        'price': 14000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg', // Network image URL
      },
      {
        'title': 'Paket Japan 2',
        'subtitle': 'Sashimi jumbo dengan minuman es teh',
        'price': 17000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Japan 3',
        'subtitle': 'Ramen jumbo dengan minuman es teh',
        'price': 17000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Japan 4',
        'subtitle': 'Ayam katsu dengan minuman es teh',
        'price': 18000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
    ],
    'Kantin Bela Negara 8': [
      {
        'title': 'Paket Korean 1',
        'subtitle': 'Kimbap jumbo dengan es teh',
        'price': 17000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg', // Network image URL
      },
      {
        'title': 'Paket Korean 2',
        'subtitle': 'Jjajangmyeon dengan minuman es teh',
        'price': 15000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Korean 3',
        'subtitle': 'Tteokbokki jumbo dengan minuman es teh',
        'price': 16000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
       {
        'title': 'Paket Korean 4',
        'subtitle': 'Ramyeon jumbo dengan minuman es teh',
        'price': 16000,
        'imageUrl': 'https://cdn.pixabay.com/photo/2017/06/06/13/10/goat-satay-2377229_1280.jpg', // Network image URL
      },
    ],
  };

  final Map<String, int> _cart = {};

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = menuItems[widget.canteenName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.canteenName),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildItemCard(
                items[index]['title'],
                items[index]['subtitle'],
                items[index]['price'],
                items[index]['imageUrl'],
              );
            },
          ),
          if (_cart.isNotEmpty)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  // Navigate to KonfirmasiPesananPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KonfirmasiPesananPage(
                        itemList: _cart.entries.map((entry) {
                          final item = items.firstWhere((item) => item['title'] == entry.key);
                          return {
                            'title': entry.key,
                            'price': item['price'],
                            'qty': entry.value,
                          };
                        }).toList(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Total Items: ${_cart.values.fold<int>(0, (sum, item) => sum + item)} | Total Price: Rp${(_cart.entries.fold<int>(
                    0,
                    (sum, entry) => sum + (entry.value * items.firstWhere((item) => item['title'] == entry.key)['price'] as int),
                  )).toString()}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard(
      String title, String subtitle, int price, String imageUrl) {
    final isInCart = _cart.containsKey(title);

    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Image.network(imageUrl, fit: BoxFit.cover), // Network image
          ListTile(
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(subtitle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rp$price',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                SizedBox(width: 8), // Add spacing between price and button
                MaterialButton(
                  child: isInCart
                      ? Row(
                          children: [
                            Icon(Icons.check, color: Colors.white),
                            Text(' Added', style: TextStyle(color: Colors.white)),
                          ],
                        )
                      : Text('Add', style: TextStyle(color: Colors.white)),
                  color: isInCart ? Colors.red : Colors.green,
                  onPressed: () {
                    setState(() {
                      if (isInCart) {
                        _cart.update(title, (value) => value + 1);
                      } else {
                        _cart[title] = 1;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}