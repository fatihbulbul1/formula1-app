import 'package:flutter/material.dart';
import 'package:test/services/dbhelper.dart';

class ShareTweet extends StatefulWidget {
  const ShareTweet({super.key});

  @override
  State<ShareTweet> createState() => _ShareTweetState();
}

class _ShareTweetState extends State<ShareTweet> {
  final TextEditingController authorCon = TextEditingController();
  final TextEditingController textCon = TextEditingController();
  final TextEditingController bodyImageCon = TextEditingController();
  Future<void> _addData() async {
    await SQLHelper.createData(authorCon.text, textCon.text, bodyImageCon.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Share your feelings!", style: textStyle()),
        SizedBox(
          height: 30,
        ),
        Text(
          "Author:",
          style: textStyle(),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: authorCon,
          cursorColor: Colors.white,
          style: textStyle(),
          decoration: inputDecoration(),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Text:",
          style: textStyle(),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: textCon,
          cursorColor: Colors.white,
          style: textStyle(),
          decoration: inputDecoration(),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Image Url:",
          style: textStyle(),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: bodyImageCon,
          cursorColor: Colors.white,
          style: textStyle(),
          decoration: inputDecoration(),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            _addData();
            authorCon.clear();
            textCon.clear();
            bodyImageCon.clear();
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 56, 56, 56),
                content: Text('Tweet successfully shared!', style: textStyle()),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Text(
            "Share Tweet",
            style: TextStyle(color: Colors.black),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red)),
        ),
      ],
    );
  }

  InputDecoration inputDecoration() {
    return const InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  TextStyle textStyle() => TextStyle(color: Colors.white);
}
