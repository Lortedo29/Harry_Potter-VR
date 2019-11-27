using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using Utils.Managers;

namespace Utils.Managers
{
    public class SceneRequirementEditor
    {
        [MenuItem("Harry Potter VR/Load Game Logic Scenes")]
        private static void LoadLogicScenes()
        {
            string[] loadedLevelScenes = GetLoadedSceneInArray(SceneManager.Data.LevelScenesName);
            string[] loadedLogicScenes = GetLoadedSceneInArray(SceneManager.Data.GameLogicSceneName);

            // load missing logic
            for (int i = 0; i < SceneManager.Data.GameLogicSceneName.Length; i++)
            {
                bool isLogicSceneLoaded = Array.Exists(loadedLogicScenes, element => element == SceneManager.Data.GameLogicSceneName[i]);

                if (!isLogicSceneLoaded)
                {
                    EditorSceneManager.OpenScene(SceneManager.Data.ScenePath + SceneManager.Data.GameLogicSceneName[i] + ".unity", OpenSceneMode.Additive);
                }
            }
        }

        static string[] GetLoadedSceneInArray(string[] scenesNames)
        {
            List<string> o = new List<string>();

            for (int i = 0; i < UnityEngine.SceneManagement.SceneManager.sceneCount; i++)
            {
                UnityEngine.SceneManagement.Scene loadedScene = UnityEngine.SceneManagement.SceneManager.GetSceneAt(i);
                bool isAWantedScene = Array.Exists(scenesNames, element => element == loadedScene.name);

                if (isAWantedScene && loadedScene.isLoaded)
                {
                    o.Add(loadedScene.name);
                }
            }

            return o.ToArray();
        }
    }
}
