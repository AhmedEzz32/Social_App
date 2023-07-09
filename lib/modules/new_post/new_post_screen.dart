import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/social_app/cubit/cubit.dart';
import 'package:project1/layout/social_app/cubit/states.dart';
import 'package:project1/shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{
  var textController = TextEditingController();

   NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        SocialCubit getData = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            titleSpacing: 0.0,
            title: const Text(
              'Create Post',
            ),
            actions: [
              defaultTextButton(
                function: ()
                {
                  var now = DateTime.now();
                  if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }else
                      {
                        SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                            text: textController.text,
                        );
                      }
                },
                text: 'Post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if(state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/bearded-man-casual-clothes-wearing-glasses-holding-cash-clenching-fist-happy-positive-rejoicing-his-success-standing-orange-background_141793-140412.jpg?w=996&t=st=1682406198~exp=1682406798~hmac=ba8f4bf766c6d653978cd4d8eea3677ca377b3e635452d20378579b5b08e7ad5',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Ahmed Ezz',
                        style: TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what\'s in your mind...' ,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 165,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(getData.postImageFile!),
                            fit: BoxFit.cover,
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        getData.removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          getData.getPostImage();
                        },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            const [
                              Icon(
                                  IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  'add photo',
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                          child:  const Text(
                            '# tags',
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
