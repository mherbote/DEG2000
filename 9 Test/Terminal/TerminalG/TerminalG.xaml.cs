using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;
using System.IO;

namespace TerminalG
{
    /// <summary>
    /// Interaktionslogik für TerminalG.xaml
    /// </summary>
    public partial class  TerminalG : UserControl
    {
      #region // Declaration
      public double ucHeight;
      public double ucWidth;

      private static string _TerminalTyp;

      private static long   _xx, _xstart;
      private static long   _yy, _ystart;
      private static bool   _Cursor;
      private static string _FontName;
      private static long   _pixBreiteX, _charX, _pixX1, _AnzX2, _pixX2;
      private static long   _pixBreiteY, _charY, _pixY1, _AnzY2, _pixY2;
      private static Brush  _cBack1 = Brushes.LightBlue; private static Brush _cFore1 = Brushes.Yellow; private static Brush _cBorder1 = Brushes.Gray;
      private static Brush  _cBack2 = Brushes.LightBlue; private static Brush _cFore2 = Brushes.Yellow; private static Brush _cBorder2 = Brushes.Gray;
      private static Brush  _c31;
      private static Brush  _c32;

      //  DispatcherTimer setup
      DispatcherTimer timer = new DispatcherTimer();

      Rectangle[,] _r1;
      Rectangle[,] _r2;
      Brush    [,] _cc;
      byte     [,] _CharCode;
      #endregion

      public void TerminalInit(long pixBreiteX =  1, long pixBreiteY =  1,
                               long charX      =  8, long charY      = 12,
                               long pixX       = 80, long pixY       = 24,
                               long AnzX2      = 80, long AnzY2      =  2,
                               string FontName = "7024-0.FNT")
      {
         InitializeComponent();

         int i; int j;

         _TerminalTyp = "Grafik";

         _pixBreiteX = pixBreiteX; _charX = charX; _AnzX2 = AnzX2;
         _pixBreiteY = pixBreiteY; _charY = charY; _AnzY2 = AnzY2;

         LoadFont(FontName);
         _pixX1 = pixX;            _pixY1 = pixY;
         _pixX2 = _charX * _AnzX2; _pixY2 = _charY * _AnzY2;

         _r1 = new Rectangle[_pixX1, _pixY1];
         _r2 = new Rectangle[_pixX2, _pixY2];
         _cc = new Brush    [_charX, _charY];

         _canvas1.Children.Clear();
         _canvas1.Background = _cBack1;
         _canvas1.Width      = _pixBreiteX * _pixX1;
         _canvas1.Height     = _pixBreiteY * _pixY1;
         _border1.Width      = _canvas1.Width  + 2;
         _border1.Height     = _canvas1.Height + 2;

         _canvas2.Children.Clear();
         _canvas2.Background = _cBack2;
         _canvas2.Width      = _pixBreiteX * _pixX2;
         _canvas2.Height     = _pixBreiteY * _pixY2;
         _border2.Width      = _canvas2.Width  + 2;
         _border2.Height     = _canvas2.Height + 2;

         if (_border1.Width > _border2.Width) ucWidth = _border1.Width;
         else                                 ucWidth = _border2.Width;

         ucHeight = _border1.Height + _border2.Height;

         for (i = 0; i < _pixY1; i += 1)
         {
            for (j = 0; j < _pixX1; j += 1)
            {
               _r1[j, i]        = new Rectangle();
               _r1[j, i].Width  = _pixBreiteX;
               _r1[j, i].Height = _pixBreiteY;
               _r1[j, i].Fill   = _cBack1;
               Canvas.SetLeft(_r1[j, i], j * _pixBreiteX);
               Canvas.SetTop (_r1[j, i], i * _pixBreiteY);
               _canvas1.Children.Add(_r1[j, i]);
            }
         }
         for (i = 0; i < _pixY2; i += 1)
         {
            for (j = 0; j < _pixX2; j += 1)
            {
               _r2[j, i]        = new Rectangle();
               _r2[j, i].Width  = _pixBreiteX;
               _r2[j, i].Height = _pixBreiteY;
               _r2[j, i].Fill   = _cBack2;
               Canvas.SetLeft(_r2[j, i], j * _pixBreiteX);
               Canvas.SetTop (_r2[j, i], i * _pixBreiteY);
               _canvas2.Children.Add(_r2[j, i]);
            }
         }

         AnzeigeStatus();
      }

      public void SetColors1(Brush BackColor, Brush ForeColor, Brush CursorColor, Brush BorderColor)
      {
         _cBack1 = BackColor;
         _cFore1 = ForeColor;
         _cBorder1 = BorderColor;
      }
      public void SetColors2(Brush BackColor, Brush ForeColor, Brush CursorColor, Brush BorderColor)
      {
         _cBack2 = BackColor;
         _cFore2 = ForeColor;
         _cBorder2 = BorderColor;
      }

      public void SetBackground1(Brush Background1)
      {
         Brush cBackOld = _cBack1;
         long i, j;

         _cBack1 = Background1;

         for (i = 0; i < _pixY1; i += 1)
         {
            for (j = 0; j < _pixX1; j += 1)
            {
               if (_r1[j, i].Fill == cBackOld)
               {
                  _r1[j, i].Fill = _cBack1;
               }
            }
         }
      }
      public void SetBackground2(Brush Background1)
      {
         Brush cBackOld = _cBack2;
         long i, j;

         _cBack2 = Background1;

         for (i = 0; i < _pixY2; i += 1)
         {
            for (j = 0; j < _pixX2; j += 1)
            {
               if (_r2[j, i].Fill == cBackOld)
               {
                  _r2[j, i].Fill = _cBack1;
               }
            }
         }
      }

      public void SetPixel1(long X, long Y, Brush Foreground)
      //      X,Y in Pixel (Start bei 0)
      {
         _r1[X, Y].Fill = Foreground;
      }
      public void SetPixel2(long X, long Y, Brush Foreground)
      //      X,Y in Pixel (Start bei 0)
      {
         _r2[X, Y].Fill = Foreground;
      }

      public void SetChar(int canvasNr, long X, long Y, Brush cBack, Brush cFore, byte Zeichen)
      //      X,Y in Alphaterminal Koordinaten (Start bei 1)
      {
         byte _charZeile;
         long _xstart, _ystart;
         long _pX1, _pX2, _pY1, _pY2;

         try
         {
            //setzen Cursor?

            _xstart = (X - 1) * _pixBreiteX * _charX;
            _ystart = (Y - 1) * _pixBreiteY * _charY;

            for (_pY1 = 0; _pY1 <= _pixBreiteY * _charY - _pixBreiteY; _pY1 = _pY1 + _pixBreiteY)
            {
               _charZeile = _CharCode[Zeichen, _pY1 / _pixBreiteY];
               for (_pX1 = 0; _pX1 <= _pixBreiteX * _charX - _pixBreiteX; _pX1 = _pX1 + _pixBreiteX)
               {
                  if (IstBit(_charZeile, _pX1 / _pixBreiteX))
                  {
                     for (_pX2 = 0; _pX2 < _pixBreiteX; _pX2 += 1)
                        for (_pY2 = 0; _pY2 < _pixBreiteY; _pY2 += 1)
                        {
                           switch (canvasNr)
                           {
                              case 1:
                                 SetPixel1(_xstart + _pX1 + _pX2, _ystart + _pY1 + _pY2, cFore);
                                 break;
                              case 2:
                                 SetPixel2(_xstart + _pX1 + _pX2, _ystart + _pY1 + _pY2, cFore);
                                 break;
                           }
                        }
                  }
                  else
                  {
                     if (cBack != null)
                     {
                        for (_pX2 = 0; _pX2 < _pixBreiteX; _pX2 += 1)
                           for (_pY2 = 0; _pY2 < _pixBreiteY; _pY2 += 1)
                           {
                              switch (canvasNr)
                              {
                                 case 1:
                                    SetPixel1(_xstart + _pX1 + _pX2, _ystart + _pY1 + _pY2, cBack);
                                    break;
                                 case 2:
                                    SetPixel2(_xstart + _pX1 + _pX2, _ystart + _pY1 + _pY2, cBack);
                                    break;
                              }
                           }
                     }
                     else
                     {
                        for (_pX2 = 0; _pX2 < _pixBreiteX; _pX2 += 1)
                           for (_pY2 = 0; _pY2 < _pixBreiteY; _pY2 += 1)
                           {
                              switch (canvasNr)
                              {
                                 case 1:
                                    SetPixel1(_xstart + _pX1 + _pX2, _ystart + _pY1 + _pY2, _cBack1);
                                    break;
                                 case 2:
                                    SetPixel2(_xstart + _pX1 + _pX2, _ystart + _pY1 + _pY2, _cBack2);
                                    break;
                              }
                           }
                     }
                  }
               }
            }
         }
         catch
         {
         }
      }

      private void AnzeigeStatus()
      {
         Brush back1 = null; Brush Fore1 = Brushes.Black;
         Brush back2 = null; Brush Fore2 = Brushes.DarkRed;
         _xx = AnzeigeString(2, 1, 1, back1, Fore1, "Terminaltyp: ");
         _xx = AnzeigeString(2, _xx, 1, back2, Fore2, _TerminalTyp);
         _xx = AnzeigeString(2, 1, 2, back1, Fore1, "Fontname   : ");
         _xx = AnzeigeString(2, _xx, 2, back2, Fore2, _FontName);
         _xx = AnzeigeString(2, 1, 3, back1, Fore1, "PixelBreite: ");
         _xx = AnzeigeString(2, _xx, 3, back2, Fore2, Convert.ToString(_pixBreiteX) + "," + Convert.ToString(_pixBreiteY));
         _xx = AnzeigeString(2, _xx + 2, 3, back1, Fore1, "CharBreite : ");
         _xx = AnzeigeString(2, _xx, 3, back2, Fore2, Convert.ToString(_charX) + "," + Convert.ToString(_charY));
         _xx = AnzeigeString(2, _xx + 2, 3, back1, Fore1, "Pixel: ");
         _xx = AnzeigeString(2, _xx, 3, back2, Fore2, Convert.ToString(_pixX1) + "," + Convert.ToString(_pixY1));
      }
      private long AnzeigeString(int canvasNr, long X, long Y, Brush cBack, Brush cFore, string AnzeigeText)
      {
         int pX3;
         Brush _cBackX = Brushes.LightGray;

         if (cBack == null)
         {
            switch (canvasNr)
            {
               case 1: _cBackX = _cBack1; break;
               case 2: _cBackX = _cBack2; break;
            }
         }
         else { _cBackX = cBack; }

         try
         {
            for (pX3 = 0; pX3 < AnzeigeText.Length; pX3 += 1)
            {
               SetChar(canvasNr, X + pX3, Y, _cBackX, cFore, Convert.ToByte(Convert.ToChar(AnzeigeText.Substring(pX3, 1))));
            }
         }
         catch
         {
         }
         return X + AnzeigeText.Length;
      }

      private void LoadFont(string FontName)
      {
         byte[] _ByteStream;
         int _i, _pX, _pY;

         try
         {
            _FontName = FontName;
            _ByteStream = File.ReadAllBytes(FontName);
            if ((_ByteStream[0] != 170) || (_ByteStream[1] != 85))
            {
               MessageBox.Show("Ungültiger Font!");
               //Close();
            }
            _charX = _ByteStream[3] * 256 + _ByteStream[2];
            _charY = _ByteStream[5] * 256 + _ByteStream[4];
            _CharCode = new byte[256, 16];

            _i = 8;
            for (_pX = 0; _pX < 256; _pX += 1)
               for (_pY = 0; _pY < _charY; _pY += 1)
               {
                  _CharCode[_pX, _pY] = _ByteStream[_i];
                  _i += 1;
               }
         }
         catch
         {
            MessageBox.Show("Font nicht gefunden!");
            //Close();
         }
      }

      private bool IstBit(byte charZeile, long pos)
      {
         byte[] _ff = { 0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01 };
         bool _wert = false;

         _wert = ((charZeile & _ff[pos]) == _ff[pos]);

         return _wert;
      }
   }
}
