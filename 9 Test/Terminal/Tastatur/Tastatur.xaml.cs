using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Tastatur
{
   /// <summary>
   /// Interaktionslogik für UserControl1.xaml
   /// </summary>
   /// 
   public partial class Tastatur : UserControl
   {
      #region // Declaration
         private Brush LightEin = Brushes.Red;
         private Brush LightAus = Brushes.LightPink;

         public double ucHeight;
         public double ucWidth;
         private long PFs;
      #endregion

      // Declare the delegate (if using non-generic pattern).
      public delegate void MyEventHandler(object sender, MyEventArgs e);
      // Declare the event.
      public event MyEventHandler PFtaste;

      public void TastaturInit()
      {
         InitializeComponent();

         ucHeight = Grid1.Height;
         ucWidth = Grid1.Width;

         PFs0_Click(null,null);
      }

      private void ShiftF_Click(object sender, RoutedEventArgs e)
      {
         if (ShiftL.Background == LightAus )
         {
            ShiftL.Background = LightEin;

            B1.Content     = "!";
            B2.Content     = "\"";       //## "
            B3.Content     = "#";
            B4.Content     = "$";
            B5.Content     = "%";
            B6.Content     = "&";
            B7.Content     = "'";
            B8.Content     = "(";
            B9.Content     = ")";
            B0.Content     = "_";       //##
            minus.Content  = "=";
            dach.Content   = "_";      //##

            Bq.Content     = "Q";
            Bw.Content     = "W";
            Be.Content     = "E";
            Br.Content     = "R";
            Bt.Content     = "T";
            Bz.Content     = "Z";
            Bu.Content     = "U";
            Bi.Content     = "I";
            Bo.Content     = "O";
            Bp.Content     = "P";
            AT.Content     = "`";
            ekauf.Content  = "{";

            Ba.Content     = "A";
            Bs.Content     = "S";
            Bd.Content     = "D";
            Bf.Content     = "F";
            Bg.Content     = "G";
            Bh.Content     = "H";
            Bj.Content     = "J";
            Bk.Content     = "K";
            Bl.Content     = "L";
            semi.Content   = "+";
            dp.Content     = "*";
            ekzu.Content   = "}";

            Bnot.Content   = "\\";
            By.Content     = "Y";
            Bx.Content     = "X";
            Bc.Content     = "C";
            Bv.Content     = "V";
            Bb.Content     = "B";
            Bn.Content     = "N";
            Bm.Content     = "M";
            komma.Content  = "<";
            punkt.Content  = ">";
            bsl.Content    = "?";
         }
         else 
         {
            ShiftL.Background = LightAus;

            B1.Content     = "1";
            B2.Content     = "2";
            B3.Content     = "3";
            B4.Content     = "4";
            B5.Content     = "5";
            B6.Content     = "6";
            B7.Content     = "7";
            B8.Content     = "8";
            B9.Content     = "9";
            B0.Content     = "0";
            minus.Content  = "-";
            dach.Content   = "^";

            Bq.Content     = "q";
            Bw.Content     = "w";
            Be.Content     = "e";
            Br.Content     = "r";
            Bt.Content     = "t";
            Bz.Content     = "z";
            Bu.Content     = "u";
            Bi.Content     = "i";
            Bo.Content     = "o";
            Bp.Content     = "p";
            AT.Content     = "@";
            ekauf.Content  = "[";

            Ba.Content     = "a";
            Bs.Content     = "s";
            Bd.Content     = "d";
            Bf.Content     = "f";
            Bg.Content     = "g";
            Bh.Content     = "h";
            Bj.Content     = "j";
            Bk.Content     = "k";
            Bl.Content     = "l";
            semi.Content   = ";";
            dp.Content     = ":";
            ekzu.Content   = "]";

            Bnot.Content   = "|";
            By.Content     = "y";
            Bx.Content     = "x";
            Bc.Content     = "c";
            Bv.Content     = "v";
            Bb.Content     = "b";
            Bn.Content     = "n";
            Bm.Content     = "m";
            komma.Content  = ",";
            punkt.Content  = ".";
            bsl.Content    = "/";
         }
      }

      private void Char_Click(object sender, RoutedEventArgs e)
      {
         Button control = sender as Button;
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs(Convert.ToString(control.Content)));
      }

      private void A_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("A"));
      }
      private void B_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("B"));
      }
      private void C_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("C"));
      }
      private void D_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("D"));
      }
      private void E_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("E"));
      }
      private void F_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("F"));
      }

      private void Z0_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("0"));
      }
      private void Z00_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("00"));
      }
      private void Z000_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("000"));
      }

      private void ET1_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("ET1"));
      }
      private void ET2_Click(object sender, RoutedEventArgs e)
      {
         if (ET21.Background == LightAus)
         {
            ET21.Background = LightEin;
            ET22.Background = LightEin;
            ET23.Background = LightEin;
         }
         else
         {
            ET21.Background = LightAus;
            ET22.Background = LightAus;
            ET23.Background = LightAus;
         }
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("ET2"));
      }

      private void TabS_Click(object sender, RoutedEventArgs e)     // Tabulator setzen
      {
          if (PFtaste != null)
              PFtaste(this, new MyEventArgs("TabS"));
      }
      private void TabLL_Click(object sender, RoutedEventArgs e)    // Tabulator löschen
      {
          if (PFtaste != null)
              PFtaste(this, new MyEventArgs("TabLL"));
      }
      private void DEL_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste(this, new MyEventArgs("DEL"));
      }
      private void InsLine_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste(this, new MyEventArgs("InsLine"));
      }
      private void DelLine_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste(this, new MyEventArgs("DelLine"));
      }
      private void InsMod_Click(object sender, RoutedEventArgs e)
      {
         if (InsModL.Background == LightAus)
         {
            InsModL.Background = LightEin;
         }
         else
         {
            InsModL.Background = LightAus;
         }
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("InsMod"));
      }

      private void CI_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste(this, new MyEventArgs ("CI"));
      }
      private void M_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste(this, new MyEventArgs("MM"));
      }
      private void RES_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste(this, new MyEventArgs("RES"));
      }
      private void CE_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("CE"));
      }

      private void TabL_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("TabL"));
      }
      private void TabR_Click(object sender, RoutedEventArgs e)
      {
          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("TabR"));
      }

      private void Home_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("CHome"));
      }
      private void CLinks_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("CLinks"));
      }
      private void CRechts_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("CRechts"));
      }
      private void CHoch_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("CHoch"));
      }
      private void CRunter_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("CRunter"));
      }
      private void CNL_Click(object sender, RoutedEventArgs e)
      {
         if (PFtaste != null)
             PFtaste.Invoke(this, new MyEventArgs("CNL"));
      }

      #region    // PF-Tasten
          private void PFs0_Click(object sender, RoutedEventArgs e)
          {
              PFs = 0;
              PFs0.Background = LightEin;
              PFs1.Background = LightAus;      // WhiteSmoke
              PFs2.Background = LightAus;
              PFs3.Background = LightAus;

              PF01.Content = "1"; PF02.Content = "2"; PF03.Content = "3";
              PF04.Content = "4"; PF05.Content = "5"; PF06.Content = "6";
              PF07.Content = "7"; PF08.Content = "8"; PF09.Content = "9";
              PF10.Content = "10"; PF11.Content = "11"; PF12.Content = "12";
          }
          private void PFs1_Click(object sender, RoutedEventArgs e)
          {
              PFs = 1;
              PFs0.Background = LightAus;
              PFs1.Background = LightEin;
              PFs2.Background = LightAus;
              PFs3.Background = LightAus;

              PF01.Content = "13"; PF02.Content = "14"; PF03.Content = "15";
              PF04.Content = "16"; PF05.Content = "17"; PF06.Content = "18";
              PF07.Content = "19"; PF08.Content = "20"; PF09.Content = "21";
              PF10.Content = "22"; PF11.Content = "23"; PF12.Content = "24";
          }
          private void PFs2_Click(object sender, RoutedEventArgs e)
          {
              PFs = 2;
              PFs0.Background = LightAus;
              PFs1.Background = LightAus;
              PFs2.Background = LightEin;
              PFs3.Background = LightAus;

              PF01.Content = "25"; PF02.Content = "26"; PF03.Content = "27";
              PF04.Content = "28"; PF05.Content = "29"; PF06.Content = "30";
              PF07.Content = "31"; PF08.Content = "32"; PF09.Content = "33";
              PF10.Content = "34"; PF11.Content = "35"; PF12.Content = "36";
          }
          private void PFs3_Click(object sender, RoutedEventArgs e)
          {
              PFs = 3;
              PFs0.Background = LightAus;
              PFs1.Background = LightAus;
              PFs2.Background = LightAus;
              PFs3.Background = LightEin;

              PF01.Content = "37"; PF02.Content = "38"; PF03.Content = "39";
              PF04.Content = "40"; PF05.Content = "41"; PF06.Content = "42";
              PF07.Content = "43"; PF08.Content = "44"; PF09.Content = "45";
              PF10.Content = "46"; PF11.Content = "47"; PF12.Content = "48";
          }

          private void PF01_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 1);
          }
          private void PF02_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 2);
          }
          private void PF03_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 3);
          }
          private void PF04_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 4);
          }
          private void PF05_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 5);
          }
          private void PF06_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 6);
          }
          private void PF07_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 7);
          }
          private void PF08_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 8);
          }
          private void PF09_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 9);
          }
          private void PF10_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 10);
          }
          private void PF11_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 11);
          }
          private void PF12_Click(object sender, RoutedEventArgs e)
          {
              PFClick(sender, e, 12);
          }
      #endregion
      private void PFClick(object sender, RoutedEventArgs e, long pf)
      {
          long pf1;
          pf1 = PFs * 12 + pf;

          if (PFtaste != null)
              PFtaste.Invoke(this, new MyEventArgs("PF"+Convert.ToString(pf1)));
      }

   }

   public class MyEventArgs
   {
       public MyEventArgs(string s) { Text = s; }
       public String Text { get; private set; } // readonly
   }
}
