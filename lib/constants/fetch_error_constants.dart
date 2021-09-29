/// Fetch error messages to show in UI
/// We should localize all strings in production app.
class FetchErrorConstants {
  static const String serverError = 'Could not get data from the server';
  static const String noInternetConnection = 'No internet connection';
  static const String timeout =
      'The time for the request is over. Try again later';
  static const String undefinedError =
      'Undefined error. Please write to app support';
}
