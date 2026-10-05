class Hsl {
  const Hsl({required this.h, required this.s, required this.l});

  final double h;
  final double s;
  final double l;
}

class ColorClassification {
  const ColorClassification({
    required this.hsl,
    required this.neutral,
    required this.baseColor,
    required this.tone,
    required this.key,
    required this.commonName,
  });

  final Hsl hsl;
  final String? neutral;
  final String? baseColor;
  final String? tone;
  final String key;
  final String commonName;
}

Hsl rgbToHsl(int r, int g, int b) {
  final rn = r / 255;
  final gn = g / 255;
  final bn = b / 255;

  final max = [rn, gn, bn].reduce((a, c) => a > c ? a : c);
  final min = [rn, gn, bn].reduce((a, c) => a < c ? a : c);
  final delta = max - min;
  final l = (max + min) / 2;

  var h = 0.0;
  var s = 0.0;

  if (delta != 0) {
    s = l > 0.5 ? delta / (2 - max - min) : delta / (max + min);
    if (max == rn) {
      h = ((gn - bn) / delta) % 6;
    } else if (max == gn) {
      h = (bn - rn) / delta + 2;
    } else {
      h = (rn - gn) / delta + 4;
    }
    h *= 60;
    if (h < 0) h += 360;
  }

  return Hsl(h: h, s: s, l: l);
}

const _hueRanges = <({String name, double hueMin, double hueMax})>[
  (name: 'vermelho', hueMin: 345, hueMax: 15),
  (name: 'vermelho-alaranjado', hueMin: 15, hueMax: 35),
  (name: 'laranja', hueMin: 35, hueMax: 50),
  (name: 'amarelo-alaranjado', hueMin: 50, hueMax: 60),
  (name: 'amarelo', hueMin: 60, hueMax: 70),
  (name: 'amarelo-esverdeado', hueMin: 70, hueMax: 100),
  (name: 'verde', hueMin: 100, hueMax: 155),
  (name: 'azul-esverdeado', hueMin: 155, hueMax: 195),
  (name: 'azul', hueMin: 195, hueMax: 245),
  (name: 'azul-arroxeado', hueMin: 245, hueMax: 270),
  (name: 'roxo', hueMin: 270, hueMax: 292),
  (name: 'rosa', hueMin: 292, hueMax: 345),
];

const _commonNames = <String, String>{
  'roxo-clara': 'lilás',
  'roxo-escura': 'roxo escuro',
  'rosa-clara': 'rosa claro',
  'rosa-escura': 'magenta escuro',
  'vermelho-escura': 'vinho',
  'laranja-escura': 'marrom',
  'laranja-clara': 'pêssego',
  'amarelo-clara': 'creme',
  'azul-escura': 'azul marinho',
  'azul-esverdeado-clara': 'turquesa',
  'verde-escura': 'verde musgo',
};

bool _hueInRange(double hue, double min, double max) {
  if (min <= max) return hue >= min && hue <= max;
  return hue >= min || hue <= max;
}

String _findBaseColor(double hue) {
  for (final range in _hueRanges) {
    if (_hueInRange(hue, range.hueMin, range.hueMax)) return range.name;
  }
  return 'vermelho';
}

String _findToneModifier(double s, double l) {
  if (l < 0.25) return 'escura';
  if (l > 0.8 && s < 0.4) return 'clara';
  if (s < 0.35) return 'acinzentada';
  return 'pura';
}

ColorClassification classifyHsl(Hsl hsl) {
  const s = 0.5;
  const l = 0.4;
  final baseColor = _findBaseColor(hsl.h);
  final tone = _findToneModifier(s, l);
  final key = '$baseColor-$tone';
  return ColorClassification(
    hsl: hsl,
    neutral: null,
    baseColor: baseColor,
    tone: tone,
    key: key,
    commonName: _commonNames[key] ?? key,
  );
}

ColorClassification classifyRgb(int r, int g, int b) {
  return classifyHsl(rgbToHsl(r, g, b));
}
