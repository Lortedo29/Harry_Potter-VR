using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace GesturesRecognition
{
    [CustomEditor(typeof(Gesture))]
    public class GestureEditor : Editor
    {
        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            Gesture myScript = (Gesture)target;

            GUILayout.Space(20);

            if (GUILayout.Button("Smooth Gesture"))
            {
                myScript.SmoothGesture();
            }

            GUILayout.Space(40);

            GUILayout.BeginHorizontal();

            GUILayout.BeginVertical();
            GUILayout.Label("Main Gesture");
            GUILayout.Box(myScript.MainGestureTexture);
            GUILayout.EndVertical();

            GUILayout.BeginVertical();
            GUILayout.Label("Smooth Gesture # " + myScript.DisplaySmoothedGesture);
            GUILayout.Box(myScript.SecondaryGestureTexture);
            GUILayout.EndVertical();

            GUILayout.EndHorizontal();

            myScript.DisplaySmoothedGesture = EditorGUILayout.IntSlider(myScript.DisplaySmoothedGesture, 0, myScript.SmoothedGestures.Count - 1);
        }
    }
}