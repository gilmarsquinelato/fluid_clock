import 'package:intl/date_symbol_data_local.dart';

import 'messages_all.dart';

List<String> supportedLocales() => [
      'en',
    ];

Future loadLocales() async {
  final locales = supportedLocales();
  for (final locale in locales) {
    print('Loading locale "$locale"');

    final result = await initializeMessages(locale);
    await initializeDateFormatting(locale);

    if (!result) {
      print('Fail to load locale "$locale"');
    }
  }
}
