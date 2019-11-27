using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class CardsManager : MonoBehaviour
{
    [SerializeField] private float _cardDistanceToHand = 0.3f;
    [SerializeField] private Card[] _cards;

    private VRTK_ControllerEvents _leftController;
    private VRTK_ControllerEvents _rightController;

    private VRTK_ControllerEvents _carryingController = null;
    private Transform _carryingTransform = null;

    #region Methods
    #region Mono Callbacks
    void Start()
    {
        StartCoroutine(LateStart());

        for (int i = 0; i < _cards.Length; i++)
        {
            _cards[i].gameObject.SetActive(false);
        }
    }

    IEnumerator LateStart()
    {
        yield return new WaitForEndOfFrame();

        // initialize controller
        _leftController = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.LeftController).GetComponent<VRTK_ControllerEvents>();
        _rightController = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();

        _leftController.ButtonOnePressed += (object sender, ControllerInteractionEventArgs e) => SwitchCardDisplay(_leftController);
        _rightController.ButtonOnePressed += (object sender, ControllerInteractionEventArgs e) => SwitchCardDisplay(_rightController);
    }
    #endregion

    #region Private methods
    void SwitchCardDisplay(VRTK_ControllerEvents carryingController)
    {
        if (_carryingController == null)
        {
            SetCardsToHand(carryingController);
        }
        else if (_carryingController == carryingController)
        {
            HideCarriedCards();
        }
        else if (_carryingController != carryingController)
        {
            HideCarriedCards();
            SetCardsToHand(carryingController);
        }
    }

    void SetCardsToHand(VRTK_ControllerEvents carryingController)
    {
        _carryingController = carryingController;

        for (int i = 0; i < _cards.Length; i++)
        {
            _cards[i].gameObject.SetActive(true); // assure that card is active

            _cards[i].ActiveCard(true);
            _cards[i].ParticleSystem.Play();
            _cards[i].transform.parent = carryingController.transform;

            // position
            float anglePosition = i * Mathf.PI / _cards.Length;
            anglePosition += 15 * Mathf.Deg2Rad;
            _cards[i].transform.localPosition = new Vector3(Mathf.Cos(anglePosition), Mathf.Sin(anglePosition), 0) * _cardDistanceToHand;

            // rotation
            _cards[i].transform.localEulerAngles = ((anglePosition * Mathf.Rad2Deg) - 90) * Vector3.forward;

            // rigidbody
            _cards[i].Rigidbody.velocity = Vector3.zero;
            _cards[i].Rigidbody.isKinematic = true;

            // set parent
            _carryingTransform = _cards[i].transform.parent;
        }
    }

    void HideCarriedCards()
    {
        bool hasHideSomething = false;

        for (int i = 0; i < _cards.Length; i++)
        {
            if (_cards[i].transform.parent == _carryingTransform)
            {
                _cards[i].ActiveCard(false);
                _cards[i].ParticleSystem.Stop();

                hasHideSomething = true;
            }
        }

        if (hasHideSomething) _carryingController = null;
        else SetCardsToHand(_carryingController);
    }

    bool IsCarryingController(VRTK_ControllerEvents toCompareController)
    {
        return _carryingController != null && _carryingController == toCompareController;
    }
    #endregion
    #endregion
}
