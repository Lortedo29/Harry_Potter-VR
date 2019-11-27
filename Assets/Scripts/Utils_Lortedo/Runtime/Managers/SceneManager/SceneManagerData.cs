using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting;
using Utils.Inspector;

namespace Utils.Managers
{
    [CreateAssetMenu(menuName = "Utils/SceneManager Data", fileName = "SceneManager Data")]
    public class SceneManagerData : ScriptableObject
    {
        [SerializeField] private string _scenePath = "Assets/Scenes/";
        [Space]
#if UNITY_EDITOR
        [SerializeField] private SceneAsset[] _levelScenesAssets = new SceneAsset[0];
        [SerializeField] private SceneAsset[] _gameLogicScenesAssets = new SceneAsset[0];
#endif  
        [SerializeField, ShowOnly] private string[] _levelScenesName = new string[0];
        [SerializeField, ShowOnly] private string[] _gameLogicSceneName = new string[0];

        public string ScenePath { get => _scenePath; }
        public string[] LevelScenesName { get => _levelScenesName; }
        public string[] GameLogicSceneName { get => _gameLogicSceneName; }

#if UNITY_EDITOR
        void OnValidate()
        {
            _levelScenesName = _levelScenesAssets.Select(x => x.name).ToArray();
            _gameLogicSceneName = _gameLogicScenesAssets.Select(x => x.name).ToArray();
        }
#endif
    }
}

