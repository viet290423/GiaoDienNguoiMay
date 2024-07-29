import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  IO.Socket? _socket;

  IO.Socket? get socket => _socket;

  SocketService() {
    _initializeSocket();
  }

  void _initializeSocket() {
    _socket = IO.io('https://api-socket-io.onrender.com',
        IO.OptionBuilder().setTransports(['websocket']).build());

    _socket?.onConnect((_) {
      print('Connected to Socket.IO server');
      notifyListeners();
    });

    _socket?.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
      notifyListeners();
    });
  }

  // @override
  // void dispose() {
  //   _socket?.dispose();
  //   super.dispose();
  // }
}
