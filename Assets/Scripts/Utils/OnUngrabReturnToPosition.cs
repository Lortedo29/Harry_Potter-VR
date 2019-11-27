using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils;
using VRTK;

/// <summary>
/// When VRTK_InteractableObject is ungrabbed, the game object return to it original position.
/// </summary>
public class OnUngrabReturnToPosition : MonoBehaviour
{
    #region Fields
    [SerializeField] private VRTK_InteractableObject _grappableItem;
    [SerializeField] private float _returnTime = 1f;

    private Vector3 _positionOrigin;

    private Vector3 _positionBeforeReturn;
    private Vector3 _velocity = Vector3.zero;
    #endregion

    #region Methods
    #region Mono Callbacks
    void Awake()
    {
        _positionOrigin = transform.position;

        if (_grappableItem == null)
        {
            _grappableItem = GetComponent<VRTK_InteractableObject>();
        }
    }

    void Start()
    {
        _grappableItem.InteractableObjectUngrabbed +=
            (object sender, InteractableObjectEventArgs e) => UpdateReturnFields();
    }

    void Update()
    {
        if (_grappableItem.IsGrabbed() == false)
        {
            transform.position = Vector3.SmoothDamp(transform.position, _positionOrigin, ref _velocity, _returnTime);
        }
    }
    #endregion

    #region 
    void UpdateReturnFields()
    {
        _positionBeforeReturn = transform.position;
        _velocity = Vector3.zero;
    }
    #endregion
    #endregion
}
