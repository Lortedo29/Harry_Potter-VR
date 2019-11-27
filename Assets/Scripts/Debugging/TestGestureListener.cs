using GesturesRecognition;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace HarryPotterVR.Tests
{
    public class TestGestureListener : MonoBehaviour
    {
        [SerializeField] private bool _debugLogGesture = false;

        void Update()
        {
            Vector3 pos = Input.mousePosition;
            pos.z = transform.position.z - Camera.main.transform.position.z;
            transform.position = Camera.main.ScreenToWorldPoint(pos);

            if (Input.GetMouseButtonDown(0))
            {
                GestureRecorder.Instance.StartRecord(transform);
            }

            if (Input.GetMouseButtonUp(0))
            {
                var gesture = GestureRecorder.Instance.StopRecord();

                if (_debugLogGesture)
                {
                    UnityEngine.Debug.Log(gesture);
                }

                var spellType = GesturesComparer.Instance.CompareGesture(gesture);

                UnityEngine.Debug.Log("Spell is " + spellType);
            }
        }
    }
}