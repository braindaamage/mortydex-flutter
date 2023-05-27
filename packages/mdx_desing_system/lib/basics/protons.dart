//* Colors

import 'dart:ui';

abstract final class MDXColors {
  static const primary = _MDXPrimaryColors();

  static const secondary = _MDXSecondaryColors();

  static const status = _MDXStatusColors();
}

final class _MDXPrimaryColors {
  const _MDXPrimaryColors();

  /// - This color can be used to show primary actions in the screen.
  /// - Along with it, it can be used to show clickable in the screen like
  /// links, radio buttons, checkboxes.
  final Color p1 = const Color(0x772F65F9);
}

final class _MDXSecondaryColors {
  const _MDXSecondaryColors();

  /// - This color can be used to highlight the text in the screen.
  final Color s1 = const Color(0x7752567A);

  /// - This color can be applied to all important objects in the
  /// pages like Text/ Icon/ Heading.
  final Color s2 = const Color(0x776C779C);

  /// - This color can be applied to all the less important information
  /// like Placeholder text.
  final Color s3 = const Color(0x77949DB8);
}

final class _MDXStatusColors {
  const _MDXStatusColors();

  /// - This can be used to show success message, positive results,
  /// or completed tasks.
  final Color s1 = const Color(0x7717BD90);

  /// - This color can be used to represent the warning message
  /// or intermediate state in the system.
  final Color s2 = const Color(0x779D5FF2);

  /// - This color can be used to represent the error message
  /// or negative action/tags in the system.
  final Color s3 = const Color(0x77FF6565);

  /// - Dark Red will be used to show the error message in the
  /// form fields.
  final Color s4 = const Color(0x77A30000);
}
