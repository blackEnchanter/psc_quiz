import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Internet connection
          'no_internet_connection_found': 'No Internet Connection Found',
          'connection_out':
              'You cannot use this application unless you can provide a valid internet connection. Please try again later.',

          // Home screen
          'appName': 'PSC Quiz',
          'start': 'Start',
          'question': 'Question',
        }
      };
}
