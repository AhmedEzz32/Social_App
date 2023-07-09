abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates
{
  final String error;
  SocialGetUserErrorState(this.error) {
    print('SocialGetUserErrorState: $error');
  }
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;
  SocialGetPostsErrorState(this.error) {
    print('SocialGetPostsErrorState: $error');
  }
}

class SocialLikePostsSuccessState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates
{
  final String error;
  SocialLikePostsErrorState(this.error) {
    print('SocialLikePostsErrorState: $error');
  }
}

//comment
class SocialCreateCommentLoadingState extends SocialStates {}

class SocialCreateCommentsSuccessState extends SocialStates {}

class SocialCreateCommentsErrorState extends SocialStates
{
  final String error;
  SocialCreateCommentsErrorState(this.error) {
    print('SocialCreateCommentsErrorState: $error');
  }
}

class SocialCommentImagePickedSuccessState extends SocialStates {}

class SocialCommentImagePickedErrorState extends SocialStates {}

class SocialRemoveCommentImageState extends SocialStates {}

class SocialGetCommentsSuccessState extends SocialStates {}

class SocialGetCommentsErrorState extends SocialStates
{
  final String error;
  SocialGetCommentsErrorState(this.error) {
    print('SocialGetCommentsErrorState: $error');
  }
}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialAllUserSuccessState extends SocialStates {}

class SocialAllUserErrorState extends SocialStates
{
  final String error;
  SocialAllUserErrorState(this.error) {
    print('SocialAllUserErrorState: $error');
  }
}

//chat
class SocialSendMessageLoadingState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates
{
  final String error;
  SocialSendMessageErrorState(this.error) {
    print('SocialSendMessageErrorState: $error');
  }
}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates
{
  final String error;
  SocialGetMessageErrorState(this.error) {
    print('SocialGetMessageErrorState: $error');
  }
}

class SocialSiqnOutSuccessState extends SocialStates {}

class SocialSiqnOutErrorState extends SocialStates
{
  final String error;
  SocialSiqnOutErrorState(this.error) {
    print('SocialSiqnOutErrorState: $error');
  }
}