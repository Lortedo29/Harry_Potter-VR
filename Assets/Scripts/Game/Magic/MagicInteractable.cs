using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils;
using Utils.Inspector;
using Utils.Pattern;
using VRTK;
using VRTK.Highlighters;


public delegate void OnFreeze(MagicInteractable sender);
public delegate void OnPush(MagicInteractable sender);
public delegate void OnStartLevitate(MagicInteractable sender);
public delegate void OnStopLevitate(MagicInteractable sender);

/// <summary>
/// Needed to use this gameObject w/ magic.
/// </summary>
public class MagicInteractable : MonoBehaviour
{
    #region Fields
    #region Static Readonly
    public readonly static int PROPERTY_ID_FRESNEL_ACTIVATION = Shader.PropertyToID("_FresnelActivation");
    public readonly static int PROPERTY_ID_FRESNEL_COLOR_ONE = Shader.PropertyToID("_FresnelColor1");
    public readonly static int PROPERTY_ID_FRESNEL_COLOR_TWO = Shader.PropertyToID("_FresnelColor2");

    public readonly static Color FREEZE_COLOR_ONE = "3993FF".HexToColor();
    public readonly static Color FREEZE_COLOR_TWO = "6139FF".HexToColor();
    public readonly static Color LEVITATION_COLOR_ONE = "FF9F2D".HexToColor();
    public readonly static Color LEVITATION_COLOR_TWO = "FF7C1C".HexToColor();
    public readonly static Color PUSH_COLOR_ONE = "3F073F".HexToColor();
    public readonly static Color PUSH_COLOR_TWO = "E51B36".HexToColor();

    public readonly static float PUSH_DELAY = 0.4f;

    public readonly static float FRESNEL_ACTIVATION_LERP_TIME = 0.1f; // we don't set it as SerializedField to don't allow different lerp time
    #endregion

    public OnFreeze OnFreeze;
    public OnPush OnPush;
    public OnStartLevitate OnStartLevitate;
    public OnStopLevitate OnStopLevitate;

    [SerializeField, EnumFlag] private TargetSpellType _deactivatedSpells = 0;

    private Coroutine _lerpCoroutine;

    private bool _isLevitating = false;
    private bool _isFreezed = false;

    private Transform _levitationFx;

    // cache variable
    private Rigidbody _rigidbody;
    private MeshRenderer _meshRenderer;
    private VRTK_InteractableObject _interactableObject;
    #endregion

    #region Properties
    public Rigidbody Rigidbody
    {
        get
        {
            return _rigidbody;
        }
    }

    public bool IsLevitating
    {
        get
        {
            return _isLevitating;
        }

        set
        {
            _isLevitating = value;

            // set fresnel color
            if (_isLevitating)
            {
                SetFresnelColor(SpellType.Levitation);

                _levitationFx = ObjectPooler.Instance.SpawnFromPool("FX_Levitation_Object", transform.position, transform.rotation).transform;
                _levitationFx.parent = transform;

                _rigidbody.collisionDetectionMode = CollisionDetectionMode.Continuous;

                OnStartLevitate?.Invoke(this);
            }
            else
            {
                _rigidbody.collisionDetectionMode = CollisionDetectionMode.Discrete;
                SetFresnelColorToDefault();

                if (_levitationFx != null)
                {
                    ObjectPooler.Instance.EnqueueGameObject("FX_Levitation_Object", _levitationFx.gameObject);
                }
                OnStopLevitate?.Invoke(this);
            }
        }
    }

    public bool IsFreezed
    {
        get
        {
            return _isFreezed;
        }
    }
    #endregion

    #region Methods
    #region Mono Callbacks
    void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
        _meshRenderer = GetComponent<MeshRenderer>();
        _interactableObject = GetComponent<VRTK_InteractableObject>();

        //Debug.Log("coucou"); // jeff

        SetFresnelColorToDefault();
        ActiveFresnel(false);
    }
    #endregion

    #region Public methods
    public bool IsSpellDeactivated(TargetSpellType spellType)
    {
        // is part of deactivate spells ?
        bool isDeactivatedSpell = _deactivatedSpells.HasFlag(spellType);

        if (isDeactivatedSpell)
        {
            Debug.LogFormat("{0} is deactivated on {1}", spellType, name);
        }

        return isDeactivatedSpell;
    }

    public void ActiveFresnel(bool active)
    {
        // disable fresnel deactivation if isFreezing
        if (_isFreezed)
            return;

        if (_meshRenderer == null)
            return;

        if (_meshRenderer.material.HasProperty(PROPERTY_ID_FRESNEL_ACTIVATION))
        {
            float targetFresnelValue = active ? 1 : 0;
            float currentFresnelValue = _meshRenderer.material.GetFloat(PROPERTY_ID_FRESNEL_ACTIVATION);

            float difference = targetFresnelValue - currentFresnelValue;
            float lerpTimeDifference = Mathf.Abs(difference * FRESNEL_ACTIVATION_LERP_TIME);

            try
            {
                if (_lerpCoroutine != null) StopCoroutine(_lerpCoroutine);
            }
            catch
            {

            }

            _lerpCoroutine = new Timer(this, lerpTimeDifference, (float completion) =>
            {
                float fresnelValue = currentFresnelValue + difference * completion;
                _meshRenderer.material.SetFloat(PROPERTY_ID_FRESNEL_ACTIVATION, fresnelValue);
            }).Coroutine;
        }
    }

    public void Freeze(float freezeTime)
    {
        // avoid freezing the item multiple time
        if (_isFreezed)
            return;


        OnFreeze?.Invoke(this);

        _isFreezed = true;

        _rigidbody.isKinematic = true;

        ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.Freez);

        ActiveFresnel(true);
        SetFresnelColor(SpellType.Freezer);

        var fx = ObjectPooler.Instance.SpawnFromPool("FX_Freeze_Object", transform.position, transform.rotation).transform;
        fx.parent = transform;

        this.ExecuteAfterTime(freezeTime, Unfreeze);
    }

    public void Push(float pushForce)
    {
        // if we have an interactable object, check if he's not grabbed
        if (GetComponent<VRTK_InteractableObject>() != null && GetComponent<VRTK_InteractableObject>().IsGrabbed())
            return;

        OnPush?.Invoke(this);

        var fx = ObjectPooler.Instance.SpawnFromPool("FX_Push_Object", transform.position, transform.rotation).transform;
        fx.parent = transform;

        SetFresnelColor(SpellType.Pushing);

        _rigidbody.collisionDetectionMode = CollisionDetectionMode.Continuous;

        ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.Push);
        this.ExecuteAfterTime(PUSH_DELAY, () =>
        {
            Vector3 direction = transform.position - Wand.Instance.transform.position;

            _rigidbody.isKinematic = false;
            _rigidbody.AddForce(direction * pushForce, ForceMode.VelocityChange);

            this.ExecuteAfterTime(PUSH_DELAY, SetFresnelColorToDefault);
        });
    }
    #endregion

    #region Private methods
    #region Fresnel colors methods
    void SetFresnelColor(SpellType spellType)
    {
        switch (spellType)
        {
            case SpellType.Levitation:
                SetFresnelColor(LEVITATION_COLOR_ONE, LEVITATION_COLOR_TWO);
                break;

            case SpellType.Pushing:
                SetFresnelColor(PUSH_COLOR_ONE, PUSH_COLOR_TWO);
                break;

            case SpellType.Freezer:
                SetFresnelColor(FREEZE_COLOR_ONE, FREEZE_COLOR_TWO);
                break;
        }
    }

    void SetFresnelColorToDefault()
    {
        SetFresnelColor(Color.white, Color.white);
    }

    void SetFresnelColor(Color mainColor, Color secondaryColor)
    {
        if (_meshRenderer == null)
            return;

        if (_meshRenderer.material.HasProperty(PROPERTY_ID_FRESNEL_COLOR_ONE))
        {
            _meshRenderer.material.SetColor(PROPERTY_ID_FRESNEL_COLOR_ONE, mainColor);
        }

        if (_meshRenderer.material.HasProperty(PROPERTY_ID_FRESNEL_COLOR_TWO))
        {
            _meshRenderer.material.SetColor(PROPERTY_ID_FRESNEL_COLOR_TWO, secondaryColor);
        }
    }
    #endregion

    void Unfreeze()
    {
        _isFreezed = false;

        _rigidbody.isKinematic = false;

        SetFresnelColorToDefault();

        // if the player don't aim the current magicInteracteble
        // disable fresnel
        if (Wand.Instance.GetMagicInteractableFromWand() != this)
        {
            ActiveFresnel(false);
        }
    }
    #endregion
    #endregion
}
