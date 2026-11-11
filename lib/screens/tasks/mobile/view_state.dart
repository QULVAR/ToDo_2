part of '../tasks.dart';

class _TasksMobileView extends StatelessWidget {
  const _TasksMobileView({required this.taskTapOpensProperties});

  final bool taskTapOpensProperties;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TestTaskButton(
                completed: state.testTaskCompleted,
                onPressed: () {
                  context.read<TasksBloc>().add(
                    TasksTestTaskPressed(
                      openProperties: taskTapOpensProperties,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
