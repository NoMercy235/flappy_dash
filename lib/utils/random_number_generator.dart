import 'dart:math';

class RandomNumberGenerator {
  final Map<String, List<double>> _memoizedValues = {};
  final Random _random = Random();

  final double start;
  final double end;
  final double step;

  RandomNumberGenerator({
    required this.start,
    required this.end,
    required this.step,
  });

  double getNumber() {
    // Ensure the range is valid
    if (start > end || step <= 0) {
      throw ArgumentError('Invalid range or step size.');
    }

    // Create a unique key for memoization
    String key = '$start-$end-$step';

    // Check if the values for this range and step are already computed
    if (!_memoizedValues.containsKey(key)) {
      _memoizedValues[key] = [
        for (double value = start; value <= end; value += step) value
      ];
    }

    // Get the list of possible values from the memoized map
    List<double> possibleValues = _memoizedValues[key]!;

    // Pick a random value from the list
    return possibleValues[_random.nextInt(possibleValues.length)];
  }
}
