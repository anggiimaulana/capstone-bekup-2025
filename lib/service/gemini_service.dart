import 'dart:io';

import 'package:capstone/env/env.dart';
import 'package:capstone/model/chat.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mime/mime.dart';

class GeminiService {
  late final GenerativeModel model;

  GeminiService() {
    final apiKey = Env.geminiApiKey;
    model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
  }

  List<DataPart> _convertPathsIntoDataparts(List<String> path) =>
      path.map((path) {
        return DataPart(lookupMimeType(path)!, File(path).readAsBytesSync());
      }).toList();

  List<Content> _convertChatsIntoContent(List<Chat> chats) => chats.map((chat) {
    return chat.isMyChat
        ? Content.multi([
            TextPart(chat.text),
            if (chat.paths != null) ..._convertPathsIntoDataparts(chat.paths!),
          ])
        : Content.model([TextPart(chat.text)]);
  }).toList();

  Future<String> sendMessage(
    String message,
    List<Chat> chats, [
    List<String>? paths,
  ]) async {
    final chat = model.startChat(history: _convertChatsIntoContent(chats));
    var content = Content.multi([
      TextPart(message),
      if (paths != null) ..._convertPathsIntoDataparts(paths),
    ]);
    var response = await chat.sendMessage(content);
    return response.text!;
  }
}
