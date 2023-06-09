// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
    print("_serverStatus: $_serverStatus");
  }

  void _initConfig() {
    // Importante aplicar la condicion si estoy en ISO o Android para el ruta del servidor
    this._socket = IO.io('http://192.168.3.21:3000/', {
      'transports': ['websocket'],
      'autoConnect': true //Sirve para que se conecte automaticamente
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // Escuchar eventos personalizados
    this._socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje: $payload');
      print('nombre: ${payload['nombre']}');
      print('mensaje: ${payload['mensaje']}');
      print(payload.containsKey('mensaje2')
          ? 'mensaje2: ${payload['mensaje2']}'
          : 'No hay mensaje2');
    });
  }
}
