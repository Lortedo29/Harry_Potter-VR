using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Pattern;
using VRTK;

[Obsolete("Use Wand class instead of WandManager")]
public class WandManager : Singleton<WandManager>
{
    #region Fields
    private VRTK_ControllerEvents _carryingController;
    private GameObject _carriedWand;
    #endregion

    #region Properties
    public GameObject CarriedWand { get => _carriedWand; }
    public VRTK_ControllerEvents CarryingController { get => _carryingController; }
    #endregion

    #region Methods
    void Start()
    {
        RegisterWandsEvents();
    }

    #region Private methods 
    #region Start Methods
    /// <summary>
    /// Listen to grab & ungrab events of every wand.
    /// </summary>
    private void RegisterWandsEvents()
    {
        GameObject[] wands = GameObject.FindGameObjectsWithTag("Wand");

        for (int i = 0; i < wands.Length; i++)
        {
            var interactableObject = wands[i].GetComponent<VRTK_InteractableObject>();

            interactableObject.InteractableObjectGrabbed += OnWandGrabbed;
            interactableObject.InteractableObjectUngrabbed += OnWandUngrabbed;
        }
    }

    void OnWandGrabbed(object sender, InteractableObjectEventArgs e)
    {
        _carryingController = e.interactingObject.GetComponent<VRTK_ControllerEvents>();
        _carriedWand = ((VRTK_InteractableObject)sender).gameObject;
    }

    void OnWandUngrabbed(object sender, InteractableObjectEventArgs e)
    {
        _carryingController = null;
        _carriedWand = null;
    }
    #endregion
    #endregion
    #endregion
}
