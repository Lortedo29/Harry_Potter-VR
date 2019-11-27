using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace HarryPotterVR.Debug
{
    /// <summary>
    /// Spawn box w/ gravity. Reset it position if it go below -5 on y;
    /// </summary>
    public class BoxDropper : MonoBehaviour
    {
        [SerializeField] private Transform _box;
        [SerializeField] private float _yThresholdToResetPosition = -5f;

        private Vector3 _startingPosition;

        private void Start()
        {
            _startingPosition = _box.position;
        }

        void Update()
        {
            if (_box.position.y <= _startingPosition.y + _yThresholdToResetPosition)
            {
                ResetBoxPosition();
            }
        }

        void ResetBoxPosition()
        {
            _box.GetComponent<Rigidbody>().velocity = Vector3.zero;
            _box.position = _startingPosition;
        }
    }
}

