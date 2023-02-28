enum RequestState {
  isNone,
  isLoading,
  isSucc,
  isError
}
enum RegisterSteps{
  isNone,
  isRegistering,
  isRegistered,
  isNotRegistered,
  isAddedUser,
  isNotAddedUser
}

enum AddCarRequestSteps{
  isNone,
  isDoneSucc,
  isChoosingPic,
 isUploadingPic,
 isUploadedPicSucc,
 isUploadedPicError,
 isFetchingUrl,
 isFetchedUrlSucc,
 isFetchedUrlError,
 isAddingPicToDb,
 isAddedPicToDBSucc,
 isAddedPicToDBError,
}

enum TextValidator{
  email,
  password,
  phone,
  name,
  other
}