import 'package:flutter/material.dart';
import 'package:spark/business_logic/models/guideline.dart';
import 'package:spark/presentation/view/disclaimer/widgets/guideline_item.dart';

class GuideLinesScreen extends StatelessWidget {
  const GuideLinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Guideline> guidelines = [
    Guideline(
      title: 'Respect Everyone',
      description:
          'Be respectful and kind to everyone you interact with on our platform. Treat others as you would like to be treated.',
    ),
    Guideline(
      title: 'Stay Safe',
      description:
          'Prioritize your safety and well-being. Meet in public places for the first few interactions and trust your instincts.',
    ),
    Guideline(
      title: 'Be Authentic',
      description:
          'Be yourself and represent yourself honestly. Misleading information or photos is not allowed.',
    ),
    Guideline(
      title: 'No Harassment',
      description:
          'Harassment or discrimination of any kind, including but not limited to race, gender, religion, or sexual orientation, will not be tolerated.',
    ),
    Guideline(
      title: 'Respect Privacy',
      description:
          'Respect the privacy of others and refrain from sharing personal information, such as phone numbers or addresses, without consent.',
    ),
    Guideline(
      title: 'Report Misconduct',
      description:
          'If you encounter any behavior that violates our guidelines or makes you feel uncomfortable, report it immediately.',
    ),
    Guideline(
      title: 'Have Fun!',
      description:
          'Most importantly, have fun and enjoy meeting new people! Our platform is designed to help you connect with others in a positive way.',
    ),
  ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text('Guidelines', style:Theme.of(context).textTheme.titleLarge ,),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),),
      ),
      body: ListView.builder(
        itemCount: guidelines.length,
        itemBuilder: (context, index) {
          return GuidelineItem(guideline: guidelines[index]);
        },
      ),
    );
  }
}
