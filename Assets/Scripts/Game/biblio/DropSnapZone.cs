using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DropSnapZone : MonoBehaviour {


    [SerializeField] private GameObject _myBook;
    [SerializeField] private Transform _posSnapObject;
    private Collider _myBookCollider;

    private void Awake()
    {
        _myBookCollider = _myBook.GetComponent<Collider>();
    }
    private void OnTriggerEnter(Collider other)
    {
        var _myRbBook = _myBook.GetComponent<Rigidbody>();
        var _myCollider = other.GetComponent<Collider>();

        if (_myCollider == _myBookCollider)
        {
            AllCubeInPosition._bookInBiblioNumber += 1;
            _myBook.transform.position = _posSnapObject.transform.position;
            _myBook.transform.rotation = _posSnapObject.transform.rotation;
            _myRbBook.isKinematic = true;

            SpellLevitation.Instance.ReleaseTarget();
           Destroy( _myBook.GetComponent<MagicInteractable>());
        }
    }
}
