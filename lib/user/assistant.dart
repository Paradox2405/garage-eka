import 'package:flutter/material.dart';

class VirtualAssistant extends StatelessWidget {
  final List<String> messages = [
    'Welcome to your virtual mechanic assistant! If you have questions regarding your car or need help with vehicle issues, I am here to assist you.',
    'Can you help me diagnose why my car is making a strange noise when I accelerate?',
    'A strange noise when accelerating can be caused by various factors, and diagnosing the issue will require a bit of investigation. Here are some steps to help you narrow down the problem:',
    '1. Identify the Noise: Determine type and location.\n2. Visual Inspection: Check for damage.\n3. Test Drive: Note when noise occurs.\n4. Check Codes: Use OBD-II scanner.\n5. Consult Mechanic: If unsure, seek professional help.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Assistant", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFf7c910),
        centerTitle: true,
      ),
      body: Column(
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
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                suffixIcon: Icon(Icons.arrow_forward),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
