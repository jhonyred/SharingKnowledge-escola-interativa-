import 'package:escola_interativa/app/core/core.dart';
import 'package:flutter/material.dart';

class PerfilDescription extends StatelessWidget {
  PerfilDescription({
    required this.photo,
    required this.name,
    required this.email,
    required this.curso,
  });

  final String photo;
  final String name;
  final String email;
  final String curso;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      color: AppColors.red,
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100.0,
            width: 100.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(photo),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.textPerfilNome,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                email,
                style: AppTextStyles.textPerfil,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                curso,
                style: AppTextStyles.textPerfil,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
