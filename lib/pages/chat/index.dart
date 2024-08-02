import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../constants/routes.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            actions: [
              IconButton(onPressed: ()async {
                bool? res = await FlutterPhoneDirectCaller.callNumber('01024908276');
              }, icon: Icon(Icons.phone, color: Theme.of(context).iconTheme.color)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).iconTheme.color,
                  )),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
                ),
              ),
            ],
          ),
          endDrawer: _buildDrawer(context),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    reverse: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      if (index.isEven) {
                        return BubbleSpecialThree(
                          text: '안녕하세요?',
                          color: Theme.of(context).primaryColor,
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.white),
                          tail: true,
                        );
                      }
                      return const BubbleSpecialThree(
                        text: '응 안녕',
                        isSender: false,
                        tail: true,
                      );
                    }),
              ),
              _buildMessageInputField(context)
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDrawer(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).size.width * 0.8, // You can adjust the width as needed
          color: Theme.of(context).canvasColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(child: Container()),
              ListTile(
                title: const Text("사진 모아보기"),
                leading: const Icon(Icons.image),
                onTap: () => Navigator.of(context).pushNamed(Routes.chatPicture),
              ),
              ListTile(
                title: const Text('커플캘린더'),
                leading: Icon(Icons.calendar_month,color: Theme.of(context).iconTheme.color,),
                onTap: () => Navigator.of(context).pushNamed(Routes.chatCalendar),
              ),
              ListTile(
                title: const Text('러브레터 보관함'),
                leading: Icon(Icons.mail_outline,color: Theme.of(context).iconTheme.color,),
                onTap: () => Navigator.of(context).pushNamed(Routes.chatLoveLetter),
              ),
              ListTile(
                title: const Text('컨텐츠 보관함'),
                leading: Icon(Icons.library_books_rounded, color: Theme.of(context).iconTheme.color,),
                onTap: () => Navigator.of(context).pushNamed(Routes.chatContents),
              )
            ],
          ),
        );
  }

  Widget _buildMessageInputField(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.add,
                    size: 32,
                  )),
              const Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                )),
              )),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 52,
                    height: double.infinity,
                    color: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
