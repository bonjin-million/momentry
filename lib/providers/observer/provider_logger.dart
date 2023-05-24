import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ProviderLogger extends ProviderObserver {
  final Logger _logger = Logger();

  @override
  void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container) {
    _logger.d('{\n  didAddProvider": "${provider.name ?? provider.runtimeType}"\n}');
  }

  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    _logger.d('{\n  didUpdateProvider": "${provider.name ?? provider.runtimeType}",\n  newValue": "$newValue"\n}');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer containers) {
    _logger.d('{\n  didDisposeProvider": "${provider.name ?? provider.runtimeType}"\n}');
  }
}