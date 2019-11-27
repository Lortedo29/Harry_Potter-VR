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
        if (_numberAnneauReach == _wayPoints.Length + 1)
        {
            Victoire();

            return;
        }

        // activate the next waypoint
        int index = _numberAnneauReach - 1;
        _wayPoints[index].SetActive(true);

        if (index - 1 >= 0)
        {
            _wayPoints[index - 1].SetActive(false);
        }
    }

    void Defaite()
    {
        int index = _numberAnneauReach - 1;
        _wayPoints[index].SetActive(false);

        _numberAnneauReach = 0;
        _timerBetwinTwoCircle = 7f;
        ManagerAudio.Instance.PlaySound(ManagerAudio.Sound.LooseSound);
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

        return;

        //switch (_numberAnneauReach)
        //{
        //    case 0:
        //        _timerBetwinTwoCircle = 7f;
        //        break;
        //    case 1:
        //        _timerBetwinTwoCircle = 7f;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint1.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint1.SetActive(true);
        //        break;
        //    case 2:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint2.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint1.SetActive(false);
        //        _wayPoint2.SetActive(true);
        //        break;
        //    case 3:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint3.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint2.SetActive(false);
        //        _wayPoint3.SetActive(true);
        //        break;
        //    case 4:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint4.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint3.SetActive(false);
        //        _wayPoint4.SetActive(true);
        //        break;
        //    case 5:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint5.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint4.SetActive(false);
        //        _wayPoint5.SetActive(true);
        //        break;
        //    case 6:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint6.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint5.SetActive(false);
        //        _wayPoint6.SetActive(true);
        //        break;
        //    case 7:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint7.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint6.SetActive(false);
        //        _wayPoint7.SetActive(true);
        //        break;
        //    case 8:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint8.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint7.SetActive(false);
        //        _wayPoint8.SetActive(true);
        //        break;
        //    case 9:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint9.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint8.SetActive(false);
        //        _wayPoint9.SetActive(true);
        //        break;
        //    case 10:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _wayPoint10.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint9.SetActive(false);
        //        _wayPoint10.SetActive(true);
        //        break;
        //    case 11:
        //        _timerBetwinTwoCircle = 7f;
        //        _timerBetwinTwoCircle -= Time.deltaTime;
        //        if (_timerBetwinTwoCircle <= 0)
        //        {
        //            _waypoint11.SetActive(false);
        //            _numberAnneauReach = 0;
        //            _timerBetwinTwoCircle = 7f;
        //        }
        //        _wayPoint10.SetActive(false);
        //        _waypoint11.SetActive(true);

        //        break;
        //    case 12:

        //        _timerBetwinTwoCircle = 7f;
        //        _numberAnneauReach = 0;
        //        break;

    }
}

