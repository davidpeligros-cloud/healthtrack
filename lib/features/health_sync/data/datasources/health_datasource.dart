import 'package:health/health.dart';

class HealthDatasource {
  final HealthFactory _health = HealthFactory();

  static const _readTypes = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.WEIGHT,
    HealthDataType.HEART_RATE,
    HealthDataType.WORKOUT,
    HealthDataType.SLEEP_SESSION,
  ];

  static const _writeTypes = [
    HealthDataType.WEIGHT,
    HealthDataType.DIETARY_ENERGY_CONSUMED,
  ];

  Future<bool> requestPermissions() async {
    try {
      final hasPermissions = await _health.hasPermissions(
        _readTypes,
        permissions: _readTypes.map((_) => HealthDataAccess.READ).toList(),
      );

      if (hasPermissions != true) {
        return await _health.requestAuthorization(
          [..._readTypes, ..._writeTypes],
          permissions: [
            ..._readTypes.map((_) => HealthDataAccess.READ),
            ..._writeTypes.map((_) => HealthDataAccess.WRITE),
          ],
        );
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<int> getTodaySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final steps = await _health.getTotalStepsInInterval(midnight, now);
    return steps ?? 0;
  }

  Future<double> getTodayActiveCalories() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final data = await _health.getHealthDataFromTypes(
      midnight,
      now,
      [HealthDataType.ACTIVE_ENERGY_BURNED],
    );

    return data.fold<double>(
      0,
      (sum, point) => sum + (point.value as NumericHealthValue).numericValue,
    );
  }
}
