using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace TerminalTest
{
    /// <summary>
    /// Interaktionslogik für MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
      Terminal.Terminal ucTerminal1 = new Terminal.Terminal();
      TerminalG.TerminalG ucTerminalG1 = new TerminalG.TerminalG();

      long xx, yy;
      string FontVerz = "D:\\devel\\1 DEG2000\\FONT\\";
      string FontStart = "7024-1.FNT";
      Brush CanvasBack = Brushes.BurlyWood;
      double Abst        =  3,
             TitelHeight = 39,
             ucTheight,
             ucTwidth,
             ucTastLeft;

      public MainWindow()
      {
         InitializeComponent();

         try
         {
                Canvas1.Background = CanvasBack;

                Canvas1.Children.Add(ucTerminal1);
                ucTerminal1.SetColors1(Brushes.Gray, Brushes.Yellow, Brushes.Red, Brushes.Gray);
                ucTerminal1.SetColors2(Brushes.LightBlue, Brushes.Black, Brushes.Red, Brushes.LightGray);
                ucTerminal1.TerminalInit(1, 1, 8, 12, 80, 24, 80, 3, FontVerz + FontStart);
                Canvas.SetLeft(ucTerminal1, Abst);
                Canvas.SetTop(ucTerminal1, Abst);

                Canvas1.Children.Add(ucTerminalG1);
                ucTerminalG1.SetColors1(Brushes.Gray, Brushes.Yellow, Brushes.Red, Brushes.Gray);
                ucTerminalG1.SetColors2(Brushes.LightBlue, Brushes.Black, Brushes.Red, Brushes.LightGray);
                ucTerminalG1.TerminalInit(1, 1, 8, 12, 640, 384, 80, 3, FontVerz + FontStart);
                //         ucTerminalG1.TerminalInit(1, 1, 8, 12, 0, 0, 0, 0, FontVerz + FontStart); 
                Canvas.SetLeft(ucTerminalG1, 2 * Abst + ucTerminal1.ucWidth);
                Canvas.SetTop(ucTerminalG1, Abst);

                ucTwidth = ucTerminal1.ucWidth + Abst + ucTerminalG1.ucWidth;

                Tastatur.Tastatur ucTastatur1 = new Tastatur.Tastatur();
                Canvas1.Children.Add(ucTastatur1);
                ucTastatur1.TastaturInit();
                ucTastatur1.PFtaste += new Tastatur.Tastatur.MyEventHandler(ucTastatur1_PFtaste);

                if (ucTerminal1.ucHeight > ucTerminalG1.ucHeight)
                    ucTheight = ucTerminal1.ucHeight;
                else
                    ucTheight = ucTerminalG1.ucHeight;

                if (ucTwidth > ucTastatur1.ucWidth)
                    ucTastLeft = (ucTwidth - ucTastatur1.ucWidth) / 2;
                else
                {
                    ucTastLeft = 0;
                    ucTwidth = ucTastatur1.ucWidth;
                }
                Canvas.SetLeft(ucTastatur1, Abst + ucTastLeft);
                Canvas.SetTop(ucTastatur1, 2 * Abst + ucTheight);

                Term1.Width = Abst + ucTwidth + Abst + 16;
                Term1.Height = Abst + ucTheight + Abst + ucTastatur1.ucHeight + Abst + TitelHeight;

                //ucTerminal1.SetPixel(10, 10, Brushes.Red);
                ucTerminal1.Testbild3();
                //ucTerminal1.Testbild2(Brushes.Beige, Brushes.Black);            
                //         ucTerminal1.SetBackground(Brushes.Blue);
                //ucTerminal1.SetChar(1, 1, 1, Brushes.Blue, Brushes.Yellow, Convert.ToByte(Convert.ToChar("A")));
                //ucTerminal1.SetChar(2, 1, 1, null, Brushes.Black, Convert.ToByte(Convert.ToChar("A")));

                for (yy = 50; yy < 100; yy += 1)
                    for (xx = 20; xx < 30; xx += 1)
                    {
                        ucTerminalG1.SetPixel1(xx, yy, Brushes.Yellow);
                    }
            }
            catch
         { }
         
         ucTerminal1.SetCursor(1, 1, 1);
      }

      void ucTastatur1_PFtaste(object sender,  Tastatur.MyEventArgs PF1)
      {
          try
          {
                switch (PF1.Text)
                {
                    case "CI":
                        ucTerminal1.SetCursor(1, 0, 0);
                        ucTerminal1.SetCursor(1, -1, -1);
                        //                              ucTerminal1.Testbild2(Brushes.Beige, Brushes.Black);
                        break;
                    case "MM":
                        ucTerminal1.SetCursor(1, 0, 0);
                        ucTerminal1.SetCursor(2, -1, -1);
                        //               ucTerminal1.Testbild1(null        , Brushes.Yellow);
                        break;
                    case "RES":
                        ucTerminal1.SetCursor(1, 0, 0);
                        ucTerminal1.SetCursor(3, -1, -1);
                        //               ucTerminal1.Testbild1(Brushes.Blue, Brushes.Yellow);
                        break;
                    case "CE":
                        ucTerminal1.SetCursor(1, 0, 0);
                        //ucTerminal1.SetCursor(3, xx, yy);
                        break;
                    case "CHome":
                        ucTerminal1.CHome();  //TerminalDEL();
                        break;
                    case "CLinks":
                        ucTerminal1.CLinks();
                        break;
                    case "CRechts":
                        ucTerminal1.CRechts();
                        break;
                    case "CHoch":
                        ucTerminal1.CHoch();
                        break;
                    case "CRunter":
                        ucTerminal1.CRunter();
                        break;
                    case "CNL":
                        ucTerminal1.CNL();
                        break;
                    case "InsMod":
                        break;
                    case "ET1":
                        break;
                    case "ET2":
                        break;

                    case "DelLine":
                        break;

                    #region // PF-Tasten
                    #region // Ebene 0: PF01...PF12
                    case "PF1":
                        ucTerminal1.Testbild1(null, Brushes.Yellow);
                        ucTerminal1.SetCursor(1, 1, 1);
                        break;
                    case "PF2":
                        ucTerminal1.Testbild1(Brushes.Blue, Brushes.Yellow);
                        ucTerminal1.SetCursor(1, 1, 1);
                        break;
                    case "PF3":
                        ucTerminal1.Testbild3();
                        break;
                    case "PF4":
                        ucTerminal1.Testbild2(Brushes.Beige, Brushes.Black);
                        ucTerminal1.SetCursor(1, 1, 1);
                        break;
                    case "PF5":
                        break;
                    case "PF6":
                        break;
                    case "PF7":
                        break;
                    case "PF8":
                        break;
                    case "PF9":
                        break;
                    case "PF10":
                        break;
                    case "PF11":
                        break;
                    case "PF12":
                        break;
                    #endregion
                    #region // Ebene 1: PF13...PF24
                    case "PF13":
                        break;
                    case "PF14":
                        break;
                    case "PF15":
                        break;
                    case "PF16":
                        break;
                    case "PF17":
                        break;
                    case "PF18":
                        break;
                    case "PF19":
                        break;
                    case "PF20":
                        break;
                    case "PF21":
                        break;
                    case "PF22":
                        break;
                    case "PF23":
                        break;
                    case "PF24":
                        break;
                    #endregion
                    #region // Ebene 2: PF25...PF36
                    case "PF25":
                        break;
                    case "PF26":
                        break;
                    case "PF27":
                        break;
                    case "PF28":
                        break;
                    case "PF29":
                        break;
                    case "PF30":
                        break;
                    case "PF31":
                        break;
                    case "PF32":
                        break;
                    case "PF33":
                        break;
                    case "PF34":
                        break;
                    case "PF35":
                        break;
                    case "PF36":
                        break;
                    #endregion
                    #region // Ebene 3: PF37...PF48
                    case "PF37":
                        break;
                    case "PF38":
                        break;
                    case "PF39":
                        break;
                    case "PF40":
                        break;
                    case "PF41":
                        break;
                    case "PF42":
                        break;
                    case "PF43":
                        break;
                    case "PF44":
                        break;
                    case "PF45":
                        break;
                    case "PF46":
                        break;
                    case "PF47":
                        break;
                    case "PF48":
                        break;
                    #endregion
                    #endregion

                    case "00":
                        ucTerminal1.SetChar(1, -1, -1, Brushes.Beige, Brushes.Black, Convert.ToByte(Convert.ToChar("0")));
                        ucTerminal1.SetChar(1, -1, -1, Brushes.Beige, Brushes.Black, Convert.ToByte(Convert.ToChar("0")));
                        ucTerminal1.SetCursor(1, -1, -1);
                        break;
                    case "000":
                        ucTerminal1.SetChar(1, -1, -1, Brushes.Beige, Brushes.Black, Convert.ToByte(Convert.ToChar("0")));
                        ucTerminal1.SetChar(1, -1, -1, Brushes.Beige, Brushes.Black, Convert.ToByte(Convert.ToChar("0")));
                        ucTerminal1.SetChar(1, -1, -1, Brushes.Beige, Brushes.Black, Convert.ToByte(Convert.ToChar("0")));
                        ucTerminal1.SetCursor(1, -1, -1);
                        break;

                    default:
                        if (PF1.Text.Length == 1)
                        {
                            ucTerminal1.SetChar(1, -1, -1, Brushes.Beige, Brushes.Black, Convert.ToByte(Convert.ToChar(PF1.Text)));
                            ucTerminal1.SetCursor(1, -1, -1);
                        }
                        break;
                }
          }
          catch
          { }
      }
   }
}
