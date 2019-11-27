using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Inspector;
using VRTK;

namespace HarryPotterVR.Debug
{
    public class SpellsWithKeyboard : MonoBehaviour
    {
        [SerializeField, EnumNamedArray(typeof(SpellType))] private KeyCode[] _spellsKeyCodes = new KeyCode[3];

#if UNITY_EDITOR
        void Update()
        {
            if (VRTK_SDKManager.instance.loadedSetup == null)
                return;

            if (VRTK_SDKManager.instance.loadedSetup.name != "VRSimulator")
                return;

            // check for spells use
            for (int i = 0; i < _spellsKeyCodes.Length; i++)
            {
                var keycode = _spellsKeyCodes[i];

                if (Input.GetKeyDown(keycode))
                {
                    var spellType = (SpellType)i;
                    var target = GetAimedMagicInteractable();

                    SpellsManager.Instance.UseSpell(spellType, target);

                    if (spellType == SpellType.Levitation)
                    {
                        Wand.Instance.SpellTarget = target;
                    }
                }
            }

            // check for Leviatation release
            KeyCode keycodeLevitation = _spellsKeyCodes[(int)SpellType.Levitation];

            if (Input.GetKeyUp(keycodeLevitation))
            {
                Wand.Instance.SpellTarget = null;

                SpellsManager.Instance.SpellLevitation.ReleaseTarget();
            }
        }

        public static MagicInteractable GetAimedMagicInteractable()
        {
            Ray ray = Camera.main.ViewportPointToRay(new Vector3(0.5f, 0.5f));
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit, Wand.Instance.MaxSpellDistance))
            {
                return hit.transform.GetComponent<MagicInteractable>();
            }

            return null;
        }

        void OnGUI()
        {
            // draw "crosshair"
            Rect centerRect = new Rect
            {
                position = new Vector2(Screen.width, Screen.height) / 2,
                size = new Vector2(100, 100)
            };

            GUI.Label(centerRect, "X");
        }
#endif
    }
}
