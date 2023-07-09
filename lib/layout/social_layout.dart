import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/styles/icon_broken.dart';
import '../../modules/social_app/new_post/new_post_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
   {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state)
      {
        if(state is SocialNewPostState)
          {
            navigateTo(context,  NewPostScreen(),
            );
          }
      },
      builder: (BuildContext context, Object? state)
      {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(onPressed:()
              {

              },
                icon: const Icon(
                IconBroken.Notification,
              )),
              IconButton(onPressed:()
              {

              },
                icon: const Icon(
                IconBroken.Search,
              )),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items:
             const [
              BottomNavigationBarItem(
                icon: Icon(
                IconBroken.Home,
              ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                IconBroken.Chat,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                IconBroken.Location,
              ),
                label: 'Users',

              ),
              BottomNavigationBarItem(
                icon: Icon(
                IconBroken.Setting,
              ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
