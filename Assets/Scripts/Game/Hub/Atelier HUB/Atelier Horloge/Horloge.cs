using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Horloge : MonoBehaviour
{
    [SerializeField] private GameObject _grosseAiguille, _petiteAiguille;
    private bool _declanchementAtelier = false;
    private bool _petiteAiguilleRotate = false;
    [SerializeField] private float _needleSpeed = 1f;

	
	void Update ()
    {
        if (Input.GetKeyDown(KeyCode.A))
        {
            _declanchementAtelier = true;
        }
		if(_declanchementAtelier == true)
        {
            _declanchementAtelier = false;
            _petiteAiguilleRotate = true;
            _grosseAiguille.transform.Rotate(0, 0, Random.Range(0, 360));

        }
        if(_petiteAiguilleRotate == true)
        {
            _petiteAiguille.transform.Rotate(0, 0, _needleSpeed);
        }

        if(_petiteAiguille.GetComponent<MagicInteractable>().IsFreezed == true)
        {
            _needleSpeed = 0f;
        }
        else
        {
            _needleSpeed = 0.3f;
        }
	}
    private void OnTriggerStay(Collider other)
    {
        if (other.gameObject == _petiteAiguille && _petiteAiguille.GetComponent<MagicInteractable>().IsFreezed == true)
        {
            _declanchementAtelier = false;
            _petiteAiguilleRotate = false;
        }
    }
}
