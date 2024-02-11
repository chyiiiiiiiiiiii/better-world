import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_message_provider.g.dart';

@Riverpod(keepAlive: true)
class ShowMessage extends _$ShowMessage {
  @override
  String build() {
    return '';
  }

  // ignore: use_setters_to_change_properties
  void show(String message) {
    state = message;
  }
}
