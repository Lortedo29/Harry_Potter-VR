using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SmoothFollow : MonoBehaviour {

    public Transform target;
    public float speed = 2f;

	void Update ()
    {
        transform.position = Vector3.Lerp(gameObject.transform.position, target.position, speed);
    }
}
