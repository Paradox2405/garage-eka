import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:garage_eka/models/assistant_response_model.dart';

class VirtualAssistant extends StatefulWidget {
  @override
  _VirtualAssistantState createState() => _VirtualAssistantState();
}

class _VirtualAssistantState extends State<VirtualAssistant> {
  TextEditingController _questionController = TextEditingController();
  bool isLoading=false;
  final dio = Dio();
  final List<String> messages = [
    'Welcome to your virtual mechanic assistant! If you have questions regarding your car or need help with vehicle issues, I am here to assist you.',
  ];

  Future<void> askQuestion(String question) async {
    setState(() {
      isLoading=true;
    });
   try {
     final response = await dio.post('https://api-chat-bot-8d73e80e9890.herokuapp.com/chatBot', data: {"question": question, 'sessionId': 'asdqwe'});
     ResponseModel responseModel=ResponseModel.fromJson(response.data);
     messages.add(responseModel.data!.response??"");
     setState(() {
       isLoading=false;
     _questionController.text='';
     });
   }  catch (e) {
     print(e);
     setState(() {
       isLoading=false;
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Assistant", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFf7c910),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    bool isUserMessage = index % 2 == 1;
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(16),
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color:
                        isUserMessage ? Colors.blue[100] : Colors.yellow[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    hintText: 'Ask me anything...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: InkWell(onTap:(){
                      messages.add(_questionController.text);
                     askQuestion(_questionController.text);
                    },child: Icon(Icons.arrow_forward)),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          isLoading?Center(child: CircularProgressIndicator()):SizedBox.shrink(),
        ],
      ),
    );
  }
}
