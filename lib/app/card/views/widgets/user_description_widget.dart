import 'package:flutter/material.dart';

class UserDescription extends StatelessWidget {
  UserDescription({
    required this.photo,
    required this.name,
    required this.curso,
  });

  final String photo;
  final String name;
  final String curso;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          photo,
        ),
      ),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        curso,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      // trailing: Icon(
      //   Icons.favorite_border,
      //   color: AppColors.red,
      // ),
    );
  }
}
