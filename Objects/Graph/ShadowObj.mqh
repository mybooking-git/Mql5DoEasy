//+------------------------------------------------------------------+
//|                                                    ShadowObj.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "GCnvElement.mqh"
#include <Math\Alglib\alglib.mqh>
//+------------------------------------------------------------------+
//| Shadow object class                                              |
//+------------------------------------------------------------------+
class CShadowObj : public CGCnvElement
  {
private:
   color             m_color_shadow;                  // Shadow color
   uchar             m_opacity_shadow;                // Shadow opacity
   
//--- Gaussian blur
   bool              GaussianBlur(const uint radius);
//--- Return the array of weight ratios
   bool              GetQuadratureWeights(const double mu0,const int n,double &weights[]);
//--- Draw the object shadow form
   void              DrawShadowFigureRect(const int w,const int h);

public:
//--- Constructor
                     CShadowObj(const long chart_id,
                                const int subwindow,
                                const string name,
                                const int x,
                                const int y,
                                const int w,
                                const int h);

//--- Supported object properties (1) integer and (2) string ones
   virtual bool      SupportProperty(ENUM_CANV_ELEMENT_PROP_INTEGER property) { return true; }
   virtual bool      SupportProperty(ENUM_CANV_ELEMENT_PROP_STRING property)  { return true; }

//--- Draw an object shadow
   void              DrawShadow(const int shift_x,const int shift_y,const uchar blur_value);
   
//+------------------------------------------------------------------+
//| Methods of simplified access to object properties                |
//+------------------------------------------------------------------+
//--- (1) Set and (2) return the shadow color
   void              SetColorShadow(const color colour)                       { this.m_color_shadow=colour;    }
   color             ColorShadow(void)                                  const { return this.m_color_shadow;    }
//--- (1) Set and (2) return the shadow opacity
   void              SetOpacityShadow(const uchar opacity)                    { this.m_opacity_shadow=opacity; }
   uchar             OpacityShadow(void)                                const { return this.m_opacity_shadow;  }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CShadowObj::CShadowObj(const long chart_id,
                       const int subwindow,
                       const string name,
                       const int x,
                       const int y,
                       const int w,
                       const int h) : CGCnvElement(GRAPH_ELEMENT_TYPE_SHADOW_OBJ,chart_id,subwindow,name,x,y,w,h)
  {
   this.m_type=OBJECT_DE_TYPE_GSHADOW; 
   CGCnvElement::SetColorBackground(clrNONE);
   CGCnvElement::SetOpacity(0);
   CGCnvElement::SetActive(false);
   this.m_opacity_shadow=127;
   color gray=CGCnvElement::ChangeColorSaturation(ChartColorBackground(),-100);
   this.m_color_shadow=CGCnvElement::ChangeColorLightness(gray,-50);
   this.m_shadow=false;
   this.m_visible=true;
   CGCnvElement::Erase();
  }
//+------------------------------------------------------------------+
//| Draw the object shadow                                           |
//+------------------------------------------------------------------+
void CShadowObj::DrawShadow(const int shift_x,const int shift_y,const uchar blur_value)
  {
//--- Calculate the height and width of the drawn rectangle
   int w=this.Width()-OUTER_AREA_SIZE*2;
   int h=this.Height()-OUTER_AREA_SIZE*2;
//--- Draw a filled rectangle with calculated dimensions
   this.DrawShadowFigureRect(w,h);
//--- Calculate the blur radius, which cannot exceed a quarter of the OUTER_AREA_SIZE constant
   int radius=(blur_value>OUTER_AREA_SIZE/4 ? OUTER_AREA_SIZE/4 : blur_value);
//--- If failed to blur the shape, exit the method (GaussianBlur() displays the error on the journal)
   if(!this.GaussianBlur(radius))
      return;
//--- Shift the shadow object by X/Y offsets specified in the method arguments and update the canvas
   CGCnvElement::Move(this.CoordX()+shift_x,this.CoordY()+shift_y);
   CGCnvElement::Update();
  }
//+------------------------------------------------------------------+
//| Draw the object shadow form                                      |
//+------------------------------------------------------------------+
void CShadowObj::DrawShadowFigureRect(const int w,const int h)
  {
   CGCnvElement::DrawRectangleFill(OUTER_AREA_SIZE,OUTER_AREA_SIZE,OUTER_AREA_SIZE+w-1,OUTER_AREA_SIZE+h-1,this.m_color_shadow,this.m_opacity_shadow);
   CGCnvElement::Update();
  }
//+------------------------------------------------------------------+
//| Gaussian blur                                                    |
//| https://www.mql5.com/en/articles/1612#chapter4                   |
//+------------------------------------------------------------------+
bool CShadowObj::GaussianBlur(const uint radius)
  {
//---
   int n_nodes=(int)radius*2+1;
//--- Read graphical resource data. If failed, return false
   if(!CGCnvElement::ResourceStamp(DFUN))
      return false;
   
//--- Check the blur amount. If the blur radius exceeds half of the width or height, return 'false'
   if((int)radius>=this.Width()/2 || (int)radius>=this.Height()/2)
     {
      ::Print(DFUN,CMessage::Text(MSG_SHADOW_OBJ_IMG_SMALL_BLUR_LARGE));
      return false;
     }
     
//--- Decompose image data from the resource into a, r, g, b color components
   int  size=::ArraySize(this.m_duplicate_res);
//--- arrays for storing A, R, G and B color components
//--- for horizontal and vertical blur
   uchar a_h_data[],r_h_data[],g_h_data[],b_h_data[];
   uchar a_v_data[],r_v_data[],g_v_data[],b_v_data[];
   
//--- Change the size of component arrays according to the array size of the graphical resource data
   if(::ArrayResize(a_h_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"a_h_data\"");
      return false;
     }
   if(::ArrayResize(r_h_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"r_h_data\"");
      return false;
     }
   if(::ArrayResize(g_h_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"g_h_data\"");
      return false;
     }
   if(ArrayResize(b_h_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"b_h_data\"");
      return false;
     }
   if(::ArrayResize(a_v_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"a_v_data\"");
      return false;
     }
   if(::ArrayResize(r_v_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"r_v_data\"");
      return false;
     }
   if(::ArrayResize(g_v_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"g_v_data\"");
      return false;
     }
   if(::ArrayResize(b_v_data,size)==-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      ::Print(DFUN_ERR_LINE,": \"b_v_data\"");
      return false;
     }
//--- Declare the array for storing blur weight ratios and,
//--- if failed to get the array of weight ratios, return 'false'
   double weights[];
   if(!this.GetQuadratureWeights(1,n_nodes,weights))
      return false;
      
//--- Set components of each image pixel to the color component arrays
   for(int i=0;i<size;i++)
     {
      a_h_data[i]=GETRGBA(this.m_duplicate_res[i]);
      r_h_data[i]=GETRGBR(this.m_duplicate_res[i]);
      g_h_data[i]=GETRGBG(this.m_duplicate_res[i]);
      b_h_data[i]=GETRGBB(this.m_duplicate_res[i]);
     }

//--- Blur the image horizontally (along the X axis)
   uint XY; // Pixel coordinate in the array
   double a_temp=0.0,r_temp=0.0,g_temp=0.0,b_temp=0.0;
   int coef=0;
   int j=(int)radius;
   //--- Loop by the image width
   for(int Y=0;Y<this.Height();Y++)
     {
      //--- Loop by the image height
      for(uint X=radius;X<this.Width()-radius;X++)
        {
         XY=Y*this.Width()+X;
         a_temp=0.0; r_temp=0.0; g_temp=0.0; b_temp=0.0;
         coef=0;
         //--- Multiply each color component by the weight ratio corresponding to the current image pixel
         for(int i=-1*j;i<j+1;i=i+1)
           {
            a_temp+=a_h_data[XY+i]*weights[coef];
            r_temp+=r_h_data[XY+i]*weights[coef];
            g_temp+=g_h_data[XY+i]*weights[coef];
            b_temp+=b_h_data[XY+i]*weights[coef];
            coef++;
           }
         //--- Save each rounded color component calculated according to the ratios to the component arrays
         a_h_data[XY]=(uchar)::round(a_temp);
         r_h_data[XY]=(uchar)::round(r_temp);
         g_h_data[XY]=(uchar)::round(g_temp);
         b_h_data[XY]=(uchar)::round(b_temp);
        }
      //--- Remove blur artifacts to the left by copying adjacent pixels
      for(uint x=0;x<radius;x++)
        {
         XY=Y*this.Width()+x;
         a_h_data[XY]=a_h_data[Y*this.Width()+radius];
         r_h_data[XY]=r_h_data[Y*this.Width()+radius];
         g_h_data[XY]=g_h_data[Y*this.Width()+radius];
         b_h_data[XY]=b_h_data[Y*this.Width()+radius];
        }
      //--- Remove blur artifacts to the right by copying adjacent pixels
      for(int x=int(this.Width()-radius);x<this.Width();x++)
        {
         XY=Y*this.Width()+x;
         a_h_data[XY]=a_h_data[(Y+1)*this.Width()-radius-1];
         r_h_data[XY]=r_h_data[(Y+1)*this.Width()-radius-1];
         g_h_data[XY]=g_h_data[(Y+1)*this.Width()-radius-1];
         b_h_data[XY]=b_h_data[(Y+1)*this.Width()-radius-1];
        }
     }

//--- Blur vertically (along the Y axis) the image already blurred horizontally
   int dxdy=0;
   //--- Loop by the image height
   for(int X=0;X<this.Width();X++)
     {
      //--- Loop by the image width
      for(uint Y=radius;Y<this.Height()-radius;Y++)
        {
         XY=Y*this.Width()+X;
         a_temp=0.0; r_temp=0.0; g_temp=0.0; b_temp=0.0;
         coef=0;
         //--- Multiply each color component by the weight ratio corresponding to the current image pixel
         for(int i=-1*j;i<j+1;i=i+1)
           {
            dxdy=i*(int)this.Width();
            a_temp+=a_h_data[XY+dxdy]*weights[coef];
            r_temp+=r_h_data[XY+dxdy]*weights[coef];
            g_temp+=g_h_data[XY+dxdy]*weights[coef];
            b_temp+=b_h_data[XY+dxdy]*weights[coef];
            coef++;
           }
         //--- Save each rounded color component calculated according to the ratios to the component arrays
         a_v_data[XY]=(uchar)::round(a_temp);
         r_v_data[XY]=(uchar)::round(r_temp);
         g_v_data[XY]=(uchar)::round(g_temp);
         b_v_data[XY]=(uchar)::round(b_temp);
        }
      //--- Remove blur artifacts at the top by copying adjacent pixels
      for(uint y=0;y<radius;y++)
        {
         XY=y*this.Width()+X;
         a_v_data[XY]=a_v_data[X+radius*this.Width()];
         r_v_data[XY]=r_v_data[X+radius*this.Width()];
         g_v_data[XY]=g_v_data[X+radius*this.Width()];
         b_v_data[XY]=b_v_data[X+radius*this.Width()];
        }
      //--- Remove blur artifacts at the bottom by copying adjacent pixels
      for(int y=int(this.Height()-radius);y<this.Height();y++)
        {
         XY=y*this.Width()+X;
         a_v_data[XY]=a_v_data[X+(this.Height()-1-radius)*this.Width()];
         r_v_data[XY]=r_v_data[X+(this.Height()-1-radius)*this.Width()];
         g_v_data[XY]=g_v_data[X+(this.Height()-1-radius)*this.Width()];
         b_v_data[XY]=b_v_data[X+(this.Height()-1-radius)*this.Width()];
        }
     }
     
//--- Set the twice blurred (horizontally and vertically) image pixels to the graphical resource data array
   for(int i=0;i<size;i++)
      this.m_duplicate_res[i]=ARGB(a_v_data[i],r_v_data[i],g_v_data[i],b_v_data[i]);
//--- Display the image pixels on the canvas in a loop by the image height and width from the graphical resource data array
   for(int X=0;X<this.Width();X++)
     {
      for(uint Y=radius;Y<this.Height()-radius;Y++)
        {
         XY=Y*this.Width()+X;
         this.m_canvas.PixelSet(X,Y,this.m_duplicate_res[XY]);
        }
     }
//--- Done
   return true;
  }
//+------------------------------------------------------------------+
//| Return the array of weight ratios                                |
//| https://www.mql5.com/en/articles/1612#chapter3_2                 |
//+------------------------------------------------------------------+
bool CShadowObj::GetQuadratureWeights(const double mu0,const int n,double &weights[])
  {
   CAlglib alglib;
   double  alp[];
   double  bet[];
   ::ArrayResize(alp,n);
   ::ArrayResize(bet,n);
   ::ArrayInitialize(alp,1.0);
   ::ArrayInitialize(bet,1.0);
//---
   double out_x[];
   int    info=0;
   alglib.GQGenerateRec(alp,bet,mu0,n,info,out_x,weights);
   if(info!=1)
     {
      string txt=(info==-3 ? "internal eigenproblem solver hasn't converged" : info==-2 ? "Beta[i]<=0" : "incorrect N was passed");
      ::Print("Call error in CGaussQ::GQGenerateRec: ",txt);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
