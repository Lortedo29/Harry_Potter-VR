using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class MonoBehaviourExtension
{
    /// <summary>
    /// Execute task after time.
    /// </summary>
    /// <param name="mono"></param>
    /// <param name="time"></param>
    /// <param name="task"></param>
    public static Coroutine ExecuteAfterTime(this MonoBehaviour mono, float time, Action task)
    {
        return mono.StartCoroutine(AfterTimeCoroutine(time, task));
    }

    /// <summary>
    /// Called from ExecuteAfterTime.
    /// </summary>
    static IEnumerator AfterTimeCoroutine(float time, Action task)
    {
        yield return new WaitForSecondsRealtime(time);

        task();
    }

    public static Coroutine ExecuteNextFrame(this MonoBehaviour mono, Action task)
    {
        return mono.StartCoroutine(NextFrameCoroutine(1, task));
    }

    public static Coroutine ExecuteForXFrames(this MonoBehaviour mono, int frameToWait, Action task)
    {
        return mono.StartCoroutine(NextFrameCoroutine(frameToWait, task));
    }

    static IEnumerator NextFrameCoroutine(int frameToWait, Action task)
    {
        for (int i = 1; i <= frameToWait; i++)
        {
            yield return new WaitForEndOfFrame();
        }

        task();
    }
}
