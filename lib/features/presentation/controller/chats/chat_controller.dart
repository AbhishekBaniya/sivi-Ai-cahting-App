/*class ChatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxBool isVisible = true.obs;

  RxBool isTyping = false.obs;
  RxBool isOnline = false.obs;
  Rx<DateTime> lastSeen = DateTime.now().obs;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  Rx<TextEditingController> textController = TextEditingController().obs;

  late String myId;
  late String otherId;
  late String chatId;

  @override
  void onInit() async {
    super.onInit();
    try {
      myId = await LocalUserService.getId();
      otherId = 'STATIC_OTHER_USER'; // change later
      chatId = _chatId(myId, otherId);

      _setOnline(true);
      _listenMessages();
      _listenTyping();
      _listenPresence();

      isLoading(false);
    } catch (e) {
      hasError(true);
      isLoading(false);
    }
  }

  String _chatId(String a, String b) =>
      a.compareTo(b) < 0 ? '${a}_$b' : '${b}_$a';

  // SEND MESSAGE
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    await firestore.collection('messages').doc(chatId).collection('chat').add({
      'senderId': myId,
      'text': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // LISTEN MESSAGES
  void _listenMessages() {
    firestore
        .collection('messages')
        .doc(chatId)
        .collection('chat')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
          messages.value = snapshot.docs.map((doc) {
            final data = doc.data();
            return ChatMessage(
              text: data['text'],
              isMe: data['senderId'] == myId,
              time:
                  (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
            );
          }).toList();
        });
  }

  // TYPING
  void setTyping(bool value) {
    firestore.collection('typing').doc(chatId).set({
      myId: value,
    }, SetOptions(merge: true));
  }

  void _listenTyping() {
    firestore.collection('typing').doc(chatId).snapshots().listen((doc) {
      final data = doc.data();
      if (data == null) return;
      isTyping.value = data[otherId] == true;
    });
  }

  // ONLINE / LAST SEEN
  void _setOnline(bool value) {
    firestore.collection('users').doc(myId).set({
      'isOnline': value,
      'lastSeen': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  void _listenPresence() {
    firestore.collection('users').doc(otherId).snapshots().listen((doc) {
      if (!doc.exists) return;
      final data = doc.data()!;
      isOnline.value = data['isOnline'] ?? false;
      lastSeen.value =
          (data['lastSeen'] as Timestamp?)?.toDate() ?? DateTime.now();
    });
  }

  @override
  void onClose() {
    _setOnline(false);
    super.onClose();
  }
}*/
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/chat_model.dart';

class ChatController extends GetxController {
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
