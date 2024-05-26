//#define DEBUG1

using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;

namespace BWSnew
{
    public partial class Zeichen : Control
    {
        public Bitmap Image;

        public Zeichen()
        {
            InitializeComponent();            
        }

        //protected override void OnPaint(PaintEventArgs pe)
        //{
        //    base.OnPaint(pe);
        //}

        #region Pixel
        private int _pixelX, _pixelY;
        public int PixelX
        {
            get { return _pixelX; }
            set { _pixelX = value; }
        }
        public int PixelY
        {
            get { return _pixelY; }
            set { _pixelY = value; }
        }
        #endregion

        #region Zeichen
        private int _zeichenX, _zeichenY;
        private Color _colorB, _colorF;
        public int ZeichenX
        {
            get { return _zeichenX; }
            set { _zeichenX = value; }
        }
        public int ZeichenY
        {
            get { return _zeichenY; }
            set { _zeichenY = value; }
        }

        public Color ZeichenColorBack
        {
            get { return _colorB; }
            set { _colorB = value; }
        }
        public Color ZeichenColorFore
        {
            get { return _colorF; }
            set { _colorF = value; }
        }
        #endregion 

        private int _left, _top;
        public int Left1
        {
            get { return _left; }
            set { _left = value; }
        }
        public int Top1        
        {
            get { return _top; }
            set { _top = value; }
        }

        public void Init()
        {
            Image = new Bitmap(PixelX * ZeichenX, PixelY * ZeichenY, System.Drawing.Imaging.PixelFormat.Format32bppArgb);
        }

        //public void Init()
        //{
        //    Image = new Bitmap(PixelX * ZeichenX, PixelY * ZeichenY, System.Drawing.Imaging.PixelFormat.Format32bppArgb);            
        //}

        // false ... = ColorBack
        // true  ... = ColorFore
        public void SetZeichen(Zeichen Z, bool[,] ZeichenTemplate)
        {
            UInt16 x, y;
            x = 0; y = 0;

            for (UInt16 j1 = 0; j1 < ZeichenY * PixelY; j1 = (ushort)(j1 + PixelY))
            {
                y =(ushort)(j1 / PixelY);

                for (UInt16 i1 = 0; i1 < ZeichenX * PixelX; i1 = (ushort)(i1 + PixelX))
                {
                    x = (ushort)(i1 / PixelX);
//#if DEBUG
                    Debug.Write("i1=" + i1 + " j1=" + j1 + "  x=" + x + " y=" + y + "\n");
//#endif 
                    if (ZeichenTemplate[y, x])
                        for (UInt16 i2 = 0; i2 < PixelX; i2++)
                        {
                            for (UInt16 j2 = 0; j2 < PixelY; j2++)
                            {
                                Z.Image.SetPixel(i1 + i2, j1 + j2, ZeichenColorFore);
//#if DEBUG
                                Debug.Write("i1=" + i1 + " j1=" + j1 + "  x=" + x + " y=" + y);
                                Debug.Write("   1 X=" + (i1 + i2) + " Y=" + (j1 + j2) + " " + ZeichenColorFore + " " + ZeichenTemplate[y, x] + "\n");
//#endif 
                            }
                        }
                    else
                        for (UInt16 i2 = 0; i2 < PixelX; i2++)
                        {
                            for (UInt16 j2 = 0; j2 < PixelY; j2++)
                            {
                                Z.Image.SetPixel(i1 + i2 , j1 + j2, ZeichenColorBack);
//#if DEBUG
                                Debug.Write("i1=" + i1 + " j1=" + j1 + "  x=" + x + " y=" + y);
                                Debug.Write("   0 X=" + (i1 + i2) + " Y=" + (j1 + j2) + " " + ZeichenColorBack + " " + ZeichenTemplate[y, x] + "\n");
//#endif 
                            }
                        }
                }
//#if DEBUG
//                Debug.Write("\n");
//#endif 
            }
            Z.Refresh();
        }
    }
}
