import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({required this.message, super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          LucideIcons.bookOpenText,
          size: 45.0,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        Text(message, style: const TextStyle(fontStyle: FontStyle.italic)),
      ],
    ),
  );
}
