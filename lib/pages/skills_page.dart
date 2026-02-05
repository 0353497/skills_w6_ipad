import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text("Skills List")),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 1; i <= 3; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: constraints.maxWidth / 2,
                              color: Colors.blue,
                              padding: EdgeInsets.all(8),
                              child: Text("Skill style type"),
                            ),
                            SizedBox(
                              height: Get.height / 4,
                              child: GridView.count(
                                childAspectRatio: 8,
                                physics: NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                crossAxisCount: constraints.maxWidth >= 768
                                    ? 3
                                    : 2,
                                children: [
                                  for (int i = 1; i <= 9; i++)
                                    InkWell(
                                      onTap: () {
                                        var data =
                                            """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim congue ullamcorper. Sed a volutpat mi. Mauris nunc felis, iaculis sed tempus id, commodo ut nisl. Nullam vel metus vitae nulla vehicula dictum. Proin justo lacus, porta sed interdum id, sagittis vehicula eros. Donec ultrices justo sed vestibulum rutrum. In hac habitasse platea dictumst. Etiam feugiat aliquet lectus nec suscipit. Maecenas vulputate lectus nec lacinia efficitur. Mauris lobortis quam eget lorem mattis placerat. Quisque faucibus, lorem sed congue elementum, turpis turpis accumsan felis, vel molestie ipsum tortor eu odio. Nam sollicitudin ante ut tortor tempor, quis porta augue elementum.

Praesent eros quam, hendrerit sed ipsum vitae, congue blandit sem. Quisque fringilla consequat justo, quis maximus lacus rutrum a. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec at venenatis nulla. In posuere neque id enim fringilla, sodales congue velit porta. Phasellus imperdiet ultrices nibh, sed interdum odio scelerisque eget. Aenean imperdiet dui sapien, et hendrerit neque malesuada et. Ut bibendum sagittis leo, eu condimentum diam scelerisque ac. Vestibulum id mi nisl. Etiam at lorem sit amet neque dapibus aliquet quis at turpis.

Nulla tempor, elit in porttitor volutpat, nunc nisi finibus augue, non tincidunt enim justo egestas lectus. Maecenas faucibus molestie ornare. Donec lorem nunc, faucibus id leo vel, efficitur feugiat neque. Fusce convallis orci vitae egestas imperdiet. Proin fermentum interdum urna, auctor placerat urna sodales ultrices. Sed bibendum interdum dui, non lacinia metus. Cras viverra massa libero, sed viverra justo bibendum a. Duis posuere facilisis lobortis. Suspendisse sed volutpat velit, non laoreet magna.""";
                                        Get.dialog(
                                          SkillDialog(i: i, data: data),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Skill $i"),
                                            Icon(Icons.add),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SkillDialog extends StatelessWidget {
  const SkillDialog({super.key, required this.i, required this.data});

  final int i;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: Get.width - 200,
        height: Get.height - 200,
        child: LayoutBuilder(
          builder: (_, constraints) => constraints.maxWidth >= 768
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Text("Skill ${i + 1}"),
                            Expanded(child: Text(data)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              width: double.maxFinite,
                              "assets/${i % 3}.jpg",
                            ),
                            if (i != 8)
                              ElevatedButton(
                                onPressed: () async {
                                  Get.dialog(
                                    SkillDialog(i: (i + 1), data: data),
                                  );
                                },
                                child: Text("Next"),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Skill $i"),
                      Image.asset(
                        width: double.maxFinite,
                        "assets/${i % 3}.jpg",
                      ),
                      Flexible(child: Text(data)),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Get.dialog(
                                SkillDialog(i: (i + 1) % 9, data: data),
                              );
                            },
                            child: Text("Next"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
