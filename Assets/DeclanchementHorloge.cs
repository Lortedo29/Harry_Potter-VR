using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeclanchementHorloge : MonoBehaviour {

    [SerializeField] private GameObject _wand;

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log(other);
        if(other.gameObject != _wand)
        {
        Horloge._declanchementAtelier = true;

        }

        
    }
}

