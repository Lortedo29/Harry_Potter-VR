using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using Utils.Pattern;
using VRTK;

namespace GesturesRecognition
{
    public class GestureRecorder : Singleton<GestureRecorder>
    {
        #region Fields
        public readonly static float DISTANCE_THRESHOLD = 0.01f;
        public readonly static int ORIENTATION_SAMPLES_COUNT = 15;
        public readonly static float PERCENT_TO_VALIDATE_ORIENTATION_SAMPLES = 0.9f; // 90% of the sample are the same orientation

        [SerializeField] private bool _debugLogOrientation = false;

        private bool _isRecording;

        private Transform _controller;
        private Vector3 _normal;
        private Vector3 _lastPositionOfController;

        private Orientation? _currentOrientation;
        private List<Orientation> _gestureOrientations = new List<Orientation>();

        private Queue<Orientation> _orientationSamples = new Queue<Orientation>();
        #endregion

        #region Methods
        #region Mono Callbacks
        void Update()
        {
            if (!_isRecording)
                return;

            // controller is enough far from last position
            if (Vector3.Distance(_controller.position, _lastPositionOfController) >= DISTANCE_THRESHOLD)
            {
                AddOrientationSample();
                CheckForNewOrientation();

                _lastPositionOfController = _controller.position;
            }
        }

        void OnDrawGizmos()
        {
            Gizmos.color = Color.red;
            Gizmos.DrawSphere(_lastPositionOfController, 0.3f);
        }
        #endregion

        #region Private methods
        private void AddOrientationSample()
        {
            Orientation orientation = GetCurrentOrientation();

            _orientationSamples.Enqueue(orientation);
            _orientationSamples.RemoveEldestEntry(ORIENTATION_SAMPLES_COUNT);

            CheckForNewOrientation();
        }

        private void CheckForNewOrientation()
        {
            // if we doesn't have enought samples, don't check for new orientation
            if (_orientationSamples.Count < ORIENTATION_SAMPLES_COUNT)
                return;

            var mostFrequentOrientation = _orientationSamples
                                    .GroupBy(x => x)
                                    .OrderByDescending(x => x.Count())
                                    .Select(g => g.Key).First();

            float countMostFrequent = _orientationSamples
                .Where(x => x == mostFrequentOrientation)
                .Count();

            float percentMostFrequen = countMostFrequent / _orientationSamples.Count;

            if (percentMostFrequen >= PERCENT_TO_VALIDATE_ORIENTATION_SAMPLES)
            {
                // set _currentOrientation
                if (_currentOrientation == null || _currentOrientation != mostFrequentOrientation)
                {
                    _orientationSamples.Clear();
                    AddOrientation(mostFrequentOrientation);
                }
            }
        }

        private Orientation GetCurrentOrientation()
        {
            Vector3 direction = _controller.position - _lastPositionOfController;
            float angle = Vector3.Angle(direction, _normal) * Mathf.Deg2Rad;  // angle between 0 to 180

            if (direction.y < 0) angle *= -1; // angle between -180 to 180

            return angle.ToOrientation();
        }

        private void AddOrientation(Orientation orientation)
        {
            _currentOrientation = orientation;
            _gestureOrientations.Add((Orientation)_currentOrientation);

            if (_debugLogOrientation)
            {
                Debug.Log("New orientation  " + orientation);
            }
        }

        #endregion

        #region Public methods
        public void StartRecord(Transform controller)
        {
            StartRecord(controller, Vector3.right);
        }

        public void StartRecord(Transform controller, Transform normal)
        {
            StartRecord(controller, normal.right);
        }

        void StartRecord(Transform controller, Vector3 normal)
        {
            _isRecording = true;
            _controller = controller;

            _normal = normal;

            _gestureOrientations.Clear();
            _currentOrientation = null;

            _lastPositionOfController = _controller.position;
        }

        public Orientation[] StopRecord()
        {
            _isRecording = false;
            _controller = null;

            return _gestureOrientations.ToArray();
        }
        #endregion
        #endregion
    }
}
