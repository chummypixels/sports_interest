import 'package:flutter/material.dart';
import '../../../models/interest_type.dart';
import 'package:flutter_sports_interest/screens/onboarding/components/inviter.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'onboard_step.dart';

//creating the body of the onboarding screen
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool acceptedLicense = false;
  final outerScrollController = PageController();

  double innerScrollPosition = 0;

  //the different interests the users might have
  final interestTypes = [
    InterestType('basketball.jpg', 'BasketBall'),
    InterestType('body-building.jpg', 'BodyBuilding'),
    InterestType('football.jpg', 'Football'),
    InterestType('jogging.jpg', 'Jogging'),
    InterestType('rugby.jpg', 'Rugby'),
    InterestType('swimming.jpg', 'Swimming'),
    InterestType('tennis.jpg', 'Tennis'),
    InterestType('yoga.jpg', 'Yoga'),
  ];

  final selectedInterestTypes = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: outerScrollController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          ClipRect(
            child: Inviter(
              getStartedPressed: () => outerScrollController.animateToPage(1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn),
            ),
          ),
          Stack(
            children: [
              PageView(
                onPageChanged: (val) {
                  setState(() {
                    innerScrollPosition = val.toDouble();
                  });
                },
                children: [
                  OnboardStep(
                    [
                      Text(
                        'Get ready for a fun filled experience.',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Antique Rest & Resort is a way for you to stay fit while having fun.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                    image: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset(
                        'assets/images/explore.jpg',
                      ),
                    ),
                  ),
                  OnboardStep(
                    [
                      Text(
                        'To do that, we would have to ensure you have the right mindset and training.',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'In order to continue, you would be paired with individuals with similar sports interests to ensure everyone stays motivated',
                        textAlign: TextAlign.center,
                      ),
                      CheckboxListTile(
                        value: acceptedLicense,
                        onChanged: (val) {
                          setState(() {
                            acceptedLicense = val ?? false;
                          });
                        },
                        title: const Text('Yes I\'m in!'),
                      ),
                    ],
                    image: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset(
                        'assets/images/awesome.jpg',
                      ),
                    ),
                  ),
                  OnboardStep(
                    [
                      Text(
                        'Please select your interests',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ...interestTypes.map(
                            (e) => AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              padding: selectedInterestTypes.contains(e.name)
                                  ? const EdgeInsets.all(16)
                                  : EdgeInsets.zero,
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedInterestTypes
                                          .contains(e.name)) {
                                        selectedInterestTypes.remove(e.name);
                                      } else {
                                        selectedInterestTypes.add(e.name);
                                      }
                                    });
                                  },
                                  child: Ink.image(
                                    image: AssetImage(
                                        'assets/interest_types/${e.asset}'),
                                    fit: BoxFit.cover,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.expand,
                                      children: [
                                        Align(
                                          child: Container(
                                            padding: EdgeInsets.zero,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                e.name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            width: double.maxFinite,
                                            color: Colors.transparent
                                                .withOpacity(0.2),
                                            alignment: Alignment.bottomCenter,
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          opacity: selectedInterestTypes
                                                  .contains(e.name)
                                              ? 1.0
                                              : 0.0,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          child: Container(
                                            height: double.maxFinite,
                                            width: double.maxFinite,
                                            color: Colors.grey.withOpacity(0.3),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  OnboardStep(
                    [
                      Text(
                        'Pack your exercise gear, it\'ll get sweaty!',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Get ready to meet amazing like minded sports enthusiasts. Simply tap the button below',
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Text('CONNECT ME TO LIKE MINDED FANS'),
                      ),
                    ],
                    image: Image.asset('assets/images/get_set.png'),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: 4,
                  position: innerScrollPosition,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
