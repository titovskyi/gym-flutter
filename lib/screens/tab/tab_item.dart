enum TabItem {
  trainings,
  exercises,
  calendar,
  profile,
}

const Map<TabItem, String> tabName = {
  TabItem.trainings: 'Trainings',
  TabItem.exercises: 'Exercises',
  TabItem.calendar: 'Calendar',
  TabItem.profile: 'Profile',
};

const Map<TabItem, String> tabItemRoute = {
  TabItem.trainings: '/trainings',
  TabItem.exercises: '/exercises',
  TabItem.calendar: '/',
  TabItem.profile: '/profile',
};
