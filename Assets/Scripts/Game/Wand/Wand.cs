using GesturesRecognition;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Inspector;
using Utils.Pattern;
using VRTK;

public class Wand : Singleton<Wand>
{
    #region Fields
    [Tooltip("Time to respawn wand on belt, after it's been ungrabbed.")]
    [SerializeField] private float _respawnTime = 3;
    [SerializeField] private float _maxSpellDistance = 8f;

    private VRTK_ControllerEvents _controllerGrabbing;
    private MagicInteractable _spellTarget = null;

    private float _timeSinceReleased = 0;
    private bool _hasBeenReleased = false;
    private bool _triggerPressedLastFrame = false;

    private Vector3 _originPosition;
    private Quaternion _originRotation;

    private Transform _gestureRecordTransform; // transform that'll be used to record gesture

    // cache variable
    private Rigidbody _rigidbody;
    #endregion

    #region Properties
    public VRTK_ControllerEvents ControllerGrabbing
    {
        get
        {
            return _controllerGrabbing;
        }
    }

    public bool IsHold
    {
        get
        {
            return _controllerGrabbing != null;
        }
    }

    public float MaxSpellDistance
    {
        get
        {
            return _maxSpellDistance;
        }
    }

    public MagicInteractable SpellTarget
    {
        get
        {
            return _spellTarget;
        }
      
        set
        {
            _spellTarget = value;
        }
    }
    #endregion

    #region Methods
    #region Mono Callbacks
    void Awake()
    {
        _rigidbody = GetComponent<Rigidbody>();
        _rigidbody.isKinematic = true;
    }

    void Start()
    {
        _gestureRecordTransform = new GameObject().transform;
        _gestureRecordTransform.parent = transform;
        _gestureRecordTransform.name = "[AUTOGEN] Gesture Record Transform";
        _gestureRecordTransform.localPosition = Vector3.up;

        // register events
        var interactableObject = GetComponent<VRTK_InteractableObject>();

        interactableObject.InteractableObjectGrabbed += OnWandGrabbed;
        interactableObject.InteractableObjectUngrabbed += OnWandUngrabbed;

        StartCoroutine(LateStart());
    }

    IEnumerator LateStart()
    {
        yield return new WaitForEndOfFrame();

        // set parent to headset
        _originPosition = transform.position;
        _originRotation = transform.rotation;
    }

    void Update()
    {
        CheckForRespawn();
        ManageGestureRecording();
    }
    #endregion

    #region InteractableObject Events
    void OnWandGrabbed(object sender, InteractableObjectEventArgs e)
    {
        _controllerGrabbing = e.interactingObject.GetComponent<VRTK_ControllerEvents>();

        _timeSinceReleased = 0;
        _hasBeenReleased = false;
    }

    void OnWandUngrabbed(object sender, InteractableObjectEventArgs e)
    {
        _controllerGrabbing = null;

        // set parent & update rigidbody
        _timeSinceReleased = 0;
        _hasBeenReleased = true;
        _rigidbody.isKinematic = false;

        transform.parent = null;

        _triggerPressedLastFrame = false;
        _spellTarget = null;

        WandFeedback.Instance.StopAllSpellsFX();
        SpellLevitation.Instance.ReleaseTarget();
    }
    #endregion

    #region Public methods
    public MagicInteractable GetMagicInteractableFromWand()
    {
        Ray ray = new Ray(transform.position, transform.up);
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit, MaxSpellDistance))
        {
            return hit.transform.GetComponent<MagicInteractable>();
        }

        return null;
    }
    #endregion

    #region Private methods
    #region Gestures & Spells
    void ManageGestureRecording()
    {
        if (_controllerGrabbing == null)
            return;

        // trigger has just be pressed
        if (_controllerGrabbing.triggerPressed && !_triggerPressedLastFrame)
        {
            StartSpell();
        }

        // trigger has just be released
        if (!_controllerGrabbing.triggerPressed && _triggerPressedLastFrame)
        {
            StopSpell();
        }

        _triggerPressedLastFrame = _controllerGrabbing.triggerPressed;
    }

    void StartSpell()
    {
        Transform headset = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.Headset);
        GestureRecorder.Instance.StartRecord(_gestureRecordTransform, headset);

        WandFeedback.Instance.PlayGeneralFX();
        SpellLevitation.Instance.ReleaseTarget();

        _spellTarget = GetMagicInteractableFromWand();
    }

    void StopSpell()
    {
        var gesture = GestureRecorder.Instance.StopRecord();
        var spellType = GesturesComparer.Instance.CompareGesture(gesture);

        WandFeedback.Instance.StopGeneralFX();

        SpellsManager.Instance.UseSpell(spellType, _spellTarget);

        Debug.Log("Player invoke a spell of " + spellType + " w/ gesture " + gesture.ToDebugLog());
    }
    #endregion

    #region Belt respawn Methods
    void CheckForRespawn()
    {
        if (_hasBeenReleased)
        {
            _timeSinceReleased += Time.deltaTime;

            if (_timeSinceReleased >= _respawnTime)
            {
                Respawn();
            }
        }
    }

    void Respawn()
    {
        _hasBeenReleased = false;

        // set parent & update rigidbody
        transform.parent = null;
        _rigidbody.isKinematic = true;

        transform.localPosition = _originPosition;
        transform.rotation = _originRotation;
    }
    #endregion
    #endregion
    #endregion
}
