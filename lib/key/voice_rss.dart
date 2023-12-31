class VoiceRssApiKeyAndUrl {
  final String _apiKey = "VOICE_API_KEY";

  getFullApiUrl(String apiKey, String language, String type, String text) {
    return "http://api.voicerss.org/?key=${apiKey.toString()}&hl=${language.toString()}&c=${type.toString()}&src=${text.toString()}";
  }

  String get apiKey => _apiKey;
}
