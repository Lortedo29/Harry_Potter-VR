using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// Deactive gameObject when ParticleSystem is stopped.
/// </summary>
[RequireComponent(typeof(ParticleSystem))]
public class DeactivateOnStop : MonoBehaviour
{
    private ParticleSystem _particleSystem;

    void Awake()
    {
        _particleSystem = GetComponent<ParticleSystem>();
    }

    void Update()
    {
        if (_particleSystem.isStopped)
        {
            gameObject.SetActive(false);
        }
    }
}
