using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// Every existant spells
/// </summary>
public enum SpellType
{
    Levitation,
    Pushing,
    Freezer,
    SceneReload
}

public static class SpellTypeExtension
{
    public static string ToSceneName(this SpellType spellType)
    {
        return "SC_blockout_" + spellType.ToString();
    }

    public static TargetSpellType? ToTargetSpellType(this SpellType spellType)
    {
        switch (spellType)
        {
            case SpellType.Levitation:
                return TargetSpellType.Levitation;

            case SpellType.Pushing:
                return TargetSpellType.Pushing;

            case SpellType.Freezer:
                return TargetSpellType.Freezer;
        }

        Debug.LogWarningFormat("{0} isn't included in ToTargetSpellType function!", spellType);
        return null;
    }
}

/// <summary>
/// Spell that need a target
/// </summary>
[Flags]
public enum TargetSpellType
{
    Levitation = 1 << 0,
    Pushing = 1 << 1,
    Freezer = 1 << 2
}