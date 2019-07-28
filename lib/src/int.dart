import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Directive(
  selector: 'input[type="number"][int][bind]',
)
class IntBinder {
  final InputElement _host;

  final _valChanged = StreamController<int>();

  IntBinder(Element el) : _host = el;

  @Input()
  set bind(value) {
    _host.value = value?.toString() ?? '';
  }

  @Output()
  Stream<int> get bind => _valChanged.stream;

  String _oldValue;

  @HostListener('focus')
  void onFocus(_) {
    _oldValue = _host.value;
  }

  @HostListener('blur')
  void onBlur(_) {
    _send();
  }

  @HostListener('keyup')
  void onKeyUp(final event) {
    if (event is KeyboardEvent) {
      if (event.keyCode == KeyCode.ENTER) {
        _send();
      } else if (event.keyCode == KeyCode.ESC) {
        _host.value = _oldValue;
      }
    }
  }

  void _send() {
    _valChanged.add(int.tryParse(_host.value));
  }
}

@Directive(
  selector: 'input[type="number"][bind]',
)
class NumBinder {
  final InputElement _host;

  final _valChanged = StreamController<num>();

  NumBinder(Element el) : _host = el;

  @Input()
  set bind(value) {
    _host.value = value?.toString() ?? '';
  }

  @Output()
  Stream<num> get bind => _valChanged.stream;

  String _oldValue;

  @HostListener('focus')
  void onFocus(_) {
    _oldValue = _host.value;
  }

  @HostListener('blur')
  void onBlur(_) {
    _send();
  }

  @HostListener('keyup')
  void onKeyUp(final event) {
    if (event is KeyboardEvent) {
      if (event.keyCode == KeyCode.ENTER) {
        _send();
      } else if (event.keyCode == KeyCode.ESC) {
        _host.value = _oldValue;
      }
    }
  }

  void _send() {
    _valChanged.add(num.tryParse(_host.value));
  }
}
