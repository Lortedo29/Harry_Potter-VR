using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeclanchementHorloge : MonoBehaviour {

    private void OnTriggerEnter(Collider other)
    {
        Horloge._declanchementAtelier = true;
    }
}

