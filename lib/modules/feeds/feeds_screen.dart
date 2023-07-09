import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/social_app/cubit/cubit.dart';
import 'package:project1/layout/social_app/cubit/states.dart';
import 'package:project1/models/social_app/post_model.dart';
import 'package:project1/modules/social_app/new_comment/new_comment_screen.dart';
import 'package:project1/shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel != null,
          builder: (BuildContext context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: const [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/beautiful-african-american-woman-beige-sweater_273609-39185.jpg?w=996&t=st=1682404170~exp=1682404770~hmac=76daf919f302c19b4a5c355ee93237e13365500d68bb5453e1fc318b1bc52197'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount:  SocialCubit.get(context).posts.length,
                ),
              ],
            ),
          ),
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel postModel , context , index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  '${postModel.image}',
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:  [
                        Text(
                          '${postModel.name}',
                          style: const TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      '${postModel.dateTime}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 16,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${postModel.text}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10,
          //     top: 5,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 4,
          //           ),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software ',
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .bodySmall!
          //                     .copyWith(
          //                   color: defaultColor,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 10,
          //           ),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter ',
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .bodySmall!
          //                     .copyWith(
          //                   color: defaultColor,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(postModel.postImage != '')
            Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image:  DecorationImage(
                    image: NetworkImage(
                      '${postModel.postImage}',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5
                    ),
                    child: InkWell(
                      child: Row(
                        children: [
                          Row(
                            children:  [
                              const Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${SocialCubit.get(context).likes[index]}",
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: ()
                      {
                        SocialCubit.get(context).likePosts( SocialCubit.get(context).postsId[index]);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children:  [
                              const Icon(
                                IconBroken.Chat,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '3 comments',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: ()
                      {
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                       CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                    navigateTo(context, CommentScreen(uIdIndex: SocialCubit.get(context).postsId[index],));
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Row(
                      children:  [
                        const Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: ()
                {
                  SocialCubit.get(context).likePosts(SocialCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}