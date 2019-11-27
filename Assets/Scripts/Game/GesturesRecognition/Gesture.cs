using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using Utils.Inspector;

namespace GesturesRecognition
{
    [CreateAssetMenu(menuName = "Harry Potter VR/Gesture")]
    public class Gesture : ScriptableObject
    {
        [SerializeField] private Orientation[] _mainGesture = new Orientation[0];
        [SerializeField] private List<MDOrientationArray> _smoothedGestures = new List<MDOrientationArray>();

        public Orientation[] MainGesture
        {
            get
            {
                return _mainGesture;
            }
        }


        public List<MDOrientationArray> SmoothedGestures
        {
            get
            {
                return _smoothedGestures;
            }
        }

        [System.Serializable]
        public class MDOrientationArray
        {
            public Orientation[] orientations;

            public MDOrientationArray(Orientation[] orientations)
            {
                this.orientations = orientations;
            }
        }

#if UNITY_EDITOR
        #region Fields
        public static readonly int WIDTH = 256;

        private int _displaySmoothedGesture = 0;

        private Texture _mainGestureTexture = null;
        private Texture _secondaryGestureTexture = null;
        #endregion

        #region Properties
        public Texture MainGestureTexture
        {
            get
            {
                if (_mainGestureTexture == null)
                {
                    _mainGestureTexture = GestureTextureGenerator.GenerateTexture(_mainGesture, WIDTH, WIDTH);
                }

                return _mainGestureTexture;
            }
        }

        public Texture SecondaryGestureTexture
        {
            get
            {
                if (_secondaryGestureTexture == null)
                {
                    if (_smoothedGestures.Count > 0 && _displaySmoothedGesture >= 0 && _displaySmoothedGesture < _smoothedGestures.Count)
                    {
                        _secondaryGestureTexture = GestureTextureGenerator.GenerateTexture(_smoothedGestures[_displaySmoothedGesture].orientations, WIDTH, WIDTH);
                    }
                }

                return _secondaryGestureTexture;
            }
        }

        public int DisplaySmoothedGesture
        {
            get
            {
                return _displaySmoothedGesture;
            }

            set
            {
                _displaySmoothedGesture = value;
                OnValidate(); // update texture
            }
        }
        #endregion

        #region Methods
        public void Init(Orientation[] directions)
        {
            _mainGesture = directions;
            _smoothedGestures = new List<MDOrientationArray>();
        }

        public static Gesture CreateInstance(Orientation[] directions)
        {
            var data = CreateInstance<Gesture>();

            data.Init(directions);

            return data;
        }

        public void SmoothGesture()
        {
            _smoothedGestures = new List<MDOrientationArray>();

            var smoothedGestures = GestureSmoother.SmoothGesture(_mainGesture).ToArray();

            foreach (var smoothedGesture in smoothedGestures)
            {
                _smoothedGestures.Add(new MDOrientationArray(smoothedGesture));
            }
        }

        void OnValidate()
        {
            _mainGestureTexture = GestureTextureGenerator.GenerateTexture(_mainGesture, WIDTH, WIDTH);

            if (_smoothedGestures.Count > 0 && _displaySmoothedGesture >= 0 && _displaySmoothedGesture < _smoothedGestures.Count)
            {
                _secondaryGestureTexture = GestureTextureGenerator.GenerateTexture(_smoothedGestures[_displaySmoothedGesture].orientations, WIDTH, WIDTH);
            }
        }
        #endregion
#endif
    }
}
