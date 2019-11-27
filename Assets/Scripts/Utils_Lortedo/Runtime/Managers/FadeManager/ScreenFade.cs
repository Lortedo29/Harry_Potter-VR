using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Utils;
using Utils.Pattern;

public class ScreenFade : MonoBehaviour
{
    #region Fields
    private static ScreenFade _instance;

    private Material _fadeMaterial = null;
    private Coroutine _fadeCoroutine = null;

    private Color _currentColor = Color.clear;
    private Coroutine _coroutine = null;
    #endregion

    #region Properties
    public static ScreenFade Instance
    {
        get
        {
            if (_instance == null)
            {
                Initialize();
            }

            return _instance;
        }
    }
    #endregion

    #region Methods
    #region Mono Callbacks
    void Awake()
    {
        _fadeMaterial = new Material(Shader.Find("Unlit/TransparentColor"));
    }

    void Update()
    {
        if (transform.parent == null)
        {
            Debug.Log("Set screen fade to camera");
            transform.parent = Camera.main.transform;
        }
    }

    void OnDestroy()
    {
        _instance = null;
    }

    void OnPostRender()
    {
        _fadeMaterial.color = _currentColor;
        _fadeMaterial.SetPass(0);

        GL.PushMatrix();
        GL.LoadOrtho();
        GL.Color(_fadeMaterial.color);
        GL.Begin(GL.QUADS);
        GL.Vertex3(0f, 0f, 0.9999f);
        GL.Vertex3(0f, 1f, 0.9999f);
        GL.Vertex3(1f, 1f, 0.9999f);
        GL.Vertex3(1f, 0f, 0.9999f);
        GL.End();
        GL.PopMatrix();
    }
    #endregion

    #region Public methods
    #region Static methods
    public static void Initialize()
    {
        if (_instance)
            return;

        _instance = Camera.main.gameObject.AddComponent<ScreenFade>();
    }
    #endregion

    #region Non static methods
    public void Fade(float duration)
    {
        _currentColor = Color.black;
        _currentColor.a = 0;

        if (_coroutine != null) StopCoroutine(_coroutine);

        _coroutine = new Timer(this, duration, (float completion) =>
        {
            _currentColor.a = Mathf.Lerp(0, 1, completion);
        }).Coroutine;
    }

    public void Unfade(float duration)
    {
        _currentColor.a = 1;

        if (_coroutine != null) StopCoroutine(_coroutine);

        _coroutine = new Timer(this, duration, (float completion) =>
        {
            _currentColor.a = Mathf.Lerp(1, 0, completion);
        }).Coroutine;
    }
    #endregion
    #endregion
    #endregion
}
