//+------------------------------------------------------------------+
//|                                                FrameGeometry.mqh |
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
#include "Frame.mqh"
//+------------------------------------------------------------------+
//| Single geometric animation frame class                           |
//+------------------------------------------------------------------+
class CFrameGeometry : public CFrame
  {
private:
   double            m_square_x;                               // X coordinate of the square enclosing the shape
   double            m_square_y;                               // Y coordinate of the square enclosing the shape
   uint              m_square_length;                          // Length of the sides of the square enclosing the shape
   int               m_shift_x;                                // Offset of the X coordinate of the square enclosing the shape
   int               m_shift_y;                                // Offset of the Y coordinate of the square enclosing the shape
   int               m_array_x[];                              // Array of shape X coordinates
   int               m_array_y[];                              // Array of shape Y coordinates
//--- Save and restore the background under the image
   virtual bool      SaveRestoreBG(void);
   
//--- Calculate coordinates of the regular polygon built in a circumscribed circle inscribed in a square
   void              CoordsNgon(const int N,                   // Number of polygon vertices
                                const int coord_x,             // X coordinate of the upper-left square angle the circle will be inscribed into
                                const int coord_y,             // Y coordinate of the upper-left square angle whose inscribed circle is used to build a polygon
                                const int len,                 // Square sides length
                                const double angle);           // Polygon rotation angle (the polygon is built from the point 0 to the right of the circle center)
public:
//--- Constructors
                     CFrameGeometry() { this.m_type=OBJECT_DE_TYPE_GFRAME_GEOMETRY; }
                     CFrameGeometry(const int id,CGCnvElement *element) : CFrame(id,0,0,0,0,element)
                       {
                        this.m_type=OBJECT_DE_TYPE_GFRAME_GEOMETRY; 
                        ::ArrayResize(this.m_array_x,0);
                        ::ArrayResize(this.m_array_y,0);
                        this.m_anchor_last=FRAME_ANCHOR_LEFT_TOP;
                        this.m_square_x=0;
                        this.m_square_y=0;
                        this.m_square_length=0;
                        this.m_shift_x=0;
                        this.m_shift_y=0;
                       }
//--- Destructor
                    ~CFrameGeometry()                             { ::ArrayFree(this.m_array_x); ::ArrayFree(this.m_array_y); }
                    
//+------------------------------------------------------------------+
//| Methods of drawing regular polygons                              |
//+------------------------------------------------------------------+
//--- Draw a regular polygon without smoothing
   bool              DrawNgonOnBG(const int    N,                          // Number of polygon vertices
                                  const int    coord_x,                    // X coordinate of the upper-left frame angle
                                  const int    coord_y,                    // Y coordinate of the upper-left frame angle
                                  const int    len,                        // Frame sides length
                                  const double angle,                      // Polygon rotation angle
                                  const color  clr,                        // Color
                                  const uchar  opacity=255,                // Opacity
                                  const bool   redraw=false);              // Chart redraw flag
                                  
//--- Draw a regular filled polygon
   bool              DrawNgonFillOnBG(const    int N,                      // Number of polygon vertices
                                  const int    coord_x,                    // X coordinate of the upper-left frame angle
                                  const int    coord_y,                    // Y coordinate of the upper-left frame angle
                                  const int    len,                        // Frame sides length
                                  const double angle,                      // Polygon rotation angle
                                  const color  clr,                        // Color
                                  const uchar  opacity=255,                // Opacity
                                  const bool   redraw=false);              // Chart redraw flag
                       
//--- Draw a regular polygon using AntiAliasing algorithm
   bool              DrawNgonAAOnBG(const int  N,                          // Number of polygon vertices
                                  const int    coord_x,                    // X coordinate of the upper-left frame angle
                                  const int    coord_y,                    // Y coordinate of the upper-left frame angle
                                  const int    len,                        // Frame sides length
                                  const double angle,                      // Polygon rotation angle
                                  const color  clr,                        // Color
                                  const uchar  opacity=255,                // Opacity
                                  const bool   redraw=false,               // Chart redraw flag
                                  const uint   style=UINT_MAX);            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a regular polygon using Wu algorithm
   bool              DrawNgonWuOnBG(const int  N,                          // Number of polygon vertices
                                  const int    coord_x,                    // X coordinate of the upper-left frame angle
                                  const int    coord_y,                    // Y coordinate of the upper-left frame angle
                                  const int    len,                        // Frame sides length
                                  const double angle,                      // Polygon rotation angle
                                  const color  clr,                        // Color
                                  const uchar  opacity=255,                // Opacity
                                  const bool   redraw=false,               // Chart redraw flag
                                  const uint   style=UINT_MAX);            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a regular polygon with a specified width consecutively using two smoothing algorithms.
//--- First, individual segments are smoothed based on Bezier curves.
//--- Then, the raster smoothing algorithm is applied to the polygon built from these segments to improve the rendering quality. 
   bool              DrawNgonSmoothOnBG(const  int N,                      // Number of polygon vertices
                                  const int    coord_x,                    // X coordinate of the upper-left frame angle
                                  const int    coord_y,                    // Y coordinate of the upper-left frame angle
                                  const int    len,                        // Frame sides length
                                  const double angle,                      // Polygon rotation angle
                                  const int    size,                       // Line width
                                  const color  clr,                        // Color
                                  const uchar  opacity=255,                // Opacity
                                  const double tension=0.5,                // Smoothing parameter value
                                  const double step=10,                    // Approximation step
                                  const bool   redraw=false,               // Chart redraw flag
                                  const ENUM_LINE_STYLE style=STYLE_SOLID, // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                  const ENUM_LINE_END end_style=LINE_END_ROUND);// Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a regular polygon having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawNgonThickOnBG(const   int N,                      // Number of polygon vertices
                                  const int    coord_x,                    // X coordinate of the upper-left frame angle
                                  const int    coord_y,                    // Y coordinate of the upper-left frame angle
                                  const int    len,                        // Frame sides length
                                  const double angle,                      // Polygon rotation angle
                                  const int    size,                       // line width
                                  const color  clr,                        // Color
                                  const uchar  opacity=255,                // Opacity
                                  const bool   redraw=false,               // Chart redraw flag
                                  const uint   style=STYLE_SOLID,          // line style
                                  ENUM_LINE_END end_style=LINE_END_ROUND); // line ends style
                                  
  };
//+------------------------------------------------------------------+
//| Save and restore the background under the image                  |
//+------------------------------------------------------------------+
bool CFrameGeometry::SaveRestoreBG(void)
  {
//--- Calculate coordinate offsets for the saved area depending on the anchor point
   this.m_element.GetShiftXYbySize(this.m_square_length,this.m_square_length,FRAME_ANCHOR_LEFT_TOP,this.m_shift_x,this.m_shift_y);
//--- If the pixel array is not empty, the background under the image has already been saved -
//--- restore the previously saved background (by the previous coordinates and offsets)
   if(::ArraySize(this.m_array)>0)
     {
      if(!CPixelCopier::CopyImgDataToCanvas(int(this.m_x_last+this.m_shift_x_prev),int(this.m_y_last+this.m_shift_y_prev)))
         return false;
     }
//--- Return the result of saving the background area with the calculated coordinates and size under the future image
   return CPixelCopier::CopyImgDataToArray(int(this.m_square_x+this.m_shift_x),int(this.m_square_y+this.m_shift_y),this.m_square_length,this.m_square_length);
  }
//+------------------------------------------------------------------+
//| Calculate the coordinates of the regular polygon                 |
//+------------------------------------------------------------------+
void CFrameGeometry::CoordsNgon(const int N,          // Number of polygon vertices
                                const int coord_x,    // X coordinate of the upper-left square angle the circle will be inscribed into
                                const int coord_y,    // Y coordinate of the upper-left square angle whose inscribed circle is used to build a polygon
                                const int len,        // Length of the sides of the square a polygon is to be inscribed into
                                const double angle)   // Polygon rotation angle (the polygon is built from the point 0 to the right of the circle center)
  {
//--- If there are less than three sides, there will be three
   int n=(N<3 ? 3 : N);
//--- Set the size of coordinate arrays according to the number of vertices
   ::ArrayResize(this.m_array_x,n);
   ::ArrayResize(this.m_array_y,n);
//--- Calculate the radius of the circumscribed circle
   double R=(double)len/2.0;
//--- X and Y coordinates of the circle center
   double xc=coord_x+R;
   double yc=coord_y+R;
//--- Calculate the polygon inclination angle in degrees
   double grad=angle*M_PI/180.0;
//--- In the loop by the number of vertices, calculate the coordinates of each next polygon vertex
   for(int i=0; i<n; i++)
     {
      //--- Angle of the current polygon vertex with the rotation in degrees
      double a=2.0*M_PI*i/n+grad;
      //--- X and Y coordinates of the current polygon vertex
      double xi=xc+R*::cos(a);
      double yi=yc+R*::sin(a);
      //--- Set the current coordinates to the arrays
      this.m_array_x[i]=int(::floor(xi));
      this.m_array_y[i]=int(::floor(yi));
     }
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon                                           |
//+------------------------------------------------------------------+
bool CFrameGeometry::DrawNgonOnBG(const int N,
                                  const int coord_x,
                                  const int coord_y,
                                  const int len,
                                  const double angle,
                                  const color clr,
                                  const uchar opacity=255,
                                  const bool redraw=false)
  {
//--- Set the coordinates of the outlining rectangle
   this.m_square_x=coord_x-1;
   this.m_square_y=coord_y-1;
//--- Set the width and height of a square frame (to be used as the size of the saved area)
   this.m_square_length=len+2;
//--- Calculate the polygon coordinates on the circle
   this.CoordsNgon(N,coord_x,coord_y,len,angle);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw a polygon inscribed in a circle and update the element
   this.m_element.DrawPolygon(this.m_array_x,this.m_array_y,clr,opacity);
   this.SetLastParams(this.m_square_x,this.m_square_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a regular filled polygon                                    |
//+------------------------------------------------------------------+
bool CFrameGeometry::DrawNgonFillOnBG(const    int N,                         // Number of polygon vertices
                                       const int    coord_x,                  // X coordinate of the upper-left frame angle
                                       const int    coord_y,                  // Y coordinate of the upper-left frame angle
                                       const int    len,                      // Frame sides length
                                       const double angle,                    // Polygon rotation angle
                                       const color  clr,                      // Color
                                       const uchar  opacity=255,              // Opacity
                                       const bool   redraw=false)             // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_square_x=coord_x-1;
   this.m_square_y=coord_y-1;
//--- Set the width and height of a square frame (to be used as the size of the saved area)
   this.m_square_length=len+2;
//--- Calculate the polygon coordinates on the circle
   this.CoordsNgon(N,coord_x,coord_y,len,angle);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw a polygon inscribed in a circle and update the element
   this.m_element.DrawPolygonFill(this.m_array_x,this.m_array_y,clr,opacity);
   this.SetLastParams(this.m_square_x,this.m_square_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon using                                     |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CFrameGeometry::DrawNgonAAOnBG(const int  N,                             // Number of polygon vertices
                                       const int    coord_x,                  // X coordinate of the upper-left frame angle
                                       const int    coord_y,                  // Y coordinate of the upper-left frame angle
                                       const int    len,                      // Frame sides length
                                       const double angle,                    // Polygon rotation angle
                                       const color  clr,                      // Color
                                       const uchar  opacity=255,              // Opacity
                                       const bool   redraw=false,             // Chart redraw flag
                                       const uint   style=UINT_MAX)           // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   this.m_square_x=coord_x-1;
   this.m_square_y=coord_y-1;
//--- Set the width and height of a square frame (to be used as the size of the saved area)
   this.m_square_length=len+2;
//--- Calculate the polygon coordinates on the circle
   this.CoordsNgon(N,coord_x,coord_y,len,angle);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw a polygon inscribed in a circle and update the element
   this.m_element.DrawPolygonAA(this.m_array_x,this.m_array_y,clr,opacity,style);
   this.SetLastParams(this.m_square_x,this.m_square_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon using                                     |
//| Wu algorithm                                                     |
//+------------------------------------------------------------------+
bool CFrameGeometry::DrawNgonWuOnBG(const int  N,                             // Number of polygon vertices
                                       const int    coord_x,                  // X coordinate of the upper-left frame angle
                                       const int    coord_y,                  // Y coordinate of the upper-left frame angle
                                       const int    len,                      // Frame sides length
                                       const double angle,                    // Polygon rotation angle
                                       const color  clr,                      // Color
                                       const uchar  opacity=255,              // Opacity
                                       const bool   redraw=false,             // Chart redraw flag
                                       const uint   style=UINT_MAX)           // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   this.m_square_x=coord_x-1;
   this.m_square_y=coord_y-1;
//--- Set the width and height of a square frame (to be used as the size of the saved area)
   this.m_square_length=len+2;
//--- Calculate the polygon coordinates on the circle
   this.CoordsNgon(N,coord_x,coord_y,len,angle);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw a polygon inscribed in a circle and update the element
   this.m_element.DrawPolygonWu(this.m_array_x,this.m_array_y,clr,opacity,style);
   this.SetLastParams(this.m_square_x,this.m_square_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon of a specified width                      |
//| using two smoothing algorithms in series.                        |
//| First, individual segments are smoothed based on Bezier curves.  |
//| Then, to improve the rendering quality,                          |
//| a raster smoothing algorithm is applied                          |
//| to the polygon made of these segments.                           |
//+------------------------------------------------------------------+
bool CFrameGeometry::DrawNgonSmoothOnBG(const  int N,                         // Number of polygon vertices
                                       const int    coord_x,                  // X coordinate of the upper-left frame angle
                                       const int    coord_y,                  // Y coordinate of the upper-left frame angle
                                       const int    len,                      // Frame sides length
                                       const double angle,                    // Polygon rotation angle
                                       const int    size,                     // Line width
                                       const color  clr,                      // Color
                                       const uchar  opacity=255,              // Opacity
                                       const double tension=0.5,              // Smoothing parameter value
                                       const double step=10,                  // Approximation step
                                       const bool   redraw=false,             // Chart redraw flag
                                       const ENUM_LINE_STYLE style=STYLE_SOLID,// Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                       const ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
  {
//--- Calculate the adjustment of the outlining rectangle coordinates depending on the line size
   int correct=int(::ceil((double)size/2.0))+1;
//--- Set the coordinates of the outlining rectangle
   this.m_square_x=coord_x-correct;
   this.m_square_y=coord_y-correct;
//--- Set the width and height of a square frame (to be used as the size of the saved area)
   this.m_square_length=len+correct*2;
//--- Calculate the polygon coordinates on the circle
   this.CoordsNgon(N,coord_x,coord_y,len,angle);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw a polygon inscribed in a circle and update the element
   this.m_element.DrawPolygonSmooth(this.m_array_x,this.m_array_y,size,clr,opacity,tension,step,style,end_style);
   this.SetLastParams(this.m_square_x,this.m_square_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon with a specified width using              |
//| a smoothing algorithm with the preliminary sorting               |
//+------------------------------------------------------------------+
bool CFrameGeometry::DrawNgonThickOnBG(const   int N,                         // Number of polygon vertices
                                       const int    coord_x,                  // X coordinate of the upper-left frame angle
                                       const int    coord_y,                  // Y coordinate of the upper-left frame angle
                                       const int    len,                      // Frame sides length
                                       const double angle,                    // Polygon rotation angle
                                       const int    size,                     // line width
                                       const color  clr,                      // Color
                                       const uchar  opacity=255,              // Opacity
                                       const bool   redraw=false,             // Chart redraw flag
                                       const uint   style=STYLE_SOLID,        // line style
                                       ENUM_LINE_END end_style=LINE_END_ROUND)// line ends style
  {
//--- Calculate the adjustment of the outlining rectangle coordinates depending on the line size
   int correct=int(::ceil((double)size/2.0))+1;
//--- Set the coordinates of the outlining rectangle
   this.m_square_x=coord_x-correct;
   this.m_square_y=coord_y-correct;
//--- Set the width and height of a square frame (to be used as the size of the saved area)
   this.m_square_length=len+correct*2;
//--- Calculate the polygon coordinates on the circle
   this.CoordsNgon(N,coord_x,coord_y,len,angle);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw a polygon inscribed in a circle and update the element
   this.m_element.DrawPolygonThick(this.m_array_x,this.m_array_y,size,clr,opacity,style,end_style);
   this.SetLastParams(this.m_square_x,this.m_square_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
