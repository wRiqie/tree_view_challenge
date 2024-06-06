import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/values/app_images.dart';

class ErrorPlaceholderWidget extends StatelessWidget {
  final String? imgPath;
  final String? caption;
  final VoidCallback? onReload;
  const ErrorPlaceholderWidget(
      {super.key, this.caption, this.onReload, this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          imgPath ?? AppImages.error,
          width: 200,
        ),
        const SizedBox(
          height: 12,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            caption ?? 'Algo deu errado, tente novamente...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(.8),
              fontSize: 16,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: onReload,
          icon: const Icon(Icons.replay_outlined),
          label: const Text('Recarregar'),
        ),
      ],
    );
  }
}
