import 'package:cargo_app/features/authentication/screens/login/login_page.dart';
import 'package:cargo_app/features/screen/packages_page.dart';
import 'package:cargo_app/features/screen/shipFreightPage.dart';
import 'package:cargo_app/features/screen/trackFreightScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../authentication/controllers/shipfreightget_controller.dart';
import 'Carrier/user/profileuser_page.dart'; // Import GetX for state management

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  final ShipmentgetController shipmentController = Get.put(ShipmentgetController());

  @override
  void initState() {
    super.initState();
    _loadUserName();
    shipmentController.fetchShipments();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
        //   onPressed: () {},
        // ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileUserPage()),
              );

            },
            icon: Icon(Icons.settings, color: Colors.grey),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/cargologo.png',
                    height: 60,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Shipping. Easier!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Hello, $userName!',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your Freights:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (shipmentController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (shipmentController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        shipmentController.errorMessage.value,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (shipmentController.shipments.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'You have no shipments at the moment.',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: shipmentController.shipments.length,
                    itemBuilder: (context, index) {
                      final shipment = shipmentController.shipments[index];
                      return GestureDetector(
                        onTap: () {
                          if (shipment.status?.toLowerCase() == 'shipped') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShipmentDeliveredScreen(
                                  shipmentName: shipment.freightShipped ?? 'Unknown Shipment',
                                ),
                              ),
                            );
                          } else {
                            Get.to(() => TrackFreightScreen(
                              id: shipment.id,
                              freightName: shipment.freightShipped ?? 'N/A',
                              freightId: shipment.vendorId?.id ?? 'N/A',
                              vendorDetails: {
                                'name': shipment.vendorId?.name ?? 'N/A',
                                'phone': shipment.vendorId?.phone ?? 'N/A',
                                'companyName': shipment.vendorId?.companyName ?? 'N/A',
                                'fleetSize': shipment.vendorId?.fleetSize ?? 'N/A',
                                'address': shipment.vendorId?.address ?? 'N/A',
                                'commercialNumber': shipment.vendorId?.commercialNumber ?? 'N/A',
                                'email': shipment.vendorId?.email ?? 'N/A',
                              },
                            ));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildFreightCard(
                            'assets/cargologo.png',
                            shipment.freightShipped ?? 'Unknown Shipment',
                            'DHL,',
                            shipment.status ?? 'N/A',
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),


            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PackagesScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF09007D),
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'See Our Packages'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF08085A),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) => ShipFreightScreen()),
                    );
                  },
                  child: Text(
                    'New Freight',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFreightCard(String imageUrl, String title, String company, String status) {

    // Default card for other statuses
    String displayStatus = '';

    switch (status.toLowerCase()) {
      case 'processing':
        displayStatus = 'Pending from the Carrier';
        break;
      case 'shipped':
        displayStatus = 'Shipment has been Delivered';
        break;
      case 'accept':
        displayStatus = 'Carrier has Accepted';
        break;
      case 'declined':
        displayStatus = 'Carrier has declined';
        break;
      default:
        displayStatus = status;  // Default to showing the original status
    }



    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  company,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  displayStatus,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ShipmentDeliveredScreen extends StatelessWidget {
  final String shipmentName;

  const ShipmentDeliveredScreen({Key? key, required this.shipmentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The Shipment Has Been Delivered',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18),
            Text(
              'Thank You For Using Cargo!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 26),
            Text(
              'Shipment: $shipmentName',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
