import 'package:fitness_time/models/activity.dart';
import 'package:fitness_time/styles/app_styles.dart';
import 'package:fitness_time/widgets/activity_card.dart';
import 'package:flutter/material.dart';

import 'new_activity.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Activity> activities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness Time"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Actividades",
              style: AppStyles.bigTitle,
            ),
            if (activities.isEmpty)
              const Padding(
                padding: EdgeInsets.all(80.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.run_circle_outlined,
                      size: 120,
                      color: Colors.black45,
                    ),
                    Text(
                      "No hay actividades. Pulsa + per añadir una.",
                      style: AppStyles.subtitle,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            for (var activity in activities)
              Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  activities.remove(activity);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("S'ha esborrat l'activitat ${activity.type}")));
                  setState(() {});
                },
                child: GestureDetector(
                    onLongPress: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.delete),
                                    title: const Text(
                                      "Esborrar activitat",
                                      style: AppStyles.mediumTitle,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      activities.remove(activity);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "S'ha esborrat l'activitat ${activity.type}")));
                                      setState(() {});
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.close),
                                    title: const Text(
                                      "Duplica activitat",
                                      style: AppStyles.mediumTitle,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      activities.add(Activity(
                                          type: "Copia de ${activity.type}",
                                          date: DateTime.now(),
                                          distance: activity.distance));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "S'ha duplicat l'activitat ${activity.type}")));
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: ActivityCard(activity: activity)),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Activity? activity = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewActivity()));
          if (activity != null) activities.add(activity);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
