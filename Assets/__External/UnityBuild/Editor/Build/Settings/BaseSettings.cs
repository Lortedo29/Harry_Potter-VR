using System.IO;
using UnityEditor;
using UnityEngine;

namespace SuperSystems.UnityBuild
{

public class BaseSettings : ScriptableObject
{
    protected const string SettingsPath = "Assets/__External/UnityBuildSettings/{0}.asset";

    protected static T CreateAsset<T>(string assetName) where T : BaseSettings
    {
        string assetPath = string.Format(SettingsPath, assetName);
        T instance = AssetDatabase.LoadAssetAtPath<T>(assetPath) as T;

        if (instance == null)
        {    
            Debug.Log("UnityBuild: Creating settings file - " + assetPath);
            instance = CreateInstance<T>();
            instance.name = assetName;

            if (!Directory.Exists("Assets/__External/UnityBuildSettings"))
                AssetDatabase.CreateFolder("Assets/__External", "UnityBuildSettings");

            AssetDatabase.CreateAsset(instance, assetPath);
        }

        return instance;
    }
}

}