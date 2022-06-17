import 'package:flutter/material.dart';

import '../../constants.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  PrivacyPolicyPageState createState() => PrivacyPolicyPageState();
}

class PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 26,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: kDefaultPadding),
              const Text(
                'Політика Конфіденційності',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: kDefaultPadding),
              const Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas odio sit'
                    'amet libero porttitor, et mattis ex finibus. Nam in augue pretium, feugiat ante sed, tempus'
                    'turpis. Nulla sodales aliquam nulla in vestibulum. Duis facilisis quam nibh, sit amet pulvinar'
                    'diam dictum eu. In quis tortor nec sem lobortis consectetur. Donec quis mauris magna. Curabitur'
                    'orci augue, vestibulum at scelerisque quis, tempus eget diam. Maecenas eget est pellentesque, tincidunt'
                    'lectus non, tincidunt ante. Ut blandit libero justo, et blandit dui venenatis a. Mauris lobortis semper'
                    'semper. Phasellus nec scelerisque lacus, eget ultrices arcu. Cras imperdiet purus quis purus vulputate'
                    'egestas. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus sed volutpat tortor.'
                    'Donec venenatis, est lacinia lacinia hendrerit, sem nulla tincidunt odio, et sollicitudin nunc urna ac nulla.'
                    'Donec eu leo suscipit, rhoncus purus lobortis, finibus erat.'
                    '\n\nMorbi pharetra elit ac sapien maximus consectetur. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;'
                    'Vestibulum efficitur sapien mi, eget maximus diam efficitur ac. Donec aliquam, diam scelerisque efficitur vehicula, odio augue ornare purus,'
                    'id aliquam libero mi eget erat. Praesent eget laoreet felis, ut laoreet est. Nulla bibendum tristique odio, ut fringilla justo mollis.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
