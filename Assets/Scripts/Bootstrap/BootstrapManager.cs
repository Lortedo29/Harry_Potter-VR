using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils.Managers;

public class BootstrapManager : MonoBehaviour
{
    [SerializeField] private string _sceneToLoad = "SC_Test_MagicHighlight";

    void Start()
    {
        SceneManager.LoadSceneAsync(_sceneToLoad);
    }
}
