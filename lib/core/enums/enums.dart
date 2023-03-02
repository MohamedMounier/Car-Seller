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
enum LoginSteps{
  isNone,
  isLoginUserIn,
  isLoginUserInError,
  isLoginUserInSuccess,
  isSavingUserUid,
  isSavingUserUidError,
  isSavingUserUidSuccess,
  isSavingUserType,
  isSavingUserTypeError,
  isSavingUserTypeSuccess,

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

enum HomeScreenDataSteps{
  isNone,
  isFetchingUserType,
  isFetchingUserTypeSucc,
  isFetchingUserTypeError,
  isFetchingUserUid,
  isFetchingUserUidSucc,
  isFetchingUserUidError,
  isFetchingCars,
  isFetchingCarsSucc,
  isFetchingCarsError,
  isFetchingUserInfo,
  isFetchingUserInfoError,
  isFetchingUserInfoSucc,
}
enum LocalDataStats{
  isNone,
  isRemovingUid,
  isRemovedUidSucc,
  isRemovedUidError,
  isResetingType,
  isResetingTypeSucc,
  isResetingTypeError,
  isLoggingOut,
  isLoggedOutSucc,
  isLoggedOutError,
}