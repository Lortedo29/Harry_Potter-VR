using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Inspector;
using Utils.Pattern;

public class WandFeedback : Singleton<WandFeedback>
{
    [SerializeField] private ParticleSystem _generalFx;
    [SerializeField, EnumNamedArray(typeof(SpellType))] private ParticleSystem[] _spellsFx;

    #region Methods
    #region Mono Callbacks
    void Start()
    {
        StopGeneralFX();
        StopAllSpellsFX();
    }

    void OnValidate()
    {
        _spellsFx = _spellsFx.Resize(typeof(SpellType));
    }
    #endregion

    #region Public methods
    public void PlayGeneralFX()
    {
        StopAllSpellsFX();

        _generalFx.gameObject.SetActive(true);
        _generalFx.Play();
    }

    public void StopGeneralFX()
    {
        _generalFx.Stop();
        _generalFx.gameObject.SetActive(false);
    }

    public void PlaySpellFX(SpellType spellType)
    {
        StopGeneralFX();

        int spellTypeIndex = (int)spellType;

        for (int i = 0; i < _spellsFx.Length; i++)
        {
            if (_spellsFx[i] == null)
            {
                Debug.LogWarningFormat("_spellFx index {0} is null.", i);
                continue;
            }

            bool shouldActive = (spellTypeIndex == i);

            _spellsFx[i].gameObject.SetActive(shouldActive);

            if (shouldActive) _spellsFx[i].Play();
            else _spellsFx[i].Stop();
        }
    }

    public void StopSpellFX(SpellType spellType)
    {
        int spellTypeIndex = (int)spellType;

        _spellsFx[spellTypeIndex].Stop();
        _spellsFx[spellTypeIndex].gameObject.SetActive(false);
    }

    public void StopAllSpellsFX()
    {
        for (int i = 0; i < _spellsFx.Length; i++)
        {
            if (_spellsFx[i] == null)
            {
                Debug.LogWarningFormat("_spellFx index {0} is null.", i);
                continue;
            }

            _spellsFx[i].Stop();
            _spellsFx[i].gameObject.SetActive(false);
        }
    }
    #endregion
    #endregion
}
