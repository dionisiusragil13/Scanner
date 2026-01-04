class OnboardingContent {
  String image;
  String title;

  OnboardingContent({required this.image, required this.title});
}

List<OnboardingContent> onboardingContents = [
  OnboardingContent(
    title: 'Say Goodbye to Paper Receipts',
    image: 'images/Receipts.png',
  ),
  OnboardingContent(
    title: 'Monitor Your Daily Spending',
    image: 'images/Chart.png',
  ),
  OnboardingContent(
    title: 'Easily Access Your Receipts Anywhere',
    image: 'images/Location.png'
  ),
];