import 'package:flutter/material.dart';
import 'package:rad_mock_up/theme.dart';
import '../app/modules/chat/model/chat.model.dart';

Widget buildItem(String currentUserName, Chat chat) {
  if (chat.authorName == currentUserName) {
    // Right (my message)
    return Row(
      children: <Widget>[
        chat.media == null
            // Text
            ? Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical:5),
                child: Text(
                  chat.content,
                  style: TextStyle(color: Colors.black),
                ),
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                width: 200.0,
                decoration: BoxDecoration(
                    color: Palette.sendCardColor,
                    borderRadius: BorderRadius.circular(8.0)),
              )
            :
            // Image
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical:5),
                child: OutlinedButton(
                  child: Material(
                    child: Image.network(
                      chat.media!,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical:5),
                          decoration: BoxDecoration(
                            color: Palette.sendCardColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          width: 200.0,
                          height: 200.0,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.green,
                              value: loadingProgress.expectedTotalBytes !=
                                          null &&
                                      loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    clipBehavior: Clip.hardEdge,
                  ),
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(0))),
                ),
                // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
              )
        // Sticker
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  } else {
    // Left (peer message)
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical:5),
        child: Column(children: <Widget>[
      Row(
        children: <Widget>[
          chat.media == null
              ? Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical:5),
                  child: Text(
                    chat.content,
                    style: TextStyle(color: Colors.black),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Palette.receiveCardColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  
                )
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical:5),
                  child: TextButton(
                    child: Material(
                      child: Image.network(
                        chat.media!,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            decoration: BoxDecoration(
                              color: Palette.receiveCardColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            width: 200.0,
                            height: 200.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0))),
                  ),
                  
                )
        ],
      )
    ]));
  }
}
