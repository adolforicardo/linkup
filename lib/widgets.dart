import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

// ──────────────────────────────────────────────────────────────────────────
// Avatar
// ──────────────────────────────────────────────────────────────────────────
class LuAvatar extends StatelessWidget {
  final String initials;
  final Color bg;
  final double size;
  final bool ring;
  final bool online;
  final Widget? badge;
  const LuAvatar({
    super.key,
    required this.initials,
    this.bg = LinkUpColors.green,
    this.size = 40,
    this.ring = false,
    this.online = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final radius = size * 0.32;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: ring
                  ? [
                      BoxShadow(color: Colors.white, spreadRadius: 3, blurRadius: 0),
                      BoxShadow(color: bg, spreadRadius: 5, blurRadius: 0),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.38,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
          ),
          if (online)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.28,
                height: size * 0.28,
                decoration: BoxDecoration(
                  color: LinkUpColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          if (badge != null)
            Positioned(right: -2, bottom: -2, child: badge!),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Pill
// ──────────────────────────────────────────────────────────────────────────
enum PillColor { green, gold, navy, red, neutral, success }
enum PillSize { sm, md, lg }

class LuPill extends StatelessWidget {
  final String text;
  final PillColor color;
  final PillSize size;
  final IconData? icon;
  const LuPill(this.text, {super.key, this.color = PillColor.green, this.size = PillSize.md, this.icon});

  @override
  Widget build(BuildContext context) {
    final palette = switch (color) {
      PillColor.green => (bg: LinkUpColors.pillGreenBg, fg: LinkUpColors.green),
      PillColor.gold => (bg: LinkUpColors.cream, fg: LinkUpColors.goldDark),
      PillColor.navy => (bg: LinkUpColors.pillNavyBg, fg: LinkUpColors.navy),
      PillColor.red => (bg: LinkUpColors.dangerBg, fg: LinkUpColors.dangerFg),
      PillColor.neutral => (bg: LinkUpColors.pillNeutralBg, fg: LinkUpColors.pillNeutralFg),
      PillColor.success => (bg: LinkUpColors.successBg, fg: LinkUpColors.successFg),
    };
    final padding = switch (size) {
      PillSize.sm => const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      PillSize.md => const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      PillSize.lg => const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    };
    final fontSize = switch (size) {
      PillSize.sm => 10.5,
      PillSize.md => 11.5,
      PillSize.lg => 12.5,
    };
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: palette.bg, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize, color: palette.fg),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(color: palette.fg, fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Button
// ──────────────────────────────────────────────────────────────────────────
enum BtnVariant { primary, gold, navy, secondary, ghost, danger }
enum BtnSize { sm, md, lg }

class LuBtn extends StatelessWidget {
  final String label;
  final BtnVariant variant;
  final BtnSize size;
  final VoidCallback? onPressed;
  final bool full;
  final IconData? icon;
  const LuBtn(this.label, {super.key, this.variant = BtnVariant.primary, this.size = BtnSize.md, this.onPressed, this.full = false, this.icon});

  @override
  Widget build(BuildContext context) {
    final v = switch (variant) {
      BtnVariant.primary => (bg: LinkUpColors.green, fg: Colors.white, border: Colors.transparent, shadow: LinkUpColors.green.withValues(alpha: 0.25)),
      BtnVariant.gold => (bg: LinkUpColors.gold, fg: const Color(0xFF1A1F1D), border: Colors.transparent, shadow: LinkUpColors.gold.withValues(alpha: 0.30)),
      BtnVariant.navy => (bg: LinkUpColors.navy, fg: Colors.white, border: Colors.transparent, shadow: LinkUpColors.navy.withValues(alpha: 0.25)),
      BtnVariant.secondary => (bg: Colors.white, fg: const Color(0xFF1A1F1D), border: LinkUpColors.borderStrong, shadow: Colors.transparent),
      BtnVariant.ghost => (bg: Colors.transparent, fg: const Color(0xFF1A1F1D), border: Colors.transparent, shadow: Colors.transparent),
      BtnVariant.danger => (bg: Colors.white, fg: LinkUpColors.danger, border: const Color(0xFFF0D5D0), shadow: Colors.transparent),
    };
    final padding = switch (size) {
      BtnSize.sm => const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      BtnSize.md => const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      BtnSize.lg => const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
    };
    final fontSize = switch (size) {
      BtnSize.sm => 13.0,
      BtnSize.md => 14.5,
      BtnSize.lg => 15.5,
    };
    final radius = switch (size) {
      BtnSize.sm => 10.0,
      BtnSize.md => 12.0,
      BtnSize.lg => 14.0,
    };
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: full ? double.infinity : null,
        padding: padding,
        decoration: BoxDecoration(
          color: v.bg,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: v.border, width: 1),
          boxShadow: v.shadow == Colors.transparent
              ? null
              : [BoxShadow(color: v.shadow, blurRadius: 14, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisSize: full ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: fontSize + 1, color: v.fg),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(color: v.fg, fontSize: fontSize, fontWeight: FontWeight.w600, letterSpacing: -0.15),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Card
// ──────────────────────────────────────────────────────────────────────────
class LuCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  const LuCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.onTap, this.color, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor ?? LinkUpColors.border, width: 1),
          boxShadow: [
            BoxShadow(color: LinkUpColors.green.withValues(alpha: 0.03), blurRadius: 2, offset: const Offset(0, 1)),
          ],
        ),
        child: child,
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Stars
// ──────────────────────────────────────────────────────────────────────────
class LuStars extends StatelessWidget {
  final double value;
  final double size;
  final bool showNumber;
  final Color color;
  const LuStars({super.key, required this.value, this.size = 14, this.showNumber = false, this.color = LinkUpColors.gold});

  @override
  Widget build(BuildContext context) {
    final full = value.floor();
    final half = value - full >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            (i < full || (i == full && half)) ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: (i < full || (i == full && half)) ? color : LinkUpColors.textDisabled,
          ),
        if (showNumber) ...[
          const SizedBox(width: 4),
          Text(value.toStringAsFixed(1), style: TextStyle(fontSize: size, fontWeight: FontWeight.w700, color: LinkUpColors.textPrimary)),
        ],
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Section title
// ──────────────────────────────────────────────────────────────────────────
class LuSectionTitle extends StatelessWidget {
  final String text;
  final Widget? action;
  const LuSectionTitle(this.text, {super.key, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.34, color: LinkUpColors.textPrimary)),
          if (action != null) action!,
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Top bar
// ──────────────────────────────────────────────────────────────────────────
class LuTopBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final bool large;
  const LuTopBar({super.key, required this.title, this.leading, this.actions = const [], this.large = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, large ? 6 : 8, 20, large ? 4 : 8),
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 10)],
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: large ? 28 : 17,
                fontWeight: large ? FontWeight.w800 : FontWeight.w700,
                letterSpacing: -0.7,
                color: LinkUpColors.textPrimary,
              ),
            ),
          ),
          for (final a in actions) ...[a, const SizedBox(width: 8)],
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// IconBtn
// ──────────────────────────────────────────────────────────────────────────
class LuIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool active;
  final String? badge;
  final Color color;
  final Color bg;
  const LuIconBtn({
    super.key,
    required this.icon,
    this.onPressed,
    this.active = false,
    this.badge,
    this.color = LinkUpColors.textPrimary,
    this.bg = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: active ? LinkUpColors.green : bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: bg == Colors.transparent ? Colors.transparent : LinkUpColors.border,
            width: 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 19, color: active ? Colors.white : color),
            if (badge != null)
              Positioned(
                top: -1,
                right: -3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(color: LinkUpColors.danger, borderRadius: BorderRadius.circular(8)),
                  constraints: const BoxConstraints(minWidth: 14),
                  alignment: Alignment.center,
                  child: Text(badge!, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Progress bar
// ──────────────────────────────────────────────────────────────────────────
class LuProgressBar extends StatelessWidget {
  final double value;
  final Color color;
  final double height;
  final Color bg;
  const LuProgressBar({super.key, required this.value, this.color = LinkUpColors.green, this.height = 6, this.bg = LinkUpColors.border});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Stack(
        children: [
          Container(height: height, color: bg),
          FractionallySizedBox(
            widthFactor: (value / 100).clamp(0.0, 1.0),
            child: Container(height: height, color: color),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Divider
// ──────────────────────────────────────────────────────────────────────────
class LuDivider extends StatelessWidget {
  final double margin;
  const LuDivider({super.key, this.margin = 12});
  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: LinkUpColors.border, margin: EdgeInsets.symmetric(vertical: margin));
}

// ──────────────────────────────────────────────────────────────────────────
// Input field
// ──────────────────────────────────────────────────────────────────────────
class LuInputField extends StatelessWidget {
  final String? label;
  final String? value;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final IconData? icon;
  final TextInputType? type;
  const LuInputField({super.key, this.label, this.value, this.onChanged, this.placeholder, this.icon, this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 6),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: LinkUpColors.surfaceTint,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: LinkUpColors.border),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: LinkUpColors.textMuted),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  keyboardType: type,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    hintStyle: const TextStyle(color: LinkUpColors.textMuted, fontSize: 14),
                  ),
                  style: const TextStyle(fontSize: 14, color: LinkUpColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Toggle row
// ──────────────────────────────────────────────────────────────────────────
class LuToggleRow extends StatelessWidget {
  final String label;
  final String? sub;
  final bool value;
  final ValueChanged<bool> onChanged;
  const LuToggleRow({super.key, required this.label, this.sub, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                if (sub != null) ...[
                  const SizedBox(height: 2),
                  Text(sub!, style: const TextStyle(fontSize: 12, color: LinkUpColors.textMuted)),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 26,
              decoration: BoxDecoration(
                color: value ? LinkUpColors.green : LinkUpColors.textDisabled,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: value ? 21 : 3,
                    top: 3,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 1))],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Reputation radar (custom painter)
// ──────────────────────────────────────────────────────────────────────────
class RadarPoint {
  final String label;
  final int value;
  const RadarPoint(this.label, this.value);
}

class LuReputationRadar extends StatelessWidget {
  final List<RadarPoint> data;
  final double size;
  final Color color;
  final Color goldColor;
  const LuReputationRadar({super.key, required this.data, this.size = 180, this.color = LinkUpColors.green, this.goldColor = LinkUpColors.gold});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _RadarPainter(data: data, color: color, goldColor: goldColor)),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final List<RadarPoint> data;
  final Color color;
  final Color goldColor;
  _RadarPainter({required this.data, required this.color, required this.goldColor});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2, cy = size.height / 2;
    final r = size.width * 0.38;
    final n = data.length;
    Offset point(int i, double v) {
      final angle = -math.pi / 2 + (math.pi * 2 * i) / n;
      return Offset(cx + math.cos(angle) * r * v, cy + math.sin(angle) * r * v);
    }

    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = LinkUpColors.borderStrong
      ..strokeWidth = 1;
    for (final p in [0.25, 0.5, 0.75, 1.0]) {
      final path = Path();
      for (int j = 0; j < n; j++) {
        final pt = point(j, p);
        if (j == 0) path.moveTo(pt.dx, pt.dy);
        else path.lineTo(pt.dx, pt.dy);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }
    for (int i = 0; i < n; i++) {
      final pt = point(i, 1);
      canvas.drawLine(Offset(cx, cy), pt, gridPaint);
    }

    final fillPaint = Paint()..color = color.withValues(alpha: 0.18);
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;
    final shape = Path();
    for (int i = 0; i < n; i++) {
      final pt = point(i, data[i].value / 100);
      if (i == 0) shape.moveTo(pt.dx, pt.dy);
      else shape.lineTo(pt.dx, pt.dy);
    }
    shape.close();
    canvas.drawPath(shape, fillPaint);
    canvas.drawPath(shape, strokePaint);

    final dotPaint = Paint()..color = goldColor;
    for (int i = 0; i < n; i++) {
      final pt = point(i, data[i].value / 100);
      canvas.drawCircle(pt, 3, dotPaint);
    }

    for (int i = 0; i < n; i++) {
      final pt = point(i, 1.18);
      final textPainter = TextPainter(
        text: TextSpan(
          text: data[i].label,
          style: GoogleFonts.plusJakartaSans(fontSize: 9.5, fontWeight: FontWeight.w700, color: LinkUpColors.textSecondary),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(pt.dx - textPainter.width / 2, pt.dy - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter old) => old.data != data || old.color != color;
}

// ──────────────────────────────────────────────────────────────────────────
// Striped placeholder (used for portfolio/video covers)
// ──────────────────────────────────────────────────────────────────────────
class LuPlaceholder extends StatelessWidget {
  final String label;
  final double height;
  final Color color;
  const LuPlaceholder({super.key, required this.label, this.height = 120, this.color = LinkUpColors.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _StripePainter(color: color)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(4)),
            child: Text(
              label.toUpperCase(),
              style: GoogleFonts.jetBrainsMono(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _StripePainter extends CustomPainter {
  final Color color;
  _StripePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withValues(alpha: 0.85);
    final spacing = 14.0;
    final maxLen = size.width + size.height;
    for (double x = -size.height; x < maxLen; x += spacing) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + size.height, size.height)
        ..lineTo(x + size.height + 6, size.height)
        ..lineTo(x + 6, 0)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ──────────────────────────────────────────────────────────────────────────
// LinkUp logo mark (curve with three dots)
// ──────────────────────────────────────────────────────────────────────────
class LuLogoMark extends StatelessWidget {
  final double size;
  final Color background;
  final Color accent;
  const LuLogoMark({super.key, this.size = 28, this.background = LinkUpColors.green, this.accent = LinkUpColors.gold});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(size * 0.28)),
      child: CustomPaint(painter: _LogoPainter(accent: accent)),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color accent;
  _LogoPainter({required this.accent});
  @override
  void paint(Canvas canvas, Size size) {
    final unit = size.width / 32;
    final paint = Paint()
      ..color = accent
      ..strokeWidth = 3 * unit
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final p = Path()
      ..moveTo(8 * unit, 18 * unit)
      ..quadraticBezierTo(16 * unit, 8 * unit, 24 * unit, 18 * unit);
    canvas.drawPath(p, paint);
    final fill = Paint()..color = accent;
    canvas.drawCircle(Offset(16 * unit, 9 * unit), 2.6 * unit, fill);
    canvas.drawCircle(Offset(9 * unit, 20 * unit), 2.0 * unit, fill);
    canvas.drawCircle(Offset(23 * unit, 20 * unit), 2.0 * unit, fill);
  }

  @override
  bool shouldRepaint(_) => false;
}

// ──────────────────────────────────────────────────────────────────────────
// LinkUp wordmark
// ──────────────────────────────────────────────────────────────────────────
class LuWordmark extends StatelessWidget {
  final double fontSize;
  const LuWordmark({super.key, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w800, letterSpacing: -0.4),
        children: const [
          TextSpan(text: 'Link', style: TextStyle(color: LinkUpColors.navy)),
          TextSpan(text: 'Up', style: TextStyle(color: LinkUpColors.green)),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Stat (compact metric)
// ──────────────────────────────────────────────────────────────────────────
class LuStat extends StatelessWidget {
  final String n;
  final String label;
  const LuStat({super.key, required this.n, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(n, style: GoogleFonts.jetBrainsMono(fontSize: 14, fontWeight: FontWeight.w800, color: LinkUpColors.navy)),
        const SizedBox(height: 1),
        Text(label, style: const TextStyle(fontSize: 9.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Password field with reveal toggle
// ──────────────────────────────────────────────────────────────────────────
class LuPasswordField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  const LuPasswordField({super.key, this.label, this.controller, this.placeholder, this.onChanged});

  @override
  State<LuPasswordField> createState() => _LuPasswordFieldState();
}

class _LuPasswordFieldState extends State<LuPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 6),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: LinkUpColors.surfaceTint,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: LinkUpColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock_outline, size: 18, color: LinkUpColors.textMuted),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    hintStyle: const TextStyle(color: LinkUpColors.textMuted, fontSize: 14),
                  ),
                  style: const TextStyle(fontSize: 14, color: LinkUpColors.textPrimary),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _obscure = !_obscure),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Icon(
                    _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 18, color: LinkUpColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Password strength meter
// ──────────────────────────────────────────────────────────────────────────
class LuPasswordStrength extends StatelessWidget {
  final String password;
  const LuPasswordStrength({super.key, required this.password});

  int get _score {
    if (password.isEmpty) return 0;
    var s = 0;
    if (password.length >= 8) s++;
    if (RegExp(r'[A-Z]').hasMatch(password)) s++;
    if (RegExp(r'[0-9]').hasMatch(password)) s++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) s++;
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final score = _score;
    final labels = ['', 'Fraca', 'Razoável', 'Boa', 'Forte'];
    final colors = [LinkUpColors.textDisabled, LinkUpColors.danger, LinkUpColors.gold, LinkUpColors.green, LinkUpColors.successFg];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (int i = 0; i < 4; i++) ...[
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: i < score ? colors[score] : LinkUpColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (i < 3) const SizedBox(width: 4),
            ],
          ],
        ),
        if (score > 0) ...[
          const SizedBox(height: 6),
          Text('Força: ${labels[score]}', style: TextStyle(fontSize: 11, color: colors[score], fontWeight: FontWeight.w700)),
        ],
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Social sign-in button (Google / Apple)
// ──────────────────────────────────────────────────────────────────────────
enum SocialProvider { google, apple }

class LuSocialBtn extends StatelessWidget {
  final SocialProvider provider;
  final VoidCallback? onPressed;
  final String? label;
  const LuSocialBtn({super.key, required this.provider, this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    final text = label ?? (provider == SocialProvider.google ? 'Continuar com Google' : 'Continuar com Apple');
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: provider == SocialProvider.apple ? const Color(0xFF1A1F1D) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: provider == SocialProvider.apple ? Colors.transparent : LinkUpColors.borderStrong),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (provider == SocialProvider.google)
              const _GoogleLogo(size: 18)
            else
              const Icon(Icons.apple, size: 22, color: Colors.white),
            const SizedBox(width: 10),
            Text(text, style: TextStyle(
              color: provider == SocialProvider.apple ? Colors.white : LinkUpColors.textPrimary,
              fontSize: 14.5, fontWeight: FontWeight.w600, letterSpacing: -0.15,
            )),
          ],
        ),
      ),
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  final double size;
  const _GoogleLogo({this.size = 18});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: CustomPaint(painter: _GoogleLogoPainter()));
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2, cy = size.height / 2;
    final r = size.width * 0.46;
    final p = Paint();
    final colors = [
      const Color(0xFF4285F4),
      const Color(0xFF34A853),
      const Color(0xFFFBBC05),
      const Color(0xFFEA4335),
    ];
    for (int i = 0; i < 4; i++) {
      p.color = colors[i];
      final start = -math.pi / 2 + (math.pi / 2) * i;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        start, math.pi / 2, true, p,
      );
    }
    p.color = Colors.white;
    canvas.drawCircle(Offset(cx, cy), r * 0.55, p);
    final tp = TextPainter(
      text: TextSpan(text: 'G', style: GoogleFonts.plusJakartaSans(
        color: const Color(0xFF4285F4), fontSize: size.width * 0.62, fontWeight: FontWeight.w700,
      )),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
  }

  @override
  bool shouldRepaint(_) => false;
}

// ──────────────────────────────────────────────────────────────────────────
// OTP input — 6-digit auto-advance with paste
// ──────────────────────────────────────────────────────────────────────────
class LuOtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool error;
  const LuOtpInput({super.key, this.length = 6, this.onCompleted, this.onChanged, this.error = false});

  @override
  State<LuOtpInput> createState() => _LuOtpInputState();
}

class _LuOtpInputState extends State<LuOtpInput> {
  late final List<TextEditingController> _ctrls;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _ctrls) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _value => _ctrls.map((c) => c.text).join();

  void _handleChanged(int i, String v) {
    if (v.length > 1) {
      // paste
      for (int k = 0; k < widget.length && k < v.length; k++) {
        _ctrls[k].text = v[k];
      }
      _nodes[(v.length - 1).clamp(0, widget.length - 1)].requestFocus();
    } else if (v.isNotEmpty && i < widget.length - 1) {
      _nodes[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }
    widget.onChanged?.call(_value);
    if (_value.length == widget.length) widget.onCompleted?.call(_value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < widget.length; i++) Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < widget.length - 1 ? 8 : 0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: LinkUpColors.surfaceTint,
                  border: Border.all(
                    color: widget.error
                        ? LinkUpColors.danger
                        : (_ctrls[i].text.isNotEmpty ? LinkUpColors.green : LinkUpColors.border),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _ctrls[i],
                  focusNode: _nodes[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: i == 0 ? widget.length : 1,
                  onChanged: (v) => _handleChanged(i, v),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: LinkUpColors.navy),
                  decoration: const InputDecoration(
                    border: InputBorder.none, counterText: '', contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// iOS-style radio list (single select)
// ──────────────────────────────────────────────────────────────────────────
class LuRadioListItem<T> {
  final T value;
  final String label;
  final String? sub;
  final IconData? icon;
  const LuRadioListItem({required this.value, required this.label, this.sub, this.icon});
}

class LuRadioList<T> extends StatelessWidget {
  final List<LuRadioListItem<T>> items;
  final T selected;
  final ValueChanged<T> onChanged;
  final Color accent;
  const LuRadioList({super.key, required this.items, required this.selected, required this.onChanged, this.accent = LinkUpColors.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: LinkUpColors.border),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(items[i].value),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    if (items[i].icon != null) ...[
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(9)),
                        child: Icon(items[i].icon, size: 16, color: accent),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[i].label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          if (items[i].sub != null) ...[
                            const SizedBox(height: 2),
                            Text(items[i].sub!, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                          ],
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: items[i].value == selected ? accent : LinkUpColors.textDisabled, width: 2),
                      ),
                      child: items[i].value == selected
                          ? Center(child: Container(width: 10, height: 10, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)))
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            if (i < items.length - 1) const Divider(height: 1, thickness: 1, color: LinkUpColors.border, indent: 14, endIndent: 14),
          ],
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Bottom sheet helper
// ──────────────────────────────────────────────────────────────────────────
class LuBottomSheetAction {
  final IconData icon;
  final String label;
  final String? sub;
  final VoidCallback? onTap;
  final bool destructive;
  const LuBottomSheetAction({required this.icon, required this.label, this.sub, this.onTap, this.destructive = false});
}

class LuBottomSheet {
  static Future<T?> show<T>(BuildContext context, {required String title, required List<LuBottomSheetAction> actions}) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: LinkUpColors.borderStrong, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.4)),
            const SizedBox(height: 12),
            for (final a in actions) GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(sheetCtx);
                a.onTap?.call();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: a.destructive ? LinkUpColors.dangerBg : LinkUpColors.surfaceTint,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(a.icon, size: 18, color: a.destructive ? LinkUpColors.danger : LinkUpColors.green),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.label, style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600,
                            color: a.destructive ? LinkUpColors.danger : LinkUpColors.textPrimary,
                          )),
                          if (a.sub != null) ...[
                            const SizedBox(height: 2),
                            Text(a.sub!, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                          ],
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 18, color: LinkUpColors.textMuted),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Confirm dialog helper
// ──────────────────────────────────────────────────────────────────────────
class LuConfirmDialog {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirmar',
    String cancelLabel = 'Cancelar',
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: destructive ? LinkUpColors.dangerBg : LinkUpColors.pillGreenBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  destructive ? Icons.warning_amber_rounded : Icons.help_outline,
                  size: 28, color: destructive ? LinkUpColors.danger : LinkUpColors.green,
                ),
              ),
              const SizedBox(height: 14),
              Text(title, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, letterSpacing: -0.4, color: LinkUpColors.navy),
              ),
              const SizedBox(height: 6),
              Text(message, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: LinkUpColors.textSecondary, height: 1.45),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(child: LuBtn(cancelLabel, variant: BtnVariant.secondary, full: true, onPressed: () => Navigator.pop(ctx, false))),
                  const SizedBox(width: 8),
                  Expanded(child: LuBtn(confirmLabel,
                    variant: destructive ? BtnVariant.danger : BtnVariant.primary,
                    full: true,
                    onPressed: () => Navigator.pop(ctx, true),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return result ?? false;
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Snackbar helper (shorthand)
// ──────────────────────────────────────────────────────────────────────────
void luSnack(BuildContext context, String message, {IconData icon = Icons.check_circle_outline}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: LinkUpColors.navy,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: const Duration(seconds: 3),
    content: Row(
      children: [
        Icon(icon, color: LinkUpColors.gold, size: 18),
        const SizedBox(width: 10),
        Expanded(child: Text(message, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600))),
      ],
    ),
  ));
}
