import 'package:app_agendai/app.dart';
import 'package:app_agendai/core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      flavor: AppFlavor.dev,
      baseUrl: 'https://parseapi.back4app.com/functions',
      appId: 'EXS9N8beYcFk7w4fNxWuh6wZrVbvxZ7As4PlCQ5J',
      restKey: 'ENllbFbpR7B2BEQdiBSV0kg89af562aYBCaoUwsM',
    ),
  );
}
