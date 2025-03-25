import 'package:flutter/material.dart';

// Global list to store cart items
List<Map<String, String>> globalCartItems = [];
List<Map<String, dynamic>> placedOrders = [];  // To store placed orders

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePagee(),
    );
  }
}

class HomePagee extends StatelessWidget {
  const HomePagee({super.key});

  final List<Map<String, String>> medicines = const [
    {
      'image': 'lib/images/medicinea.png',
      'name': 'Paracetamol',
      'price': '2.50',
      'description': 'Paracetamol is commonly used to reduce fever and relieve mild to moderate pain. It works by blocking pain signals in the brain and lowering body temperature.'
    },
    {
      'image': 'lib/images/medicineb.png',
      'name': 'Dolo 650',
      'price': '3.20',
      'description': 'Dolo 650 is a popular choice for fever and body aches. It is safe and effective for relieving symptoms of cold, flu, and mild infections.'
    },
    {
      'image': 'lib/images/medicinec.png',
      'name': 'Nice',
      'price': '1.80',
      'description': 'Nice is used to treat inflammation, muscle pain, and arthritis. It provides quick relief from swelling and stiffness in the joints.'
    },
    {
      'image': 'lib/images/medicined.png',
      'name': 'Aspirin 300',
      'price': '4.10',
      'description': 'Aspirin 300 is an anti-inflammatory drug used for pain relief and to reduce the risk of heart attacks. It helps by thinning the blood and easing discomfort.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/images/emptyprofile.jpg'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 12,
              child: Text(
                globalCartItems.length.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for medicine',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We will deliver your medicines',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Catalog'),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'lib/images/medicine.png',
                    height: 80,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Popular',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  return MedicineCard(
                    image: medicines[index]['image']!,
                    name: medicines[index]['name']!,
                    price: medicines[index]['price']!,
                    description: medicines[index]['description']!,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlacedOrdersPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Placed Orders'),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String description;

  const MedicineCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                image: image,
                name: name,
                price: price,
                description: description,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                height: 80,
              ),
              Spacer(),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '\$' + price,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String description;

  const ProductDetailPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  void _addToCart(BuildContext context) {
    globalCartItems.add({'name': name, 'price': price, 'image': image});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added to cart!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              image,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '\$' + price,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () => _addToCart(context),
              icon: Icon(Icons.shopping_cart),
              label: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  double calculateTotalCost() {
    return globalCartItems.fold(0.0, (total, item) => total + double.parse(item['price']!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: globalCartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    globalCartItems[index]['image']!,
                    height: 40,
                  ),
                  title: Text(globalCartItems[index]['name']!),
                  subtitle: Text('\$' + globalCartItems[index]['price']!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        globalCartItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Total: \$${calculateTotalCost().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && addressController.text.isNotEmpty) {
                      placedOrders.add({
                        'name': nameController.text,
                        'address': addressController.text,
                        'items': List.from(globalCartItems),
                        'total': calculateTotalCost(),
                      });
                      globalCartItems.clear(); // Clear cart after order
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Order Placed!'),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter your name and address.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Center(
                    child: Text('Buy Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlacedOrdersPage extends StatelessWidget {
  const PlacedOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placed Orders'),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: placedOrders.length,
        itemBuilder: (context, index) {
          final order = placedOrders[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Order by: ${order['name']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address: ${order['address']}'),
                  Text('Total: \$${order['total'].toStringAsFixed(2)}'),
                  SizedBox(height: 5),
                  Text('Items:'),
                  ...order['items'].map<Widget>((item) {
                    return Text('${item['name']} - \$${item['price']}');
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
