import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _currentLocation;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _initializeCamera();
  }


  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show error
      setState(() {
        _currentLocation = "Location services are disabled.";
      });
      return;
    }


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        setState(() {
          _currentLocation = "Location permission denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {

      setState(() {
        _currentLocation = "Location permissions are permanently denied.";
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation =
        "${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}";
      });
    } catch (e) {
      setState(() {
        _currentLocation = "Failed to get location.";
      });
    }
  }


  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    setState(() {
      _cameras = cameras;
    });

    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(_cameras![0], ResolutionPreset.high);
      await _cameraController?.initialize();
    }
  }


  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/eiffel.jpg'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Content
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Hi, Nice to meet you in',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Monument Explorer!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Display location or loading text
                      Text(
                        _currentLocation ?? "Fetching your location...",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _cameras == null || _cameras!.isEmpty
                    ? CircularProgressIndicator()
                    : Column(
                  children: [
                    _cameraController!.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _cameraController!.value.aspectRatio,
                      child: CameraPreview(_cameraController!),
                    )
                        : Container(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_cameraController != null &&
                            _cameraController!.value.isInitialized) {
                          XFile picture = await _cameraController!
                              .takePicture();

                        }
                      },
                      child: Text('Capture Image'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/monuments');
                      },
                      child: Text('Navigate to Monuments'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
