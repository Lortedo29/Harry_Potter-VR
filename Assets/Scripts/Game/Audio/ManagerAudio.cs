using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Inspector;
using Utils.Pattern;

public class ManagerAudio : Singleton<ManagerAudio>
{
    public enum Sound
    {
       Levitation,
       Push,
       Freez,
       AnneauReach,
       WinSound,
       LooseSound,

    }

    public AudioSource _myAudioSource;

    [SerializeField, EnumNamedArray(typeof(Sound))] private AudioClip[] _audio = new AudioClip[0];

    void OnValidate()
    {
        int enumLength = Enum.GetValues(typeof(Sound)).Length;

        if (_audio.Length != enumLength)
        {
            Array.Resize(ref _audio, enumLength);
        }
    }

    public void PlaySound(Sound sound)
    {
        _myAudioSource.clip = _audio[(int)sound];
        _myAudioSource.Play();
    }

    public void StopSound()
    {
        _myAudioSource.Stop();
    }
}

