import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/home_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/utils/config.dart';
import 'package:tfb/views/AccountScreen/ContactUs/widget/contact_card.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: height * .4,
              fit: BoxFit.cover,
              imageUrl: AppConfig.tfbMap,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error), // Error icon
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .25),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Contact Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: AppColor.secondaryColor,
                          thickness: 1,
                        ),
                        controller.generalSettings.value.phone1?.isNotEmpty ==
                                true
                            ? ContactCard(
                                title: 'Primary Contact Number',
                                details:
                                    controller.generalSettings.value.phone1!,
                                icon: Icons.phone,
                                onTap: () {
                                  controller.launchPhone();
                                },
                              )
                            : const SizedBox.shrink(),
                        controller.generalSettings.value.phone2?.isNotEmpty ==
                                true
                            ? ContactCard(
                                title: 'Secondary Contact Number',
                                details:
                                    '${controller.generalSettings.value.phone2}',
                                icon: Icons.phone,
                                onTap: () {
                                  controller.launchPhone();
                                },
                              )
                            : const SizedBox.shrink(),
                        controller.generalSettings.value.email?.isNotEmpty ==
                                true
                            ? ContactCard(
                                title: 'Email',
                                details:
                                    '${controller.generalSettings.value.email}',
                                icon: Icons.email,
                                onTap: () {
                                  controller.launchEmail();
                                },
                              )
                            : const SizedBox.shrink(),
                        controller.generalSettings.value.address?.isNotEmpty ==
                                true
                            ? ContactCard(
                                title: 'Address',
                                details:
                                    '${controller.generalSettings.value.address}',
                                icon: Icons.location_on,
                                onTap: () {},
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Social Media Links',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: AppColor.secondaryColor,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.generalSettings.value.facebook
                                        ?.isNotEmpty ==
                                    true
                                ? InkWell(
                                    onTap: () {
                                      controller.openSocialUrl(
                                          '${controller.generalSettings.value.facebook}');
                                    },
                                    child: Image.asset(
                                      'assets/socialIcons/facebook.png',
                                      height: 40,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 10),
                            controller.generalSettings.value.instagram
                                        ?.isNotEmpty ==
                                    true
                                ? Image.asset(
                                    'assets/socialIcons/instagram.png',
                                    height: 40,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 10),
                            controller.generalSettings.value.linkedin
                                        ?.isNotEmpty ==
                                    true
                                ? Image.asset(
                                    'assets/socialIcons/linkedin.png',
                                    height: 40,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 10),
                            controller.generalSettings.value.whatsapp
                                        ?.isNotEmpty ==
                                    true
                                ? Image.asset(
                                    'assets/socialIcons/whatsapp.png',
                                    height: 40,
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 10),
                            controller.generalSettings.value.youtube
                                        ?.isNotEmpty ==
                                    true
                                ? Image.asset(
                                    'assets/socialIcons/youtube.png',
                                    height: 40,
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
