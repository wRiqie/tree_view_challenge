import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/values/app_images.dart';

class EmptyPlaceholderWidget extends StatelessWidget {
  final String? caption;
  const EmptyPlaceholderWidget({super.key, this.caption});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppImages.empty,
          width: 170,
        ),
        const SizedBox(
          height: 12,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            caption ?? 'Sem dados...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(.8),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
