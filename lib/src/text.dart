import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Directive(
  selector: 'input[type="text"][bind]',
)
class TextBinder {
  final InputElement _host;

  final _valChanged = StreamController<String>();

  TextBinder(Element el) : _host = el;

  @Input()
  set bind(value) {
    _host.value = value?.toString() ?? '';
  }

  @Output()
  Stream<String> get bind => _valChanged.stream;

  String _oldValue;

  @HostListener('focus')
  void onFocus(_) {
    _oldValue = _host.value;
  }

  @HostListener('blur')
  void onBlur(_) {
    _valChanged.add(_host.value);
  }

  @HostListener('keyup')
  void onKeyUp(final event) {
    if (event is KeyboardEvent) {
      if (event.keyCode == KeyCode.ENTER) {
        _valChanged.add(_host.value);
      } else if (event.keyCode == KeyCode.ESC) {
        _host.value = _oldValue;
      }
    }
  }
}