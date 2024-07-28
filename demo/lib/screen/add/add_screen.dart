import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:io';
import 'save_add_screen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  IO.Socket? socket;
  late List<CameraDescription> cameras;
  bool isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('http://192.168.42.24:8080',
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket?.onConnect((_) => print('Connected to Socket.IO server'));
    socket?.onDisconnect((_) => print('Disconnected from Socket.IO server'));
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras found');
      }
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _switchCamera() async {
    if (_controller != null && cameras.isNotEmpty) {
      final lensDirection = _controller!.description.lensDirection;
      CameraDescription newDescription;
      if (lensDirection == CameraLensDirection.front) {
        newDescription = cameras.firstWhere(
          (description) =>
              description.lensDirection == CameraLensDirection.back,
        );
        isFrontCamera = false;
      } else {
        newDescription = cameras.firstWhere(
          (description) =>
              description.lensDirection == CameraLensDirection.front,
        );
        isFrontCamera = true;
      }

      final temporaryController = CameraController(
        newDescription,
        ResolutionPreset.high,
      );

      await temporaryController.initialize();

      setState(() {
        _controller = temporaryController;
        _initializeControllerFuture = _controller!.initialize();
      });
    }
  }

  void _toggleFlash() async {
    if (_controller != null) {
      FlashMode currentFlashMode = _controller!.value.flashMode;
      FlashMode newFlashMode;
      if (currentFlashMode == FlashMode.off) {
        newFlashMode = FlashMode.torch;
      } else {
        newFlashMode = FlashMode.off;
      }
      await _controller!.setFlashMode(newFlashMode);
      setState(() {});
    }
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
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (_controller != null &&
                            _controller!.value.isInitialized) {
                          return Container(
                            width: 350,
                            height: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width:
                                        _controller!.value.previewSize!.width,
                                    height:
                                        _controller!.value.previewSize!.height,
                                    child: CameraPreview(_controller!),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text('Camera is not initialized'));
                        }
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(height: 60),
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
                          onPressed: _switchCamera,
                          iconSize: 30,
                        ),
                      ),
                      const SizedBox(width: 40),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await _initializeControllerFuture;
                            if (_controller != null) {
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
                            }
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
                          onPressed: _toggleFlash,
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
