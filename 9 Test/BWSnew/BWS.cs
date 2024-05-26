using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace BWSnew
{
    public partial class BWS : Form
    {
        private const int BWSx = 2;
        private const int BWSy = 2;
        private const int Zx = 7;
        private const int Zy = 16;
        private const int PIx = 1;
        private const int PIy = 1;

        public BWS()
        {
            InitializeComponent();
        }

        //public Zeichen Zeichen1;

        Dictionary<int, Zeichen> ZeichenDict = new Dictionary<int, Zeichen>();
        Dictionary<int, PictureBox> PictureBoxDict = new Dictionary<int, PictureBox>();

        bool[,] zeichenTemplate = { { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false },
                                     { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false },
                                     { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false },
                                     { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false },
                                     { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false },
                                     { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false },
                                     { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false },
                                     { true, false,true, false,true, false, true },
                                     { false, true,false, true,false, true, false }
                                 };
        //bool[,] zeichenTemplate = { { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false },
        //                            { false, false,false, false,false, false, false }
        //                          };

        private void BWS_Load(object sender, EventArgs e)        
        {
            BWS_Create();

            //Zeichen Z = ZeichenDict[83];
            //Z.SetZeichen(Z, zeichenTemplate);


            //            Zeichen.SetZeichen(zeichenTemplate);
            
        }

        private void BWS_Create()
        {
            for (int i = 0; i < BWSy; i++)
                for (int j = 0; j < BWSx; j++)
                {
                    var PB = new PictureBox()
                    {
                        Location = new System.Drawing.Point(j * Zx * PIx, i * Zy * PIy),
                        Size = new System.Drawing.Size(PIx * Zx, PIy * Zy),
                        BorderStyle = BorderStyle.None 
                    };
                    this.Controls.Add(PB);
                    PictureBoxDict.Add(i * BWSx + j, PB);

                    var Zeichen = new Zeichen()
                    {
                        PixelX = PIx,
                        PixelY = PIy,
                        ZeichenX = Zx,
                        ZeichenY = Zy,
                        Location = new System.Drawing.Point(0, 0),
                        Size = new System.Drawing.Size(PIx*Zx, PIy*Zy),
                        ZeichenColorBack = System.Drawing.Color.Blue,
                        ZeichenColorFore = System.Drawing.Color.Yellow,

                        Name = "Zeichen" + string.Format("X{0}", i) + string.Format("Y{0}", j),
                        Text = ""
                    };                    
                    this.Controls.Add(Zeichen);
                    ZeichenDict.Add(i * BWSx + j, Zeichen);

                    PB.Image = Zeichen.Image;
                }
            for (int i = 0; i < BWSy; i++)
                for (int j = 0; j < BWSx; j++)
                {
                    {
                        Zeichen Z = ZeichenDict[i*BWSx+j];
                        PictureBox PB = PictureBoxDict[i*BWSx+j];
                        Z.Init();
                        Z.SetZeichen(Z, zeichenTemplate);
                        PB.Image = Z.Image;
                    }
                }
            
        }
    }
}
