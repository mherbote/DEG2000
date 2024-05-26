using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;
using System.IO;

namespace Terminal
{
    /// <summary>
    /// Interaktionslogik für Terminal.xaml
    /// </summary>
    public partial class Terminal : UserControl
    {
      #region // Declaration
          public double ucHeight;
          public double ucWidth;

          private static string _TerminalTyp;
          private static int    _CursorTyp;                                      // 1 ... Unterstrich
                                                                                 // 2 ... Voller         Block
                                                                                 // 3 ... Invertierender Block
          private static long   _CursorX1, _CursorX2, _CursorXret, _xx, _xstart;
          private static long   _CursorY1, _CursorY2, _CursorYret, _yy, _ystart;
          private static bool   _Cursor;
          private static string _FontName;
          private static long   _pixBreiteX, _charX, _AnzX1, _pixX1, _AnzX2, _pixX2;
          private static long   _pixBreiteY, _charY, _AnzY1, _pixY1, _AnzY2, _pixY2;
          private static Brush  _cBack1  = Brushes.LightBlue; private static Brush _cFore1 = Brushes.Yellow; private static Brush _cBorder1 = Brushes.Gray;
          private static Brush  _cBack2  = Brushes.LightBlue; private static Brush _cFore2 = Brushes.Yellow; private static Brush _cBorder2 = Brushes.Gray;
          private static Brush  _cCursor = Brushes.Red;
          private static Brush _c31;
          private static Brush _c32;

      //  DispatcherTimer setup
      DispatcherTimer timer = new DispatcherTimer();

          Rectangle[,] _r1;
          Rectangle[,] _r2;
          Brush    [,] _cc;
          bool     [,] _c;
          byte     [,] _CharCode;
      #endregion

      public void TerminalInit(long   pixBreiteX =  1, long pixBreiteY =  1, 
                                 long   charX      =  8, long charY      = 12,
                                 long   AnzX1      = 80, long AnzY1      = 24,
                                 long   AnzX2      = 80, long AnzY2      =  2,
                                 string FontName   = "7024-0.FNT")
      {
         InitializeComponent();

         int i; int j;
         //Tick EventHandler
            timer.Tick += new EventHandler(Timer_Tick);
         //Tick interval einstellen und Timer starten.
            timer.Interval = new TimeSpan(0, 0, 0, 0, 50);

         _TerminalTyp = "ALPHA";
         _CursorTyp   = 1;
         _Cursor      = false;
         _CursorX1 = 0;
         _CursorY1 = 0;
         _CursorX2 = 1;
         _CursorY2 = 1;

         _pixBreiteX = pixBreiteX; _charX = charX; _AnzX1 = AnzX1; _AnzX2 = AnzX2;
         _pixBreiteY = pixBreiteY; _charY = charY; _AnzY1 = AnzY1; _AnzY2 = AnzY2;

         LoadFont(FontName);
         _pixX1 = _charX * _AnzX1; _pixY1 = _charY * _AnzY1;
         _pixX2 = _charX * _AnzX2; _pixY2 = _charY * _AnzY2;

         _r1 = new Rectangle[_pixX1, _pixY1];
         _r2 = new Rectangle[_pixX2, _pixY2];
         _cc = new Brush    [_charX, _charY];
         _c  = new bool     [_charX, _charY];

         _canvas1.Children.Clear();
         _canvas1.Background = _cBack1;
         _canvas1.Width      = _pixBreiteX * _pixX1;
         _canvas1.Height     = _pixBreiteY * _pixY1;
         _border1.Width      = _canvas1.Width + 2;
         _border1.Height     = _canvas1.Height + 2;

         _canvas2.Children.Clear();
         _canvas2.Background = _cBack2;
         _canvas2.Width      = _pixBreiteX * _pixX2;
         _canvas2.Height     = _pixBreiteY * _pixY2;
         _border2.Width      = _canvas2.Width  + 2;
         _border2.Height     = _canvas2.Height + 2;

         if (_border1.Width >_border2.Width)          ucWidth = _border1.Width;
         else                                         ucWidth = _border2.Width;
         
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
//*         timer.Start();
      }

      public void SetColors1(Brush BackColor, Brush ForeColor, Brush CursorColor, Brush BorderColor)
      {
         _cBack1   = BackColor;
         _cFore1   = ForeColor;
         _cBorder1 = BorderColor;
         _cCursor  = CursorColor;
      }
      public void SetColors2(Brush BackColor, Brush ForeColor, Brush CursorColor, Brush BorderColor)
      {
          _cBack2   = BackColor;
          _cFore2   = ForeColor;
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
         long Xloc, Yloc;
         long _xstart, _ystart;
         long _pX1, _pX2, _pY1, _pY2;

            try
            {
                if (X == -1 & Y == -1) 
                { 
                    switch (canvasNr)
                    { 
                        case 1: 
                            Xloc = _CursorX1;
                            Yloc = _CursorY1;
                            break;
                        case 2:
                            Xloc = _CursorX2;
                            Yloc = _CursorY2;
                            break;
                        default:
                            Xloc = 1;
                            Yloc = 1;
                            break;
                    }
                }
                else
                { 
                    Xloc = X; 
                    Yloc = Y; 
                }

                _xstart = (Xloc - 1) * _pixBreiteX * _charX;
                _ystart = (Yloc - 1) * _pixBreiteY * _charY;

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

                switch (canvasNr)
                {
                    case 1:
                        _CursorX1 += 1;
                        if (_CursorX1 > _AnzX1)
                        {
                            _CursorX1 = 1;
                            _CursorY1 += 1;
                            if (_CursorY1 == _AnzY1)
                            {
                                //TODO:  Zeilen nach oben scrollen
                            }
                        }
                        break;
                    case 2:
                        _CursorX2 += 1;
                        if (_CursorX2 > _AnzX2)
                        {
                            _CursorX2 = 1;
                            _CursorY2 += 1;
                            if (_CursorY2 == _AnzY2)
                            {
                                //TODO:  Zeilen nach oben scrollen
                            }
                        }
                        break;
                }
            }
            catch
            {
            }
      }

      public void SetCursor(int CursorTyp, long X, long Y)
      {
         long _x1, _y1;
         long _xstart, _ystart;

         if (X == 0 & Y == 0 & _CursorX1 != 0 & _CursorY1 != 0)
         {
            // Alten Cursor zurück setzen
            _xstart = (_CursorX1 - 1) * _pixBreiteX * _charX;
            _ystart = (_CursorY1 - 1) * _pixBreiteY * _charY;
            _Cursor = false;
            timer.Stop();
            for (_x1 = 0; _x1 < _charX; _x1 += 1)
               for (_y1 = 0; _y1 < _charY; _y1 += 1)
               {
                  _r1[_xstart + _x1, _ystart + _y1].Fill = _cc[_x1, _y1];
               }
         }
         else
         {
             if (X == -1 | Y == -1)
             { }
             else
             {
                 _CursorX1 = X;
                 _CursorY1 = Y;
             }

            _CursorTyp = CursorTyp;
            _c31 = null;
            _c32 = null;

            _xstart = (_CursorX1 - 1) * _pixBreiteX * _charX;
            _ystart = (_CursorY1 - 1) * _pixBreiteY * _charY;
            for (_y1 = 0; _y1 < _charY; _y1 += 1)
                for (_x1 = 0; _x1 < _charX; _x1 += 1)
                {
                    _cc[_x1, _y1] = _r1[_xstart + _x1, _ystart + _y1].Fill;
                    if (_c31 == null)
                    {
                        _c31 = _cc[_x1, _y1];
                    }
                    else
                    {
                        if (_c32 == null & _c31 != _cc[_x1, _y1])
                        {
                            _c32 = _cc[_x1, _y1];
                        }
                    }
                }             
//*            timer.Start();
         }
         AnzeigeCursorStatus();
      }

      public void Testbild1(Brush cBack, Brush cFore)
      {
         byte  _pZ = 0x00;
         long  _pX1, _pY1;
         Brush _cBackX;

         if (cBack == null) { _cBackX = _cBack1; }
         else
         {
            _cBackX = cBack;
            _cBack1 = cBack;
         }

         for (_pY1 = 1; _pY1 <= _AnzY1; _pY1 += 1)
            for (_pX1 = 1; _pX1 <= _AnzX1; _pX1 += 1)
            {
               SetChar(1,_pX1, _pY1, _cBackX, cFore, _pZ);
               _pZ += 1;
               if (_pZ == 255) { _pZ = 0x00; }
            }
      }

      public void Testbild2(Brush cBack, Brush cFore)
      {
         long   pX1,pX2, pY1;
         int    pX3;
         Brush  _cBackX;
         string _test = "----+----";

         if (cBack == null)  { _cBackX = _cBack1; }
         else                { _cBackX =  cBack;
                               _cBack1 = cBack;
                             }

         for (pY1 = 1; pY1 <= _AnzY1; pY1 += 1)
            for (pX1 = 1; pX1 <= _AnzX1; pX1 += 10)
            {
               for (pX3 = 0; pX3 <= 8; pX3 += 1)
               {
                  pX2 = pX1 + Convert.ToInt64(pX3);
                  SetChar(1,pX2, pY1, _cBackX, cFore, Convert.ToByte(Convert.ToChar(_test.Substring(pX3, 1))));
               }
                  pX2 = pX1 + Convert.ToInt64(pX3);
                  SetChar(1,pX2, pY1, _cBackX, cFore, Convert.ToByte(0x30 + (pX1 + 9) / 10));
            }
      }

        public void Testbild3()
        {
            long pX1, pY1;
            int  pX2, pY2;
            string [] _s; _s = new string [11];
            long   [] _y; _y = new long   [11];
            Brush  [] _b; _b = new Brush  [11];

            _s[ 0] = "Z80-Emulator als Basisemulator";                            _y[ 0] =  2; _b[ 0] = Brushes.White;
            _s[ 1] = "Copyright (C) 1987-2008 by Udo Munk";                       _y[ 1] =  3; _b[ 1] = Brushes.White;
            _s[ 2] = "Release 1.17";                                              _y[ 2] =  4; _b[ 2] = Brushes.White;

            _s[3] = "DEG2000-System Emulator";                                    _y[ 3] =  7; _b[ 3] = Brushes.Red;
            _s[ 4] = "Release 0.01";                                              _y[ 4] =  9; _b[ 4] = Brushes.Yellow;
            _s[ 5] = "Version fuer MiniTAP mit TRAM, neue Tastatur/ATS";          _y[ 5] = 11; _b[ 5] = Brushes.Yellow;
            _s[ 6] = "Copyright (C) 1996-2018 by Marcus Herbote";                 _y[ 6] = 13; _b[ 6] = Brushes.Yellow;

            _s[7] = "D E G 2 0 0 0   Software";                                   _y[ 7] = 16; _b[ 7] = Brushes.White;
            _s[ 8] = "Copyright (C) 1981-1982 by IFR             Berlin/GDR";     _y[ 8] = 17; _b[ 8] = Brushes.White;
            _s[ 9] = "Copyright (C) 1983-1985 by K EAW           Berlin/GDR";     _y[ 9] = 18; _b[ 9] = Brushes.White;
            _s[10] = "Copyright (C) 1986-1990 by WMK \"7.Oktober\" Berlin/GDR";   _y[10] = 19; _b[10] = Brushes.White;

            for (pY1=1; pY1<= _AnzY1 ;pY1++)
                for (pX1 = 1; pX1 <= _AnzX1; pX1++)
                { 
                    SetChar(1, pX1, pY1, Brushes.Blue, Brushes.Yellow, Convert.ToByte(0x20));
                }

            for (pY2 = 0; pY2 < 11; pY2++)
            {
                pY1 = _y[pY2];
                for (pX2 = 0; pX2 < _s[pY2].Length; pX2++)
                {
                    pX1 = 17 + pX2;
                    SetChar(1, pX1, pY1, Brushes.Blue, _b[pY2], Convert.ToByte(Convert.ToChar(_s[pY2].Substring(pX2, 1))));
                }
            }
        }

      public void CHome()
      {
         SetCursor(1, 0, 0);
         _CursorX1 = 1;
         _CursorY1 = 1;
         SetCursor(1, _CursorX1, _CursorY1);
      }
      public void CLinks()
      {
         _CursorXret = _CursorX1;
         _CursorYret = _CursorY1;
         SetCursor(_CursorTyp, 0, 0);

         _CursorX1 = _CursorXret - 1; if (_CursorX1 < 1) _CursorX1 = 1;
         _CursorY1 = _CursorYret;
         SetCursor(_CursorTyp, _CursorX1, _CursorY1);
      }
      public void CRechts()
      {
         _CursorXret = _CursorX1;
         _CursorYret = _CursorY1;
         SetCursor(_CursorTyp, 0, 0);

         _CursorX1 = _CursorXret + 1; if (_CursorX1 > _AnzX1) _CursorX1 = _AnzX1;
         _CursorY1 = _CursorYret;
         SetCursor(_CursorTyp, _CursorX1, _CursorY1);
      }
      public void CHoch()
      {
         _CursorXret = _CursorX1;
         _CursorYret = _CursorY1;
         SetCursor(_CursorTyp, 0, 0);

         _CursorX1 = _CursorXret; 
         _CursorY1 = _CursorYret - 1; if (_CursorY1 < 1) _CursorY1 = 1;
         SetCursor(_CursorTyp, _CursorX1, _CursorY1);
      }
      public void CRunter()
      {
         _CursorXret = _CursorX1;
         _CursorYret = _CursorY1;
         SetCursor(_CursorTyp, 0, 0);

         _CursorX1 = _CursorXret;
         _CursorY1 = _CursorYret + 1; if (_CursorY1 > _AnzY1) _CursorY1 = _AnzY1;
         SetCursor(_CursorTyp, _CursorX1, _CursorY1);
      }
      public void CNL()
      {
         _CursorXret = _CursorX1;
         _CursorYret = _CursorY1;
         SetCursor(_CursorTyp, 0, 0);

         _CursorX1 = 1;
         _CursorY1 = _CursorYret + 1; if (_CursorY1 > _AnzY1) _CursorY1 = _AnzY1;
         SetCursor(_CursorTyp, _CursorX1, _CursorY1);
      }

      public void TerminalDEL()
      {
         SetCursor(1, 0, 0);
         for (_yy = 1; _yy <= _AnzY1; _yy += 1)
            for (_xx = 1; _xx <= _AnzX1; _xx += 1)
            {
               SetChar(1, _xx, _yy, Brushes.Beige, Brushes.Black,Convert.ToByte(Convert.ToChar(" ")));
            }
         _CursorX1 = 1;
         _CursorY1 = 1;
         SetCursor(1, _CursorX1, _CursorY1);
      }

      private void AnzeigeStatus()
      {
         Brush back1 = null; Brush Fore1 = Brushes.Black;
         Brush back2 = null; Brush Fore2 = Brushes.DarkRed;
         _xx = AnzeigeString(2,     1,1, back1, Fore1, "Terminaltyp: ");
         _xx = AnzeigeString(2, _xx  ,1, back2, Fore2, _TerminalTyp   );
         _xx = AnzeigeString(2,     1,2, back1, Fore1, "Fontname   : ");
         _xx = AnzeigeString(2, _xx  ,2, back2, Fore2, _FontName);
         _xx = AnzeigeString(2,     1,3, back1, Fore1, "PixelBreite: ");
         _xx = AnzeigeString(2, _xx  ,3, back2, Fore2, Convert.ToString(_pixBreiteX) + "," + Convert.ToString(_pixBreiteY));
         _xx = AnzeigeString(2, _xx+2,3, back1, Fore1, "CharBreite : ");
         _xx = AnzeigeString(2, _xx  ,3, back2, Fore2, Convert.ToString(_charX) + "," + Convert.ToString(_charY));
         _xx = AnzeigeString(2, _xx+2,3, back1, Fore1, "Char : ");
         _xx = AnzeigeString(2, _xx  ,3, back2, Fore2, Convert.ToString(_AnzX1) + "," + Convert.ToString(_AnzY1));
         _xx = AnzeigeString(2, _xx+2,3, back1, Fore1, "Pixel: ");
         _xx = AnzeigeString(2, _xx  ,3, back2, Fore2, Convert.ToString(_pixX1) + "," + Convert.ToString(_pixY1));
         AnzeigeCursorStatus();
      }
      private void AnzeigeCursorStatus()
      {
         Brush back1 = null; Brush Fore1 = Brushes.Black;
         Brush back2 = null; Brush Fore2 = Brushes.DarkRed;
         _xx = AnzeigeString(2, _AnzX2-20, 1, back1, Fore1, "CursorPos: ");
               AnzeigeString(2, _xx      , 1, back2, Fore2, "         ");
               AnzeigeString(2, _xx      , 1, back2, Fore2, Convert.ToString(_CursorX1) + "," + Convert.ToString(_CursorY1));
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

      private void CursorEinAus()
      {
         _xstart = (_CursorX1 - 1) * _pixBreiteX * _charX;
         _ystart = (_CursorY1 - 1) * _pixBreiteY * _charY;

         if (_CursorX1 == 0 & _CursorY1 == 0) { return; }

         try
         {
            switch (_Cursor)
            {
               case true:
                  _Cursor = false;
                  for (_xx = 0; _xx < _charX; _xx += 1)
                     for (_yy = 0; _yy < _charY; _yy += 1)
                     {
                        _r1[_xstart + _xx, _ystart + _yy].Fill = _cc[_xx, _yy];
                     }
                  //timer.Interval = new TimeSpan(0, 0, 0, 1);
                  break;
               case false:
                  _Cursor = true;
                  switch (_CursorTyp)
                  {
                     case 1:
                        for (_xx = 0; _xx < _charX; _xx += 1)
                           for (_yy = 1; _yy <= 2; _yy += 1)
                           {
                              SetPixel1(_xstart + _xx, _ystart + _pixBreiteY * _charY - _yy - 2, _cCursor);
                           }
                        //timer.Interval = new TimeSpan(0, 0, 0, 0, 150);
                        break;
                     case 2:
                        for (_xx = 0; _xx < _charX; _xx += 1)
                           for (_yy = 0; _yy < _charY; _yy += 1)
                           {
                              SetPixel1(_xstart + _xx, _ystart + _yy, _cCursor);
                           }
                        break;
                     case 3:
                        for (_xx = 0; _xx < _charX; _xx += 1)
                           for (_yy = 0; _yy < _charY; _yy += 1)
                           {
                              if (_cc[_xx, _yy] == _c31)
                                 _r1[_xstart + _xx, _ystart + _yy].Fill = _c32;
                              else
                                 _r1[_xstart + _xx, _ystart + _yy].Fill = _c31;
                           }
                        break;
                  }
                  break;
            }
         }
         catch
         { 
         }
      }

      private void Timer_Tick(object sender, EventArgs e)
      {
         CursorEinAus();
      }
    }
}
