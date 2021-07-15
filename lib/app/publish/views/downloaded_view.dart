import 'package:flutter/material.dart';

class DownloadedPublishView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publicações baixadas"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Publicações baixadas"),
      ),
    );
  }
}
