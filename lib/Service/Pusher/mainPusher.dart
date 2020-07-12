import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:tienda_mimi/Service/Model/base_model.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';

class MainPusher {

  Event lastEvent;
  Channel channel;
  String lastConnectionState;
  var channelController = TextEditingController(text: "my-channel");
  var eventController = TextEditingController(text: "my-event");


  Future<void> initPusher() async {
    try {
      await Pusher.init('18c8170377c406cfcf3a', PusherOptions(cluster: 'us2'),
          enableLogging: true);
      new Future.delayed(const Duration(seconds: 120)); //recommend

    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void conectPusher() {
    Pusher.connect(onConnectionStateChange: (x) async {
      lastConnectionState = x.currentState;
      print(lastConnectionState.toString() + ' cambio');
    }, onError: (x) {
      debugPrint("Error: ${x.message}");
    });
  }


  Future<void> suscribePusher() async {
    channel = await Pusher.subscribe(channelController.text);
  }

  void bindPusher(){
    channel.bind(eventController.text, (x) {

      lastEvent = x;
      Message mes=Message.fromJson(jsonDecode(lastEvent.data));
      amountProduct=mes.message;
      _inEventData.add(lastEvent.data);
      _inEventData2.add(lastEvent.data);
      _inEventData3.add(lastEvent.data);

    });
  }

  void unbindPusher(){
    channel.unbind(eventController.text);
    _eventData.close();
  }



  StreamController<String> _eventData = StreamController<String>.broadcast();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;
  Future get closeStream => _eventData.close();

  StreamController<String> _eventData2 = StreamController<String>.broadcast();
  Sink get _inEventData2 => _eventData2.sink;
  Stream get eventStream2 => _eventData2.stream;

  StreamController<String> _eventData3 = StreamController<String>.broadcast();
  Sink get _inEventData3 => _eventData3.sink;
  Stream get eventStream3 => _eventData3.stream;





}