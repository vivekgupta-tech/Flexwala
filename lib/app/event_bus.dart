// app/event_bus.dart — session-expired ko globally handle karne ke liye
import 'dart:async';

class AppEventBus {
  AppEventBus._();
  static final instance = AppEventBus._();
  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;
  void fireSessionExpired() => _controller.add('session_expired');
}