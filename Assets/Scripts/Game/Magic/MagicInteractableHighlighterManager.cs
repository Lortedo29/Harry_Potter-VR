using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class MagicInteractableHighlighterManager : MonoBehaviour
{
    private MagicInteractable _selectedMagicInteractable = null;

    void Update()
    {
        // get magic interactable
        MagicInteractable hitMagicInteractable = GetHitMagicInteratable();

        if (hitMagicInteractable != _selectedMagicInteractable)
        {
            SwitchSelectedMagicInteractable(hitMagicInteractable);
        }
    }

    MagicInteractable GetHitMagicInteratable()
    {
#if UNITY_EDITOR
        if (VRTK_SDKManager.instance.loadedSetup != null && VRTK_SDKManager.instance.loadedSetup.name != "VRSimulator")
        {
            if (!Wand.Instance.IsHold)
                return null;
        }
#else
        if (!Wand.Instance.IsHold)
                return null;
#endif

        if (Wand.Instance.SpellTarget != null)
        {
            return Wand.Instance.SpellTarget;
        }

#if UNITY_EDITOR
        if (VRTK_SDKManager.instance.loadedSetup != null && VRTK_SDKManager.instance.loadedSetup.name == "VRSimulator")
        {
            return HarryPotterVR.Debug.SpellsWithKeyboard.GetAimedMagicInteractable();
        }
#endif

        return Wand.Instance.GetMagicInteractableFromWand();
    }


    void SwitchSelectedMagicInteractable(MagicInteractable newSelectedMagicInteractable)
    {
        _selectedMagicInteractable?.ActiveFresnel(false);
        newSelectedMagicInteractable?.ActiveFresnel(true);

        _selectedMagicInteractable = newSelectedMagicInteractable;
    }
}
