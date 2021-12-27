abstract class AddPhotosState {
  const AddPhotosState();
}

class AddPhotosEmpty extends AddPhotosState {
  const AddPhotosEmpty();
}

class AddPhotosLoaded extends AddPhotosState {
  const AddPhotosLoaded();
}

class AddPhotosReadyToSend extends AddPhotosState {
  const AddPhotosReadyToSend();
}

class AddPhotosVerify extends AddPhotosState {
  const AddPhotosVerify();
}

class AddPhotosSending extends AddPhotosState {
  const AddPhotosSending();
}

class AddPhotosSucces extends AddPhotosState {
  const AddPhotosSucces();
}

class AddPhotosFailure extends AddPhotosState {
  const AddPhotosFailure();
}
