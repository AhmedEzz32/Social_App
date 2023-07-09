import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/social_app/cubit/cubit.dart';
import 'package:project1/layout/social_app/cubit/states.dart';
import 'package:project1/models/social_app/message_model.dart';
import 'package:project1/models/social_app/social_user_model.dart';
import 'package:project1/shared/styles/icon_broken.dart';
import '../../../shared/styles/colors.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? socialUserModel;
  ChatDetailsScreen({super.key, this.socialUserModel});

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: socialUserModel!.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if (state is SocialSendMessageSuccessState) {
              messageController.clear();
            }
            // if (state is SocialGetMessageSuccessState) {
            //   ScrollDragController.momentumRetainVelocityThresholdFactor;
            // }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          '${socialUserModel!.image}',
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '${socialUserModel!.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message =
                            SocialCubit.get(context).message[index];
                            if (SocialCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return bulidMyMessage(message);
                            }
                            return bulidMessage(message);
                          },
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                          itemCount: SocialCubit.get(context).message.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[400]!,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Colors.grey,
                                  size: 28,
                                )),
                            const SizedBox(height: 10),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Message...",
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              height: 48,
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: socialUserModel!.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text
                                    );
                                  },
                                  icon: const Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  Widget bulidMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      child: Text("${messageModel.text}"),
    ),
  );
  Widget bulidMyMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: defaultColor.withOpacity(0.2),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      child: Text("${messageModel.text}"),
    ),
  );
}