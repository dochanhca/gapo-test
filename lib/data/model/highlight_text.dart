import 'package:equatable/equatable.dart';

class HighLightText extends Equatable {
  late final String text;
  late final bool isHighLight;

  HighLightText({required this.text, this.isHighLight = false});

  @override
  // TODO: implement props
  List<Object?> get props => [text];
}
