import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar(this.avatarUrl, this.iconUrl);

  late final String avatarUrl;
  late final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCircleImage(avatarUrl, 56),
        Positioned(
          right: 0,
          bottom: 0,
          child: _buildCircleImage(iconUrl, 24),
        )
      ],
    );
  }

  _buildCircleImage(String url, double size) {
    return ClipOval(
      child: Image.network(url, width: size, height: size),
    );
  }
}
