import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/screen/profile/contact_info/text_field_widget.dart';
import 'package:my_albums_app/theming/dimensions.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';

class ContactInfoScreen extends StatelessWidget {
  const ContactInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: contactInfoPadding,
      child: Center(
        child: Column(
          children: [
            smallVerticalDistance,
            Row(
              children: const [
                Flexible(
                    child: TextFieldWidget(
                  title: "FIRST NAME",
                )),
                Flexible(
                    child: TextFieldWidget(
                  title: "LAST NAME",
                ))
              ],
            ),
            smallVerticalDistance,
            const TextFieldWidget(
              title: "EMAIL ADDRESS",
            ),
            smallVerticalDistance,
            const TextFieldWidget(
              title: "PHONE NUMBER",
            ),
            xLargeVerticalDistance,
            const TextFieldWidget(
              title: "STREET ADDRESS",
            ),
            smallVerticalDistance,
            Row(
              children: const [
                Flexible(
                  child: TextFieldWidget(
                    title: "CITY",
                  ),
                ),
                Flexible(
                  child: TextFieldWidget(
                    title: "COUNTRY",
                  ),
                )
              ],
            ),
            smallVerticalDistance,
            const TextFieldWidget(
              title: "ZIP CODE",
            ),
            largeVerticalDistance,
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
              onPressed: () {},
              child: const Text(
                "Use my location",
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBarWidget(
      title: Text(AppLocalizations.of(context)!.contactInfo,
          style: Theme.of(context).textTheme.headlineSmall),
      automaticallyImplyLeading: false,
      leading: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Back"),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text("Apply"),
        )
      ],
    );
  }
}
