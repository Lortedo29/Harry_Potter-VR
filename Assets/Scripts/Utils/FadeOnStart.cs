using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FadeOnStart : MonoBehaviour
{
    void Start()
    {
        this.ExecuteForXFrames(2, () => ScreenFade.Instance.Unfade(Portal.FADE_TIME));
    }
}
