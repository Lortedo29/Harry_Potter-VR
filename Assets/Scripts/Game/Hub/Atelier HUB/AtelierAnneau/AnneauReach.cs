using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnneauReach : MonoBehaviour {

    [SerializeField] private GameObject _plume;
    [SerializeField] private AudioClip _reachAnneau;

    private void OnTriggerEnter(Collider other)
    {
        var _plumeCollider = _plume.GetComponent<Collider>();
        var _otherCollider =  other.GetComponent<Collider>();
        if(_plumeCollider == _otherCollider)
        {
            AnneauAtelierTravel.Instance.TraverseAnneau();
            ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.AnneauReach);
        }
    }
}
