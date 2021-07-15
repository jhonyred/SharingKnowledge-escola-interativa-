import 'package:flutter/material.dart';

class PerfilListTile extends StatelessWidget {
  PerfilListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Icon icon;
  final String title;
  final String subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
