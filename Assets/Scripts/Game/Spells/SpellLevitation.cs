using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils;
using Utils.Pattern;
using VRTK;

/// <summary>
/// Set the parent of the target we want to move.
/// Then the parent follow w/ smooth the _hardPosition field.
/// Hard field is a child of the wand. So it follow it rotation and position
/// </summary>
public class SpellLevitation : Singleton<SpellLevitation>
{
    #region Fields
    public readonly static float THRESHOLD_ADD_FORCE = 0.1f;
    public readonly static float THRESHOLD_DISTANCE_HAPTIC_EMIT = 0.1f;

    [SerializeField] private Bounds2D _boundsZDistance = new Bounds2D(2f, 10f);
    [SerializeField] private float _speedOnZAxis = 2f;

    private Transform _parentTarget;
    private Transform _hardPosition;

    private Transform _target;
    private Rigidbody _targetRigidbody;

    private Vector3 _hapticsLastPosition;

#if UNITY_EDITOR
    private float _distanceHardPosition = 0; // between hitPosition & camera
#endif
    #endregion

    #region Methods
    #region Mono Callbacks
    void Start()
    {
        // create hardPosition and smoothFollow gameObjects
        _hardPosition = new GameObject().transform;
        _hardPosition.parent = Wand.Instance.transform;
        _hardPosition.localPosition = Vector3.up;
        _hardPosition.name = "[AUTOGEN] Levitation - Hard Position";

        _parentTarget = new GameObject().transform;
        var smoothFollow = _parentTarget.gameObject.AddComponent<SmoothFollow>();
        smoothFollow.target = _hardPosition;
        smoothFollow.speed = 0.02f;
        smoothFollow.name = "[AUTOGEN] Levitation - Smooth Follow";
    }

    void Update()
    {
        if (_target == null)
        {
            ReleaseChildren();
        }
        else
        {
            ManageHaptics();
            ManageTranslationZ();
            ManageRelease();

#if UNITY_EDITOR
            SetHardPosition();
#endif
        }
    }

    void FixedUpdate()
    {
        AssureTargetLocalPosition();
    }

    void OnDisable()
    {
        ReleaseTarget();
        ReleaseChildren();
    }
    #endregion

    #region Public Methods
    public void SetTarget(RaycastHit hit)
    {
        SetTarget(hit.transform, hit.point);
    }

    public void SetTarget(Transform target)
    {
        SetTarget(target, target.transform.position);
    }

    public void ReleaseTarget()
    {
        if (_target == null)
        {
            Debug.LogWarning("Can't release a NULL target.");
            return;
        }

        // release target
        ManagerAudio.Instance.StopSound();
        _target.transform.SetParent(null);
        _targetRigidbody.useGravity = true;
        _targetRigidbody.velocity = Vector3.zero;

        _target.GetComponent<MagicInteractable>().IsLevitating = false;

        WandFeedback.Instance.StopSpellFX(SpellType.Levitation);

        _target = null;
        _targetRigidbody = null;
    }
    #endregion

    #region Private Methods
    void ManageHaptics()
    {
		if (Wand.Instance.ControllerGrabbing == null)
			return;
		
        if (Vector3.Distance(_hapticsLastPosition, _parentTarget.position) >= THRESHOLD_DISTANCE_HAPTIC_EMIT)
        {
            var controllerReference = VRTK_ControllerReference.GetControllerReference(Wand.Instance.ControllerGrabbing.gameObject);
            VRTK_ControllerHaptics.TriggerHapticPulse(controllerReference, 0.3f);

            _hapticsLastPosition = _parentTarget.position;
        }
    }

    void ManageRelease()
    {
#if UNITY_EDITOR
        // prevent release if we are controlling w/ keyboard
        if (VRTK_SDKManager.instance.loadedSetup.name == "VRSimulator")
            return;
#endif

        if (Wand.Instance.ControllerGrabbing == null || Wand.Instance.ControllerGrabbing.triggerPressed)
        {
            ReleaseTarget();
        }
    }

    void SetTarget(Transform target, Vector3 hitPosition)
    {
        // set target
        _target = target.transform;
        _targetRigidbody = _target.GetComponent<Rigidbody>();
        _targetRigidbody.useGravity = false;

        ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.Levitation);
        var interactebleObject = _target.GetComponent<VRTK_InteractableObject>();
        if (interactebleObject != null)
        {
            interactebleObject.InteractableObjectGrabbed += (object sender, InteractableObjectEventArgs e) => ReleaseTarget();
        }

        _target.GetComponent<MagicInteractable>().IsLevitating = true;

        // update position
        _hardPosition.position = hitPosition;
        _parentTarget.position = hitPosition;

#if UNITY_EDITOR
        _distanceHardPosition = Vector3.Distance(Camera.main.transform.position, hitPosition);
#endif

        _target.transform.SetParent(_parentTarget);
    }

    void ManageTranslationZ()
    {
        if (Wand.Instance.ControllerGrabbing == null)
            return;

        float yPositionHardPosition = _hardPosition.localPosition.y;

        // get angle of controller 
        float angle = Mathf.Abs(Wand.Instance.ControllerGrabbing.transform.eulerAngles.z) - 180;

        if (angle >= 0 && angle <= 110f) // go forward
        {
            yPositionHardPosition += _speedOnZAxis * Time.deltaTime;
        }
        else if (angle <= 0 && angle >= -140f) // go backward
        {
            yPositionHardPosition -= _speedOnZAxis * Time.deltaTime;
        }

        // clamp position and set position
        yPositionHardPosition = _boundsZDistance.Clamp(yPositionHardPosition);
        _hardPosition.localPosition = Vector3.up * yPositionHardPosition;
    }

    /// <summary>
    /// Set children's parent to null.
    /// </summary>
    void ReleaseChildren()
    {
        _parentTarget.ActionForEachChildren((GameObject child) => child.transform.parent = null);
    }

    /// <summary>
    /// Avoid target to have a local position different of zero
    /// </summary>
    void AssureTargetLocalPosition()
    {
        if (_target == null)
            return;

        Vector3 deltaDirection = Vector3.zero - _target.localPosition;

        if (_target.localPosition.magnitude >= THRESHOLD_ADD_FORCE)
        {
            // try to set local position to zero
            _targetRigidbody.AddForce(Vector3.Lerp(Vector3.zero, -_target.localPosition, 1f), ForceMode.Acceleration);
        }
        else
        {
            // the local position don't need to be set to zero
            _targetRigidbody.velocity = Vector3.zero;
        }
    }
    #endregion

#if UNITY_EDITOR
    #region Editor ONLY Methods
    private void SetHardPosition()
    {
        if (VRTK_SDKManager.instance.loadedSetup.name != "VRSimulator")
            return;

        Vector3 direction = Camera.main.transform.forward;
        _hardPosition.position = Wand.Instance.transform.position + direction * _distanceHardPosition;
    }
    #endregion
#endif
    #endregion
}

