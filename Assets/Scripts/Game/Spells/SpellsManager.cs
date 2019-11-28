using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Managers;
using Utils.Pattern;
using VRTK;

public class SpellsManager : Singleton<SpellsManager>
{
    [Header("Spell Freezer")]
    [SerializeField] private float _freezeTime = 3f;
    [Header("Spell Pushing")]
    [SerializeField] private float _pushForce = 30f;
    [Header("Spell Leviation")]
    [SerializeField] private SpellLevitation _spellLevitation;

    public SpellLevitation SpellLevitation
    {
        get
        {
            return _spellLevitation;
        }
    }

    public void UseSpell(SpellType? spellType, MagicInteractable target)
    {
        if (spellType == null)
        {
            Debug.LogWarning("Unrecognized spellType");
        }
        else
        {
            UseSpell((SpellType)spellType, target);
        }
    }

    public void UseSpell(SpellType spellType, MagicInteractable target)
    {
        TargetSpellType? targetSpellType = spellType.ToTargetSpellType();

        // do spellType is a targetSpellType & 
        if (targetSpellType != null)
        {
            // do we have a target ?
            if (target == null)
            {
                Debug.LogWarning("No target selected");
                return;
            }

            // is spell not deactivated on target
            if (target.IsSpellDeactivated((TargetSpellType)targetSpellType))
                return;
        }

        WandFeedback.Instance.PlaySpellFX(spellType);

        switch (spellType)
        {
            case SpellType.Levitation:
                _spellLevitation.SetTarget(target.transform);
                break;

            case SpellType.Pushing:
                target.Push(_pushForce);
                break;

            case SpellType.Freezer:
                target.Freeze(_freezeTime);
                break;

            case SpellType.SceneReload:
                ReloadWithFade();
                break;
        }

        // manage haptics
        if (spellType == SpellType.Freezer || spellType == SpellType.Pushing)
        {
            if (Wand.Instance.ControllerGrabbing == null)
                return;

            var controllerReference = VRTK_ControllerReference.GetControllerReference(Wand.Instance.ControllerGrabbing.gameObject);
            VRTK_ControllerHaptics.TriggerHapticPulse(controllerReference, 1);
        }
    }

    public void UseSpell(SpellType spellType)
    {
        TargetSpellType? targetSpellType = spellType.ToTargetSpellType();

        if (targetSpellType != null)
        {
            Debug.LogWarningFormat("{0} is a targetSpellType. We can't UseSpell w/out target.");
            return;
        }

        switch (spellType)
        {
            // target spell type
            case SpellType.Levitation:
            case SpellType.Pushing:
            case SpellType.Freezer:
                break;

            case SpellType.SceneReload:
                ReloadWithFade();
                break;
        }
    }

    void ReloadWithFade()
    {
        ScreenFade.Instance.Fade(Portal.FADE_TIME);

        DontDestroyObject.Instance.ExecuteAfterTime(Portal.FADE_TIME, () =>
        {
            SceneManager.ReloadSceneAsync();
        });
    }
}
