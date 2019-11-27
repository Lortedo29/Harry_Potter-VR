using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils;
using VRTK;

public class Card : MonoBehaviour
{
    #region Fields
    public readonly static int PROPERTY_ID_STEP_VALUE = Shader.PropertyToID("_StepValue");
    public readonly static float DISOLVE_TIME = 0.8f;

    private Coroutine _dissolveCoroutine;

    // cache variables
    private VRTK_InteractableObject _interactableObject;
    private Rigidbody _rigidbody;
    private MeshRenderer _meshRenderer;
    private ParticleSystem _particleSystem;
    #endregion

    #region Properties
    public VRTK_InteractableObject InteractableObject
    {
        get
        {
            return _interactableObject;
        }
    }

    public Rigidbody Rigidbody
    {
        get
        {
            return _rigidbody;
        }
    }

    public ParticleSystem ParticleSystem
    {
        get
        {
            return _particleSystem;
        }
    }
    #endregion

    #region Methods
    void Awake()
    {
        _interactableObject = GetComponent<VRTK_InteractableObject>();
        _rigidbody = GetComponent<Rigidbody>();
        _meshRenderer = GetComponentInChildren<MeshRenderer>();
        _particleSystem = _meshRenderer.GetComponentInChildren<ParticleSystem>();
    }

    void Start()
    {
        _interactableObject.InteractableObjectUngrabbed += (object sender, InteractableObjectEventArgs e) =>
        {
            transform.parent = null;
            _rigidbody.isKinematic = false;
        };
    }

    public void ActiveCard(bool active)
    {
        // do _meshRenderer exist and has property ?
        if (_meshRenderer == null || _meshRenderer.material.HasProperty(PROPERTY_ID_STEP_VALUE) == false)
            return;

        // stop dissolve coroutine
        if (_dissolveCoroutine != null)
        {
            StopCoroutine(_dissolveCoroutine);
        }

        _dissolveCoroutine = new Timer(this, DISOLVE_TIME, (float completion) =>
        {
            if (active == false) completion = 1 - completion;

            _meshRenderer.material.SetFloat(PROPERTY_ID_STEP_VALUE, completion);
        }).Coroutine;
    }
    #endregion
}
