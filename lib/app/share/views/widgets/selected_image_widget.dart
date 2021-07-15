import 'package:escola_interativa/app/core/app_colors.dart';
import 'package:escola_interativa/app/core/app_text_style.dart';
import 'package:flutter/material.dart';

class SelectedImageWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;
  final Widget? contador;

  const SelectedImageWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
    this.contador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors.darkRed,
          minimumSize: Size.fromHeight(50),
        ),
        child: _buildContent(),
        onPressed: onClicked,
      ),
    );
  }

  Widget _buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24.0),
          SizedBox(width: 10.0),
          Text(
            text,
            style: AppTextStyles.textShareButton,
          ),
          SizedBox(width: 10.0),
          Container(
            child: contador,
          )
        ],
      );
}
