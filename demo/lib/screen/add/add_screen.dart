import 'package:camera/camera.dart';
import 'package:demo/app/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'save_add_screen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('https://api-socket-io.onrender.com',
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket?.onConnect((_) => print('Connected to Socket.IO server'));
    socket?.onDisconnect((_) => print('Disconnected from Socket.IO server'));
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'TAKE GREAT PICTURE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // Check if the controller is initialized
                        if (_controller != null &&
                            _controller!.value.isInitialized) {
                          return Container(
                            width: 350, // Width of camera preview
                            height: 350, // Height of camera preview
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(50), // Rounded corners
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: CameraPreview(_controller!),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text('Camera is not initialized'));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(height: Dimensions.height30 * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5EFE2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.autorenew,
                              color: Color(0xFF4E7360)),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                      ),
                      const SizedBox(width: 40),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await _initializeControllerFuture;
                            final image = await _controller!.takePicture();
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaveAddScreen(
                                  imagePath: image.path,
                                  socket: socket,
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5EFE2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF4E7360),
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5EFE2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.flash_on,
                              color: Color(0xFF4E7360)),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
