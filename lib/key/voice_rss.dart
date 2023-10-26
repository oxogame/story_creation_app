class VoiceRssApiKeyAndUrl {
  final String _apiKey = "8c166a66b0a943b7826dd2cfc7fe052f";

  getFullApiUrl(String apiKey, String language, String type, String text) {
    return "http://api.voicerss.org/?key=${apiKey.toString()}&hl=${language.toString()}&c=${type.toString()}&src=${text.toString()}";
  }

  String get apiKey => _apiKey;
}
