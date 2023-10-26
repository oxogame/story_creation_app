import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:company_app_demo/key/key.dart';

import '../key/open_ai.dart';
import '../key/voice_rss.dart';

class FetchGenerated {
  static Future<String> fetchGeneratedTextWithUrl(image) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKeyAndUrl().apiUrl),
        headers: {
          'Authorization': 'Bearer ${ApiKeyAndUrl().apiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'inputs': image}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        String generatedText = jsonResponse[0]['generated_text'];
        return generatedText;
      } else {
        throw Exception('Failed to load generated text. Try Again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String> fetchGeneratedTextWithGallery(
      File? pingImageResult) async {
    if (pingImageResult == null) {
      throw Exception('No Image Selected.');
    }

    try {
      final response = await http.post(
        Uri.parse(ApiKeyAndUrl().apiUrl),
        headers: {
          'Authorization': 'Bearer ${ApiKeyAndUrl().apiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'inputs': base64Encode(pingImageResult.readAsBytesSync())}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        String generatedText = jsonResponse[0]['generated_text'];
        return generatedText;
      } else {
        throw Exception('Failed to load generated text. Try Again.');
      }
    } catch (e) {
      print("Hata Burada");
      throw Exception('${e}Failed to load generated text. Try Again.' );
    }
  }

  static Future<String> generateStory(String prompt) async {
    try {
      final headers = {
        "Authorization": "Bearer ${OpenAiApiKeyAndUrl().apiKey}",
        "Content-Type": "application/json",
      };
      Map<String, dynamic> bodyObject = {
        'model': 'ft:gpt-3.5-turbo-0613:personal::8BroEyiD',
        "temperature": 0.7,
        'messages': [
          {
            "role": "system",
            "content": "You are a child story-telling assistant."
          },
          {"role": "user", "content": prompt}
        ]
      };

      final response = await http.post(
        Uri.parse(OpenAiApiKeyAndUrl().apiUrl),
        headers: headers,
        body: jsonEncode(bodyObject),
      );

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))['choices'][0]
            ['message']["content"];
      } else {
        throw Exception('Failed To Generate Story.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Uint8List> storyToSound(String text) async {
    try {
      final response =
          await http.post(Uri.parse('http://api.voicerss.org/'), body: {
        "key": VoiceRssApiKeyAndUrl().apiKey,
        "hl": "tr-tr",
        "src": text,
        "r": "0", // Set to 0 for default audio format
        "c": "mp3", // Set to mp3 for audio format
        "f": "44khz_16bit_stereo", // Set audio quality
        "ssml": "false", // Set to false for plain text
        "b64": "false", // Set to false for plain text
      });

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to load generated text. Try Again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
