using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace GesturesRecognition
{
    public static class GestureTextureGenerator
    {
        public readonly static int PX_PER_ORIENTATION = 64;
        public readonly static int MARGINS = 64;

        public static Texture2D GenerateTexture(Orientation[] gesture, Vector2Int size)
        {
            return GenerateTexture(gesture, size.x, size.y);
        }

        public static Texture2D GenerateTexture(Orientation[] gesture, int sizeX, int sizeY)
        {
            Texture2D texture = new Texture2D(sizeX, sizeY);
            Vector2 gestureSize = GetGestureSize(gesture, PX_PER_ORIENTATION, MARGINS);

            int scaledPxPerOrientation = (int)(Mathf.Max(gestureSize.x, gestureSize.y) * PX_PER_ORIENTATION / Mathf.Max(sizeX, sizeY));

            Vector2 pointerPosition = new Vector2(sizeX, sizeY) / 2 + Vector2.up * gestureSize.y / 4 - Vector2.right * gestureSize.x / 4;

            foreach (Orientation o in gesture)
            {
                var p1 = pointerPosition;
                var p2 = pointerPosition + o.ToVector() * scaledPxPerOrientation;

                pointerPosition = p2;

                // draw line
                texture.DrawLine((int)p1.x, (int)p1.y, (int)p2.x, (int)p2.y, Color.black);
            }

            return texture;
        }

        private static Vector2Int GetGestureSize(Orientation[] gesture, int pixelPerOrientation, int margins)
        {
            Vector2 maxSize = Vector2.zero;
            Vector2 pointer = Vector2.zero;

            Vector2 currentSize = Vector2.zero;

            foreach (Orientation o in gesture)
            {
                currentSize += o.ToVector();

                if (Mathf.Abs(currentSize.x) > Mathf.Abs(maxSize.x))
                {
                    maxSize.x = currentSize.x;
                }

                if (Mathf.Abs(currentSize.y) > Mathf.Abs(maxSize.y))
                {
                    maxSize.y = currentSize.y;
                }
            }

            return ((maxSize.ToAbsolute() * pixelPerOrientation) + (Vector2.one * margins)).ToVector2Int();
        }
    }
}
