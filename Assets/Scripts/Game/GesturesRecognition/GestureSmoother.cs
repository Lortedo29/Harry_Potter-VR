using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace GesturesRecognition
{
    public static class GestureSmoother
    {
        public static List<Orientation[]> SmoothGesture(Orientation[] mainGesture)
        {
            List<Orientation[]> output = new List<Orientation[]>();

            int edgesCount = mainGesture.Length - 1;

            for (int edgeIndex = 0; edgeIndex < edgesCount; edgeIndex++)
            {
                int remainingEdges = edgesCount - edgeIndex;

                for (int simultaneousEdge = 0; simultaneousEdge < remainingEdges; simultaneousEdge++)
                {
                    List<int> o = new List<int>
                    {
                        edgeIndex
                    };

                    for (int i = edgeIndex + 1; i < simultaneousEdge && i < edgesCount; i++)
                    {
                        o.Add(i);
                    }

                    Orientation[] smoothedGesture = SmoothEdge(mainGesture, o.ToArray());

                    if (!Enumerable.SequenceEqual(smoothedGesture, mainGesture))
                    {
                        output.Add(smoothedGesture);
                    }
                }
            }

            Debug.LogFormat("Generated {0} gestures", output.Count);
            return output;
        }

        private static Orientation[] SmoothEdge(Orientation[] mainGesture, int[] edgesIndex)
        {
            var list = mainGesture.ToList();

            for (int i = edgesIndex.Length - 1; i >= 0; i--)
            {
                int orientationIndex = edgesIndex[i];
                Orientation averageOrientation = GetAverage(mainGesture[orientationIndex], mainGesture[orientationIndex + 1]);

                if (averageOrientation != list[orientationIndex])
                {
                    list.Insert(orientationIndex + 1, averageOrientation);
                }
            }

            return list.ToArray();
        }

        private static Orientation GetAverage(Orientation o1, Orientation o2)
        {
            float averageX = (Mathf.Cos(o1.ToAngle()) + Mathf.Cos(o2.ToAngle())) / 2;
            float averageY = (Mathf.Sin(o1.ToAngle()) + Mathf.Sin(o2.ToAngle())) / 2;

            float averageAngle = Mathf.Atan2(averageY, averageX);

            Orientation output = averageAngle.ToOrientation();

            Debug.LogFormat("{0} and {1} into {2} w/ average angle {3}", o1, o2, output, averageAngle * Mathf.Rad2Deg);
            return output;
        }
    }
}
