import 'dart:convert';

final String dummyWorkouts = json.encode([
  {
    'id': 'First',
    'title': 'Hip Thrust',
    'subTitle': 'Cable',
    'equipment': ['Cable Machine'],
    'preparation':
        'Stand before the machine with feet shoulder width apart. Squat down to hold the low handle in an overhand grip.',
    'execution': [
      'Stretch your legs and pull your back upwards into an upright position.',
      'Squeez your glutes in the upright position.',
      'Push your hips back to lower your body to the starting position slowly and repeat.',
    ],
    'date': DateTime.now().toIso8601String(),
  },
  {
    'id': 'Second',
    'title': 'Decline Bench Press',
    'subTitle': 'BArbell',
    'preparation':
        'Lie on a bench with feet secured under the footpads. Hold the barbell over your chest with elbows bent at 90 degrees and palms facing forward.',
    'execution': [
      'Exhale and squeeze your chect to push the bar up to extend your arms straight.',
      'Inhale and slowly lower your bar to the starting position and repeat',
    ],
    'date': DateTime.now().toIso8601String(),
  }
]);
