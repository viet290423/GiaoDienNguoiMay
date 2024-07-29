import 'dart:async';
import 'package:camera/camera.dart';
import 'package:demo/controller/socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'save_add_screen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  late List<CameraDescription> cameras;
  bool isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
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
      await _initializeControllerFuture;

      if (mounted) {
        setState(() {});
      }

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

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
                                  fit: BoxFit.fill,
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
                                    socket: socketService.socket,
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
