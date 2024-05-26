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

namespace WPF_Test
{
   /// <summary>
   /// Interaktionslogik für TerminalPoint.xaml
   /// </summary>
   /// 
   public partial class TerminalPoint : UserControl
   {
      #region // Declarations
      private Brush _PointColor;
      private static double _PointX, _PointY;
      #endregion

      public Brush PointColor 
      { get { return _PointColor; }
        set {        _PointColor = value; }
      }

      public double PointX
      { get{ return _PointX; }
        set{ if (value >= 0 && value < 10) _PointX = value;
             else                          _PointX = 1;
           }
      }

      public double PointY
      {
         get { return _PointY; }
         set
         {
            if (value >= 0 && value < 10) _PointY = value;
            else                          _PointY = 1;
         }
      }


      public TerminalPoint() //long pointX1 = 1, long pointY1 = 1) //, Brush pointColor1 = Brushes.Yellow)
      {
         InitializeComponent();
         PointX = 20;             //_Point.Width  = _PointX;  //pointX1;  
         PointY = 50;             //_Point.Height = _PointY;
         PointColor = Brushes.Blue; // _Point.Background = _pointColor; //pointColor1; 
      }
   }
}


//              d:DesignHeight="{Binding Path=_Point.Height}" d:DesignWidth="{Binding Path=_Point.Width}"

//Background = "{Binding Path=TerminalPoint.pointColor}" 
//              Height="{Binding Path=TerminalPoint.pointY}" 
//              Width ="{Binding Path=TerminalPoint.pointX}" 


//      <Canvas x:Name="_Point" Margin="0,0,0,0" Height="4" Width="4"
//      /> // Canvas

//       Height     = "{Binding Path=_pointY}" 
//       Width      = "{Binding Path=_pointX}" 
