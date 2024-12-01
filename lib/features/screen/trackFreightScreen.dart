import 'dart:async';

import 'package:cargo_app/features/screen/homepage_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/controllers/TrackFreight_controller.dart';
import '../authentication/models/usertracking_model.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';

class TrackFreightScreen extends StatefulWidget {
  String? id;
  final String freightName;
  final String freightId;
  final Map<String, dynamic> vendorDetails;

  TrackFreightScreen({
    required this.id,
    required this.freightName,
    required this.freightId,
    required this.vendorDetails,
  });

  @override
  State<TrackFreightScreen> createState() => _TrackFreightScreenState();
}

class _TrackFreightScreenState extends State<TrackFreightScreen> {
  bool isLoading = false;
  double? latitude;
  double? longitude;
  String? locationMessage;



  Future<void> _onTrackFreight() async {
    setState(() {
      isLoading = true;
      locationMessage = '';
    });

    try {
      // Use widget.id here
      TrackFreightController controller = TrackFreightController();
      TrackinguserModel trackingData =
      await controller.fetchTrackingDetails(widget.id ?? ''); // Use widget.id instead of widget.freightId

      double fetchedLatitude = trackingData.tracker.location.coordinates[0];
      double fetchedLongitude = trackingData.tracker.location.coordinates[1];

      // Extract the delivery information
      String city = trackingData.tracker.orderId.deliveryTo.city ?? 'Unknown';
      String district = trackingData.tracker.orderId.deliveryTo.district ?? 'Unknown';
      String zipCode = trackingData.tracker.orderId.deliveryTo.zipCode ?? 'Unknown';

      // Check city and district to override latitude and longitude
      if (city == 'Riyadh' && district == 'Al Yasmin') {
        fetchedLatitude = 24.82184;
        fetchedLongitude = 46.6008263;
      } else if (city == 'Riyadh' && district == 'Al Olaya') {
        // Override with coordinates for Riyadh, Al Olaya
        fetchedLatitude = 24.6923963;
        fetchedLongitude = 46.6835284;
      }

      else if (city == 'Riyadh' && district == 'Al Murabba') {
        // Override with coordinates for Riyadh, Al Olaya
        fetchedLatitude = 24.6629644;
        fetchedLongitude = 46.707033;
      }

      else if (city == 'Riyadh' && district == 'Al Malaz') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.6646445;
        fetchedLongitude = 46.7353774;
      }

      else if (city == 'Riyadh' && district == 'Al Muhammadiyah') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.7326028;
        fetchedLongitude = 46.6489199;
      }

      else if (city == 'Riyadh' && district == 'Diplomatic Quarter (DQ)') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.6804453;
        fetchedLongitude = 46.6214712;
      }

      else if (city == 'Riyadh' && district == 'Hittin') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.7613351;
        fetchedLongitude = 46.6009616;
      }

      else if (city == 'Riyadh' && district == 'Hittin') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.7613351;
        fetchedLongitude = 46.6009616;
      }


      else if (city == 'Riyadh' && district == 'Al Rabwah') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.6937836;
        fetchedLongitude = 46.7547256;
      }

      else if (city == 'Riyadh' && district == 'Al Sulimaniyah') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.6984852;
        fetchedLongitude = 46.702648;
      }

      else if (city == 'Riyadh' && district == 'Al Nakheel') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.7488902;
        fetchedLongitude = 46.6527276;
      }


      else if (city == 'Riyadh' && district == 'Al Hamra') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.7756052;
        fetchedLongitude = 46.7535825;
      }

      else if (city == 'Riyadh' && district == 'Qurtubah') {
        // Override with coordinates for Riyadh, Al Malaz
        fetchedLatitude = 24.8152095;
        fetchedLongitude = 46.7358839;
      }

      // You can add more conditions for other city-district pairs as needed
      else if (city == 'Jeddah' && district == 'Al Hamra') {
        fetchedLatitude = 21.5322512;
        fetchedLongitude = 39.1687637;
      }

      else if (city == 'Jeddah' && district == 'Al Andalus') {
        fetchedLatitude = 21.5296385;
        fetchedLongitude = 39.1441558;
      }

      else if (city == 'Jeddah' && district == 'Al Rawdah') {
        fetchedLatitude = 21.5646293;
        fetchedLongitude = 39.1581087;
      }

      else if (city == 'Jeddah' && district == 'Al Salamah') {
        fetchedLatitude = 21.5943416;
        fetchedLongitude = 39.1531361;
      }

      else if (city == 'Jeddah' && district == 'Al Khalidiyah') {
        fetchedLatitude = 21.5607661;
        fetchedLongitude = 39.134199;
      }

      else if (city == 'Jeddah' && district == 'Al Shati') {
        fetchedLatitude = 21.6045974;
        fetchedLongitude = 39.1129248;
      }

      else if (city == 'Jeddah' && district == 'Al Muhammadiyah') {
        fetchedLatitude = 21.649861;
        fetchedLongitude = 39.1298449;
      }

      else if (city == 'Jeddah' && district == 'Al Basateen') {
        fetchedLatitude = 21.6845838;
        fetchedLongitude = 39.116593;
      }

      else if (city == 'Jeddah' && district == 'Al Zahra') {
        fetchedLatitude = 21.5915182;
        fetchedLongitude = 39.1325192;
      }

      else if (city == 'Jeddah' && district == 'Al Safa') {
        fetchedLatitude = 21.5852697;
        fetchedLongitude = 39.2115621;
      }

      else if (city == 'Jeddah' && district == 'Al Aziziyah') {
        fetchedLatitude = 21.5529572;
        fetchedLongitude = 39.1944103;
      }

      else if (city == 'Jeddah' && district == 'Al Rehab') {
        fetchedLatitude = 21.5523532;
        fetchedLongitude = 39.2250528;
      }

      else if (city == 'Makkah' && district == 'Al Aziziyah') {
        fetchedLatitude = 21.4156867;
        fetchedLongitude = 39.8555768;
      }

      else if (city == 'Makkah' && district == 'Al Shoqiyah') {
        fetchedLatitude = 21.3855604;
        fetchedLongitude = 39.7965601;
      }

      else if (city == 'Makkah' && district == 'Al Awali') {
        fetchedLatitude = 21.3032829;
        fetchedLongitude = 39.9428912;
      }

      else if (city == 'Makkah' && district == 'Al Rusaifa') {
        fetchedLatitude = 21.4126839;
        fetchedLongitude = 39.7893656;
      }

      else if (city == 'Makkah' && district == 'Al Nassim') {
        fetchedLatitude = 21.3806119;
        fetchedLongitude = 39.874029;
      }

      else if (city == 'Makkah' && district == 'Al Maabdah') {
        fetchedLatitude = 21.4355569;
        fetchedLongitude = 39.8476833;
      }

      else if (city == 'Makkah' && district == 'Al Zahra') {
        fetchedLatitude = 21.4307307;
        fetchedLongitude = 39.7980025;
      }

      else if (city == 'Makkah' && district == 'Al Kaakiya') {
        fetchedLatitude = 21.3792198;
        fetchedLongitude = 39.8166664;
      }

      else if (city == 'Makkah' && district == 'Jarwal') {
        fetchedLatitude = 21.4281065;
        fetchedLongitude = 39.8190133;
      }

      else if (city == 'Madinah' && district == 'Al Haram') {
        fetchedLatitude = 24.4688821;
        fetchedLongitude = 39.6124608;
      }

      else if (city == 'Madinah' && district == 'Al Uyun') {
        fetchedLatitude = 24.5200688;
        fetchedLongitude = 39.5700796;
      }

      else if (city == 'Madinah' && district == 'Al Aziziyah') {
        fetchedLatitude = 23.3733004;
        fetchedLongitude = 40.8606005;
      }

      else if (city == 'Madinah' && district == 'Quba') {
        fetchedLatitude = 24.461668;
        fetchedLongitude = 39.6046887;
      }

      else if (city == 'Madinah' && district == 'Al Khalidiyah') {
        fetchedLatitude = 24.461017;
        fetchedLongitude = 39.6609191;
      }

      else if (city == 'Madinah' && district == 'Al Aqiq') {
        fetchedLatitude = 24.4689223;
        fetchedLongitude = 39.5989081;
      }

      else if (city == 'Madinah' && district == 'Al Awali') {
        fetchedLatitude = 24.4590758;
        fetchedLongitude = 39.6202629;
      }

      else if (city == 'Madinah' && district == 'Bani Khidrah') {
        fetchedLatitude = 24.4642673;
        fetchedLongitude = 39.6027266;
      }

      else if (city == 'Madinah' && district == 'Al Iskan') {
        fetchedLatitude = 24.4578401;
        fetchedLongitude = 39.6366876;
      }

      else if (city == 'Madinah' && district == 'Al Shuraybat') {
        fetchedLatitude = 24.4484556;
        fetchedLongitude = 39.6276862;
      }

      else if (city == 'Dammam' && district == 'Al Faisaliyah') {
        fetchedLatitude = 26.3924809;
        fetchedLongitude = 50.0416274;
      }

      else if (city == 'Dammam' && district == 'Al Shati') {
        fetchedLatitude = 26.4749029;
        fetchedLongitude = 50.107678;
      }

      else if (city == 'Dammam' && district == 'Al Rakah') {
        fetchedLatitude = 26.3695061;
        fetchedLongitude = 50.1815107;
      }

      else if (city == 'Dammam' && district == 'Al Khalidiyah') {
        fetchedLatitude = 26.4138166;
        fetchedLongitude = 50.1258277;
      }

      else if (city == 'Dammam' && district == 'Al Anoud') {
        fetchedLatitude = 26.4472359;
        fetchedLongitude = 50.0623962;
      }

      else if (city == 'Dammam' && district == 'Al Mazruiyah') {
        fetchedLatitude = 26.4425653;
        fetchedLongitude = 50.11573;
      }

      else if (city == 'Dammam' && district == 'Al Murjan') {
        fetchedLatitude = 26.4735406;
        fetchedLongitude = 50.1200375;
      }

      else if (city == 'Dammam' && district == 'Al Badiyah') {
        fetchedLatitude = 26.4269138;
        fetchedLongitude = 50.0812425;
      }

      else if (city == 'Dammam' && district == 'Al Muhammadiyah') {
        fetchedLatitude = 26.4558614;
        fetchedLongitude = 50.04545;
      }

      else if (city == 'Dammam' && district == 'Al Fursan') {
        fetchedLatitude = 26.3565362;
        fetchedLongitude = 26.3565362;
      }

      else if (city == 'Al Khobar' && district == 'Al Khobar Al Shamalia') {
        fetchedLatitude = 26.2908939;
        fetchedLongitude = 50.2032082;
      }

      else if (city == 'Al Khobar' && district == 'Al Aqrabiyah') {
        fetchedLatitude = 26.2952534;
        fetchedLongitude = 50.1823163;
      }

      else if (city == 'Al Khobar' && district == 'Al Rawabi') {
        fetchedLatitude = 26.3320179;
        fetchedLongitude = 50.2021572;
      }

      else if (city == 'Al Khobar' && district == 'Al Olaya') {
        fetchedLatitude = 26.3014375;
        fetchedLongitude = 50.1786126;
      }

      else if (city == 'Al Khobar' && district == 'Al Hamra') {
        fetchedLatitude = 26.2277828;
        fetchedLongitude = 50.1938231;
      }

      else if (city == 'Al Khobar' && district == 'Al Rakah Al Janubiyah') {
        fetchedLatitude = 26.3516864;
        fetchedLongitude = 50.189559;
      }

      else if (city == 'Al Khobar' && district == 'Al Yarmouk') {
        fetchedLatitude = 26.3118046;
        fetchedLongitude = 50.2003142;
      }

      else if (city == 'Al Khobar' && district == 'Al Thuqbah') {
        fetchedLatitude = 26.2744572;
        fetchedLongitude = 50.180285;
      }

      else if (city == 'Al Khobar' && district == 'Al Khuzama') {
        fetchedLatitude = 26.2066295;
        fetchedLongitude = 50.1744114;
      }

      else if (city == 'Abha' && district == 'Al Sadd') {
        fetchedLatitude = 18.216748;
        fetchedLongitude = 42.4877776;
      }

      else if (city == 'Abha' && district == 'Al Shamasan') {
        fetchedLatitude = 18.227846;
        fetchedLongitude = 42.5029049;
      }

      else if (city == 'Abha' && district == 'Al Manhal') {
        fetchedLatitude = 18.224389;
        fetchedLongitude = 42.5094394;
      }

      else if (city == 'Abha' && district == 'Al Dabab') {
        fetchedLatitude = 18.1973728;
        fetchedLongitude = 42.5054678;
      }

      else if (city == 'Abha' && district == 'Al Rabwah') {
        fetchedLatitude = 18.2050024;
        fetchedLongitude = 42.5163871;
      }

      else if (city == 'Abha' && district == 'Al Khasha') {
        fetchedLatitude = 18.2137813;
        fetchedLongitude = 42.5027676;
      }

      else if (city == 'Abha' && district == 'Al Nasr') {
        fetchedLatitude = 18.255081;
        fetchedLongitude = 42.5037379;
      }

      else if (city == 'Abha' && district == 'Al Ward') {
        fetchedLatitude = 18.2287103;
        fetchedLongitude = 42.485318;
      }

      else if (city == 'Abha' && district == 'Al Mahalah') {
        fetchedLatitude = 18.2764351;
        fetchedLongitude = 42.5602404;
      }

      else if (city == 'Taif' && district == 'Al Shifa ') {
        fetchedLatitude = 21.070195;
        fetchedLongitude = 40.3057905;
      }

      else if (city == 'Taif' && district == 'Al Hada') {
        fetchedLatitude = 21.3409391;
        fetchedLongitude = 40.3299976;
      }

      else if (city == 'Taif' && district == 'Al Faisaliyah') {
        fetchedLatitude = 21.290853;
        fetchedLongitude = 40.418158;
      }

      else if (city == 'Taif' && district == 'Al Ruddaf') {
        fetchedLatitude = 21.2247918;
        fetchedLongitude = 40.4178855;
      }

      else if (city == 'Taif' && district == 'Al Khalidiyah') {
        fetchedLatitude = 21.274801;
        fetchedLongitude = 40.394831;
      }

      else if (city == 'Taif' && district == 'Al Salamah') {
        fetchedLatitude = 21.2684271;
        fetchedLongitude =  40.3977454;
      }

      else if (city == 'Taif' && district == 'Al Naseem') {
        fetchedLatitude = 21.2642113;
        fetchedLongitude =  40.4442584;
      }

      else if (city == 'Al Ahsa' && district == 'Al Mubarraz') {
        fetchedLatitude = 25.4261014;
        fetchedLongitude =  49.4749942;
      }

      else if (city == 'Al Ahsa' && district == 'Al Hofuf') {
        fetchedLatitude = 25.3057029;
        fetchedLongitude =  49.5309129;
      }

      else if (city == 'Al Ahsa' && district == 'Al Uqair') {
        fetchedLatitude = 25.6444504;
        fetchedLongitude =  50.2043006;
      }

      else if (city == 'Al Ahsa' && district == 'Al Shubah') {
        fetchedLatitude = 25.468976;
        fetchedLongitude =  49.6184886;
      }

      else if (city == 'Al Ahsa' && district == 'Al Qara') {
        fetchedLatitude = 25.4114824;
        fetchedLongitude =  49.6825147;
      }

      else if (city == 'Al Ahsa' && district == 'Al Jishshah') {
        fetchedLatitude = 25.4643321;
        fetchedLongitude =  49.8857429;
      }

      else if (city == 'Al Ahsa' && district == 'Al Oyoun') {
        fetchedLatitude = 25.665386;
        fetchedLongitude =  49.5771745;
      }

      else if (city == 'Al Ahsa' && district == 'Al Khars') {
        fetchedLatitude = 25.4439938;
        fetchedLongitude =  49.5698699;
      }

      else if (city == 'Al Ahsa' && district == 'Al Manar') {
        fetchedLatitude = 25.3488371;
        fetchedLongitude =  49.5683374;
      }
      // More city-district conditions can be added here...

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackFreightMapScreen(
            latitude: fetchedLatitude,
            longitude: fetchedLongitude,
            userLatitude: position.latitude,
            userLongitude: position.longitude,
            city: city,
            district: district,
            zipCode: zipCode,
          ),
        ),
      );

      Future.delayed(Duration(seconds: 15), () async {
        Position newPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          latitude = newPosition.latitude;
          longitude = newPosition.longitude;
        });
      });

    } catch (error) {
      setState(() {
        isLoading = false;
        locationMessage = 'Failed to fetch location data';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }







  @override
  Widget build(BuildContext context) {
    var vendorDetails = widget.vendorDetails; // Get the vendor details

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
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
                  SizedBox(height: 4),
                  Text(
                    'Your Carrier',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Freight: ${widget.freightName}', // Display the passed freight name
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Vendor Details Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFreightDetailRow('Driver Name', vendorDetails['name'] ?? 'N/A'),
                  _buildFreightDetailRow('Company Name', vendorDetails['companyName'] ?? 'N/A'),
                  _buildFreightDetailRow('Fleet Size', vendorDetails['fleetSize'] ?? 'N/A'),
                  _buildFreightDetailRow('Address', vendorDetails['address'] ?? 'N/A'),
                  _buildFreightDetailRow('Commercial Number', vendorDetails['commercialNumber'] ?? 'N/A'),
                  _buildFreightDetailRow('Email', vendorDetails['email'] ?? 'N/A'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Driver Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFreightDetailRow('Driver Number', vendorDetails['phone'] ?? 'N/A'),
                  _buildFreightDetailRow('License Number', 'DL123456789'),
                  _buildFreightDetailRow('Registration', 'D7142348'),
                  _buildFreightDetailRow('Truck License Plate', 'SYA 2845'),
                ],
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
                  onPressed: _onTrackFreight,
                  child: Text(
                    'Track Freight',
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

  Widget _buildFreightDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class TrackFreightMapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double userLatitude;
  final double userLongitude;
  final String city;
  final String district;
  final String zipCode;

  TrackFreightMapScreen({
    required this.latitude,
    required this.longitude,
    required this.userLatitude,
    required this.userLongitude,
    required this.city,
    required this.district,
    required this.zipCode,
  });

  @override
  _TrackFreightMapScreenState createState() => _TrackFreightMapScreenState();
}

class _TrackFreightMapScreenState extends State<TrackFreightMapScreen> {
  late double latitude;
  late double longitude;
  late double userLatitude;
  late double userLongitude;

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
    latitude = widget.latitude;
    longitude = widget.longitude;
    userLatitude = widget.userLatitude;
    userLongitude = widget.userLongitude;
    print('Freight Latitude: $latitude, Freight Longitude: $longitude');
    print('User Latitude: $userLatitude, User Longitude: $userLongitude');
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print("Location permission is permanently denied. Please enable it in settings.");
      _showPermissionDialog();
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          userLatitude = position.latitude;
          userLongitude = position.longitude;
        });
      } else {
        print("Location permission is denied.");
      }
    } else {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        userLatitude = position.latitude;
        userLongitude = position.longitude;
      });
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Location Permission Denied'),
        content: Text('Location permission has been permanently denied. Please enable it in your device settings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Geolocator.openAppSettings();
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  late Timer _timer;
  Duration _countdownDuration = Duration(minutes: 10);

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdownDuration.inSeconds > 0) {
        setState(() {
          _countdownDuration -= Duration(seconds: 1);
        });
      } else {
        timer.cancel(); // Stop the timer when it reaches 0.
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen map
          FlutterMap(
            options: MapOptions(
              center: LatLng(latitude, longitude),
              zoom: 12.0,
              minZoom: 2.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(latitude, longitude),
                    builder: (ctx) => Image.asset(
                      'assets/gps-navigation.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(userLatitude, userLongitude),
                    builder: (ctx) => Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(latitude, longitude),
                      LatLng((latitude + userLatitude) / 2, longitude - 0.01),
                      LatLng((latitude + userLatitude) / 2, longitude + 0.01),
                      LatLng(userLatitude, userLongitude),
                    ],
                    strokeWidth: 4.0,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),

          // Circular back button
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          // Floating Bottom Card
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  Text(
                    "Delivery Location, City: ${widget.city}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "District: ${widget.district}, Zip Code: ${widget.zipCode}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Data Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Column 1: Today's Distance and Duration
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            icon: Icons.directions_car,
                            label: "Today Km",
                            value: "15 Km",
                            color: Colors.green,
                          ),
                          SizedBox(height: 8),
                          _buildInfoRow(
                            icon: Icons.timer_off,
                            label: "Total Duration",
                            value: formatDuration(_countdownDuration),
                            color: Colors.red,
                          ),
                        ],
                      ),

                      // Column 2: Last Stop Data
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            icon: Icons.navigation,
                            label: "From Last Stop",
                            value: "2.24 Km",
                            color: Colors.orange,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable row widget for displaying info
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}