import 'dart:convert';

class Chat {
  final String text;
  final bool isMyChat;
  final List<String>? paths;

  Chat({required this.text, required this.isMyChat, this.paths});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isMyChat': isMyChat,
      'paths': paths,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      text: map['text'] as String,
      isMyChat: map['isMyChat'] as bool,
      paths: map['paths'] != null
          ? List<String>.from((map['paths'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);
}
