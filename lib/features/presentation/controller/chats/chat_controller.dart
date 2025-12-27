import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/chat_model.dart';
import '../chat_history/chat_history_controller.dart';

class ChatController extends GetxController {
  final args = Get.arguments;
  final chatHistoryController = Get.put(ChatHistoryController());
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxBool isVisible = true.obs;

  RxBool isTyping = false.obs;
  RxBool isOnline = false.obs;
  Rx<DateTime> lastSeen = DateTime.now().obs;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final textController = TextEditingController().obs;

  final _autoReplies = [
    "Hmm 🤔",
    "Okay 👍",
    "Got it!",
    "Tell me more 👀",
    "That makes sense",
    "Haha 😄",
    "Alright",
    "Interesting...",
    "I see 👌",
    "Sounds good",
  ].obs;

  final Map<List<String>, List<String>> _smartReplies = {
    ['hi', 'hello', 'hey']: ['Hey 👋', 'Hello 😊', 'Hi there!'],
    ['how are you', 'how r u', 'how are u']: [
      'I’m good, how about you?',
      'Doing great 😊',
      'All good here!',
    ],
    ['bye', 'good night', 'gn']: ['Good night 🌙', 'Bye 👋', 'Sweet dreams 😴'],
    ['thanks', 'thank you']: ['You’re welcome 😊', 'Anytime!', 'No problem 👍'],
    ['ok', 'okay', 'alright']: ['Cool 👍', 'Alright!', 'Got it 😊'],
  };

  late String myId;
  late String otherId;
  late String chatId;

  Timer? _typingTimer;

  /// Matches: void Function(String)?
  void onChanged(String value) {
    if (value.isNotEmpty) {
      isTyping.value = true;

      _typingTimer?.cancel();
      _typingTimer = Timer(const Duration(seconds: 1), () {
        isTyping.value = false;
      });
    } else {
      isTyping.value = false;
    }
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(ChatMessage(text: text, isMe: true, time: DateTime.now()));
    isTyping(false);
    _simulateSmartReply(text);
  }

  void receiveMessage(String text) {
    messages.add(ChatMessage(text: text, isMe: false, time: DateTime.now()));
  }

  void _simulateSmartReply(String userMessage) async {
    isOnline.value = true;
    isTyping.value = true;

    await Future.delayed(Duration(milliseconds: 700 + Random().nextInt(1300)));

    final reply = _getSmartReply(userMessage);

    messages.add(ChatMessage(text: reply, isMe: false, time: DateTime.now()));

    isTyping.value = false;
  }

  String _getSmartReply(String message) {
    final text = message.toLowerCase();

    for (final entry in _smartReplies.entries) {
      for (final keyword in entry.key) {
        if (text.contains(keyword)) {
          final replies = entry.value;
          return replies[Random().nextInt(replies.length)];
        }
      }
    }

    chatHistoryController.addOrUpdateChat(
      chatId: args['id'].toString() ?? '0', // or item.id if available
      name: args['name'] ?? '',
      message: messages.last.text,
      time: messages.last.time.toString(),
      unreadCount: messages.length,
    );

    /// fallback (no keyword matched)
    return _autoReplies[Random().nextInt(_autoReplies.length)];
  }

  void _simulateRandomReply() async {
    isOnline.value = true;

    // Show typing
    isTyping.value = true;

    await Future.delayed(Duration(milliseconds: 800 + Random().nextInt(1200)));

    final randomReply = _autoReplies[Random().nextInt(_autoReplies.length)];

    messages.add(
      ChatMessage(text: randomReply, isMe: false, time: DateTime.now()),
    );

    isTyping.value = false;
    chatHistoryController.addOrUpdateChat(
      chatId: args['id'].toString() ?? '0', // or item.id if available
      name: args['name'] ?? '',
      message: messages.last.text,
      time: messages.last.time.toString(),
      unreadCount: messages.length,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  /// 🔥 async init
  Future<void> _init() async {
    try {
      _simulateRandomReply();
      isLoading(false);
    } catch (e) {
      hasError(true);
      isLoading(false);
    }
  }

  // ================= APP LIFECYCLE =================
  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setOnline(true);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _setOnline(false);
    }
  }*/

  @override
  void onClose() {
    _typingTimer?.cancel();
    super.onClose();
  }

  String getFirstLetter(String text) {
    final trimmed = text.trimLeft();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }
}

/*
* */
