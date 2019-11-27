using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnneauReachExperliamus : MonoBehaviour {

    [SerializeField] private GameObject _plume;

    private void OnTriggerEnter(Collider other)
    {
        var _plumeCollider = _plume.GetComponent<Collider>();
        var _otherCollider = other.GetComponent<Collider>();
        if (_plumeCollider == _otherCollider)
        {
            Expelliarmus._numberAnneauReach += 1;
        }
    }
}
