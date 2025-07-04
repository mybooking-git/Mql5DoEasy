//+------------------------------------------------------------------+
//|                                                    FrameQuad.mqh |
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
//| Class of a single rectangular animation frame                    |
//+------------------------------------------------------------------+
class CFrameQuad : public CFrame
  {
private:
   double            m_quad_x;                                 // X coordinate of the rectangle enclosing the shape
   double            m_quad_y;                                 // Y coordinate of the rectangle enclosing the shape
   uint              m_quad_width;                             // Width of the rectangle enclosing the shape
   uint              m_quad_height;                            // Height of the rectangle enclosing the shape
   int               m_shift_x;                                // Offset of the X coordinate of the rectangle enclosing the shape
   int               m_shift_y;                                // Offset of the Y coordinate of the rectangle enclosing the shape
//--- Save and restore the background under the image
   virtual bool      SaveRestoreBG(void);
public:
//--- Constructors
                     CFrameQuad() { this.m_type=OBJECT_DE_TYPE_GFRAME_QUAD; }
                     CFrameQuad(const int id,CGCnvElement *element) : CFrame(id,0,0,0,0,element)
                       {
                        this.m_type=OBJECT_DE_TYPE_GFRAME_QUAD; 
                        this.m_anchor_last=FRAME_ANCHOR_LEFT_TOP;
                        this.m_quad_x=0;
                        this.m_quad_y=0;
                        this.m_quad_width=0;
                        this.m_quad_height=0;
                        this.m_shift_x=0;
                        this.m_shift_y=0;
                       }

//+------------------------------------------------------------------+
//| Drawing primitives while saving and restoring the background     |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| The methods of drawing primitives without smoothing              |
//+------------------------------------------------------------------+
//--- Set the color of the dot with the specified coordinates
   bool              SetPixelOnBG(const int x,const int y,const color clr,const uchar opacity=255,const bool redraw=false);
                       
//--- Draw a segment of a vertical line
   bool              DrawLineVerticalOnBG(const int x,                  // X coordinate of the segment
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a segment of a horizontal line
   bool              DrawLineHorizontalOnBG(const int x1,               // X coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y,                            // Segment Y coordinate
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a segment of a freehand line
   bool              DrawLineOnBG(const int x1,                         // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a polyline
   bool              DrawPolylineOnBG(int &array_x[],                   // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a polygon
   bool              DrawPolygonOnBG(int  &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a rectangle using two points
   bool              DrawRectangleOnBG(const int x1,                    // X coordinate of the first point defining the rectangle
                              const int   y1,                           // Y coordinate of the first point defining the rectangle
                              const int   x2,                           // X coordinate of the second point defining the rectangle
                              const int   y2,                           // Y coordinate of the second point defining the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a circle
   bool              DrawCircleOnBG(const int x,                        // X coordinate of the circle center
                              const int   y,                            // Y coordinate of the circle center
                              const int   r,                            // Circle radius
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a triangle
   bool              DrawTriangleOnBG(const int x1,                     // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw an ellipse using two points
   bool              DrawEllipseOnBG(const int x1,                      // X coordinate of the first point defining the ellipse
                              const int   y1,                           // Y coordinate of the first point defining the ellipse
                              const int   x2,                           // X coordinate of the second point defining the ellipse
                              const int   y2,                           // Y coordinate of the second point defining the ellipse
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw an arc of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2).
//--- The arc boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   bool              DrawArcOnBG(const int x1,                          // X coordinate of the top left corner forming the rectangle
                              const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                              const int   x3,                           // X coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   y3,                           // Y coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   x4,                           // X coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   y4,                           // Y coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled sector of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2).
//--- The sector boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   bool              DrawPieOnBG(const int x1,                          // X coordinate of the upper left corner of the rectangle
                              const int   y1,                           // Y coordinate of the upper left corner of the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner of the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner of the rectangle
                              const int   x3,                           // X coordinate of the first point to find the arc boundaries
                              const int   y3,                           // Y coordinate of the first point to find the arc boundaries
                              const int   x4,                           // X coordinate of the second point to find the arc boundaries
                              const int   y4,                           // Y coordinate of the second point to find the arc boundaries
                              const color clr,                          // Line color
                              const color fill_clr,                     // Fill color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//+------------------------------------------------------------------+
//| The methods of drawing filled primitives without smoothing       |
//+------------------------------------------------------------------+
//--- Fill in the area
   bool              FillOnBG(const int   x,                            // X coordinate of the filling start point
                              const int   y,                            // Y coordinate of the filling start point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const uint  threshould=0,                 // Threshold
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled rectangle
   bool              DrawRectangleFillOnBG(const int x1,                // X coordinate of the first point defining the rectangle
                              const int   y1,                           // Y coordinate of the first point defining the rectangle
                              const int   x2,                           // X coordinate of the second point defining the rectangle
                              const int   y2,                           // Y coordinate of the second point defining the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag

//--- Draw a filled circle
   bool              DrawCircleFillOnBG(const int x,                    // X coordinate of the circle center
                              const int   y,                            // Y coordinate of the circle center
                              const int   r,                            // Circle radius
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled triangle
   bool              DrawTriangleFillOnBG(const int x1,                 // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled polygon
   bool              DrawPolygonFillOnBG(int &array_x[],                // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled ellipse inscribed in a rectangle with the specified coordinates
   bool              DrawEllipseFillOnBG(const int x1,                  // X coordinate of the top left corner forming the rectangle
                              const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false);                // Chart redraw flag
                       
//+------------------------------------------------------------------+
//| The methods of drawing primitives using smoothing                |
//+------------------------------------------------------------------+
//--- Draw a point using AntiAliasing algorithm
   bool              SetPixelAAOnBG(const double x,                     // Point X coordinate
                              const double y,                           // Pixel Y coordinate
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   redraw=false);               // Chart redraw flag
                       
//--- Draw a segment of a freehand line using AntiAliasing algorithm
   bool              DrawLineAAOnBG(const int x1,                       // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a segment of a freehand line using Wu algorithm
   bool              DrawLineWuOnBG(const int x1,                       // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draws a segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawLineThickOnBG(const int x1,                    // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const int   size,                         // Line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              ENUM_LINE_END end_style=LINE_END_ROUND);  // Line style is one of the ENUM_LINE_END enumeration values
 
//--- Draw a vertical segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawLineThickVerticalOnBG(const int x,             // X coordinate of the segment
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   y2,                           // Y coordinate of the segment second point
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND); // Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a horizontal segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawLineThickHorizontalOnBG(const int x1,          // X coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y,                            // Segment Y coordinate
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND); // Line style is one of the ENUM_LINE_END enumeration values

//--- Draws a polyline using AntiAliasing algorithm
   bool              DrawPolylineAAOnBG(int &array_x[],                 // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draws a polyline using Wu algorithm
   bool              DrawPolylineWuOnBG(int &array_x[],                 // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a polyline with a specified width consecutively using two antialiasing algorithms.
//--- First, individual line segments are smoothed based on Bezier curves.
//--- Then, the raster antialiasing algorithm is applied to the polyline built from these segments to improve the rendering quality
   bool              DrawPolylineSmoothOnBG(const int &array_x[],       // Array with the X coordinates of polyline points
                              const int    &array_y[],                  // Array with the Y coordinates of polyline points
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END   end_style=LINE_END_ROUND);// Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a polyline having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawPolylineThickOnBG(const int &array_x[],        // Array with the X coordinates of polyline points
                              const int      &array_y[],                // Array with the Y coordinates of polyline points
                              const int      size,                      // Line width
                              const color    clr,                       // Color
                              const uchar    opacity=255,               // Opacity
                              const bool     redraw=false,              // Chart redraw flag
                              const uint     style=STYLE_SOLID,         // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              ENUM_LINE_END  end_style=LINE_END_ROUND); // Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a polygon using AntiAliasing algorithm
   bool              DrawPolygonAAOnBG(int &array_x[],                  // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a polygon using Wu algorithm
   bool              DrawPolygonWuOnBG(int &array_x[],                  // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a polygon with a specified width consecutively using two smoothing algorithms.
//--- First, individual segments are smoothed based on Bezier curves.
//--- Then, the raster smoothing algorithm is applied to the polygon built from these segments to improve the rendering quality. 
   bool              DrawPolygonSmoothOnBG(int &array_x[],              // Array with the X coordinates of polyline points
                              int          &array_y[],                  // Array with the Y coordinates of polyline points
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END   end_style=LINE_END_ROUND);// Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a polygon having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawPolygonThickOnBG(const int &array_x[],         // array with the X coordinates of polygon points
                              const int   &array_y[],                   // array with the Y coordinates of polygon points
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // line style
                              ENUM_LINE_END end_style=LINE_END_ROUND);  // line ends style
                       
//--- Draw a triangle using AntiAliasing algorithm
   bool              DrawTriangleAAOnBG(const int x1,                   // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a triangle using Wu algorithm
   bool              DrawTriangleWuOnBG(const int x1,                   // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a circle using AntiAliasing algorithm
   bool              DrawCircleAAOnBG(const int x,                      // X coordinate of the circle center
                              const int    y,                           // Y coordinate of the circle center
                              const double r,                           // Circle radius
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a circle using Wu algorithm
   bool              DrawCircleWuOnBG(const int x,                      // X coordinate of the circle center
                              const int    y,                           // Y coordinate of the circle center
                              const double r,                           // Circle radius
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw an ellipse by two points using AntiAliasing algorithm
   bool              DrawEllipseAAOnBG(const double x1,                 // X coordinate of the first point defining the ellipse
                              const double y1,                          // Y coordinate of the first point defining the ellipse
                              const double x2,                          // X coordinate of the second point defining the ellipse
                              const double y2,                          // Y coordinate of the second point defining the ellipse
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw an ellipse by two points using Wu algorithm
   bool              DrawEllipseWuOnBG(const int x1,                    // X coordinate of the first point defining the ellipse
                              const int   y1,                           // Y coordinate of the first point defining the ellipse
                              const int   x2,                           // X coordinate of the second point defining the ellipse
                              const int   y2,                           // Y coordinate of the second point defining the ellipse
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  };
//+------------------------------------------------------------------+
//| Set the color of the dot with the specified coordinates          |
//+------------------------------------------------------------------+
bool CFrameQuad::SetPixelOnBG(const int x,const int y,const color clr,const uchar opacity=255,const bool redraw=false)
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=1;
   this.m_quad_height=1;
   
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.SetPixel(x,y,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a segment of a vertical line                                |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawLineVerticalOnBG(const int   x,              // X coordinate of the segment
                                      const int   y1,             // Y coordinate of the segment first point
                                      const int   y2,             // Y coordinate of the segment second point
                                      const color clr,            // Color
                                      const uchar opacity=255,    // Opacity
                                      const bool  redraw=false)   // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=x;
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=1;
   this.m_quad_height=::fabs(y2-y1)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLineVertical(x,y1,y2,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a segment of a horizontal line                              |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawLineHorizontalOnBG(const int   x1,           // X coordinate of the segment first point
                                        const int   x2,           // X coordinate of the segment second point
                                        const int   y,            // Segment Y coordinate
                                        const color clr,          // Color
                                        const uchar opacity=255,  // Opacity
                                        const bool  redraw=false) // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLineHorizontal(x1,x2,y,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a segment of a freehand line                                |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawLineOnBG(const int   x1,            // X coordinate of the segment first point
                              const int   y1,            // Y coordinate of the segment first point
                              const int   x2,            // X coordinate of the segment second point
                              const int   y2,            // Y coordinate of the segment second point
                              const color clr,           // Color
                              const uchar opacity=255,   // Opacity
                              const bool  redraw=false)  // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=::fabs(y2-y1)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLine(x1,y1,x2,y2,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polyline                                                  |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolylineOnBG(int         &array_x[],   // Array with the X coordinates of polyline points
                                  int         &array_y[],   // Array with the Y coordinates of polyline points
                                  const color clr,          // Color
                                  const uchar opacity=255,  // Opacity
                                  const bool  redraw=false) // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1;
   this.m_quad_height=(max_y_value-min_y_value)+1;

//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolyline(array_x,array_y,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polygon                                                   |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolygonOnBG(int         &array_x[],    // Array with the X coordinates of polygon points
                                 int         &array_y[],    // Array with the Y coordinates of polygon points
                                 const color clr,           // Color
                                 const uchar opacity=255,   // Opacity
                                 const bool  redraw=false)  // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1;
   if(this.m_quad_width==0)
      this.m_quad_width=1;
   this.m_quad_height=(max_y_value-min_y_value)+1;
   if(this.m_quad_height==0)
      this.m_quad_height=1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolygon(array_x,array_y,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a rectangle using two points                                |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawRectangleOnBG(const int   x1,             // X coordinate of the first point defining the rectangle
                                   const int   y1,             // Y coordinate of the first point defining the rectangle
                                   const int   x2,             // X coordinate of the second point defining the rectangle
                                   const int   y2,             // Y coordinate of the second point defining the rectangle
                                   const color clr,            // Color
                                   const uchar opacity=255,    // Opacity
                                   const bool  redraw=false)   // Chart redraw flag
     {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=::fabs(y2-y1)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawRectangle(x1,y1,x2,y2,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw the circle                                                  |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawCircleOnBG(const int   x,              // X coordinate of the circle center
                                const int   y,              // Y coordinate of the circle center
                                const int   r,              // Circle radius
                                const color clr,            // Color
                                const uchar opacity=255,    // Opacity
                                const bool  redraw=false)   // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   int rd=(r>0 ? r : 1);
   this.m_quad_x=x-rd;
   this.m_quad_y=y-rd;
   double x2=x+rd;
   double y2=y+rd;
   if(this.m_quad_x<0)
      this.m_quad_x=0;
   if(this.m_quad_y<0)
      this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(::ceil(x2-this.m_quad_x)+1);
   this.m_quad_height=int(::ceil(y2-this.m_quad_y)+1);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawCircle(x,y,rd,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a triangle                                                  |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawTriangleOnBG(const int   x1,           // X coordinate of the triangle first vertex
                                  const int   y1,           // Y coordinate of the triangle first vertex
                                  const int   x2,           // X coordinate of the triangle second vertex
                                  const int   y2,           // Y coordinate of the triangle second vertex
                                  const int   x3,           // X coordinate of the triangle third vertex
                                  const int   y3,           // Y coordinate of the triangle third vertex
                                  const color clr,          // Color
                                  const uchar opacity=255,  // Opacity
                                  const bool  redraw=false) // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(::fmin(x1,x2),x3);
   this.m_quad_y=::fmin(::fmin(y1,y2),y3);
   int max_x=::fmax(::fmax(x1,x2),x3);
   int max_y=::fmax(::fmax(y1,y2),y3);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(max_x-this.m_quad_x)+1;
   this.m_quad_height=int(max_y-this.m_quad_y)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawTriangle(x1,y1,x2,y2,x3,y3,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw an ellipse using two points                                 |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawEllipseOnBG(const int   x1,            // X coordinate of the first point defining the ellipse
                                 const int   y1,            // Y coordinate of the first point defining the ellipse
                                 const int   x2,            // X coordinate of the second point defining the ellipse
                                 const int   y2,            // Y coordinate of the second point defining the ellipse
                                 const color clr,           // Color
                                 const uchar opacity=255,   // Opacity
                                 const bool  redraw=false)  // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=::fabs(y2-y1)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawEllipse(x1,y1,x2,y2,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw an arc of an ellipse inscribed in a rectangle               |
//| with the corners in (x1,y1) and (x2,y2).                         |
//| The arc boundaries are cropped from the ellipse center           |
//| moving to two points with the coordinates of (x3,y3) and (x4,y4) |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawArcOnBG(const int   x1,             // X coordinate of the top left corner forming the rectangle
                             const int   y1,             // Y coordinate of the top left corner forming the rectangle
                             const int   x2,             // X coordinate of the bottom right corner forming the rectangle
                             const int   y2,             // Y coordinate of the bottom right corner forming the rectangle
                             const int   x3,             // X coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const int   y3,             // Y coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const int   x4,             // X coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const int   y4,             // Y coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const color clr,            // Color
                             const uchar opacity=255,    // Opacity
                             const bool  redraw=false)   // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2)-1;
   this.m_quad_y=::fmin(y1,y2)-1;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+2;
   this.m_quad_height=::fabs(y2-y1)+2;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawArc(x1,y1,x2,y2,x3,y3,x4,y4,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a filled sector of an ellipse inscribed in a rectangle      |
//| with the corners in (x1,y1) and (x2,y2).                         |
//| The sector boundaries are cropped from the ellipse center        |
//| moving to two points with the coordinates of (x3,y3) and (x4,y4) |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPieOnBG(const int   x1,             // X coordinate of the upper left corner of the rectangle
                             const int   y1,             // Y coordinate of the upper left corner of the rectangle
                             const int   x2,             // X coordinate of the bottom right corner of the rectangle
                             const int   y2,             // Y coordinate of the bottom right corner of the rectangle
                             const int   x3,             // X coordinate of the first point to find the arc boundaries
                             const int   y3,             // Y coordinate of the first point to find the arc boundaries
                             const int   x4,             // X coordinate of the second point to find the arc boundaries
                             const int   y4,             // Y coordinate of the second point to find the arc boundaries
                             const color clr,            // Color
                             const color fill_clr,       // Fill color
                             const uchar opacity=255,    // Opacity
                             const bool  redraw=false)   // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2)-1;
   this.m_quad_y=::fmin(y1,y2)-1;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+2;
   this.m_quad_height=::fabs(y2-y1)+2;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPie(x1,y1,x2,y2,x3,y3,x4,y4,clr,fill_clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Fill in the area                                                 |
//+------------------------------------------------------------------+
bool CFrameQuad::FillOnBG(const int   x,              // X coordinate of the filling start point
                          const int   y,              // Y coordinate of the filling start point
                          const color clr,            // Color
                          const uchar opacity=255,    // Opacity
                          const uint  threshould=0,   // Threshold
                          const bool  redraw=false)   // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=0;
   this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=this.m_element.Width();
   this.m_quad_height=this.m_element.Height();
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.Fill(x,y,clr,opacity,threshould);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a filled rectangle                                          |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawRectangleFillOnBG(const int   x1,            // X coordinate of the first point defining the rectangle
                                       const int   y1,            // Y coordinate of the first point defining the rectangle
                                       const int   x2,            // X coordinate of the second point defining the rectangle
                                       const int   y2,            // Y coordinate of the second point defining the rectangle
                                       const color clr,           // Color
                                       const uchar opacity=255,   // Opacity
                                       const bool  redraw=false)  // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=::fabs(y2-y1)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawRectangleFill(x1,y1,x2,y2,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a filled circle                                             |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawCircleFillOnBG(const int   x,             // X coordinate of the circle center
                                    const int   y,             // Y coordinate of the circle center
                                    const int   r,             // Circle radius
                                    const color clr,           // Color
                                    const uchar opacity=255,   // Opacity
                                    const bool  redraw=false)  // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   int rd=(r>0 ? r : 1);
   this.m_quad_x=x-rd;
   this.m_quad_y=y-rd;
   double x2=x+rd;
   double y2=y+rd;
   if(this.m_quad_x<0)
      this.m_quad_x=0;
   if(this.m_quad_y<0)
      this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(::ceil(x2-this.m_quad_x)+1);
   this.m_quad_height=int(::ceil(y2-this.m_quad_y)+1);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawCircleFill(x,y,rd,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a filled triangle                                           |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawTriangleFillOnBG(const int   x1,             // X coordinate of the triangle first vertex
                                      const int   y1,             // Y coordinate of the triangle first vertex
                                      const int   x2,             // X coordinate of the triangle second vertex
                                      const int   y2,             // Y coordinate of the triangle second vertex
                                      const int   x3,             // X coordinate of the triangle third vertex
                                      const int   y3,             // Y coordinate of the triangle third vertex
                                      const color clr,            // Color
                                      const uchar opacity=255,    // Opacity
                                      const bool  redraw=false)   // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(::fmin(x1,x2),x3)-1;
   this.m_quad_y=::fmin(::fmin(y1,y2),y3)-1;
   int max_x=::fmax(::fmax(x1,x2),x3)+1;
   int max_y=::fmax(::fmax(y1,y2),y3)+1;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(max_x-this.m_quad_x)+1;
   this.m_quad_height=int(max_y-this.m_quad_y)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawTriangleFill(x1,y1,x2,y2,x3,y3,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a filled polygon                                            |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolygonFillOnBG(int         &array_x[],   // Array with the X coordinates of polygon points
                                     int         &array_y[],   // Array with the Y coordinates of polygon points
                                     const color clr,          // Color
                                     const uchar opacity=255,  // Opacity
                                     const bool  redraw=false) // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1;
   this.m_quad_height=(max_y_value-min_y_value)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolygonFill(array_x,array_y,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a filled ellipse inscribed in a rectangle                   |
//| with the given coordinates                                       |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawEllipseFillOnBG(const int   x1,           // X coordinate of the top left corner forming the rectangle
                                     const int   y1,           // Y coordinate of the top left corner forming the rectangle
                                     const int   x2,           // X coordinate of the bottom right corner forming the rectangle
                                     const int   y2,           // Y coordinate of the bottom right corner forming the rectangle
                                     const color clr,          // Color
                                     const uchar opacity=255,  // Opacity
                                     const bool  redraw=false) // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=::fabs(y2-y1)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawEllipseFill(x1,y1,x2,y2,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a point using AntiAliasing algorithm                        |
//+------------------------------------------------------------------+
bool CFrameQuad::SetPixelAAOnBG(const double x,             // Point X coordinate
                                const double y,             // Pixel Y coordinate
                                const color  clr,           // Color
                                const uchar  opacity=255,   // Opacity
                                const bool   redraw=false)  // Chart redraw flag
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=x-1;
   if(this.m_quad_x<0)
      this.m_quad_x=0;
   this.m_quad_y=y-1;
   if(this.m_quad_y<0)
      this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=3;
   this.m_quad_height=3;
   
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.SetPixelAA(x,y,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a segment of a freehand line                                |
//| using AntiAliasing algorithm                                     |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawLineAAOnBG(const int   x1,             // X coordinate of the segment first point
                                const int   y1,             // Y coordinate of the segment first point
                                const int   x2,             // X coordinate of the segment second point
                                const int   y2,             // Y coordinate of the segment second point
                                const color clr,            // Color
                                const uchar opacity=255,    // Opacity
                                const bool  redraw=false,   // Chart redraw flag
                                const uint  style=UINT_MAX) // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=::fabs(y2-y1)+1;

//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLineAA(x1,y1,x2,y2,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a segment of a freehand line using the                      |
//| Wu algorithm                                                     |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawLineWuOnBG(const int   x1,             // X coordinate of the segment first point
                                const int   y1,             // Y coordinate of the segment first point
                                const int   x2,             // X coordinate of the segment second point
                                const int   y2,             // Y coordinate of the segment second point
                                const color clr,            // Color
                                const uchar opacity=255,    // Opacity
                                const bool  redraw=false,   // Chart redraw flag
                                const uint  style=UINT_MAX) // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2);
   this.m_quad_y=::fmin(y1,y2);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1;
   this.m_quad_height=::fabs(y2-y1)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLineWu(x1,y1,x2,y2,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a  segment of a freehand line having a specified width      |
//| using a smoothing algorithm                                      |
//| with the preliminary sorting                                     |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawLineThickOnBG(const int   x1,                         // X coordinate of the segment first point
                                   const int   y1,                         // Y coordinate of the segment first point
                                   const int   x2,                         // X coordinate of the segment second point
                                   const int   y2,                         // Y coordinate of the segment second point
                                   const int   size,                       // Line width
                                   const color clr,                        // Color
                                   const uchar opacity=255,                // Opacity
                                   const bool  redraw=false,               // Chart redraw flag
                                   const uint  style=STYLE_SOLID,          // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                                   ENUM_LINE_END end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration's values
  {
//--- Calculate the adjustment of the outlining rectangle coordinates depending on the line size
   int correct=int(::ceil((double)size/2.0))+1;
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2)-correct;
   this.m_quad_y=::fmin(y1,y2)-correct;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1+correct*2;
   this.m_quad_height=::fabs(y2-y1)+1+correct*2;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLineThick(x1,y1,x2,y2,size,clr,opacity,style,end_style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+----------------------------------------------------------------------+
//| Draw a vertical segment of a freehand line having a specified width  |
//| using a smoothing algorithm                                          |
//| with the preliminary sorting                                         |
//+----------------------------------------------------------------------+
bool CFrameQuad::DrawLineThickVerticalOnBG(const int   x,                              // X coordinate of the segment
                                           const int   y1,                             // Y coordinate of the segment first point
                                           const int   y2,                             // Y coordinate of the segment second point
                                           const int   size,                           // line width
                                           const color clr,                            // Color
                                           const uchar opacity=255,                    // Opacity
                                           const bool  redraw=false,                   // Chart redraw flag
                                           const uint  style=STYLE_SOLID,              // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                                           const ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
  {
//--- Calculate the adjustment of the outlining rectangle coordinates depending on the line size and the type of its ends
   int correct_x=(int)::ceil((double)size/2.0);
   int correct_y=(end_style==LINE_END_BUTT ? 0 : correct_x);
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=x-correct_x;
   this.m_quad_y=::fmin(y1,y2)-correct_y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=size;
   this.m_quad_height=::fabs(y2-y1)+1+correct_y*2;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLineThickVertical(x,y1,y2,size,clr,opacity,style,end_style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+-----------------------------------------------------------------------+
//| Draws a horizontal segment of a freehand line having a specified width|
//| using a smoothing algorithm                                           |
//| with the preliminary sorting                                          |
//+-----------------------------------------------------------------------+
bool CFrameQuad::DrawLineThickHorizontalOnBG(const int   x1,                              // X coordinate of the segment first point
                                             const int   x2,                              // X coordinate of the segment second point
                                             const int   y,                               // Segment Y coordinate
                                             const int   size,                            // line width
                                             const color clr,                             // Color
                                             const uchar opacity=255,                     // Opacity
                                             const bool  redraw=false,                    // Chart redraw flag
                                             const uint  style=STYLE_SOLID,               // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                                             const ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
  {
//--- Calculate the adjustment of the outlining rectangle coordinates depending on the line size and the type of its ends
   int correct_y=(int)::ceil((double)size/2.0);
   int correct_x=(end_style==LINE_END_BUTT ? 0 : correct_y);
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(x1,x2)-correct_x;
   this.m_quad_y=y-correct_y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=::fabs(x2-x1)+1+correct_x*2;
   this.m_quad_height=size;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawLineThickHorizontal(x1,x2,y,size,clr,opacity,style,end_style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polyline using                                            |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolylineAAOnBG(int         &array_x[],       // Array with the X coordinates of polyline points
                                    int         &array_y[],       // Array with the Y coordinates of polyline points
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const bool  redraw=false,     // Chart redraw flag
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1;
   this.m_quad_height=(max_y_value-min_y_value)+1;

//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolylineAA(array_x,array_y,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draws a polyline using Wu algorithm                              |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolylineWuOnBG(int         &array_x[],       // Array with the X coordinates of polyline points
                                    int         &array_y[],       // Array with the Y coordinates of polyline points
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const bool  redraw=false,     // Chart redraw flag
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1;
   this.m_quad_height=(max_y_value-min_y_value)+1;

//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolylineWu(array_x,array_y,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polyline with a specified width using                     |
//| two smoothing algorithms in series.                              |
//| First, individual segments are smoothed                          |
//| based on Bezier curves.                                          |
//| Then, to improve the rendering quality,                          |
//| a raster smoothing algorithm is applied                          |
//| made of the polyline segments                                    |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolylineSmoothOnBG(const int    &array_x[],                    // Array with the X coordinates of polyline points
                                        const int    &array_y[],                    // Array with the Y coordinates of polyline points
                                        const int    size,                          // Line width
                                        const color  clr,                           // Color
                                        const uchar  opacity=255,                   // Chart redraw flag
                                        const double tension=0.5,                   // Smoothing parameter value
                                        const double step=10,                       // Approximation step
                                        const bool   redraw=false,                  // Chart redraw flag
                                        const ENUM_LINE_STYLE style=STYLE_SOLID,    // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                        const ENUM_LINE_END   end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=0;
   this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=this.m_element.Width();
   this.m_quad_height=this.m_element.Height();
   
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolylineSmooth(array_x,array_y,size,clr,opacity,tension,step,style,end_style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polyline with a specified width using                     |
//| a smoothing algorithm with the preliminary sorting               |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolylineThickOnBG(const int   &array_x[],                // Array with the X coordinates of polyline points
                                       const int   &array_y[],                // Array with the Y coordinates of polyline points
                                       const int   size,                      // Line width
                                       const color clr,                       // Color
                                       const uchar opacity=255,               // Opacity
                                       const bool  redraw=false,              // Chart redraw flag
                                       const uint  style=STYLE_SOLID,         // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                                       ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
  {
//--- Calculate the adjustment of the outlining rectangle coordinates depending on the line size
   int correct=int(::ceil((double)size/2.0))+1;
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x-correct;
   this.m_quad_y=y-correct;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1+correct*2;
   this.m_quad_height=(max_y_value-min_y_value)+1+correct*2;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolylineThick(array_x,array_y,size,clr,opacity,style,end_style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polygon using                                             |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolygonAAOnBG(int         &array_x[],     // Array with the X coordinates of polygon points
                                   int         &array_y[],     // Array with the Y coordinates of polygon points
                                   const color clr,            // Color
                                   const uchar opacity=255,    // Opacity
                                   const bool  redraw=false,   // Chart redraw flag
                                   const uint  style=UINT_MAX) // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1;
   if(this.m_quad_width==0)
      this.m_quad_width=1;
   this.m_quad_height=(max_y_value-min_y_value)+1;
   if(this.m_quad_height==0)
      this.m_quad_height=1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolygonAA(array_x,array_y,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polygon using Wu algorithm                                |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolygonWuOnBG(int         &array_x[],     // Array with the X coordinates of polygon points
                                   int         &array_y[],     // Array with the Y coordinates of polygon points
                                   const color clr,            // Color
                                   const uchar opacity=255,    // Opacity
                                   const bool  redraw=false,   // Chart redraw flag
                                   const uint  style=UINT_MAX) // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x;
   this.m_quad_y=y;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1;
   if(this.m_quad_width==0)
      this.m_quad_width=1;
   this.m_quad_height=(max_y_value-min_y_value)+1;
   if(this.m_quad_height==0)
      this.m_quad_height=1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolygonWu(array_x,array_y,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polygon with a specified width using                      |
//| two smoothing algorithms in series.                              |
//| First, individual segments are smoothed based on Bezier curves.  |
//| Then, to improve the rendering quality,                          |
//| a raster smoothing algorithm is applied                          |
//| to the polygon made of these segments.                           |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolygonSmoothOnBG(int          &array_x[],                  // Array with the X coordinates of polyline points
                                       int          &array_y[],                  // Array with the Y coordinates of polyline points
                                       const int    size,                        // Line width
                                       const color  clr,                         // Color
                                       const uchar  opacity=255,                 // Chart redraw flag
                                       const double tension=0.5,                 // Smoothing parameter value
                                       const double step=10,                     // Approximation step
                                       const bool   redraw=false,                // Chart redraw flag
                                       const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                       const ENUM_LINE_END   end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=0;
   this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=this.m_element.Width();
   this.m_quad_height=this.m_element.Height();
   
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolygonSmooth(array_x,array_y,size,clr,opacity,tension,step,style,end_style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a polygon with a specified width using                      |
//| a smoothing algorithm with the preliminary sorting               |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawPolygonThickOnBG(const int   &array_x[],                 // array with the X coordinates of polygon points
                                      const int   &array_y[],                 // array with the Y coordinates of polygon points
                                      const int   size,                       // line width
                                      const color clr,                        // Color
                                      const uchar opacity=255,                // Opacity
                                      const bool  redraw=false,               // Chart redraw flag
                                      const uint  style=STYLE_SOLID,          // line style
                                      ENUM_LINE_END end_style=LINE_END_ROUND) // line ends style
  {
//--- Calculate the adjustment of the outlining rectangle coordinates depending on the line size
   int correct=int(::ceil((double)size/2.0))+1;
//--- Set the coordinates of the outlining rectangle
   int x=0,y=0;
   if(!ArrayMinimumValue(DFUN_ERR_LINE,array_x,x) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,y))
      return false;
   this.m_quad_x=x-correct;
   this.m_quad_y=y-correct;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   int max_x_value=0,min_x_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_x,max_x_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_x,min_x_value))
      return false;
   int max_y_value=0,min_y_value=0;
   if(!ArrayMaximumValue(DFUN_ERR_LINE,array_y,max_y_value) || !ArrayMinimumValue(DFUN_ERR_LINE,array_y,min_y_value))
      return false;
   this.m_quad_width=(max_x_value-min_x_value)+1+correct*2;
   this.m_quad_height=(max_y_value-min_y_value)+1+correct*2;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawPolygonThick(array_x,array_y,size,clr,opacity,style,end_style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a triangle using                                            |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawTriangleAAOnBG(const int   x1,               // X coordinate of the triangle first vertex
                                    const int   y1,               // Y coordinate of the triangle first vertex
                                    const int   x2,               // X coordinate of the triangle second vertex
                                    const int   y2,               // Y coordinate of the triangle second vertex
                                    const int   x3,               // X coordinate of the triangle third vertex
                                    const int   y3,               // Y coordinate of the triangle third vertex
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const bool  redraw=false,     // Chart redraw flag
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(::fmin(x1,x2),x3);
   this.m_quad_y=::fmin(::fmin(y1,y2),y3);
   int max_x=::fmax(::fmax(x1,x2),x3);
   int max_y=::fmax(::fmax(y1,y2),y3);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(max_x-this.m_quad_x)+1;
   this.m_quad_height=int(max_y-this.m_quad_y)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawTriangleAA(x1,y1,x2,y2,x3,y3,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a triangle using Wu algorithm                               |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawTriangleWuOnBG(const int   x1,               // X coordinate of the triangle first vertex
                                    const int   y1,               // Y coordinate of the triangle first vertex
                                    const int   x2,               // X coordinate of the triangle second vertex
                                    const int   y2,               // Y coordinate of the triangle second vertex
                                    const int   x3,               // X coordinate of the triangle third vertex
                                    const int   y3,               // Y coordinate of the triangle third vertex
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const bool  redraw=false,     // Chart redraw flag
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=::fmin(::fmin(x1,x2),x3);
   this.m_quad_y=::fmin(::fmin(y1,y2),y3);
   int max_x=::fmax(::fmax(x1,x2),x3);
   int max_y=::fmax(::fmax(y1,y2),y3);
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(max_x-this.m_quad_x)+1;
   this.m_quad_height=int(max_y-this.m_quad_y)+1;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawTriangleWu(x1,y1,x2,y2,x3,y3,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a circle using                                              |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawCircleAAOnBG(const int    x,              // X coordinate of the circle center
                                  const int    y,              // Y coordinate of the circle center
                                  const double r,              // Circle radius
                                  const color  clr,            // Color
                                  const uchar  opacity=255,    // Opacity
                                  const bool   redraw=false,   // Chart redraw flag
                                  const uint   style=UINT_MAX) // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   double rd=(r>0 ? r : 1);
   this.m_quad_x=x-rd;
   this.m_quad_y=y-rd;
   double x2=x+rd;
   double y2=y+rd;
   if(this.m_quad_x<0)
      this.m_quad_x=0;
   if(this.m_quad_y<0)
      this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(::ceil(x2-this.m_quad_x)+1);
   this.m_quad_height=int(::ceil(y2-this.m_quad_y)+1);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawCircleAA(x,y,rd,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw a circle using Wu algorithm                                 |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawCircleWuOnBG(const int    x,              // X coordinate of the circle center
                                  const int    y,              // Y coordinate of the circle center
                                  const double r,              // Circle radius
                                  const color  clr,            // Color
                                  const uchar  opacity=255,    // Opacity
                                  const bool   redraw=false,   // Chart redraw flag
                                  const uint   style=UINT_MAX) // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Set the coordinates of the outlining rectangle
   double rd=(r>0 ? r : 1);
   this.m_quad_x=x-rd;
   this.m_quad_y=y-rd;
   double x2=x+rd;
   double y2=y+rd;
   if(this.m_quad_x<0)
      this.m_quad_x=0;
   if(this.m_quad_y<0)
      this.m_quad_y=0;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(::ceil(x2-this.m_quad_x)+1);
   this.m_quad_height=int(::ceil(y2-this.m_quad_y)+1);
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawCircleWu(x,y,rd,clr,opacity);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw an ellipse using two points while applying                  |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawEllipseAAOnBG(const double x1,               // X coordinate of the first point defining the ellipse
                                   const double y1,               // Y coordinate of the first point defining the ellipse
                                   const double x2,               // X coordinate of the second point defining the ellipse
                                   const double y2,               // Y coordinate of the second point defining the ellipse
                                   const color  clr,              // Color
                                   const uchar  opacity=255,      // Opacity
                                   const bool   redraw=false,     // Chart redraw flag
                                   const uint   style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Get the minimum and maximum coordinates
   double xn1=::fmin(x1,x2);
   double xn2=::fmax(x1,x2);
   double yn1=::fmin(y1,y2);
   double yn2=::fmax(y1,y2);
   if(xn2==xn1)
      xn2=xn1+0.1;
   if(yn2==yn1)
      yn2=yn1+0.1;
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=xn1-1;
   this.m_quad_y=yn1-1;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(::ceil((xn2-xn1)+1))+2;
   this.m_quad_height=int(::ceil((yn2-yn1)+1))+2;
//--- Adjust the width and height of the outlining rectangle
   if(this.m_quad_width<3)
      this.m_quad_width=3;
   if(this.m_quad_height<3)
      this.m_quad_height=3;
      
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawEllipseAA(xn1,yn1,xn2,yn2,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Draw an ellipse using two points while applying                  |
//| Wu algorithm                                                     |
//+------------------------------------------------------------------+
bool CFrameQuad::DrawEllipseWuOnBG(const int   x1,             // X coordinate of the first point defining the ellipse
                                   const int   y1,             // Y coordinate of the first point defining the ellipse
                                   const int   x2,             // X coordinate of the second point defining the ellipse
                                   const int   y2,             // Y coordinate of the second point defining the ellipse
                                   const color clr,            // Color
                                   const uchar opacity=255,    // Opacity
                                   const bool  redraw=false,   // Chart redraw flag
                                   const uint  style=UINT_MAX) // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
//--- Get the minimum and maximum coordinates
   double xn1=::fmin(x1,x2);
   double xn2=::fmax(x1,x2);
   double yn1=::fmin(y1,y2);
   double yn2=::fmax(y1,y2);
   if(xn2==xn1)
      xn2=xn1+0.1;
   if(yn2==yn1)
      yn2=yn1+0.1;
//--- Set the coordinates of the outlining rectangle
   this.m_quad_x=xn1-1;
   this.m_quad_y=yn1-1;
//--- Set the width and height of the image outlining the rectangle (to be used as the size of the saved area)
   this.m_quad_width=int(::ceil((xn2-xn1)+1))+2;
   this.m_quad_height=int(::ceil((yn2-yn1)+1))+2;
//--- Adjust the width and height of the outlining rectangle
   if(this.m_quad_width<3)
      this.m_quad_width=3;
   if(this.m_quad_height<3)
      this.m_quad_height=3;
  
//--- Restore the previously saved background and save the new one
   if(!this.SaveRestoreBG())
      return false;
      
//--- Draw the shape and update the element
   this.m_element.DrawEllipseWu((int)xn1,(int)yn1,(int)xn2,(int)yn2,clr,opacity,style);
   this.SetLastParams(this.m_quad_x,this.m_quad_y,this.m_shift_x,this.m_shift_y);
   this.m_element.Update(redraw);
   return true;
  }
//+------------------------------------------------------------------+
//| Save and restore the background under the image                  |
//+------------------------------------------------------------------+
bool CFrameQuad::SaveRestoreBG(void)
  {
//--- Calculate coordinate offsets for the saved area depending on the anchor point
   this.m_element.GetShiftXYbySize(this.m_quad_width,this.m_quad_height,FRAME_ANCHOR_LEFT_TOP,this.m_shift_x,this.m_shift_y);
//--- If the pixel array is not empty, the background under the image has already been saved -
//--- restore the previously saved background (by the previous coordinates and offsets)
   if(::ArraySize(this.m_array)>0)
     {
      if(!CPixelCopier::CopyImgDataToCanvas(int(this.m_x_last+this.m_shift_x_prev),int(this.m_y_last+this.m_shift_y_prev)))
         return false;
     }
//--- Return the result of saving the background area with the calculated coordinates and size under the future image
   return CPixelCopier::CopyImgDataToArray(int(this.m_quad_x+this.m_shift_x),int(this.m_quad_y+this.m_shift_y),this.m_quad_width,this.m_quad_height);
  }
//+------------------------------------------------------------------+
