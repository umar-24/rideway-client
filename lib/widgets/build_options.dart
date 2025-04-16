
import 'package:flutter/material.dart';

class BuildOptions extends StatelessWidget {
    final Widget? child;
    final String title;
    final String subtitle;
    final void Function()? onTap;
  const BuildOptions({
    super.key, required this.child, required this.title, required this.subtitle, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: child,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
