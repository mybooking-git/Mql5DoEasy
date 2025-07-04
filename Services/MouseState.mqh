//+------------------------------------------------------------------+
//|                                                   MouseState.mqh |
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
#include "DELib.mqh"
//+------------------------------------------------------------------+
//| Mouse status class                                               |
//+------------------------------------------------------------------+
class CMouseState
  {
private:
   int               m_coord_x;                             // X coordinate
   int               m_coord_y;                             // Y coordinate
   int               m_delta_wheel;                         // Mouse wheel scroll value
   int               m_window_num;                          // Subwindow index
   long              m_chart_id;                            // Chart ID
   ushort            m_state_flags;                         // Status flags
   
//--- Set the status of mouse buttons, as well as of Shift and Ctrl keys
   void              SetButtonKeyState(const int id,const long lparam,const double dparam,const ushort flags);
//--- Set the mouse buttons and keys status flags
   void              SetButtKeyFlags(const short flags);
//--- Data location in the ushort value of the button status
   //---------------------------------------------------------------------------
   //   bit    |    byte   |            state            |    dec    |   hex   |
   //---------------------------------------------------------------------------
   //    0     |     0     | left mouse button           |     1     |    1    |
   //---------------------------------------------------------------------------
   //    1     |     0     | right mouse button          |     2     |    2    |
   //---------------------------------------------------------------------------
   //    2     |     0     | SHIFT key                   |     4     |    4    |
   //---------------------------------------------------------------------------
   //    3     |     0     | CTRL key                    |     8     |    8    |
   //---------------------------------------------------------------------------
   //    4     |     0     | middle mouse button         |    16     |   10    |
   //---------------------------------------------------------------------------
   //    5     |     0     | 1 add. mouse button         |    32     |   20    |
   //---------------------------------------------------------------------------
   //    6     |     0     | 2 add. mouse button         |    64     |   40    |
   //---------------------------------------------------------------------------
   //    7     |     0     | scrolling the wheel         |    128    |   80    |
   //---------------------------------------------------------------------------
   //---------------------------------------------------------------------------
   //    0     |     1     | cursor inside the form      |    256    |   100   |
   //---------------------------------------------------------------------------
   //    1     |     1     | cursor inside active area   |    512    |   200   |
   //---------------------------------------------------------------------------
   //    2     |     1     | cursor in the control area  |   1024    |   400   |
   //---------------------------------------------------------------------------
   //    3     |     1     | cursor in the scrolling area|   2048    |   800   |
   //---------------------------------------------------------------------------
   //    4     |     1     | cursor at the left edge     |   4096    |  1000   |
   //---------------------------------------------------------------------------
   //    5     |     1     | cursor at the bottom edge   |   8192    |  2000   |
   //---------------------------------------------------------------------------
   //    6     |     1     | cursor at the right edge    |   16384   |  4000   |
   //---------------------------------------------------------------------------
   //    7     |     1     | cursor at the top edge      |   32768   |  8000   |
   //---------------------------------------------------------------------------
      
public:
//--- Reset the states of all buttons and keys
   void              ResetAll(void);
//--- Set (1) the subwindow index and (2) the chart ID
   void              SetWindowNum(const int wnd_num)           { this.m_window_num=wnd_num;        }
   void              SetChartID(const long id)                 { this.m_chart_id=id;               }
//--- Return the variable with the mouse status flags
   ushort            GetMouseFlags(void)                       { return this.m_state_flags;        }
//--- Return (1-2) the cursor coordinates, (3) scroll wheel value, (4) status of the mouse buttons and Shift/Ctrl keys
   int               CoordX(void)                        const { return this.m_coord_x;            }
   int               CoordY(void)                        const { return this.m_coord_y;            }
   int               DeltaWheel(void)                    const { return this.m_delta_wheel;        }
   ENUM_MOUSE_BUTT_KEY_STATE ButtonKeyState(const int id,const long lparam,const double dparam,const string flags);
//--- Return the flag of the clicked (1) left, (2) right, (3) middle, (4) first and (5) second additional mouse buttons
   bool              IsPressedButtonLeft(void)           const { return this.m_state_flags==1;     }
   bool              IsPressedButtonRight(void)          const { return this.m_state_flags==2;     }
   bool              IsPressedButtonMiddle(void)         const { return this.m_state_flags==16;    }
   bool              IsPressedButtonX1(void)             const { return this.m_state_flags==32;    }
   bool              IsPressedButtonX2(void)             const { return this.m_state_flags==64;    }
//--- Return the flag of the pressed (1) Shift, (2) Ctrl, (3) Shift+Ctrl key and the flag of scrolling the mouse wheel
   bool              IsPressedKeyShift(void)             const { return this.m_state_flags==4;     }
   bool              IsPressedKeyCtrl(void)              const { return this.m_state_flags==8;     }
   bool              IsPressedKeyCtrlShift(void)         const { return this.m_state_flags==12;    }
   bool              IsWheel(void)                       const { return this.m_state_flags==128;   }

//--- Return the flag indicating the status of the left mouse button and (1) the mouse wheel, (2) Shift, (3) Ctrl, (4) Ctrl+Shift
   bool              IsPressedButtonLeftWheel(void)      const { return this.m_state_flags==129;   }
   bool              IsPressedButtonLeftShift(void)      const { return this.m_state_flags==5;     }
   bool              IsPressedButtonLeftCtrl(void)       const { return this.m_state_flags==9;     }
   bool              IsPressedButtonLeftCtrlShift(void)  const { return this.m_state_flags==13;    }
//--- Return the flag indicating the status of the right mouse button and (1) the mouse wheel, (2) Shift, (3) Ctrl, (4) Ctrl+Shift
   bool              IsPressedButtonRightWheel(void)     const { return this.m_state_flags==130;   }
   bool              IsPressedButtonRightShift(void)     const { return this.m_state_flags==6;     }
   bool              IsPressedButtonRightCtrl(void)      const { return this.m_state_flags==10;    }
   bool              IsPressedButtonRightCtrlShift(void) const { return this.m_state_flags==14;    }
//--- Return the flag indicating the status of the middle mouse button and (1) the mouse wheel, (2) Shift, (3) Ctrl, (4) Ctrl+Shift
   bool              IsPressedButtonMiddleWheel(void)    const { return this.m_state_flags==144;   }
   bool              IsPressedButtonMiddleShift(void)    const { return this.m_state_flags==20;    }
   bool              IsPressedButtonMiddleCtrl(void)     const { return this.m_state_flags==24;    }
   bool              IsPressedButtonMiddleCtrlShift(void)const { return this.m_state_flags==28;    }

//--- Constructor/destructor
                     CMouseState();
                    ~CMouseState();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMouseState::CMouseState() : m_delta_wheel(0),m_coord_x(0),m_coord_y(0),m_window_num(0)
  {
   this.ResetAll();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMouseState::~CMouseState()
  {
  }
//+------------------------------------------------------------------+
//| Reset the states of all buttons and keys                         |
//+------------------------------------------------------------------+
void CMouseState::ResetAll(void)
  {
   this.m_delta_wheel = 0;
   this.m_state_flags = 0;
  }
//+------------------------------------------------------------------+
//| Set the status of mouse buttons, as well as of Shift/Ctrl keys   |
//+------------------------------------------------------------------+
void CMouseState::SetButtonKeyState(const int id,const long lparam,const double dparam,const ushort flags)
  {
   //--- Reset the values of all mouse status bits
   this.ResetAll();
   //--- If a chart or an object is left-clicked
   if(id==CHARTEVENT_CLICK || id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Write the appropriate chart coordinates and set the bit of 0
      this.m_coord_x=(int)lparam;
      this.m_coord_y=(int)dparam;
      this.m_state_flags |=(0x0001);
     }
   //--- otherwise
   else
     {
      //--- in case of a mouse wheel scrolling
      if(id==CHARTEVENT_MOUSE_WHEEL)
        {
         //--- get the cursor coordinates and the total scroll value (the minimum of +120 or -120)
         this.m_coord_x=(int)(short)lparam;
         this.m_coord_y=(int)(short)(lparam>>16);
         this.m_delta_wheel=(int)dparam;
         //--- Call the method of setting flags indicating the states of the mouse buttons and Shift/Ctrl keys
         this.SetButtKeyFlags((short)(lparam>>32));
         //--- and set the bit of 8
         this.m_state_flags &=0xFF7F;
         this.m_state_flags |=(0x0001<<7);
        }
      //--- If this is a cursor movement, write its coordinates and
      //--- call the method of setting flags indicating the states of the mouse buttons and Shift/Ctrl keys
      if(id==CHARTEVENT_MOUSE_MOVE)
        {
         this.m_coord_x=(int)lparam;
         this.m_coord_y=(int)dparam;
         this.SetButtKeyFlags(flags);
        }
     }
  }
//+------------------------------------------------------------------+
//| Set the mouse buttons and keys status flags                      |
//+------------------------------------------------------------------+
void CMouseState::SetButtKeyFlags(const short flags)
  {
//--- Left mouse button status
   if((flags & 0x0001)!=0) this.m_state_flags |=(0x0001<<0);
//--- Right mouse button status
   if((flags & 0x0002)!=0) this.m_state_flags |=(0x0001<<1);
//--- SHIFT status
   if((flags & 0x0004)!=0) this.m_state_flags |=(0x0001<<2);
//--- CTRL status
   if((flags & 0x0008)!=0) this.m_state_flags |=(0x0001<<3);
//--- Middle mouse button status
   if((flags & 0x0010)!=0) this.m_state_flags |=(0x0001<<4);
//--- The first additional mouse button status
   if((flags & 0x0020)!=0) this.m_state_flags |=(0x0001<<5);
//--- The second additional mouse button status
   if((flags & 0x0040)!=0) this.m_state_flags |=(0x0001<<6);
  }
//+------------------------------------------------------------------+
//| Return the mouse buttons and Shift/Ctrl keys states              |
//+------------------------------------------------------------------+
ENUM_MOUSE_BUTT_KEY_STATE CMouseState::ButtonKeyState(const int id,const long lparam,const double dparam,const string flags)
  {
   this.SetButtonKeyState(id,lparam,dparam,(ushort)flags);
   return (ENUM_MOUSE_BUTT_KEY_STATE)this.m_state_flags;
  }
//+------------------------------------------------------------------+
