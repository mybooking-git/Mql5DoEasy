//+------------------------------------------------------------------+
//|                                                   Animations.mqh |
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
#include "FrameText.mqh"
#include "FrameQuad.mqh"
#include "FrameGeometry.mqh"
//+------------------------------------------------------------------+
//| Animation class                                                  |
//+------------------------------------------------------------------+
class CAnimations : public CObject
  {
private:
   CGCnvElement     *m_element;                             // Pointer to the graphical element
   CArrayObj         m_list_frames_text;                    // List of text animation frames
   CArrayObj         m_list_frames_quad;                    // List of rectangular animation frames
   CArrayObj         m_list_frames_geom;                    // List of geometric shape animations frames

//--- Return the flag indicating the presence of the frame object with the specified ID in the list
   bool              IsPresentFrame(const ENUM_ANIMATION_FRAME_TYPE frame_type,const int id);
//--- Return or create a new animation frame object
   CFrame           *GetOrCreateFrame(const string source,const int id,const ENUM_ANIMATION_FRAME_TYPE frame_type,const bool create_new);

protected:
   int               m_type;                                // Object type

public:
                     CAnimations(CGCnvElement *element);
                     CAnimations(){ this.m_type=OBJECT_DE_TYPE_GANIMATIONS; }

//--- Create a new (1) rectangular, (2) text and geometric animation frame object
   CFrame           *CreateNewFrameText(const int id);
   CFrame           *CreateNewFrameQuad(const int id);
   CFrame           *CreateNewFrameGeometry(const int id);
//--- Return the animation frame objects by ID
   CFrame           *GetFrame(const ENUM_ANIMATION_FRAME_TYPE frame_type,const int id);
//--- Return the list of (1) text, (2) rectangular and (3) geometric shape animation frames
   CArrayObj        *GetListFramesText(void)                { return &this.m_list_frames_text;  }
   CArrayObj        *GetListFramesQuad(void)                { return &this.m_list_frames_quad;  }
   CArrayObj        *GetListFramesGeometry(void)            { return &this.m_list_frames_geom;  }

//--- Return an object type
   virtual int       Type(void)                       const { return this.m_type;               }
//+------------------------------------------------------------------+
//| The methods of drawing, while saving and restoring the background|
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Display a text on the background                                 |
//+------------------------------------------------------------------+
   bool              TextOnBG(const int id,
                              const string text,
                              const int x,
                              const int y,
                              const ENUM_FRAME_ANCHOR anchor,
                              const color clr,
                              const uchar opacity,
                              const bool create_new=true,
                              const bool redraw=false);
//+------------------------------------------------------------------+
//| The methods of drawing primitives without smoothing              |
//+------------------------------------------------------------------+
//--- Set the color of the dot with the specified coordinates
   bool              SetPixelOnBG(const int id,const int x,const int y,const color clr,const uchar opacity=255,const bool create_new=true,const bool redraw=false);
                       
//--- Draw a segment of a vertical line
   bool              DrawLineVerticalOnBG(const int id,                 // Frame ID
                              const int   x,                            // Segment X coordinate
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a segment of a horizontal line
   bool              DrawLineHorizontalOnBG(const int id,               // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y,                            // Segment Y coordinate
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a segment of a freehand line
   bool              DrawLineOnBG(const int id,                         // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a polyline
   bool              DrawPolylineOnBG(const int id,                     // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a polygon
   bool              DrawPolygonOnBG(const int id,                      // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a rectangle using two points
   bool              DrawRectangleOnBG(const int id,                    // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the rectangle
                              const int   y1,                           // Y coordinate of the first point defining the rectangle
                              const int   x2,                           // X coordinate of the second point defining the rectangle
                              const int   y2,                           // Y coordinate of the second point defining the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a circle
   bool              DrawCircleOnBG(const int id,                       // Frame ID
                              const int   x,                            // X coordinate of the circle center
                              const int   y,                            // Y coordinate of the circle center
                              const int   r,                            // Circle radius
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a triangle
   bool              DrawTriangleOnBG(const int id,                     // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw an ellipse using two points
   bool              DrawEllipseOnBG(const int id,                      // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the ellipse
                              const int   y1,                           // Y coordinate of the first point defining the ellipse
                              const int   x2,                           // X coordinate of the second point defining the ellipse
                              const int   y2,                           // Y coordinate of the second point defining the ellipse
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw an arc of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2).
//--- The arc boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   bool              DrawArcOnBG(const int id,                          // Frame ID
                              const int   x1,                           // X coordinate of the top left corner forming the rectangle
                              const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                              const int   x3,                           // X coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   y3,                           // Y coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   x4,                           // X coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   y4,                           // Y coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled sector of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2).
//--- The sector boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   bool              DrawPieOnBG(const int id,                          // Frame ID
                              const int   x1,                           // X coordinate of the upper left corner of the rectangle
                              const int   y1,                           // Y coordinate of the upper left corner of the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner of the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner of the rectangle
                              const int   x3,                           // X coordinate of the first point to find the arc boundaries
                              const int   y3,                           // Y coordinate of the first point to find the arc boundaries
                              const int   x4,                           // X coordinate of the second point to find the arc boundaries
                              const int   y4,                           // Y coordinate of the second point to find the arc boundaries
                              const color clr,                          // Color
                              const color fill_clr,                     // Fill color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//+------------------------------------------------------------------+
//| The methods of drawing filled primitives without smoothing       |
//+------------------------------------------------------------------+
//--- Fill in the area
   bool              FillOnBG(const int   id,                           // Frame ID
                              const int   x,                            // X coordinate of the filling start point
                              const int   y,                            // Y coordinate of the filling start point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const uint  threshould=0,                 // Threshold
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled rectangle
   bool              DrawRectangleFillOnBG(const int id,                // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the rectangle
                              const int   y1,                           // Y coordinate of the first point defining the rectangle
                              const int   x2,                           // X coordinate of the second point defining the rectangle
                              const int   y2,                           // Y coordinate of the second point defining the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag

//--- Draw a filled circle
   bool              DrawCircleFillOnBG(const int id,                   // Frame ID
                              const int   x,                            // X coordinate of the circle center
                              const int   y,                            // Y coordinate of the circle center
                              const int   r,                            // Circle radius
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled triangle
   bool              DrawTriangleFillOnBG(const int id,                 // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled polygon
   bool              DrawPolygonFillOnBG(const int id,                  // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//--- Draw a filled ellipse inscribed in a rectangle with the specified coordinates
   bool              DrawEllipseFillOnBG(const int id,                  // Frame ID
                              const int   x1,                           // X coordinate of the top left corner forming the rectangle
                              const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false);                // Chart redraw flag
                       
//+------------------------------------------------------------------+
//| The methods of drawing primitives using smoothing                |
//+------------------------------------------------------------------+
//--- Draw a point using AntiAliasing algorithm
   bool              SetPixelAAOnBG(const int id,                       // Frame ID
                              const double x,                           // Point X coordinate
                              const double y,                           // Pixel Y coordinate
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false);               // Chart redraw flag
                       
//--- Draw a segment of a freehand line using AntiAliasing algorithm
   bool              DrawLineAAOnBG(const int id,                       // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a segment of a freehand line using Wu algorithm
   bool              DrawLineWuOnBG(const int id,                       // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draws a segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawLineThickOnBG(const int id,                    // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const int   size,                         // Line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              ENUM_LINE_END end_style=LINE_END_ROUND);  // Line style is one of the ENUM_LINE_END enumeration values
 
//--- Draw a vertical segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawLineThickVerticalOnBG(const int id,            // Frame ID
                              const int   x,                            // Segment X coordinate
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   y2,                           // Y coordinate of the segment second point
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND); // Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a horizontal segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawLineThickHorizontalOnBG(const int id,          // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y,                            // Segment Y coordinate
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND); // Line style is one of the ENUM_LINE_END enumeration values

//--- Draws a polyline using AntiAliasing algorithm
   bool              DrawPolylineAAOnBG(const int id,                   // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draws a polyline using Wu algorithm
   bool              DrawPolylineWuOnBG(const int id,                   // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a polyline with a specified width consecutively using two antialiasing algorithms.
//--- First, individual line segments are smoothed based on Bezier curves.
//--- Then, the raster antialiasing algorithm is applied to the polyline built from these segments to improve the rendering quality
   bool              DrawPolylineSmoothOnBG(const int id,               // Frame ID
                              const int    &array_x[],                  // Array with the X coordinates of polyline points
                              const int    &array_y[],                  // Array with the Y coordinates of polyline points
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND);// Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a polyline having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawPolylineThickOnBG(const int id,                // Frame ID
                              const int     &array_x[],                 // Array with the X coordinates of polyline points
                              const int     &array_y[],                 // Array with the Y coordinates of polyline points
                              const int     size,                       // Line width
                              const color   clr,                        // Color
                              const uchar   opacity=255,                // Opacity
                              const bool    create_new=true,            // New object creation flag
                              const bool    redraw=false,               // Chart redraw flag
                              const uint    style=STYLE_SOLID,          // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              ENUM_LINE_END end_style=LINE_END_ROUND);  // Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a polygon using AntiAliasing algorithm
   bool              DrawPolygonAAOnBG(const int id,                    // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a polygon using Wu algorithm
   bool              DrawPolygonWuOnBG(const int id,                    // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a polygon with a specified width consecutively using two smoothing algorithms.
//--- First, individual segments are smoothed based on Bezier curves.
//--- Then, the raster smoothing algorithm is applied to the polygon built from these segments to improve the rendering quality. 
   bool              DrawPolygonSmoothOnBG(const int id,                // Frame ID
                              int          &array_x[],                  // Array with the X coordinates of polyline points
                              int          &array_y[],                  // Array with the Y coordinates of polyline points
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND);// Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a polygon having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawPolygonThickOnBG(const int id,                 // Frame ID
                              const int   &array_x[],                   // array with the X coordinates of polygon points
                              const int   &array_y[],                   // array with the Y coordinates of polygon points
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // line style
                              ENUM_LINE_END end_style=LINE_END_ROUND);  // line ends style
                       
//--- Draw a triangle using AntiAliasing algorithm
   bool              DrawTriangleAAOnBG(const int id,                   // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a triangle using Wu algorithm
   bool              DrawTriangleWuOnBG(const int id,                   // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a circle using AntiAliasing algorithm
   bool              DrawCircleAAOnBG(const int id,                     // Frame ID
                              const int    x,                           // X coordinate of the circle center
                              const int    y,                           // Y coordinate of the circle center
                              const double r,                           // Circle radius
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a circle using Wu algorithm
   bool              DrawCircleWuOnBG(const int id,                     // Frame ID
                              const int    x,                           // X coordinate of the circle center
                              const int    y,                           // Y coordinate of the circle center
                              const double r,                           // Circle radius
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw an ellipse by two points using AntiAliasing algorithm
   bool              DrawEllipseAAOnBG(const int id,                    // Frame ID
                              const double x1,                          // X coordinate of the first point defining the ellipse
                              const double y1,                          // Y coordinate of the first point defining the ellipse
                              const double x2,                          // X coordinate of the second point defining the ellipse
                              const double y2,                          // Y coordinate of the second point defining the ellipse
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw an ellipse by two points using Wu algorithm
   bool              DrawEllipseWuOnBG(const int id,                    // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the ellipse
                              const int   y1,                           // Y coordinate of the first point defining the ellipse
                              const int   x2,                           // X coordinate of the second point defining the ellipse
                              const int   y2,                           // Y coordinate of the second point defining the ellipse
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX);              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  
//+------------------------------------------------------------------+
//| Methods of drawing regular polygons                              |
//+------------------------------------------------------------------+
//--- Draw a regular polygon without smoothing
   bool              DrawNgonOnBG(const int id,                         // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false);               // Chart redraw flag
                                  
//--- Draw a regular filled polygon
   bool              DrawNgonFillOnBG(const int id,                     // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false);               // Chart redraw flag
                       
//--- Draw a regular polygon using AntiAliasing algorithm
   bool              DrawNgonAAOnBG(const int id,                       // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a regular polygon using Wu algorithm
   bool              DrawNgonWuOnBG(const int id,                       // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX);             // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       
//--- Draw a regular polygon with a specified width consecutively using two smoothing algorithms.
//--- First, individual segments are smoothed based on Bezier curves.
//--- Then, the raster smoothing algorithm is applied to the polygon built from these segments to improve the rendering quality. 
   bool              DrawNgonSmoothOnBG(const int id,                   // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND);// Line style is one of the ENUM_LINE_END enumeration values
                       
//--- Draw a regular polygon having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawNgonThickOnBG(const int id,                    // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const int    size,                        // line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=STYLE_SOLID,           // line style
                              ENUM_LINE_END end_style=LINE_END_ROUND);  // line ends style
  
  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CAnimations::CAnimations(CGCnvElement *element)
  {
   this.m_type=OBJECT_DE_TYPE_GANIMATIONS; 
   this.m_element=element;
  }
//+------------------------------------------------------------------+
//| Return the animation frame objects by type and ID                |
//+------------------------------------------------------------------+
CFrame *CAnimations::GetFrame(const ENUM_ANIMATION_FRAME_TYPE frame_type,const int id)
  {
//--- Declare the pointer to the animation frame object
   CFrame *frame=NULL;
//--- Depending on the necessary object type, receive their number in the appropriate list
   int total=
     (
      frame_type==ANIMATION_FRAME_TYPE_TEXT     ?  this.m_list_frames_text.Total()  : 
      frame_type==ANIMATION_FRAME_TYPE_QUAD     ?  this.m_list_frames_quad.Total()  :
      frame_type==ANIMATION_FRAME_TYPE_GEOMETRY ?  this.m_list_frames_geom.Total()  :  0
     );
//--- Get the next object in the loop ...
   for(int i=0;i<total;i++)
     {
      //--- ... by the list corresponding to the animation frame type
      switch(frame_type)
        {
         case ANIMATION_FRAME_TYPE_TEXT      :  frame=this.m_list_frames_text.At(i);   break;
         case ANIMATION_FRAME_TYPE_QUAD      :  frame=this.m_list_frames_quad.At(i);   break;
         case ANIMATION_FRAME_TYPE_GEOMETRY  :  frame=this.m_list_frames_geom.At(i);   break;
         default: break;
        }
      //---if failed to get the pointer, move on to the next one
      if(frame==NULL)
         continue;
      //--- If the object ID correspond to the required one,
      //--- return the pointer to the detected object
      if(frame.ID()==id)
         return frame;
     }
//--- Nothing is found - return NULL
   return NULL;
  }
//+------------------------------------------------------------------------+
//| Return the flag indicating the presence of the animation frame object  |
//| with the specified type and ID                                         |
//+------------------------------------------------------------------------+
bool CAnimations::IsPresentFrame(const ENUM_ANIMATION_FRAME_TYPE frame_type,const int id)
  {
   return(this.GetFrame(frame_type,id)!=NULL);
  }
//+------------------------------------------------------------------+
//| Create a new text animation frame object                         |
//+------------------------------------------------------------------+
CFrame *CAnimations::CreateNewFrameText(const int id)
  {
//--- If the object with such an ID is already present, inform of that in the journal and return NULL
   if(this.IsPresentFrame(ANIMATION_FRAME_TYPE_TEXT,id))
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_FRAME_ALREADY_IN_LIST),(string)id);
      return NULL;
     }
//--- Create a new text animation frame object with the specified ID
   CFrame *frame=new CFrameText(id,this.m_element);
//--- If failed to create an object, inform of that and return NULL
   if(frame==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_ERR_FAILED_CREATE_FRAME));
      return NULL;
     }
//--- If failed to add the created object to the list, inform of that, remove the object and return NULL
   if(!this.m_list_frames_text.Add(frame))
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST)," ID: ",id);
      delete frame;
      return NULL;
     }
//--- Return the pointer to a newly created object
   return frame;
  }
//+------------------------------------------------------------------+
//| Create a new rectangular animation frame object                  |
//+------------------------------------------------------------------+
CFrame *CAnimations::CreateNewFrameQuad(const int id)
  {
//--- If the object with such an ID is already present, inform of that in the journal and return NULL
   if(this.IsPresentFrame(ANIMATION_FRAME_TYPE_QUAD,id))
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_FRAME_ALREADY_IN_LIST),(string)id);
      return NULL;
     }
//--- Create a new rectangular animation frame object with the specified ID
   CFrame *frame=new CFrameQuad(id,this.m_element);
//--- If failed to create an object, inform of that and return NULL
   if(frame==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_ERR_FAILED_CREATE_FRAME));
      return NULL;
     }
//--- If failed to add the created object to the list, inform of that, remove the object and return NULL
   if(!this.m_list_frames_quad.Add(frame))
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST)," ID: ",id);
      delete frame;
      return NULL;
     }
//--- Return the pointer to a newly created object
   return frame;
  }
//+------------------------------------------------------------------+
//| Create a new geometric animation frame object                    |
//+------------------------------------------------------------------+
CFrame *CAnimations::CreateNewFrameGeometry(const int id)
  {
//--- If the object with such an ID is already present, inform of that in the journal and return NULL
   if(this.IsPresentFrame(ANIMATION_FRAME_TYPE_GEOMETRY,id))
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_FRAME_ALREADY_IN_LIST),(string)id);
      return NULL;
     }
//--- Create a new geometric animation frame object with the specified ID
   CFrame *frame=new CFrameGeometry(id,this.m_element);
//--- If failed to create an object, inform of that and return NULL
   if(frame==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_ERR_FAILED_CREATE_FRAME));
      return NULL;
     }
//--- If failed to add the created object to the list, inform of that, remove the object and return NULL
   if(!this.m_list_frames_geom.Add(frame))
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST)," ID: ",id);
      delete frame;
      return NULL;
     }
//--- Return the pointer to a newly created object
   return frame;
  }
//+------------------------------------------------------------------+
//| Return or create a new animation frame object                    |
//+------------------------------------------------------------------+
CFrame *CAnimations::GetOrCreateFrame(const string source,const int id,const ENUM_ANIMATION_FRAME_TYPE frame_type,const bool create_new)
  {
   //--- Declare null pointers to objects
   CFrameQuad     *frame_q=NULL;
   CFrameText     *frame_t=NULL;
   CFrameGeometry *frame_g=NULL;
   //--- Depending on the required object type
   switch(frame_type)
     {
      //--- If this is a text animation frame,
      case ANIMATION_FRAME_TYPE_TEXT :
        //--- get the pointer to an object with a specified ID
        frame_t=this.GetFrame(ANIMATION_FRAME_TYPE_TEXT,id);
        //--- If the pointer is obtained, return it
        if(frame_t!=NULL)
           return frame_t;
        //--- If the flag of creating a new object is not set, report an error and return NULL
        if(!create_new)
          {
           ::Print(source,CMessage::Text(MSG_FORM_OBJECT_FRAME_NOT_EXIST_LIST),(string)id);
           return NULL;
          }
        //--- Return the result of creating a new text animation frame object (pointer to the created object)
        return this.CreateNewFrameText(id);
      
      //--- If this is a rectangle animation frame
      case ANIMATION_FRAME_TYPE_QUAD :
        //--- get the pointer to an object with a specified ID
        frame_q=this.GetFrame(ANIMATION_FRAME_TYPE_QUAD,id);
        //--- If the pointer is obtained, return it
        if(frame_q!=NULL)
           return frame_q;
        //--- If the flag of creating a new object is not set, report an error and return NULL
        if(!create_new)
          {
           ::Print(source,CMessage::Text(MSG_FORM_OBJECT_FRAME_NOT_EXIST_LIST),(string)id);
           return NULL;
          }
        //--- Return the result of creating a new rectangular animation frame object (pointer to the created object)
        return this.CreateNewFrameQuad(id);
      
      //--- If this is a geometric animation frame
      case ANIMATION_FRAME_TYPE_GEOMETRY :
        //--- get the pointer to an object with a specified ID
        frame_g=this.GetFrame(ANIMATION_FRAME_TYPE_GEOMETRY,id);
        //--- If the pointer is obtained, return it
        if(frame_g!=NULL)
           return frame_g;
        //--- If the flag of creating a new object is not set, report an error and return NULL
        if(!create_new)
          {
           ::Print(source,CMessage::Text(MSG_FORM_OBJECT_FRAME_NOT_EXIST_LIST),(string)id);
           return NULL;
          }
        //--- Return the result of creating a new geometric animation frame object (pointer to the created object)
        return this.CreateNewFrameGeometry(id);
      //--- In the remaining cases, return NULL
      default:
        return NULL;
     }
  }
//+--------------------------------------------------------------------------------+
//| Display the text on the background, while saving and restoring the background  |
//+--------------------------------------------------------------------------------+
bool CAnimations::TextOnBG(const int id,
                           const string text,
                           const int x,
                           const int y,
                           const ENUM_FRAME_ANCHOR anchor,
                           const color clr,
                           const uchar opacity,
                           const bool create_new=true,
                           const bool redraw=false)
  {
   CFrameText *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_TEXT,create_new);
   if(frame==NULL)
      return false;
   return frame.TextOnBG(text,x,y,anchor,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Set the color of the dot with the specified coordinates          |
//+------------------------------------------------------------------+
bool CAnimations::SetPixelOnBG(const int id,const int x,const int y,const color clr,const uchar opacity=255,const bool create_new=true,const bool redraw=false)
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.SetPixelOnBG(x,y,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a segment of a vertical line                                |
//+------------------------------------------------------------------+
bool CAnimations::DrawLineVerticalOnBG(const int id,                 // Frame ID
                           const int   x,                            // Segment X coordinate
                           const int   y1,                           // Y coordinate of the segment first point
                           const int   y2,                           // Y coordinate of the segment second point
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineVerticalOnBG(x,y1,y2,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a segment of a horizontal line                              |
//+------------------------------------------------------------------+
bool CAnimations::DrawLineHorizontalOnBG(const int id,               // Frame ID
                           const int   x1,                           // X coordinate of the segment first point
                           const int   x2,                           // X coordinate of the segment second point
                           const int   y,                            // Segment Y coordinate
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineHorizontalOnBG(x1,x2,y,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a segment of a freehand line                                |
//+------------------------------------------------------------------+
bool CAnimations::DrawLineOnBG(const int id,                         // Frame ID
                           const int   x1,                           // X coordinate of the segment first point
                           const int   y1,                           // Y coordinate of the segment first point
                           const int   x2,                           // X coordinate of the segment second point
                           const int   y2,                           // Y coordinate of the segment second point
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineOnBG(x1,y1,x2,y2,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a polyline                                                  |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolylineOnBG(const int id,                     // Frame ID
                           int         &array_x[],                   // Array with the X coordinates of polyline points
                           int         &array_y[],                   // Array with the Y coordinates of polyline points
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolylineOnBG(array_x,array_y,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a polygon                                                   |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolygonOnBG(const int id,                      // Frame ID
                           int         &array_x[],                   // Array with the X coordinates of polygon points
                           int         &array_y[],                   // Array with the Y coordinates of polygon points
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolygonOnBG(array_x,array_y,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a rectangle using two points                                |
//+------------------------------------------------------------------+
bool CAnimations::DrawRectangleOnBG(const int id,                    // Frame ID
                           const int   x1,                           // X coordinate of the first point defining the rectangle
                           const int   y1,                           // Y coordinate of the first point defining the rectangle
                           const int   x2,                           // X coordinate of the second point defining the rectangle
                           const int   y2,                           // Y coordinate of the second point defining the rectangle
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawRectangleOnBG(x1,y1,x2,y2,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw the circle                                                  |
//+------------------------------------------------------------------+
bool CAnimations::DrawCircleOnBG(const int id,                       // Frame ID
                           const int   x,                            // X coordinate of the circle center
                           const int   y,                            // Y coordinate of the circle center
                           const int   r,                            // Circle radius
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawCircleOnBG(x,y,r,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a triangle                                                  |
//+------------------------------------------------------------------+
bool CAnimations::DrawTriangleOnBG(const int id,                     // Frame ID
                           const int   x1,                           // X coordinate of the triangle first vertex
                           const int   y1,                           // Y coordinate of the triangle first vertex
                           const int   x2,                           // X coordinate of the triangle second vertex
                           const int   y2,                           // Y coordinate of the triangle second vertex
                           const int   x3,                           // X coordinate of the triangle third vertex
                           const int   y3,                           // Y coordinate of the triangle third vertex
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawTriangleOnBG(x1,y1,x2,y2,x3,y3,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw an ellipse using two points                                 |
//+------------------------------------------------------------------+
bool CAnimations::DrawEllipseOnBG(const int id,                      // Frame ID
                           const int   x1,                           // X coordinate of the first point defining the ellipse
                           const int   y1,                           // Y coordinate of the first point defining the ellipse
                           const int   x2,                           // X coordinate of the second point defining the ellipse
                           const int   y2,                           // Y coordinate of the second point defining the ellipse
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawEllipseOnBG(x1,y1,x2,y2,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw an arc of an ellipse inscribed in a rectangle               |
//| with the corners in (x1,y1) and (x2,y2).                         |
//| The arc boundaries are cropped from the ellipse center           |
//| moving to two points with the coordinates of (x3,y3) and (x4,y4) |
//+------------------------------------------------------------------+
bool CAnimations::DrawArcOnBG(const int id,                          // Frame ID
                           const int   x1,                           // X coordinate of the top left corner forming the rectangle
                           const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                           const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                           const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                           const int   x3,                           // X coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                           const int   y3,                           // Y coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                           const int   x4,                           // X coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                           const int   y4,                           // Y coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawArcOnBG(x1,y1,x2,y2,x3,y3,x4,y4,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a filled sector of an ellipse inscribed in a rectangle      |
//| with the corners in (x1,y1) and (x2,y2).                         |
//| The sector boundaries are cropped from the ellipse center        |
//| moving to two points with the coordinates of (x3,y3) and (x4,y4) |
//+------------------------------------------------------------------+
bool CAnimations::DrawPieOnBG(const int id,                          // Frame ID
                           const int   x1,                           // X coordinate of the upper left corner of the rectangle
                           const int   y1,                           // Y coordinate of the upper left corner of the rectangle
                           const int   x2,                           // X coordinate of the bottom right corner of the rectangle
                           const int   y2,                           // Y coordinate of the bottom right corner of the rectangle
                           const int   x3,                           // X coordinate of the first point to find the arc boundaries
                           const int   y3,                           // Y coordinate of the first point to find the arc boundaries
                           const int   x4,                           // X coordinate of the second point to find the arc boundaries
                           const int   y4,                           // Y coordinate of the second point to find the arc boundaries
                           const color clr,                          // Color
                           const color fill_clr,                     // Fill color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPieOnBG(x1,y1,x2,y2,x3,y3,x4,y4,clr,fill_clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Fill in the area                                                 |
//+------------------------------------------------------------------+
bool CAnimations::FillOnBG(const int   id,                           // Frame ID
                           const int   x,                            // X coordinate of the filling start point
                           const int   y,                            // Y coordinate of the filling start point
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const uint  threshould=0,                 // Threshold
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.FillOnBG(x,y,clr,opacity,threshould,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a filled rectangle                                          |
//+------------------------------------------------------------------+
bool CAnimations::DrawRectangleFillOnBG(const int id,                // Frame ID
                           const int   x1,                           // X coordinate of the first point defining the rectangle
                           const int   y1,                           // Y coordinate of the first point defining the rectangle
                           const int   x2,                           // X coordinate of the second point defining the rectangle
                           const int   y2,                           // Y coordinate of the second point defining the rectangle
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawRectangleFillOnBG(x1,y1,x2,y2,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a filled circle                                             |
//+------------------------------------------------------------------+
bool CAnimations::DrawCircleFillOnBG(const int id,                   // Frame ID
                           const int   x,                            // X coordinate of the circle center
                           const int   y,                            // Y coordinate of the circle center
                           const int   r,                            // Circle radius
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawCircleFillOnBG(x,y,r,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a filled triangle                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawTriangleFillOnBG(const int id,                 // Frame ID
                           const int   x1,                           // X coordinate of the triangle first vertex
                           const int   y1,                           // Y coordinate of the triangle first vertex
                           const int   x2,                           // X coordinate of the triangle second vertex
                           const int   y2,                           // Y coordinate of the triangle second vertex
                           const int   x3,                           // X coordinate of the triangle third vertex
                           const int   y3,                           // Y coordinate of the triangle third vertex
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawTriangleFillOnBG(x1,y1,x2,y2,x3,y3,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a filled polygon                                            |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolygonFillOnBG(const int id,                  // Frame ID
                           int         &array_x[],                   // Array with the X coordinates of polygon points
                           int         &array_y[],                   // Array with the Y coordinates of polygon points
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolygonFillOnBG(array_x,array_y,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a filled ellipse inscribed in a rectangle                   |
//| with the given coordinates                                       |
//+------------------------------------------------------------------+
bool CAnimations::DrawEllipseFillOnBG(const int id,                  // Frame ID
                           const int   x1,                           // X coordinate of the top left corner forming the rectangle
                           const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                           const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                           const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false)                 // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawEllipseFillOnBG(x1,y1,x2,y2,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a point using AntiAliasing algorithm                        |
//+------------------------------------------------------------------+
bool CAnimations::SetPixelAAOnBG(const int id,                       // Frame ID
                           const double x,                           // Point X coordinate
                           const double y,                           // Pixel Y coordinate
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false)                // Chart redraw flag
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.SetPixelAAOnBG(x,y,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a segment of a freehand line using the                      |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawLineAAOnBG(const int id,                       // Frame ID
                           const int   x1,                           // X coordinate of the segment first point
                           const int   y1,                           // Y coordinate of the segment first point
                           const int   x2,                           // X coordinate of the segment second point
                           const int   y2,                           // Y coordinate of the segment second point
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineAAOnBG(x1,y1,x2,y2,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a segment of a freehand line using the                      |
//| Wu algorithm                                                     |
//+------------------------------------------------------------------+
bool CAnimations::DrawLineWuOnBG(const int id,                       // Frame ID
                           const int   x1,                           // X coordinate of the segment first point
                           const int   y1,                           // Y coordinate of the segment first point
                           const int   x2,                           // X coordinate of the segment second point
                           const int   y2,                           // Y coordinate of the segment second point
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineWuOnBG(x1,y1,x2,y2,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a  segment of a freehand line having a specified width      |
//| using a smoothing algorithm                                      |
//| with the preliminary sorting                                     |
//+------------------------------------------------------------------+
bool CAnimations::DrawLineThickOnBG(const int id,                    // Frame ID
                           const int   x1,                           // X coordinate of the segment first point
                           const int   y1,                           // Y coordinate of the segment first point
                           const int   x2,                           // X coordinate of the segment second point
                           const int   y2,                           // Y coordinate of the segment second point
                           const int   size,                         // Line width
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                           ENUM_LINE_END end_style=LINE_END_ROUND)   // Line style is one of the ENUM_LINE_END enumeration values
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineThickOnBG(x1,y1,x2,y2,size,clr,opacity,redraw,style,end_style);
  }
//+------------------------------------------------------------------+
//| Draw a vertical segment of a freehand line having a specified width  |
//| using a smoothing algorithm                                      |
//| with the preliminary sorting                                     |
//+------------------------------------------------------------------+
bool CAnimations::DrawLineThickVerticalOnBG(const int id,            // Frame ID
                           const int   x,                            // Segment X coordinate
                           const int   y1,                           // Y coordinate of the segment first point
                           const int   y2,                           // Y coordinate of the segment second point
                           const int   size,                         // line width
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                           const ENUM_LINE_END end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration values
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineThickVerticalOnBG(x,y1,y2,size,clr,opacity,redraw,style,end_style);
  }
//+-----------------------------------------------------------------------+
//| Draws a horizontal segment of a freehand line having a specified width|
//| using a smoothing algorithm                                           |
//| with the preliminary sorting                                          |
//+-----------------------------------------------------------------------+
bool CAnimations::DrawLineThickHorizontalOnBG(const int id,          // Frame ID
                           const int   x1,                           // X coordinate of the segment first point
                           const int   x2,                           // X coordinate of the segment second point
                           const int   y,                            // Segment Y coordinate
                           const int   size,                         // line width
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                           const ENUM_LINE_END end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration values
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawLineThickHorizontalOnBG(x1,x2,y,size,clr,opacity,redraw,style,end_style);
  }
//+------------------------------------------------------------------+
//| Draw a polyline using                                            |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolylineAAOnBG(const int id,                   // Frame ID
                           int         &array_x[],                   // Array with the X coordinates of polyline points
                           int         &array_y[],                   // Array with the Y coordinates of polyline points
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolylineAAOnBG(array_x,array_y,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draws a polyline using Wu algorithm                              |
//+------------------------------------------------------------------+
//--- 
bool CAnimations::DrawPolylineWuOnBG(const int id,                   // Frame ID
                           int         &array_x[],                   // Array with the X coordinates of polyline points
                           int         &array_y[],                   // Array with the Y coordinates of polyline points
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolylineWuOnBG(array_x,array_y,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a polyline with a specified width using                     |
//| two smoothing algorithms in series.                              |
//| First, individual segments are smoothed                          |
//| based on Bezier curves.                                          |
//| Then, to improve the rendering quality,                          |
//| a raster smoothing algorithm                                     |
//| made of the polyline segments is applied                         |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolylineSmoothOnBG(const int id,               // Frame ID
                           const int    &array_x[],                  // Array with the X coordinates of polyline points
                           const int    &array_y[],                  // Array with the Y coordinates of polyline points
                           const int    size,                        // Line width
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const double tension=0.5,                 // Smoothing parameter value
                           const double step=10,                     // Approximation step
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                           const ENUM_LINE_END   end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration values
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolylineSmoothOnBG(array_x,array_y,size,clr,opacity,tension,step,redraw,style,end_style);
  }
//+------------------------------------------------------------------+
//| Draw a polyline with a specified width using                     |
//| a smoothing algorithm with the preliminary sorting               |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolylineThickOnBG(const int id,                // Frame ID
                           const int      &array_x[],                // Array with the X coordinates of polyline points
                           const int      &array_y[],                // Array with the Y coordinates of polyline points
                           const int      size,                      // Line width
                           const color    clr,                       // Color
                           const uchar    opacity=255,               // Opacity
                           const bool     create_new=true,           // New object creation flag
                           const bool     redraw=false,              // Chart redraw flag
                           const uint     style=STYLE_SOLID,         // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                           ENUM_LINE_END  end_style=LINE_END_ROUND)  // Line style is one of the ENUM_LINE_END enumeration values
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolylineThickOnBG(array_x,array_y,size,clr,opacity,redraw,style,end_style);
  }
//+------------------------------------------------------------------+
//| Draw a polygon using                                             |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolygonAAOnBG(const int id,                    // Frame ID
                           int         &array_x[],                   // Array with the X coordinates of polygon points
                           int         &array_y[],                   // Array with the Y coordinates of polygon points
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolygonAAOnBG(array_x,array_y,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a polygon using Wu algorithm                                |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolygonWuOnBG(const int id,                    // Frame ID
                           int         &array_x[],                   // Array with the X coordinates of polygon points
                           int         &array_y[],                   // Array with the Y coordinates of polygon points
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolygonWuOnBG(array_x,array_y,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a polygon with a specified width using                      |
//| two smoothing algorithms in series.                              |
//| First, individual segments are smoothed based on Bezier curves.  |
//| Then, to improve the rendering quality,                          |
//| a raster smoothing algorithm is applied                          |
//| to the polygon made of these segments.                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawPolygonSmoothOnBG(const int id,                // Frame ID
                           int          &array_x[],                  // Array with the X coordinates of polyline points
                           int          &array_y[],                  // Array with the Y coordinates of polyline points
                           const int    size,                        // Line width
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const double tension=0.5,                 // Smoothing parameter value
                           const double step=10,                     // Approximation step
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                           const ENUM_LINE_END   end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration values
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolygonSmoothOnBG(array_x,array_y,size,clr,opacity,tension,step,redraw,style,end_style);
  }
//+------------------------------------------------------------------+
//| Draw a polygon with a specified width using                      |
//| a smoothing algorithm with the preliminary sorting               |
//+------------------------------------------------------------------+
//--- Draw a polygon having a specified width using smoothing algorithm with the preliminary filtration
bool CAnimations::DrawPolygonThickOnBG(const int id,                 // Frame ID
                           const int   &array_x[],                   // array with the X coordinates of polygon points
                           const int   &array_y[],                   // array with the Y coordinates of polygon points
                           const int   size,                         // line width
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=STYLE_SOLID,            // line style
                           ENUM_LINE_END end_style=LINE_END_ROUND)   // line ends style
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawPolygonThickOnBG(array_x,array_y,size,clr,opacity,redraw,style,end_style);
  }
//+------------------------------------------------------------------+
//| Draw a triangle using                                            |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawTriangleAAOnBG(const int id,                   // Frame ID
                           const int   x1,                           // X coordinate of the triangle first vertex
                           const int   y1,                           // Y coordinate of the triangle first vertex
                           const int   x2,                           // X coordinate of the triangle second vertex
                           const int   y2,                           // Y coordinate of the triangle second vertex
                           const int   x3,                           // X coordinate of the triangle third vertex
                           const int   y3,                           // Y coordinate of the triangle third vertex
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawTriangleAAOnBG(x1,y1,x2,y2,x3,y3,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a triangle using Wu algorithm                               |
//+------------------------------------------------------------------+
bool CAnimations::DrawTriangleWuOnBG(const int id,                   // Frame ID
                           const int   x1,                           // X coordinate of the triangle first vertex
                           const int   y1,                           // Y coordinate of the triangle first vertex
                           const int   x2,                           // X coordinate of the triangle second vertex
                           const int   y2,                           // Y coordinate of the triangle second vertex
                           const int   x3,                           // X coordinate of the triangle third vertex
                           const int   y3,                           // Y coordinate of the triangle third vertex
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawTriangleWuOnBG(x1,y1,x2,y2,x3,y3,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a circle using                                              |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawCircleAAOnBG(const int id,                     // Frame ID
                           const int    x,                           // X coordinate of the circle center
                           const int    y,                           // Y coordinate of the circle center
                           const double r,                           // Circle radius
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawCircleAAOnBG(x,y,r,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a circle using Wu algorithm                                 |
//+------------------------------------------------------------------+
bool CAnimations::DrawCircleWuOnBG(const int id,                     // Frame ID
                           const int    x,                           // X coordinate of the circle center
                           const int    y,                           // Y coordinate of the circle center
                           const double r,                           // Circle radius
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawCircleWuOnBG(x,y,r,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw an ellipse using two points while applying                  |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawEllipseAAOnBG(const int id,                    // Frame ID
                           const double x1,                          // X coordinate of the first point defining the ellipse
                           const double y1,                          // Y coordinate of the first point defining the ellipse
                           const double x2,                          // X coordinate of the second point defining the ellipse
                           const double y2,                          // Y coordinate of the second point defining the ellipse
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawEllipseAAOnBG(x1,y1,x2,y2,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw an ellipse using two points                                 |
//| using Wu algorithm                                               |
//+------------------------------------------------------------------+
bool CAnimations::DrawEllipseWuOnBG(const int id,                    // Frame ID
                           const int   x1,                           // X coordinate of the first point defining the ellipse
                           const int   y1,                           // Y coordinate of the first point defining the ellipse
                           const int   x2,                           // X coordinate of the second point defining the ellipse
                           const int   y2,                           // Y coordinate of the second point defining the ellipse
                           const color clr,                          // Color
                           const uchar opacity=255,                  // Opacity
                           const bool  create_new=true,              // New object creation flag
                           const bool  redraw=false,                 // Chart redraw flag
                           const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameQuad *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_QUAD,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawEllipseWuOnBG(x1,y1,x2,y2,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon without smoothing                         |
//+------------------------------------------------------------------+
bool CAnimations::DrawNgonOnBG(const int id,                         // Frame ID
                           const int    N,                           // Number of polygon vertices
                           const int    coord_x,                     // X coordinate of the upper-left frame angle
                           const int    coord_y,                     // Y coordinate of the upper-left frame angle
                           const int    len,                         // Frame sides length
                           const double angle,                       // Polygon rotation angle
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false)                // Chart redraw flag
  {
   CFrameGeometry *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_GEOMETRY,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawNgonOnBG(N,coord_x,coord_y,len,angle,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a regular filled polygon                                    |
//+------------------------------------------------------------------+
bool CAnimations::DrawNgonFillOnBG(const int id,                     // Frame ID
                           const int    N,                           // Number of polygon vertices
                           const int    coord_x,                     // X coordinate of the upper-left frame angle
                           const int    coord_y,                     // Y coordinate of the upper-left frame angle
                           const int    len,                         // Frame sides length
                           const double angle,                       // Polygon rotation angle
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false)                // Chart redraw flag
  {
   CFrameGeometry *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_GEOMETRY,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawNgonFillOnBG(N,coord_x,coord_y,len,angle,clr,opacity,redraw);
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon using                                     |
//| AntiAliasing algorithm                                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawNgonAAOnBG(const int id,                       // Frame ID
                           const int    N,                           // Number of polygon vertices
                           const int    coord_x,                     // X coordinate of the upper-left frame angle
                           const int    coord_y,                     // Y coordinate of the upper-left frame angle
                           const int    len,                         // Frame sides length
                           const double angle,                       // Polygon rotation angle
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameGeometry *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_GEOMETRY,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawNgonAAOnBG(N,coord_x,coord_y,len,angle,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon using                                     |
//| Wu algorithm                                                     |
//+------------------------------------------------------------------+
bool CAnimations::DrawNgonWuOnBG(const int id,                       // Frame ID
                           const int    N,                           // Number of polygon vertices
                           const int    coord_x,                     // X coordinate of the upper-left frame angle
                           const int    coord_y,                     // Y coordinate of the upper-left frame angle
                           const int    len,                         // Frame sides length
                           const double angle,                       // Polygon rotation angle
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
  {
   CFrameGeometry *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_GEOMETRY,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawNgonWuOnBG(N,coord_x,coord_y,len,angle,clr,opacity,redraw,style);
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon of a specified width                      |
//| using two smoothing algorithms in series.                        |
//| First, individual segments are smoothed based on Bezier curves.  |
//| Then, to improve the rendering quality,                          |
//| a raster smoothing algorithm is applied                          |
//| to the polygon made of these segments.                           |
//+------------------------------------------------------------------+
bool CAnimations::DrawNgonSmoothOnBG(const int id,                   // Frame ID
                           const int    N,                           // Number of polygon vertices
                           const int    coord_x,                     // X coordinate of the upper-left frame angle
                           const int    coord_y,                     // Y coordinate of the upper-left frame angle
                           const int    len,                         // Frame sides length
                           const double angle,                       // Polygon rotation angle
                           const int    size,                        // Line width
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const double tension=0.5,                 // Smoothing parameter value
                           const double step=10,                     // Approximation step
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                           const ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
  {
   CFrameGeometry *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_GEOMETRY,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawNgonSmoothOnBG(N,coord_x,coord_y,len,angle,size,clr,opacity,tension,step,redraw,style,end_style);
  }
//+------------------------------------------------------------------+
//| Draw a regular polygon with a specified width using              |
//| a smoothing algorithm with the preliminary sorting               |
//+------------------------------------------------------------------+
bool CAnimations::DrawNgonThickOnBG(const int id,                    // Frame ID
                           const int    N,                           // Number of polygon vertices
                           const int    coord_x,                     // X coordinate of the upper-left frame angle
                           const int    coord_y,                     // Y coordinate of the upper-left frame angle
                           const int    len,                         // Frame sides length
                           const double angle,                       // Polygon rotation angle
                           const int    size,                        // line width
                           const color  clr,                         // Color
                           const uchar  opacity=255,                 // Opacity
                           const bool   create_new=true,             // New object creation flag
                           const bool   redraw=false,                // Chart redraw flag
                           const uint   style=STYLE_SOLID,           // line style
                           ENUM_LINE_END end_style=LINE_END_ROUND)   // line ends style
  {
   CFrameGeometry *frame=this.GetOrCreateFrame(DFUN,id,ANIMATION_FRAME_TYPE_GEOMETRY,create_new);
   if(frame==NULL)
      return false;
   return frame.DrawNgonThickOnBG(N,coord_x,coord_y,len,angle,size,clr,opacity,redraw,style,end_style);
  }
//+------------------------------------------------------------------+

