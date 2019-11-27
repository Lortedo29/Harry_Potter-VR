using System.Text;
using UnityEngine;

namespace GesturesRecognition
{
    public enum Orientation
    {
        Right = 0,
        TopRight = 1,
        Top = 2,
        TopLeft = 3,
        Left = 4,
        BotLeft = 5,
        Bot = 6,
        BotRight = 7,
    }

    public static class FloatExtension
    {
        /// <summary>
        /// Angle in radians
        /// </summary>
        /// <param name="angle">Angle in radians !</param>
        /// <returns></returns>
        /// https://gamedev.stackexchange.com/questions/49290/whats-the-best-way-of-transforming-a-2d-vector-into-the-closest-8-way-compass-d
        public static Orientation ToOrientation(this float angle)
        {
            int octant = Mathf.RoundToInt(8 * angle / (2 * Mathf.PI) + 8) % 8;
            return (Orientation)octant;
        }
    }

    public static class OrientationExtension
    {
        public static string ToDebugLog(this Orientation[] orientations)
        {
            StringBuilder sb = new StringBuilder();

            foreach (var o in orientations)
                sb.AppendLine(o.ToString());

            return sb.ToString();
        }

        public static Vector2 ToVector(this Orientation o)
        {
            switch (o)
            {
                case Orientation.Right:
                    return Vector2.right;

                case Orientation.TopRight:
                    return new Vector2(0.5f, 0.5f);

                case Orientation.Top:
                    return Vector2.up;

                case Orientation.TopLeft:
                    return new Vector2(-0.5f, 0.5f);

                case Orientation.Left:
                    return Vector2.left;

                case Orientation.BotLeft:
                    return new Vector2(-0.5f, -0.5f);

                case Orientation.Bot:
                    return Vector2.down;

                case Orientation.BotRight:
                    return new Vector2(0.5f, -0.5f);
            }

            return Vector2.zero;
        }

        /// <summary>
        /// Return in angle radians
        /// </summary>
        public static float ToAngle(this Orientation o)
        {
            int octant = (int)o;

            return (float)o * Mathf.PI / 4;
        }
    }
}