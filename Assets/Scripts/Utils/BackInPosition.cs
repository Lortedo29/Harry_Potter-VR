using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BackInPosition : MonoBehaviour
{
    [SerializeField] private float _timerBeforeBackInPosition;
    [SerializeField] private Transform _PosBase;

	

	void Update ()
    {
        


        if (gameObject.transform.position != _PosBase.position)
        {
            _timerBeforeBackInPosition -= Time.deltaTime;

            if (_timerBeforeBackInPosition <= 0)
            {
                _timerBeforeBackInPosition = 2f;
                gameObject.transform.position = _PosBase.position;
                gameObject.transform.rotation = _PosBase.rotation;
             var rb =  gameObject.GetComponent<Rigidbody>();
             rb.velocity = Vector3.zero;
             rb.angularVelocity = Vector3.zero;
            }
        }
	}
}
