using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Pattern;

public class AnneauAtelierTravel : Singleton<AnneauAtelierTravel>
{

    [SerializeField] private GameObject[] _wayPoints;
    [SerializeField] private GameObject _plume;

    public int _numberAnneauReach = 0;
    public float _timerBetwinTwoCircle = 7f;

    void Start()
    {
        _plume.GetComponent<MagicInteractable>().OnStartLevitate += (MagicInteractable sender) => StartAtelier();
    }

    public void TraverseAnneau()
    {
        _numberAnneauReach++;
        _timerBetwinTwoCircle = 7; // reset timer

        // check for victory
        if (_numberAnneauReach >= _wayPoints.Length + 1)
        {
            Victoire();

            return;
        }

        // activate the next waypoint
        int index = _numberAnneauReach - 1;
        _wayPoints[index].SetActive(true);

        // deactivate the last waypoint
        if (index - 1 >= 0)
        {
            _wayPoints[index - 1].SetActive(false);
        }
    }

    void Defaite()
    {
        _numberAnneauReach = 0;
        _timerBetwinTwoCircle = 7f;
        ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.LooseSound);

        // deactive every way point
        foreach (var waypoint in _wayPoints)
        {
            waypoint.SetActive(false);
        }
    }

    void Victoire()
    {
        ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.WinSound);
        SpellLevitation.Instance.ReleaseTarget();
    }

    void StartAtelier()
    {
        _numberAnneauReach = 0;
        TraverseAnneau();
    }


    void Update()
    {
        if (_numberAnneauReach != 0)
        {
            _timerBetwinTwoCircle -= Time.deltaTime;

            if (_timerBetwinTwoCircle <= 0)
            {
                Defaite();
            }
        }              
    }
}

