using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnableOnLateStart : MonoBehaviour
{

    [SerializeField] private GameObject[] _gameObjectToEnabled;

    void Start()
    {
        StartCoroutine("LateStart");
    }

    IEnumerator LateStart()
    {
        yield return new WaitForEndOfFrame();

        for (int i = 0; i < _gameObjectToEnabled.Length; i++)
        {
            _gameObjectToEnabled[i].SetActive(true);
        }
    }
}
