class HeightUtils {
  static double feetInchToCm(String value) {
    final parts = value.replaceAll('"', '').split("'");

    final feet = int.parse(parts[0].trim());
    final inches = int.parse(parts[1].trim());

    return (feet * 30.48) + (inches * 2.54);
  }

  static String cmToFeetInch(double cm) {
    final totalInches = cm / 2.54;

    final feet = totalInches ~/ 12;
    final inches = (totalInches % 12).round();

    return "$feet'$inches\"";
  }
}
