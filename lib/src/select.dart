import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Directive(selector: 'select[bind]')
class SelectBinder {
  final SelectElement _host;

  SelectBinder(Element el) : _host = el;

  final _valChanged = StreamController<String>();

  @Output()
  Stream<String> get bind => _valChanged.stream;

  @Input()
  set bind(value) {
    _host.value = value;
  }

  @HostListener('change')
  void onChange(value) {
    _valChanged.add(_host.value);
  }
}