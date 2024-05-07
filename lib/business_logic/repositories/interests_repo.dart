import 'package:spark/business_logic/models/interests_model.dart';
import 'package:spark/data/network/network_api_services.dart';

class InterestsRepo{
  NetworkApiServices networkApiServices=NetworkApiServices();
   Future<List<InterestCategory>> fetchInterestCategories() async {
    await Future.delayed(const Duration(seconds: 3));
    //dynamic responseData= await networkApiServices.getGetApiResponse('url'); //temprory comment
    List<InterestCategory> interestCategories = [
  InterestCategory('Sports', ['🏃 Running', '🧘 Yoga', '🏋️ Gym', '⚽ Soccer', '🎾 Tennis']),
  InterestCategory(
      'Creativity', ['🎨 Art', '✏️ Design', '💄 Makeup', '📸 Photography', '🎬 Filmmaking']),
  InterestCategory('Going Out', ['🎤 Concerts', '😂 Stand-up Comedy', '🎭 Theater', '🍹 Bar Hopping']),
  InterestCategory('Staying In', ['🎮 Video Games', '🎲 Board Games', '📺 Netflix', '📚 Reading']),
  InterestCategory('Film & TV', ['💑 Romance', '😆 Comedy', '🎭 Drama', '👻 Horror', '🚀 Sci-Fi']),
  InterestCategory('Reading', ['💖 Romance', '😄 Comedy', '🕵️ Mystery', '🐉 Fantasy', '📖 Non-Fiction']),
  InterestCategory('Music', ['🎵 Pop', '🎸 Rock', '🎤 Hip Hop', '🎧 EDM', '🎻 Classical']),
  InterestCategory(
      'Food & Drink', ['🍳 Cooking', '🍷 Wine Tasting', '🍹 Mixology', '🍔 Burgers', '🍣 Sushi']),
  InterestCategory('Traveling', [
    '🌄 Adventure Travel',
    '🌍 Cultural Exploration',
    '🏖️ Beach Relaxation',
    '✈️ Air Travel',
    '🚗 Road Trips'
  ]),
  InterestCategory('Pets', ['🐶 Dogs', '🐱 Cats', '🐾 Exotic Pets', '🦜 Birds', '🐠 Fish']),
  InterestCategory(
      'Values & Traits', ['♀️ Feminism', '🌿 Environmentalism', '🤝 Kindness', '💪 Empowerment', '🧠 Learning']),
  // Add more categories and interests as needed
];
    return interestCategories;
  }
}