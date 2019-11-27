using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Managers;
using VRTK;

/// <summary>
/// If character touches it, teleport players to spell's scene field.
/// </summary>
public class Portal : MonoBehaviour
{
    public static readonly float DISTANCE_THRESHOLD = 0.5f;
    public static readonly float FADE_TIME = 0.8f;

    private VRTK_InteractableObject _interactableObject;
    [SerializeField] private bool _teleportToCustomScene = false;
    [SerializeField, DrawIf(nameof(_teleportToCustomScene), true, ComparisonType.Equals)] private string _customSceneName;
    [SerializeField, DrawIf(nameof(_teleportToCustomScene), false, ComparisonType.Equals)] private SpellType _sceneToLoad = SpellType.Pushing;

    private bool _isGrab = false;
    private static bool _isLoading = false;

    private string SceneToLoad
    {
        get
        {
            return _teleportToCustomScene ? _customSceneName : _sceneToLoad.ToSceneName();
        }
    }

    void Awake()
    {
        if (_interactableObject == null)
        {
            _interactableObject = GetComponent<VRTK_InteractableObject>();
        }
    }

    void Update()
    {
        if (_interactableObject.IsGrabbed())
        {
            // check if transform is near of headset
            if (Vector3.Distance(transform.position, VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.Headset).position) <= DISTANCE_THRESHOLD)
            {
                LoadScene();
            }
        }
    }

    void OnDestroy()
    {
        _isLoading = false;
    }

    void LoadScene()
    {
        if (_isLoading)
            return;

        _isLoading = true;

        ScreenFade.Instance.Fade(FADE_TIME);

        DontDestroyObject.Instance.ExecuteAfterTime(FADE_TIME, () =>
        {
            SceneManager.LoadScene(SceneToLoad);
        });
    }
}
