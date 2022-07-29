import 'package:flutter/material.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/controllers/inbox_controller.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as tago;

class InboxScreen extends StatelessWidget {
  InboxScreen({Key? key}) : super(key: key);

  final InboxController inboxController = Get.put(InboxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Expanded(child: Obx(() {
              print(
                  'the current value of the inbox list is: ${inboxController.inboxes}');
              if (inboxController.inboxes.isEmpty) {
                return Center(
                    child: Text('No message here',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )));
              } else {
                return ListView.builder(
                  itemCount: inboxController.inboxes.length,
                  itemBuilder: (context, i) {
                    final inbox = inboxController.inboxes[i];

                    return Card(
                      color: backgroundColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: backgroundColor,
                          backgroundImage: NetworkImage(inbox.profilePhoto),
                        ),
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inbox.username,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: buttonColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                inbox.message,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(inbox.datePublished.toDate()),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }))
          ]),
        ),
      ),
    );
  }
}
