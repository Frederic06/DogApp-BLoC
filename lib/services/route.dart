String kLoginURLString = "https://reqres.in/api/login";
String kBaseURLString = "https://dog.ceo/api/";
String kGetAllBreedsURLString = kBaseURLString + "breeds/list/all";

String getRandomBreedImage(String breedName) {
  return kBaseURLString + "breed/" + breedName +"/images/random/";
} 

String getRandom5BreedImage(String breedName) {
  return kBaseURLString + "breed/" + breedName +"/images/random/5";
} 

String getSubBreedList(String breedName) {
  return kBaseURLString + "breed/" + breedName +"/list/";
}    

String getRandomImageFromBreed(String breedName) {
  return kBaseURLString + 'breed/' + breedName + '/images/random';
}
