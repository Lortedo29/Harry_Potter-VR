using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Expelliarmus : MonoBehaviour {

    [SerializeField] private GameObject _wayPoint1, _wayPoint2, _wayPoint3, _wayPoint4, _wayPoint5;
    public static int _numberAnneauReach = 1;
    [SerializeField] private GameObject _plume;

    //Timer
    private float _timerBetwinTwoCircle = 7f;


    void Update()
    {
        //if (_plume.GetComponent<MagicInteractable>().IsLevitating == true && _numberAnneauReach == 0)
        //{
        //    _numberAnneauReach = 1;
        //}

        switch (_numberAnneauReach)
        {
            case 0:
                _wayPoint1.SetActive(false);
                _wayPoint2.SetActive(false);
                _wayPoint3.SetActive(false);
                _wayPoint4.SetActive(false);
                _wayPoint5.SetActive(false);

                break;
            case 1:
                _timerBetwinTwoCircle -= Time.deltaTime;
                if (_timerBetwinTwoCircle <= 0)
                {
                    _numberAnneauReach = 0;
                    _timerBetwinTwoCircle = 7f;
                }
                _wayPoint1.SetActive(true);
                break;
            case 2:
                _timerBetwinTwoCircle -= Time.deltaTime;
                if (_timerBetwinTwoCircle <= 0)
                {

                    _numberAnneauReach = 0;
                    _timerBetwinTwoCircle = 7f;
                }
                _wayPoint1.SetActive(false);
                _wayPoint2.SetActive(true);
                break;
            case 3:
                _timerBetwinTwoCircle -= Time.deltaTime;
                if (_timerBetwinTwoCircle <= 0)
                {

                    _numberAnneauReach = 0;
                    _timerBetwinTwoCircle = 7f;
                }
                _wayPoint2.SetActive(false);
                _wayPoint3.SetActive(true);
                break;
            case 4:
                _timerBetwinTwoCircle -= Time.deltaTime;
                if (_timerBetwinTwoCircle <= 0)
                {

                    _numberAnneauReach = 0;
                    _timerBetwinTwoCircle = 7f;
                }
                _wayPoint3.SetActive(false);
                _wayPoint4.SetActive(true);
                break;
            case 5:
                _numberAnneauReach = 0;
                break;
        }
    }
}
