using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AllCubeInPosition : MonoBehaviour {

    public static int _bookInBiblioNumber;
    [SerializeField] private GameObject _myOrb; 


    private void Update()
    {
        if(_bookInBiblioNumber >= 5)
        {
            ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.WinSound);
        }
    }
}
