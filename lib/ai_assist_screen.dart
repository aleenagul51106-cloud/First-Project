

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AiAssistScreen extends StatefulWidget {
  const AiAssistScreen({super.key});

  @override
  State<AiAssistScreen> createState() => _AiAssistScreenState();
}

class _AiAssistScreenState extends State<AiAssistScreen> {
  //===================== PASTE YOUR API KEY HERE =====================
  // static const String apiKey =
  //     "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";

  static const String apiUrl =
      "https://api.groq.com/openai/v1/chat/completions";

  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  bool isLoading = false;

  // Future<void> sendMessage() async {
  //   if (_controller.text.trim().isEmpty) return;
  //
  //   String userMessage = _controller.text.trim();
  //
  //   setState(() {
  //     messages.add({
  //       "isUser": true,
  //       "message": userMessage,
  //     });
  //     isLoading = true;
  //   });
  //
  //   _controller.clear();
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse("$apiUrl?key=$apiKey"),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({
  //         "contents": [
  //           {
  //             "parts": [
  //               {
  //                 "text": userMessage,
  //               }
  //             ]
  //           }
  //         ]
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //
  //       String reply =
  //       data["candidates"][0]["content"]["parts"][0]["text"];
  //
  //       setState(() {
  //         messages.add({
  //           "isUser": false,
  //           "message": reply,
  //         });
  //       });
  //     } else {
  //       setState(() {
  //         messages.add({
  //           "isUser": false,
  //           "message": "Error : ${response.body}",
  //         });
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       messages.add({
  //         "isUser": false,
  //         "message": e.toString(),
  //       });
  //     });
  //   }
  //
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  Widget chatBubble(bool isUser, String text) {
    return Align(
      alignment:
      isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        padding: const EdgeInsets.all(15),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .75,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey.withOpacity(.2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF2FF),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "GroqCloud AI Chat",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return chatBubble(
                  messages[index]["isUser"],
                  messages[index]["message"],
                );
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask Gemini...",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // CircleAvatar(
                //   radius: 28,
                //   backgroundColor: Colors.deepPurple,
                //   child: IconButton(
                //     onPressed: isLoading ? null : sendMessage,
                //     icon: const Icon(
                //       Icons.send,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}