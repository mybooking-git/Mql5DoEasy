//+------------------------------------------------------------------+
//|                                                 GStdGraphObj.mqh |
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
#include "..\GBaseObj.mqh"
#include "..\..\..\Services\Properties.mqh"
#include "..\..\Graph\Form.mqh"
#include "..\..\Graph\Extend\CGStdGraphObjExtToolkit.mqh"
//+------------------------------------------------------------------+
//| Class of the dependent object pivot point data                   |
//+------------------------------------------------------------------+
class CPivotPointData
  {
private:
   bool              m_axis_x;
   int               m_property[][2];
public:
//--- (1) Set and (2) return the flag indicating that the pivot point belongs to the X coordinate
   void              SetAxisX(const bool axis_x)         { this.m_axis_x=axis_x;             }
   bool              IsAxisX(void)                 const { return this.m_axis_x;             }
   string            AxisDescription(void)         const { return(this.m_axis_x ? "X" : "Y");}
//--- Return the number of base object pivot points for calculating the coordinate of the dependent one
   int               GetBasePivotsNum(void)  const { return ::ArrayRange(this.m_property,0);  }
//--- Add the new pivot point of the base object for calculating the coordinate of a dependent one
   bool              AddNewBasePivotPoint(const string source,const int pivot_prop,const int pivot_num)
                       {
                        //--- Get the array size 
                        int pivot_index=this.GetBasePivotsNum();
                        //--- if failed to increase the array size, inform of that and return 'false'
                        if(::ArrayResize(this.m_property,pivot_index+1)!=pivot_index+1)
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
                           return false;
                          }
                        //--- Return the result of changing the values of a newly added new array dimension
                        return this.ChangeBasePivotPoint(source,pivot_index,pivot_prop,pivot_num);
                       }
//--- Change the specified pivot point of the base object for calculating the coordinate of a dependent one
   bool              ChangeBasePivotPoint(const string source,const int pivot_index,const int pivot_prop,const int pivot_num)
                       {
                        //--- Get the array size. If it is zero, inform of that and return 'false'
                        int n=this.GetBasePivotsNum();
                        if(n==0)
                          {
                           CMessage::ToLog(source,(this.IsAxisX() ? MSG_GRAPH_OBJ_EXT_NOT_ANY_PIVOTS_X : MSG_GRAPH_OBJ_EXT_NOT_ANY_PIVOTS_Y));
                           return false;
                          }
                        //--- If the specified index goes beyond the array range, inform of that and return 'false'
                        if(pivot_index<0 || pivot_index>n-1)
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_REQUEST_OUTSIDE_ARRAY);
                           return false;
                          }
                        //--- Set the values, passed to the method, in the specified array cells by index
                        this.m_property[pivot_index][0]=pivot_prop;
                        this.m_property[pivot_index][1]=pivot_num;
                        return true;
                       }

//--- Return(1) a property and (2) a modifier of the property from the array
   int               GetProperty(const string source,const int index)     const
                       {
                        if(index<0 || index>this.GetBasePivotsNum()-1)
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_REQUEST_OUTSIDE_ARRAY);
                           return WRONG_VALUE;
                          }
                        return this.m_property[index][0];   
                       }
   int               GetPropertyModifier(const string source,const int index)  const
                       {
                        if(index<0 || index>this.GetBasePivotsNum()-1)
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_REQUEST_OUTSIDE_ARRAY);
                           return WRONG_VALUE;
                          }
                        return this.m_property[index][1];   
                       }

//--- Return the description of the number of pivot points for setting the coordinate
   string            GetBasePivotsNumDescription(void) const
                       {
                        return CMessage::Text(IsAxisX() ? MSG_GRAPH_OBJ_EXT_NUM_BASE_PP_TO_SET_X : MSG_GRAPH_OBJ_EXT_NUM_BASE_PP_TO_SET_Y)+
                               (string)this.GetBasePivotsNum();
                       }

//--- Constructor/destructor
                     CPivotPointData(void){;}
                    ~CPivotPointData(void){;}
  };
//+------------------------------------------------------------------+
//| Class of data on X and Y pivot points of a composite object      |
//+------------------------------------------------------------------+
class CPivotPointXY : public CObject
  {
private:
   CPivotPointData   m_pivot_point_x;            // X coordinate pivot point
   CPivotPointData   m_pivot_point_y;            // Y coordinate pivot point
public:
//--- Return the pointer to the (1) X and (2) Y coordinate pivot point data object
   CPivotPointData  *GetPivotPointDataX(void)      { return &this.m_pivot_point_x;                    }
   CPivotPointData  *GetPivotPointDataY(void)      { return &this.m_pivot_point_y;                    }
//--- Return the number of base object pivot points for calculating the (1) X and (2) Y coordinate
   int               GetBasePivotsNumX(void) const { return this.m_pivot_point_x.GetBasePivotsNum();  }
   int               GetBasePivotsNumY(void) const { return this.m_pivot_point_y.GetBasePivotsNum();  }
//--- Add the new pivot point of the base object for calculating the X coordinate of a dependent one
   bool              AddNewBasePivotPointX(const int pivot_prop,const int pivot_num)
                       {
                        return this.m_pivot_point_x.AddNewBasePivotPoint(DFUN,pivot_prop,pivot_num);
                       }
//--- Add the new pivot point of the base object for calculating the Y coordinate of a dependent one
   bool              AddNewBasePivotPointY(const int pivot_prop,const int pivot_num)
                       {
                        return this.m_pivot_point_y.AddNewBasePivotPoint(DFUN,pivot_prop,pivot_num);
                       }
//--- Add new pivot points of the base object for calculating the X and Y coordinates of a dependent one
   bool              AddNewBasePivotPointXY(const int pivot_prop_x,const int pivot_num_x,
                                            const int pivot_prop_y,const int pivot_num_y)
                       {
                        bool res=true;
                        res &=this.m_pivot_point_x.AddNewBasePivotPoint(DFUN,pivot_prop_x,pivot_num_x);
                        res &=this.m_pivot_point_y.AddNewBasePivotPoint(DFUN,pivot_prop_y,pivot_num_y);
                        return res;
                       }
//--- Change the specified pivot point of the base object for calculating the X coordinate of a dependent one
   bool              ChangeBasePivotPointX(const int pivot_index,const int pivot_prop,const int pivot_num)
                       {
                        return this.m_pivot_point_x.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop,pivot_num);
                       }
//--- Change the specified pivot point of the base object for calculating the Y coordinate of a dependent one
   bool              ChangeBasePivotPointY(const int pivot_index,const int pivot_prop,const int pivot_num)
                       {
                        return this.m_pivot_point_y.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop,pivot_num);
                       }
//--- Change specified pivot points of the base object for calculating the X and Y coordinates
   bool              ChangeBasePivotPointXY(const int pivot_index,
                                            const int pivot_prop_x,const int pivot_num_x,
                                            const int pivot_prop_y,const int pivot_num_y)
                       {
                        bool res=true;
                        res &=this.m_pivot_point_x.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop_x,pivot_num_x);
                        res &=this.m_pivot_point_y.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop_y,pivot_num_y);
                        return res;
                       }
//--- Return (1) the property for calculating the X coordinate and (2) the X coordinate property modifier
   int               GetPropertyX(const string source,const int index) const
                       {
                        return this.m_pivot_point_x.GetProperty(source,index);
                       }
   int               GetPropertyModifierX(const string source,const int index) const
                       {
                       return this.m_pivot_point_x.GetPropertyModifier(source,index);
                       }
//--- Return (1) the property for calculating the Y coordinate and (2) the Y coordinate property modifier
   int               GetPropertyY(const string source,const int index) const
                       {
                        return this.m_pivot_point_y.GetProperty(source,index);
                       }
   int               GetPropertyModifierY(const string source,const int index) const
                       {
                       return this.m_pivot_point_y.GetPropertyModifier(source,index);
                       }
//--- Return the description of the number of pivot points for setting the (1) X and (2) Y coordinates
   string            GetBasePivotsNumXDescription(void) const
                       {
                        return this.m_pivot_point_x.GetBasePivotsNumDescription();
                       }
   string            GetBasePivotsNumYDescription(void) const
                       {
                        return this.m_pivot_point_y.GetBasePivotsNumDescription();
                       }
                       
//--- Constructor/destructor
                     CPivotPointXY(void){ this.m_pivot_point_x.SetAxisX(true); this.m_pivot_point_y.SetAxisX(false); }
                    ~CPivotPointXY(void){;}
  };  
//+------------------------------------------------------------------+
//| Class of connected data on composite object pivot points         |
//+------------------------------------------------------------------+
class CLinkedPivotPoint
  {
private:
   CArrayObj         m_list;                       // List of pivot points of the bound object X and Y coordinates
   int               m_base_obj_index;             // Base object index
public:
//--- (1) Set and (2) return the base object index
   void              SetBaseObjIndex(const int index)       { this.m_base_obj_index=index;                  }
   int               GetBaseObjIndex(void)            const { return this.m_base_obj_index;                 }
//--- Create a new object of the class of data on X and Y pivot points of a composite object and add it to the object list
   bool              CreateNewLinkedCoord(const int pivot_prop_x,const int pivot_num_x,const int pivot_prop_y,const int pivot_num_y)
                       {
                        //--- Create an object of data on X and Y pivot points
                        CPivotPointXY *obj=new CPivotPointXY();
                        if(obj==NULL)
                           return false;
                        //--- Add a single dimension with data on pivot points of the base object by X and Y to each object
                        if(!obj.AddNewBasePivotPointXY(pivot_prop_x,pivot_num_x,pivot_prop_y,pivot_num_y))
                           return false;
                        //--- If failed to add the newly created object to the list, inform of that, remove the object and return 'false'
                        if(!this.m_list.Add(obj))
                          {
                           CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                           delete obj;
                           return false;
                          }
                        //--- All is successful - return 'true'
                        return true;
                       }
   
//--- Return the amount of data on pivot points of X and Y coordinates
   int               GetNumLinkedCoords(void)               const {  return this.m_list.Total();                  }
//--- Return the pointer to the (1) first and (2) the last object of data on X and Y pivot points (3) by index
   CPivotPointXY    *GetLinkedCoordFirst(void)              const { return this.m_list.At(0);                     }
   CPivotPointXY    *GetLinkedCoordLast(void)               const { return this.m_list.At(this.m_list.Total()-1); }
   CPivotPointXY    *GetLinkedCoord(const int index)        const { return this.m_list.At(index);                 }
//--- Return the pointer to the X coordinate pivot point data object by index
   CPivotPointData  *GetBasePivotPointDataX(const int index_coord_point) const
                       {
                        CPivotPointXY *obj=this.GetLinkedCoord(index_coord_point);
                        return(obj!=NULL ? obj.GetPivotPointDataX() : NULL);
                       }
//--- Return the pointer to the Y coordinate pivot point data object by index
   CPivotPointData  *GetBasePivotPointDataY(const int index_coord_point) const
                       {
                        CPivotPointXY *obj=this.GetLinkedCoord(index_coord_point);
                        return(obj!=NULL ? obj.GetPivotPointDataY() : NULL);
                       }
//--- Return the number of base object pivot points for calculating the X coordinate by index
   int               GetBasePivotsNumX(const int index_coord_point) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataX(index_coord_point);
                        return(obj!=NULL ? obj.GetBasePivotsNum() : 0);
                       }
//--- Return the number of base object pivot points for calculating the Y coordinate by index
   int               GetBasePivotsNumY(const int index_coord_point) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataY(index_coord_point);
                        return(obj!=NULL ? obj.GetBasePivotsNum() : 0);
                       }
   
//--- Add the new pivot point of the base object for calculating the X coordinate for a specified anchor point of the dependent one
   bool              AddNewBasePivotPointX(const int index_coord_point,const int pivot_prop,const int pivot_num)
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataX(index_coord_point);
                        return(obj!=NULL ? obj.AddNewBasePivotPoint(DFUN,pivot_prop,pivot_num) : false);
                       }
//--- Add the new pivot point of the base object for calculating the Y coordinate for a specified anchor point of the dependent one
   bool              AddNewBasePivotPointY(const int index_coord_point,const int pivot_prop,const int pivot_num)
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataY(index_coord_point);
                        return(obj!=NULL ? obj.AddNewBasePivotPoint(DFUN,pivot_prop,pivot_num) : false);
                       }
//--- Add the new pivot points of the base object for calculating the X and Y coordinates for a specified anchor point of the dependent one
   bool              AddNewBasePivotPointXY(const int index_coord_point,
                                            const int pivot_prop_x,const int pivot_num_x,
                                            const int pivot_prop_y,const int pivot_num_y)
                       {
                        CPivotPointData *objx=this.GetBasePivotPointDataX(index_coord_point);
                        if(objx==NULL)
                           return false;
                        CPivotPointData *objy=this.GetBasePivotPointDataY(index_coord_point);
                        if(objy==NULL)
                           return false;
                        bool res=true;
                        res &=objx.AddNewBasePivotPoint(DFUN,pivot_prop_x,pivot_num_x);
                        res &=objy.AddNewBasePivotPoint(DFUN,pivot_prop_y,pivot_num_y);
                        return res;
                       }

//--- Change the specified pivot point of the base object for calculating the X coordinate for a specified anchor point of the dependent one
   bool              ChangeBasePivotPointX(const int index_coord_point,const int pivot_index,const int pivot_prop,const int pivot_num)
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataX(index_coord_point);
                        return(obj!=NULL ? obj.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop,pivot_num) : false);
                       }
//--- Change the specified pivot point of the base object for calculating the Y coordinate for a specified anchor point of the dependent one
   bool              ChangeBasePivotPointY(const int index_coord_point,const int pivot_index,const int pivot_prop,const int pivot_num)
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataY(index_coord_point);
                        return(obj!=NULL ? obj.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop,pivot_num) : false);
                       }
//--- Change the specified pivot points of the base object for calculating the X and Y coordinates for a specified anchor point
   bool              ChangeBasePivotPointXY(const int index_coord_point,
                                            const int pivot_index,
                                            const int pivot_prop_x,const int pivot_num_x,
                                            const int pivot_prop_y,const int pivot_num_y)
                       {
                        CPivotPointData *objx=this.GetBasePivotPointDataX(index_coord_point);
                        if(objx==NULL)
                           return false;
                        CPivotPointData *objy=this.GetBasePivotPointDataY(index_coord_point);
                        if(objy==NULL)
                           return false;
                        bool res=true;
                        res &=objx.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop_x,pivot_num_x);
                        res &=objy.ChangeBasePivotPoint(DFUN,pivot_index,pivot_prop_y,pivot_num_y);
                        return res;
                       }

//--- Return the property for calculating the X coordinate for a specified anchor point
   int               GetPropertyX(const int index_coord_point,const int index) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataX(index_coord_point);
                        return(obj!=NULL ? obj.GetProperty(DFUN,index) : WRONG_VALUE);
                       }
//--- Return the modifier of the X coordinate property for a specified anchor point
   int               GetPropertyModifierX(const int index_coord_point,const int index) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataX(index_coord_point);
                        return(obj!=NULL ? obj.GetPropertyModifier(DFUN,index) : WRONG_VALUE);
                       }

//--- Return the property for calculating the Y coordinate for a specified anchor point
   int               GetPropertyY(const int index_coord_point,const int index) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataY(index_coord_point);
                        return(obj!=NULL ? obj.GetProperty(DFUN,index) : WRONG_VALUE);
                       }
//--- Return the modifier of the Y coordinate property for a specified anchor point
   int               GetPropertyModifierY(const int index_coord_point,const int index) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataY(index_coord_point);
                       return(obj!=NULL ? obj.GetPropertyModifier(DFUN,index) : WRONG_VALUE);
                       }

//--- Return the description of the number of base object pivot points for calculating the X coordinate by index
   string            GetBasePivotsNumXDescription(const int index_coord_point) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataX(index_coord_point);
                        return(obj!=NULL ? obj.GetBasePivotsNumDescription() : "WRONG_VALUE");
                       }
//--- Return the description of the number of base object pivot points for calculating the Y coordinate by index
   string            GetBasePivotsNumYDescription(const int index_coord_point) const
                       {
                        CPivotPointData *obj=this.GetBasePivotPointDataY(index_coord_point);
                        return(obj!=NULL ? obj.GetBasePivotsNumDescription() : "WRONG_VALUE");
                       }

//--- Constructor/destructor
                     CLinkedPivotPoint(void){;}
                    ~CLinkedPivotPoint(void){;}
  };  
//+------------------------------------------------------------------+
//| The class of the abstract standard graphical object              |
//+------------------------------------------------------------------+
class CGStdGraphObj : public CGBaseObj
  {
private:
   CArrayObj         m_list;                                            // List of dependent graphical objects
   CProperties      *Prop;                                              // Pointer to the properties object
   CLinkedPivotPoint m_linked_pivots;                                   // Connected pivot points
   CGStdGraphObjExtToolkit *ExtToolkit;                                 // Pointer to the extended graphical object toolkit
   int               m_pivots;                                          // Number of object reference points
//--- Read and set (1) the time and (2) the price of the specified object pivot point
   void              SetTimePivot(const int index);
   void              SetPricePivot(const int index);
//--- Read and set (1) color, (2) style, (3) width, (4) value, (5) text of the specified object level
   void              SetLevelColor(const int index);
   void              SetLevelStyle(const int index);
   void              SetLevelWidth(const int index);
   void              SetLevelValue(const int index);
   void              SetLevelText(const int index);
//--- Read and set the BMP file name for the "Bitmap Level" object. Index: 0 - ON, 1 - OFF
   void              SetBMPFile(const int index);

public:
//--- Set object's (1) integer, (2) real and (3) string properties
   void              SetProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property,int index,long value)     { this.Prop.Curr.SetLong(property,index,value);    }
   void              SetProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index,double value)    { this.Prop.Curr.SetDouble(property,index,value);  }
   void              SetProperty(ENUM_GRAPH_OBJ_PROP_STRING property,int index,string value)    { this.Prop.Curr.SetString(property,index,value);  }
//--- Return object’s (1) integer, (2) real and (3) string property from the properties array
   long              GetProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property,int index)          const { return this.Prop.Curr.GetLong(property,index);   }
   double            GetProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index)           const { return this.Prop.Curr.GetDouble(property,index); }
   string            GetProperty(ENUM_GRAPH_OBJ_PROP_STRING property,int index)           const { return this.Prop.Curr.GetString(property,index); }
//--- Set object's previous (1) integer, (2) real and (3) string properties
   void              SetPropertyPrev(ENUM_GRAPH_OBJ_PROP_INTEGER property,int index,long value) { this.Prop.Prev.SetLong(property,index,value);    }
   void              SetPropertyPrev(ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index,double value){ this.Prop.Prev.SetDouble(property,index,value);  }
   void              SetPropertyPrev(ENUM_GRAPH_OBJ_PROP_STRING property,int index,string value){ this.Prop.Prev.SetString(property,index,value);  }
//--- Return object’s (1) integer, (2) real and (3) string property from the previous properties array
   long              GetPropertyPrev(ENUM_GRAPH_OBJ_PROP_INTEGER property,int index)      const { return this.Prop.Prev.GetLong(property,index);   }
   double            GetPropertyPrev(ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index)       const { return this.Prop.Prev.GetDouble(property,index); }
   string            GetPropertyPrev(ENUM_GRAPH_OBJ_PROP_STRING property,int index)       const { return this.Prop.Prev.GetString(property,index); }
   
//--- Return (1) itself, (2) properties and (3) the change history
   CGStdGraphObj    *GetObject(void)                                       { return &this;            }
   CProperties      *Properties(void)                                      { return this.Prop;        }
   CChangeHistory   *History(void)                                         { return this.Prop.History;}
   CGStdGraphObjExtToolkit *GetExtToolkit(void)                            { return this.ExtToolkit;  }
//--- Return the flag of the object supporting this property
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property) { return true;             }
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property)  { return true;             }
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_STRING property)  { return true;             }

//--- Get description of (1) integer, (2) real and (3) string properties
   string            GetPropertyDescription(ENUM_GRAPH_OBJ_PROP_INTEGER property,const int index=0);
   string            GetPropertyDescription(ENUM_GRAPH_OBJ_PROP_DOUBLE property,const int index=0);
   string            GetPropertyDescription(ENUM_GRAPH_OBJ_PROP_STRING property,const int index=0);

//--- Return the description of the graphical object anchor point position
   virtual string    AnchorDescription(void)                const { return (string)this.GetProperty(GRAPH_OBJ_PROP_ANCHOR,0); }

//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//--- Return the object short name
   virtual string    Header(const bool symbol=false);
//--- Display the history of renaming the object to the journal
   void              PrintRenameHistory(void);

//--- Return the description of the (ENUM_OBJECT) graphical object type
   virtual string    TypeDescription(void)                  const { return CMessage::Text(MSG_GRAPH_STD_OBJ_ANY);                                              }
//--- Return the description of the coordinate of the specified graphical object (1) price and (2) time
   virtual string    PriceDescription(const int index)      const { return ::DoubleToString(this.GetProperty(GRAPH_OBJ_PROP_PRICE,index),this.m_digits);       }
   virtual string    TimeDescription(const int index)       const { return ::TimeToString(this.GetProperty(GRAPH_OBJ_PROP_TIME,index),TIME_DATE|TIME_MINUTES); }
//--- Return the description of the specified level (1) color, (2) style, (3) width, (4) value
   virtual string    LevelColorDescription(const int index) const { return ::ColorToString((color)this.GetProperty(GRAPH_OBJ_PROP_LEVELCOLOR,index),true);     }
   virtual string    LevelStyleDescription(const int index) const { return LineStyleDescription((ENUM_LINE_STYLE)this.GetProperty(GRAPH_OBJ_PROP_LEVELSTYLE,index)); }
   virtual string    LevelWidthDescription(const int index) const { return (string)this.GetProperty(GRAPH_OBJ_PROP_LEVELWIDTH,index);                          }
   virtual string    LevelValueDescription(const int index) const { return ::DoubleToString(this.GetProperty(GRAPH_OBJ_PROP_LEVELVALUE,index),5);              }

//--- Return the descriptions of all (1) times, (2) prices, (3) pivot point times and prices,
//--- (4) level values, (6) all properties of all levels, (5) BMP files of the graphical object
   string            TimesDescription(void)        const;
   string            PricesDescription(void)       const;
   string            TimePricesDescription(void)   const;
   string            LevelsColorDescription(void)  const;
   string            LevelsStyleDescription(void)  const;
   string            LevelsWidthDescription(void)  const;
   string            LevelsValueDescription(void)  const;
   string            LevelsTextDescription(void)   const;
   string            LevelsAllDescription(void)    const;
   string            BMPFilesDescription(void)     const;

//--- Compare CGStdGraphObj objects by a specified property (to sort the list by an object property)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CGStdGraphObj objects with each other by all properties (to search for equal objects)
   bool              IsEqual(CGStdGraphObj* compared_req) const;
   
//--- Set the object previous name
   bool              SetNamePrev(const string name)
                       {
                        if(!this.Prop.SetSizeRange(GRAPH_OBJ_PROP_NAME,this.Prop.CurrSize(GRAPH_OBJ_PROP_NAME)+1))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_NAME,this.Prop.CurrSize(GRAPH_OBJ_PROP_NAME)-1,name);
                        return true;
                       }
                       
//--- Return (1) the list of dependent objects, (2) dependent graphical object by index and (3) the number of dependent objects
   CArrayObj        *GetListDependentObj(void)        { return &this.m_list;           }
   CGStdGraphObj    *GetDependentObj(const int index) { return this.m_list.At(index);  }
   int               GetNumDependentObj(void)         { return this.m_list.Total();    }
//--- Return the name of the dependent object by index
   string            NameDependent(const int index);
//--- Add the dependent graphical object to the list
   bool              AddDependentObj(CGStdGraphObj *obj);
//--- Change X and Y coordinates of the current and all dependent objects
   bool              ChangeCoordsExtendedObj(const int x,const int y,const int modifier,bool redraw=false);
//--- Set X and Y coordinates into the appropriate pivot points of a specified subordinate object
   bool              SetCoordsXYtoDependentObj(CGStdGraphObj *dependent_obj);

//--- Return (1) the minimum and (2) maximum XY screen coordinate of the specified pivot point
   bool              GetMinCoordXY(int &x,int &y);
   bool              GetMaxCoordXY(int &x,int &y);
   
//--- Return the pivot point data object
   CLinkedPivotPoint*GetLinkedPivotPoint(void)        { return &this.m_linked_pivots;  }
   
//--- Add a new pivot point for calculating X and Y coordinates to the current object
   bool              AddNewLinkedCoord(const int pivot_prop_x,const int pivot_num_x,const int pivot_prop_y,const int pivot_num_y)
                       {
                        //--- If the current object is not bound to the base one, display the appropriate message and return 'false'
                        if(this.BaseObjectID()==0)
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_NOT_ATACHED_TO_BASE);
                           return false;
                          }
                        //--- Return the result of adding a new connected pivot point from the CLinkedPivotPoint class to the current object
                        return this.m_linked_pivots.CreateNewLinkedCoord(pivot_prop_x,pivot_num_x,pivot_prop_y,pivot_num_y);
                       }
//--- Add a new pivot point for calculating X and Y coordinates to the specified object
   bool              AddNewLinkedCoord(CGStdGraphObj *obj,const int pivot_prop_x,const int pivot_num_x,const int pivot_prop_y,const int pivot_num_y)
                       {
                        //--- If the current object is not an extended one, display the appropriate message and return 'false'
                        if(this.TypeGraphElement()!=GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_NOT_EXT_OBJ);
                           return false;
                          }
                        //--- If a zero pointer to the object is passed, return 'false'
                        if(obj==NULL)
                           return false;
                        //--- Return the result of adding a new connected pivot point from the CLinkedPivotPoint class to the specified object
                        return obj.AddNewLinkedCoord(pivot_prop_x,pivot_num_x,pivot_prop_y,pivot_num_y);
                       }
                       
//--- Add the new base object anchor point for calculating the X coordinate
   bool              AddNewBaseLinkedPivotX(const int index,const int pivot_prop,const int pivot_num)
                       {
                        //--- If the current object is not bound to the base one, display the appropriate message and return 'false'
                        if(this.BaseObjectID()==0)
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_NOT_ATACHED_TO_BASE);
                           return false;
                          }
                        //--- Get the pointer to the necessary pivot point data
                        CPivotPointData *data=m_linked_pivots.GetBasePivotPointDataX(index); 
                        if(data==NULL)
                           return false;
                        //--- Return the result of adding a new anchor point to the current object
                        return data.AddNewBasePivotPoint(DFUN,pivot_prop,pivot_num);
                       }
//--- Add the new base object anchor point for calculating the Y coordinate
   bool              AddNewBaseLinkedPivotY(const int index,const int pivot_prop,const int pivot_num)
                       {
                        //--- If the current object is not bound to the base one, display the appropriate message and return 'false'
                        if(this.BaseObjectID()==0)
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_NOT_ATACHED_TO_BASE);
                           return false;
                          }
                        //--- Get the pointer to the necessary pivot point data
                        CPivotPointData *data=m_linked_pivots.GetBasePivotPointDataY(index); 
                        if(data==NULL)
                           return false;
                        //--- Return the result of adding a new anchor point to the current object
                        return data.AddNewBasePivotPoint(DFUN,pivot_prop,pivot_num);
                       }

//--- Add the new base object anchor point for calculating the X coordinate to the specified subordinate graphical object
   bool              AddNewBaseLinkedPivotX(CGStdGraphObj *obj,const int index,const int pivot_prop,const int pivot_num)
                       {
                        //--- If the current object is not an extended one, display the appropriate message and return 'false'
                        if(this.TypeGraphElement()!=GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_NOT_EXT_OBJ);
                           return false;
                          }
                        //--- If a zero pointer to the object is passed, return 'false'
                        if(obj==NULL)
                           return false;
                        //--- Return the result of adding a new anchor point to the specified object
                        return obj.AddNewBaseLinkedPivotX(index,pivot_prop,pivot_num);
                       }
//--- Add the new base object anchor point for calculating the Y coordinate to the specified subordinate graphical object
   bool              AddNewBaseLinkedPivotY(CGStdGraphObj *obj,const int index,const int pivot_prop,const int pivot_num)
                       {
                        //--- If the current object is not an extended one, display the appropriate message and return 'false'
                        if(this.TypeGraphElement()!=GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_NOT_EXT_OBJ);
                           return false;
                          }
                        //--- If a zero pointer to the object is passed, return 'false'
                        if(obj==NULL)
                           return false;
                        //--- Return the result of adding a new anchor point to the specified object
                        return obj.AddNewBaseLinkedPivotY(index,pivot_prop,pivot_num);
                       }

//--- Return the number of base object pivot points for calculating the (1) X and (2) Y coordinate in the current object
   int               GetBasePivotsNumX(const int index)           { return this.m_linked_pivots.GetBasePivotsNumX(index);  }
   int               GetBasePivotsNumY(const int index)           { return this.m_linked_pivots.GetBasePivotsNumY(index);  }
//--- Return the number of base object pivot points for calculating the (1) X and (2) Y coordinate in the specified object
   int               GetBasePivotsNumX(CGStdGraphObj *obj,const int index) const { return(obj!=NULL ? obj.GetBasePivotsNumX(index): 0); }
   int               GetBasePivotsNumY(CGStdGraphObj *obj,const int index) const { return(obj!=NULL ? obj.GetBasePivotsNumY(index): 0); }
//--- Return the number of base object pivot points for calculating the coordinates in the (1) current and (2) specified object
   int               GetLinkedCoordsNum(void)               const { return this.m_linked_pivots.GetNumLinkedCoords();      }
   int               GetLinkedPivotsNum(CGStdGraphObj *obj) const { return(obj!=NULL ? obj.GetLinkedCoordsNum() : 0);      }
//--- Return the form for managing an object pivot point
   CForm            *GetControlPointForm(const int index);
//--- Return the number of form objects for managing reference points
   int               GetNumControlPointForms(void);
//--- Redraw the form for managing a reference point of an extended standard graphical object
   void              RedrawControlPointForms(const uchar opacity,const color clr);

private:
//--- Set the X coordinate (1) from the specified property of the base object to the specified subordinate object, (2) from the base object
   void              SetCoordXToDependentObj(CGStdGraphObj *obj,const int prop_from,const int modifier_from,const int modifier_to);
   void              SetCoordXFromBaseObj(const int prop_from,const int modifier_from,const int modifier_to);
//--- Set the Y coordinate (1) from the specified property of the base object to the specified subordinate object, (2) from the base object
   void              SetCoordYToDependentObj(CGStdGraphObj *obj,const int prop_from,const int modifier_from,const int modifier_to);
   void              SetCoordYFromBaseObj(const int prop_from,const int modifier_from,const int modifier_to);
//--- Set X and Y coordinates into the appropriate pivot point of a specified subordinate object
   void              SetCoordsXYtoDependentObj(CGStdGraphObj *dependent_obj,CLinkedPivotPoint *pivot_point,const int index);
//--- Set the (1) integer, (2) real and (3) string property to the specified subordinate property
   void              SetDependentINT(CGStdGraphObj *obj,const ENUM_GRAPH_OBJ_PROP_INTEGER prop,const long value,const int modifier);
   void              SetDependentDBL(CGStdGraphObj *obj,const ENUM_GRAPH_OBJ_PROP_DOUBLE prop,const double value,const int modifier);
   void              SetDependentSTR(CGStdGraphObj *obj,const ENUM_GRAPH_OBJ_PROP_STRING prop,const string value,const int modifier);

public:
//--- Event handler
   void              OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam);
//--- Default constructor
                     CGStdGraphObj(){ this.m_type=OBJECT_DE_TYPE_GSTD_OBJ; this.m_species=WRONG_VALUE; this.ExtToolkit=NULL; }
//--- Destructor
                    ~CGStdGraphObj()
                       {
                        if(this.Prop!=NULL)
                           delete this.Prop;
                        if(this.ExtToolkit!=NULL)
                          {
                           this.ExtToolkit.DeleteAllControlPointForm();
                           delete this.ExtToolkit;
                          }
                       }
protected:
//--- Protected parametric constructor
                     CGStdGraphObj(const ENUM_OBJECT_DE_TYPE obj_type,
                                   const ENUM_GRAPH_ELEMENT_TYPE elm_type,
                                   const ENUM_GRAPH_OBJ_BELONG belong,
                                   const ENUM_GRAPH_OBJ_SPECIES species,
                                   const long chart_id, const int pivots,
                                   const string name);
                     
public:
//+--------------------------------------------------------------------+ 
//|Methods of simplified access and setting graphical object properties|
//+--------------------------------------------------------------------+
//--- Number of object reference points
   int               Pivots(void)                  const { return this.m_pivots;                                                          }
//--- Object index in the list
   int               Number(void)                  const { return (int)this.GetProperty(GRAPH_OBJ_PROP_NUM,0);                            }
   void              SetNumber(const int number)         { this.SetProperty(GRAPH_OBJ_PROP_NUM,0,number);                                 }
//--- Flag of storing the change history
   bool              AllowChangeHistory(void)      const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_CHANGE_HISTORY,0);                }
   void              SetAllowChangeMemory(const bool flag){ this.SetProperty(GRAPH_OBJ_PROP_CHANGE_HISTORY,0,flag);                       }
//--- Object ID
   long              ObjectID(void)                const { return this.GetProperty(GRAPH_OBJ_PROP_ID,0);                                  }
   void              SetObjectID(const long obj_id)
                       {
                        CGBaseObj::SetObjectID(obj_id);
                        this.SetProperty(GRAPH_OBJ_PROP_ID,0,obj_id);
                        this.SetPropertyPrev(GRAPH_OBJ_PROP_ID,0,obj_id);
                       }
//--- Base object ID
   long              BaseObjectID(void)            const { return this.GetProperty(GRAPH_OBJ_PROP_BASE_ID,0);                             }
   void              SetBaseObjectID(const long obj_id)
                       {
                        this.SetProperty(GRAPH_OBJ_PROP_BASE_ID,0,obj_id);
                        this.SetPropertyPrev(GRAPH_OBJ_PROP_BASE_ID,0,obj_id);
                       }
//--- Graphical object type
   ENUM_OBJECT       GraphObjectType(void)         const { return (ENUM_OBJECT)this.GetProperty(GRAPH_OBJ_PROP_TYPE,0);                   }
   void              SetGraphObjectType(const ENUM_OBJECT obj_type)
                       {
                        CGBaseObj::SetTypeGraphObject(obj_type);
                        this.SetProperty(GRAPH_OBJ_PROP_TYPE,0,obj_type);
                       }
//--- Graphical element type
   ENUM_GRAPH_ELEMENT_TYPE GraphElementType(void)  const { return (ENUM_GRAPH_ELEMENT_TYPE)this.GetProperty(GRAPH_OBJ_PROP_ELEMENT_TYPE,0);}
   void              SetGraphElementType(const ENUM_GRAPH_ELEMENT_TYPE elm_type)
                       {
                        CGBaseObj::SetTypeElement(elm_type);
                        this.SetProperty(GRAPH_OBJ_PROP_ELEMENT_TYPE,0,elm_type);
                       }
//--- Graphical object affiliation
   ENUM_GRAPH_OBJ_BELONG Belong(void)              const { return (ENUM_GRAPH_OBJ_BELONG)this.GetProperty(GRAPH_OBJ_PROP_BELONG,0);       }
   void              SetBelong(const ENUM_GRAPH_OBJ_BELONG belong)
                       {
                        CGBaseObj::SetBelong(belong);
                        this.SetProperty(GRAPH_OBJ_PROP_BELONG,0,belong);
                       }
//--- Group of graphical objects
   int               Group(void)                   const { return (int)this.GetProperty(GRAPH_OBJ_PROP_GROUP,0);                          }
   void              SetGroup(const int group)
                       {
                        CGBaseObj::SetGroup(group);
                        this.SetProperty(GRAPH_OBJ_PROP_GROUP,0,group);
                       }
//--- Chart ID
   long              ChartID(void)                 const { return this.GetProperty(GRAPH_OBJ_PROP_CHART_ID,0);                            }
   void              SetChartID(const long chart_id)
                       {
                        CGBaseObj::SetChartID(chart_id);
                        this.SetProperty(GRAPH_OBJ_PROP_CHART_ID,0,chart_id);
                       }
//--- Chart subwindow index
   int               SubWindow(void)               const { return (int)this.GetProperty(GRAPH_OBJ_PROP_WND_NUM,0);                        }
   bool              SetSubWindow(void)
                       {
                        if(!CGBaseObj::SetSubwindow(CGBaseObj::ChartID(),CGBaseObj::Name()))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_WND_NUM,0,CGBaseObj::SubWindow());
                        return true;
                       }
//--- Object creation time
   datetime          TimeCteate(void)              const { return (datetime)this.GetProperty(GRAPH_OBJ_PROP_CREATETIME,0);                }
//--- Object visibility on timeframes
   bool              Visible(void)                 const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0);                    }
   bool              SetFlagVisible(const bool flag,const bool only_prop)
                       {
                        if(!CGBaseObj::SetVisible(flag,only_prop))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0,flag);
                        return true;
                       }
//--- Background object
   bool              Back(void)                    const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_BACK,0);                          }
   bool              SetFlagBack(const bool flag,const bool only_prop)
                       {
                        if(!CGBaseObj::SetFlagBack(flag,only_prop))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_BACK,0,flag);
                        return true;
                       }
//--- Priority of a graphical object for receiving the event of clicking on a chart
   virtual long      Zorder(void)                  const { return this.GetProperty(GRAPH_OBJ_PROP_ZORDER,0);                              }
   virtual bool      SetZorder(const long value,const bool only_prop)
                       {
                        if(!CGBaseObj::SetZorder(value,only_prop))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_ZORDER,0,value);
                        return true;
                       }
//--- Disable displaying the name of a graphical object in the terminal object list
   bool              Hidden(void)                  const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_HIDDEN,0);                        }
   bool              SetFlagHidden(const bool flag,const bool only_prop)
                       {
                        if(!CGBaseObj::SetFlagHidden(flag,only_prop))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_HIDDEN,0,flag);
                        return true;
                       }
//--- Object selection
   bool              Selected(void)                const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_SELECTED,0);                      }
   bool              SetFlagSelected(const bool flag,const bool only_prop)
                       {
                        if(!CGBaseObj::SetFlagSelected(flag,only_prop))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_SELECTED,0,flag);
                        return true;
                       }
//--- Object availability
   bool              Selectable(void)              const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_SELECTABLE,0);                    }
   bool              SetFlagSelectable(const bool flag,const bool only_prop)
                       {
                        if(!CGBaseObj::SetFlagSelectable(flag,only_prop))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_SELECTABLE,0,flag);
                        return true;
                       }
//--- Time coordinate
   datetime          Time(const int modifier)      const { return (datetime)this.GetProperty(GRAPH_OBJ_PROP_TIME,modifier);               }
   bool              SetTime(const datetime time,const int modifier)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_TIME,modifier,time))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_TIME,modifier,time);
                        return true;
                       }
//--- Color
   color             Color(void)                   const { return (color)this.GetProperty(GRAPH_OBJ_PROP_COLOR,0);                        }
   bool              SetColor(const color colour)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_COLOR,colour))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_COLOR,0,colour);
                        return true;
                       }
//--- Style
   ENUM_LINE_STYLE   Style(void)                   const { return (ENUM_LINE_STYLE)this.GetProperty(GRAPH_OBJ_PROP_STYLE,0);              }
   bool              SetStyle(const ENUM_LINE_STYLE style)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_STYLE,style))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_STYLE,0,style);
                        return true;
                       }
//--- Line width
   int               Width(void)                   const { return (int)this.GetProperty(GRAPH_OBJ_PROP_WIDTH,0);                          }
   bool              SetWidth(const int width)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_WIDTH,width))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_WIDTH,0,width);
                        return true;
                       }
//--- Object color filling
   bool              Fill(void)                    const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_FILL,0);                          }
   bool              SetFlagFill(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_FILL,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_FILL,0,flag);
                        return true;
                       }
//--- Ability to edit text in the Edit object
   bool              ReadOnly(void)                const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_READONLY,0);                      }
   bool              SetFlagReadOnly(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_READONLY,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_READONLY,0,flag);
                        return true;
                       }
//--- Number of levels
   int               Levels(void)                  const { return (int)this.GetProperty(GRAPH_OBJ_PROP_LEVELS,0);                         }
   bool              SetLevels(const int levels)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_LEVELS,levels))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_LEVELS,0,levels);
                        return true;
                       }
//--- Line level color
   color             LevelColor(const int modifier)   const { return (color)this.GetProperty(GRAPH_OBJ_PROP_LEVELCOLOR,modifier);         }
   bool              SetLevelColor(const color colour,const int modifier)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_LEVELCOLOR,modifier,colour))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_LEVELCOLOR,modifier,colour);
                        return true;
                       }
//--- Level line style
   ENUM_LINE_STYLE   LevelStyle(const int modifier)const { return (ENUM_LINE_STYLE)this.GetProperty(GRAPH_OBJ_PROP_LEVELSTYLE,modifier);  }
   bool              SetLevelStyle(const ENUM_LINE_STYLE style,const int modifier)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_LEVELSTYLE,modifier,style))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_LEVELSTYLE,modifier,style);
                        return true;
                       }
///--- Level line width
   int               LevelWidth(const int modifier)const { return (int)this.GetProperty(GRAPH_OBJ_PROP_LEVELWIDTH,modifier);              }
   bool              SetLevelWidth(const int width,const int modifier)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_LEVELWIDTH,modifier,width))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_LEVELWIDTH,modifier,width);
                        return true;
                       }
//--- Horizontal text alignment in the Edit object (OBJ_EDIT)
   ENUM_ALIGN_MODE   Align(void)                   const { return (ENUM_ALIGN_MODE)this.GetProperty(GRAPH_OBJ_PROP_ALIGN,0);              }
   bool              SetAlign(const ENUM_ALIGN_MODE align)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_ALIGN,align))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_ALIGN,0,align);
                        return true;
                       }
//--- Font size
   int               FontSize(void)                const { return (int)this.GetProperty(GRAPH_OBJ_PROP_FONTSIZE,0);                       }
   bool              SetFontSize(const int size)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_FONTSIZE,size))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_FONTSIZE,0,size);
                        return true;
                       }
//--- Ray goes to the left
   bool              RayLeft(void)                 const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_RAY_LEFT,0);                      }
   bool              SetFlagRayLeft(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_RAY_LEFT,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_RAY_LEFT,0,flag);
                        return true;
                       }
//--- Ray goes to the right
   bool              RayRight(void)                const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_RAY_RIGHT,0);                     }
   bool              SetFlagRayRight(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_RAY_RIGHT,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_RAY_RIGHT,0,flag);
                        return true;
                       }
//--- Vertical line goes through all windows of a chart
   bool              Ray(void)                     const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_RAY,0);                           }
   bool              SetFlagRay(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_RAY,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_RAY,0,flag);
                        return true;
                       }
//--- Display the full ellipse of the Fibonacci Arc object
   bool              Ellipse(void)                 const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_ELLIPSE,0);                       }
   bool              SetFlagEllipse(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_ELLIPSE,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_ELLIPSE,0,flag);
                        return true;
                       }
//--- Arrow code for the "Arrow" object
   uchar             ArrowCode(void)               const { return (uchar)this.GetProperty(GRAPH_OBJ_PROP_ARROWCODE,0);                    }
   bool              SetArrowCode(const uchar code)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_ARROWCODE,code))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_ARROWCODE,0,code);
                        return true;
                       }
//--- Position of the graphical object anchor point
   int               Anchor(void)                  const { return (int)this.GetProperty(GRAPH_OBJ_PROP_ANCHOR,0);                         }
   bool              SetAnchor(const int anchor)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_ANCHOR,anchor))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_ANCHOR,0,anchor);
                        return true;
                       }
//--- Distance from the base corner along the X axis in pixels
   int               XDistance(void)               const { return (int)this.GetProperty(GRAPH_OBJ_PROP_XDISTANCE,0);                      }
   bool              SetXDistance(const int distance)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_XDISTANCE,distance))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_XDISTANCE,0,distance);
                        return true;
                       }
//--- Distance from the base corner along the Y axis in pixels
   int               YDistance(void)               const { return (int)this.GetProperty(GRAPH_OBJ_PROP_YDISTANCE,0);                      }
   bool              SetYDistance(const int distance)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_YDISTANCE,distance))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_YDISTANCE,0,distance);
                        return true;
                       }
//--- Gann object trend
   ENUM_GANN_DIRECTION Direction(void)             const { return (ENUM_GANN_DIRECTION)this.GetProperty(GRAPH_OBJ_PROP_DIRECTION,0);      }
   bool              SetDirection(const ENUM_GANN_DIRECTION direction)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_DIRECTION,direction))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_DIRECTION,0,direction);
                        return true;
                       }
//--- Elliott wave marking level
   ENUM_ELLIOT_WAVE_DEGREE Degree(void)            const { return (ENUM_ELLIOT_WAVE_DEGREE)this.GetProperty(GRAPH_OBJ_PROP_DEGREE,0);     }
   bool              SetDegree(const ENUM_ELLIOT_WAVE_DEGREE degree)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_DEGREE,degree))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_DEGREE,0,degree);
                        return true;
                       }
//--- Display lines for Elliott wave marking
   bool              DrawLines(void)               const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_DRAWLINES,0);                     }
   bool              SetFlagDrawLines(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_DRAWLINES,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_DRAWLINES,0,flag);
                        return true;
                       }
//--- Button state (pressed/released)
   bool              State(void)                   const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_STATE,0);                         }
   bool              SetFlagState(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_STATE,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_STATE,0,flag);
                        return true;
                       }
//--- Chart object ID (OBJ_CHART)
   long              ChartObjChartID(void)         const { return this.GetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID,0);                  }
   bool              SetChartObjChartID(const long chart_id)
                       {
                        this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID,0,chart_id);
                        return true;
                       }
//--- Chart object period
   ENUM_TIMEFRAMES   ChartObjPeriod(void)          const { return (ENUM_TIMEFRAMES)this.GetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PERIOD,0);   }
   bool              SetChartObjPeriod(const ENUM_TIMEFRAMES timeframe)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_PERIOD,timeframe))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PERIOD,0,timeframe);
                        return true;
                       }
//--- Time scale display flag for the Chart object
   bool              ChartObjDateScale(void)       const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE,0);          }
   bool              SetFlagChartObjDateScale(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_DATE_SCALE,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE,0,flag);
                        return true;
                       }
//--- Price scale display flag for the Chart object
   bool              ChartObjPriceScale(void)      const { return (bool)this.GetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE,0);         }
   bool              SetFlagChartObjPriceScale(const bool flag)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_PRICE_SCALE,flag))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE,0,flag);
                        return true;
                       }
//--- Chart object scale
   int               ChartObjChartScale(void)      const { return (int)this.GetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE,0);          }
   bool              SetChartObjChartScale(const int scale)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_CHART_SCALE,scale))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE,0,scale);
                        return true;
                       }
//--- Object width along the X axis in pixels
   int               XSize(void)                   const { return (int)this.GetProperty(GRAPH_OBJ_PROP_XSIZE,0);                          }
   bool              SetXSize(const int size)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_XSIZE,size))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_XSIZE,0,size);
                        return true;
                       }
//--- Object height along the Y axis in pixels
   int               YSize(void)                   const { return (int)this.GetProperty(GRAPH_OBJ_PROP_YSIZE,0);                          }
   bool              SetYSize(const int size)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_YSIZE,size))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_YSIZE,0,size);
                        return true;
                       }
//--- X coordinate of the upper-left corner of the visibility area
   int               XOffset(void)                 const { return (int)this.GetProperty(GRAPH_OBJ_PROP_XOFFSET,0);                        }
   bool              SetXOffset(const int offset)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_XOFFSET,offset))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_XOFFSET,0,offset);
                        return true;
                       }
//--- Y coordinate of the upper-left corner of the visibility area
   int               YOffset(void)                 const { return (int)this.GetProperty(GRAPH_OBJ_PROP_YOFFSET,0);                        }
   bool              SetYOffset(const int offset)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_YOFFSET,offset))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_YOFFSET,0,offset);
                        return true;
                       }
//--- Background color for OBJ_EDIT, OBJ_BUTTON, OBJ_RECTANGLE_LABEL
   color             BGColor(void)                 const { return (color)this.GetProperty(GRAPH_OBJ_PROP_BGCOLOR,0);                      }
   bool              SetBGColor(const color colour)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_BGCOLOR,colour))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_BGCOLOR,0,colour);
                        return true;
                       }
//--- Chart corner for attaching a graphical object
   ENUM_BASE_CORNER  Corner(void)                  const { return (ENUM_BASE_CORNER)this.GetProperty(GRAPH_OBJ_PROP_CORNER,0);            }
   bool              SetCorner(const ENUM_BASE_CORNER corner)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_CORNER,corner))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_CORNER,0,corner);
                        return true;
                       }
//--- Border type for the Rectangle label object
   ENUM_BORDER_TYPE  BorderType(void)              const { return (ENUM_BORDER_TYPE)this.GetProperty(GRAPH_OBJ_PROP_BORDER_TYPE,0);       }
   bool              SetBorderType(const ENUM_BORDER_TYPE type)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_BORDER_TYPE,type))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_BORDER_TYPE,0,type);
                        return true;
                       }
//--- Border color for OBJ_EDIT and OBJ_BUTTON
   color             BorderColor(void)             const { return (color)this.GetProperty(GRAPH_OBJ_PROP_BORDER_COLOR,0);                 }
   bool              SetBorderColor(const color colour)
                       {
                        if(!::ObjectSetInteger(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_BORDER_COLOR,colour))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_BORDER_COLOR,0,colour);
                        return true;
                       }

//--- Price coordinate
   double            Price(const int modifier)     const { return this.GetProperty(GRAPH_OBJ_PROP_PRICE,modifier);                        }
   bool              SetPrice(const double price,const int modifier)
                       {
                        if(!::ObjectSetDouble(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_PRICE,modifier,price))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_PRICE,modifier,price);
                        return true;
                       }
//--- Level value
   double            LevelValue(const int modifier)const { return this.GetProperty(GRAPH_OBJ_PROP_LEVELVALUE,modifier);                   }
   bool              SetLevelValue(const double value,const int modifier)
                       {
                        if(!::ObjectSetDouble(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_LEVELVALUE,modifier,value))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_LEVELVALUE,modifier,value);
                        return true;
                       }
//--- Scale
   double            Scale(void)                   const { return this.GetProperty(GRAPH_OBJ_PROP_SCALE,0);                               }
   bool              SetScale(const double scale)
                       {
                        if(!::ObjectSetDouble(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_SCALE,scale))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_SCALE,0,scale);
                        return true;
                       }
//--- Angle
   double            Angle(void)                   const { return this.GetProperty(GRAPH_OBJ_PROP_ANGLE,0);                               }
   bool              SetAngle(const double angle)
                       {
                        if(!::ObjectSetDouble(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_ANGLE,angle))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_ANGLE,0,angle);
                        return true;
                       }
//--- Deviation of the standard deviation channel
   double            Deviation(void)               const { return this.GetProperty(GRAPH_OBJ_PROP_DEVIATION,0);                           }
   bool              SetDeviation(const double deviation)
                       {
                        if(!::ObjectSetDouble(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_DEVIATION,deviation))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_DEVIATION,0,deviation);
                        return true;
                       }

//--- Object name
   string            Name(void)                    const { return this.GetProperty(GRAPH_OBJ_PROP_NAME,0);                                }
   bool              SetName(const string name)
                       {
                        if(CGBaseObj::Name()==name)
                           return true;
                        if(CGBaseObj::Name()=="")
                          {
                           CGBaseObj::SetName(name);
                           this.SetProperty(GRAPH_OBJ_PROP_NAME,0,name);
                           return true;
                          }
                        else
                          {
                           if(!::ObjectSetString(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_NAME,name))
                              return false;
                           CGBaseObj::SetName(name);
                           this.SetProperty(GRAPH_OBJ_PROP_NAME,0,name);
                           return true;
                          }
                       }
//--- Base object name
   string            BaseName(void)                const { return this.GetProperty(GRAPH_OBJ_PROP_BASE_NAME,0);                           }
   bool              SetBaseName(const string name)
                       {
                        this.SetProperty(GRAPH_OBJ_PROP_BASE_NAME,0,name);
                        return true;
                       }
//--- Object description (text contained in the object)
   string            Text(void)                    const { return this.GetProperty(GRAPH_OBJ_PROP_TEXT,0);                                }
   bool              SetText(const string text)
                       {
                        if(!::ObjectSetString(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_TEXT,text))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_TEXT,0,text);
                        return true;
                       }
//--- Tooltip text
   string            Tooltip(void)                 const { return this.GetProperty(GRAPH_OBJ_PROP_TOOLTIP,0);                             }
   bool              SetTooltip(const string tooltip)
                       {
                        if(!::ObjectSetString(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_TOOLTIP,tooltip))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_TOOLTIP,0,tooltip);
                        return true;
                       }
//--- Level description
   string            LevelText(const int modifier) const { return this.GetProperty(GRAPH_OBJ_PROP_LEVELTEXT,modifier);                    }
   bool              SetLevelText(const string text,const int modifier)
                       {
                        if(!::ObjectSetString(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_LEVELTEXT,modifier,text))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_LEVELTEXT,modifier,text);
                        return true;
                       }
//--- Font
   string            Font(void)                    const { return this.GetProperty(GRAPH_OBJ_PROP_FONT,0);                                }
   bool              SetFont(const string font)
                       {
                        if(!::ObjectSetString(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_FONT,font))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_FONT,0,font);
                        return true;
                       }
//--- BMP file name for the "Bitmap Level" object
   string            BMPFile(const int modifier)   const { return this.GetProperty(GRAPH_OBJ_PROP_BMPFILE,modifier);                      }
   bool              SetBMPFile(const string bmp_file,const int modifier)
                       {
                        if(!::ObjectSetString(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_BMPFILE,bmp_file))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_BMPFILE,modifier,bmp_file);
                        return true;
                       }
//--- Symbol for the Chart object 
   string            ChartObjSymbol(void)          const { return this.GetProperty(GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL,0);                    }
   bool              SetChartObjSymbol(const string symbol)
                       {
                        if(!::ObjectSetString(CGBaseObj::ChartID(),CGBaseObj::Name(),OBJPROP_SYMBOL,symbol))
                           return false;
                        this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL,0,symbol);
                        return true;
                       }
//--- Set the time and price by screen coordinates
   bool              SetTimePrice(const int x,const int y,const int modifier)
                       {
                        bool res=true;
                        ENUM_OBJECT type=this.GraphObjectType();
                        if(type==OBJ_LABEL || type==OBJ_BUTTON || type==OBJ_BITMAP_LABEL || type==OBJ_EDIT || type==OBJ_RECTANGLE_LABEL)
                          {
                           res &=this.SetXDistance(x);
                           res &=this.SetYDistance(y);
                          }
                        else
                          {
                           int subwnd=0;
                           datetime time=0;
                           double price=0;
                           if(::ChartXYToTimePrice(this.ChartID(),x,y,subwnd,time,price))
                             {
                              res &=this.SetTime(time,modifier);
                              res &=this.SetPrice(price,modifier);
                             }
                          }
                        return res;
                       }
  
//--- Return the flags indicating object visibility on timeframes
   bool              IsVisibleOnTimeframeM1(void)  const { return IsVisibleOnTimeframe(PERIOD_M1, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM2(void)  const { return IsVisibleOnTimeframe(PERIOD_M2, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM3(void)  const { return IsVisibleOnTimeframe(PERIOD_M3, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM4(void)  const { return IsVisibleOnTimeframe(PERIOD_M4, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM5(void)  const { return IsVisibleOnTimeframe(PERIOD_M5, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM6(void)  const { return IsVisibleOnTimeframe(PERIOD_M6, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM10(void) const { return IsVisibleOnTimeframe(PERIOD_M10,(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM12(void) const { return IsVisibleOnTimeframe(PERIOD_M12,(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM15(void) const { return IsVisibleOnTimeframe(PERIOD_M15,(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM20(void) const { return IsVisibleOnTimeframe(PERIOD_M20,(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeM30(void) const { return IsVisibleOnTimeframe(PERIOD_M30,(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeH1(void)  const { return IsVisibleOnTimeframe(PERIOD_H1, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeH2(void)  const { return IsVisibleOnTimeframe(PERIOD_H2, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeH3(void)  const { return IsVisibleOnTimeframe(PERIOD_H3, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeH4(void)  const { return IsVisibleOnTimeframe(PERIOD_H4, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeH6(void)  const { return IsVisibleOnTimeframe(PERIOD_H6, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeH8(void)  const { return IsVisibleOnTimeframe(PERIOD_H8, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeH12(void) const { return IsVisibleOnTimeframe(PERIOD_H12,(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeD1(void)  const { return IsVisibleOnTimeframe(PERIOD_D1, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeW1(void)  const { return IsVisibleOnTimeframe(PERIOD_W1, (int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }
   bool              IsVisibleOnTimeframeMN1(void) const { return IsVisibleOnTimeframe(PERIOD_MN1,(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0)); }

//--- Return the description of the (1) object visibility on timeframes and (2) the index in the composite graphical object list
   string            VisibleOnTimeframeDescription(void);
   string            NumberDescription(void);

//--- Re-write all graphical object properties
   void              PropertiesRefresh(void);
//--- Check object property changes
   void              PropertiesCheckChanged(void);
//--- Copy the current data to the previous one
   void              PropertiesCopyToPrevData(void);
//--- Return (1) the number of property changes in history specified (2) by the property index, (3) the last and (4) the first changed object
   int               HistoryChangesTotal(void)                          { return this.History().TotalChanges();                                          }
   CChangedProps    *GetHistoryChangedProps(const string source,const int index) { return this.History().GetChangedPropsObj(source,index);               }
   CChangedProps    *GetHistoryChangedPropsLast(const string source)    { return this.History().GetChangedPropsObj(source,this.HistoryChangesTotal()-1); }
   CChangedProps    *GetHistoryChangedPropsFirst(const string source)   { return this.History().GetChangedPropsObj(source,0);                            }
//--- Using the specified index in the list of change history objects, return
//--- the specified value of (1) integer, (2) real and (3) string property
   long              HistoryChangedObjGetLong(const int time_index,const ENUM_GRAPH_OBJ_PROP_INTEGER prop,const int prop_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        return(obj!=NULL ? obj.GetLong(prop,prop_index) : 0);
                       }
   double            HistoryChangedObjGetDouble(const int time_index,const ENUM_GRAPH_OBJ_PROP_DOUBLE prop,const int prop_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        return(obj!=NULL ? obj.GetDouble(prop,prop_index) : 0);
                       }
   string            HistoryChangedObjGetString(const int time_index,const ENUM_GRAPH_OBJ_PROP_STRING prop,const int prop_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        return(obj!=NULL ? obj.GetString(prop,prop_index) : "ERROR");
                       }
//--- Return (1) a symbol, (2) symbol's Digits and (3) the time of changing the change history object
   string            HistoryChangedObjSymbol(const int time_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        return(obj!=NULL ? obj.Symbol() : "ERROR");
                       }
   int               HistoryChangedObjDigits(const int time_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        return(obj!=NULL ? obj.Digits() : 0);
                       }
   long              HistoryChangedObjTimeChanged(const int time_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        return(obj!=NULL ? obj.TimeChanged() : 0);
                       }
   string            HistoryChangedObjTimeChangedToString(const int time_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        return(obj!=NULL ? obj.TimeChangedToString() : "ERROR");
                       }
//--- Set object parameters from the specified history snapshot
   bool              SetPropertiesFromHistory(const int time_index)
                       {
                        CChangedProps *obj=this.GetHistoryChangedProps(DFUN,time_index);
                        if(obj==NULL)
                           return false;
                        int begin=0, end=GRAPH_OBJ_PROP_INTEGER_TOTAL;
                        for(int i=begin; i<end; i++)
                          {
                           ENUM_GRAPH_OBJ_PROP_INTEGER prop=(ENUM_GRAPH_OBJ_PROP_INTEGER)i;
                           for(int j=0;j<this.Prop.CurrSize(prop);j++)
                              if(this.GetProperty(prop,j)!=obj.GetLong(prop,j))
                                 this.SetHistoryINT(prop,obj.GetLong(prop,j),j);
                          }
                        begin=end; end+=GRAPH_OBJ_PROP_DOUBLE_TOTAL;
                        for(int i=begin; i<end; i++)
                          {
                           ENUM_GRAPH_OBJ_PROP_DOUBLE prop=(ENUM_GRAPH_OBJ_PROP_DOUBLE)i;
                           for(int j=0;j<this.Prop.CurrSize(prop);j++)
                             {
                              if(this.GetProperty(prop,j)!=obj.GetDouble(prop,j))
                                 this.SetHistoryDBL(prop,obj.GetDouble(prop,j),j);
                             }
                          }
                        begin=end; end+=GRAPH_OBJ_PROP_STRING_TOTAL;
                        for(int i=begin; i<end; i++)
                          {
                           ENUM_GRAPH_OBJ_PROP_STRING prop=(ENUM_GRAPH_OBJ_PROP_STRING)i;
                           for(int j=0;j<this.Prop.CurrSize(prop);j++)
                              if(this.GetProperty(prop,j)!=obj.GetString(prop,j))
                                 this.SetHistorySTR(prop,obj.GetString(prop,j),j);
                          }
                        return true;
                       }
   
private:
//--- Get and save (1) integer, (2) real and (3) string properties
   void              GetAndSaveINT(void);
   void              GetAndSaveDBL(void);
   void              GetAndSaveSTR(void);
   
//--- Create a new object of the graphical object change history
   bool              CreateNewChangeHistoryObj(const bool first)
                       {
                        bool res=true;
                        if(first)
                           res &=this.History().CreateNewElement(this.Prop.Prev,this.GetMarketWatchTime());
                        res &=this.History().CreateNewElement(this.Prop.Curr,this.GetMarketWatchTime());
                        if(!res)
                           CMessage::ToLog(DFUN,MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_SNAPSHOT);
                        return res;
                       }
//--- Set (1) integer, (2) real and (3) string property values from the change history
   void              SetHistoryINT(const ENUM_GRAPH_OBJ_PROP_INTEGER prop,const long value,const int modifier);
   void              SetHistoryDBL(const ENUM_GRAPH_OBJ_PROP_DOUBLE prop,const double value,const int modifier);
   void              SetHistorySTR(const ENUM_GRAPH_OBJ_PROP_STRING prop,const string value,const int modifier);
//--- Return the time of the last symbol tick
   long              GetSymbolTime(const string symbol)
                       {
                        MqlTick tick;
                        return(::SymbolInfoTick(symbol,tick) ? tick.time_msc : 0);
                       }
//--- Return the time of the last Market Watch tick
   long              GetMarketWatchTime(void)
                       {
                        long res=0;
                        for(int i=::SymbolsTotal(true)-1;i>WRONG_VALUE;i--)
                          {
                           const long time=this.GetSymbolTime(::SymbolName(i,true));
                           if(time>res)
                              res=time;
                          }
                        return res;
                       }   
  };
//+------------------------------------------------------------------+
//| Protected parametric constructor                                 |
//+------------------------------------------------------------------+
CGStdGraphObj::CGStdGraphObj(const ENUM_OBJECT_DE_TYPE obj_type,
                             const ENUM_GRAPH_ELEMENT_TYPE elm_type,
                             const ENUM_GRAPH_OBJ_BELONG belong,
                             const ENUM_GRAPH_OBJ_SPECIES species,
                             const long chart_id,const int pivots,
                             const string name)
  {
//--- Create the property object with the default values
   this.Prop=new CProperties(GRAPH_OBJ_PROP_INTEGER_TOTAL,GRAPH_OBJ_PROP_DOUBLE_TOTAL,GRAPH_OBJ_PROP_STRING_TOTAL);
   this.ExtToolkit=(elm_type==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? new CGStdGraphObjExtToolkit() : NULL);
//--- Set the number of pivot points and object levels
   this.m_pivots=pivots;
   int levels=(int)::ObjectGetInteger(chart_id,name,OBJPROP_LEVELS);

//--- Set the property array dimensionalities according to the number of pivot points and levels
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_TIME,this.m_pivots);
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_PRICE,this.m_pivots);
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELCOLOR,levels);
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELSTYLE,levels);
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELWIDTH,levels);
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELVALUE,levels);
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELTEXT,levels);
   this.Prop.SetSizeRange(GRAPH_OBJ_PROP_BMPFILE,2);
   
//--- Set the object (1) type, type of graphical (2) object, (3) element, (4) subwindow affiliation and (5) index, as well as (6) chart symbol Digits
   this.m_type=obj_type;
   this.SetName(name);
   CGBaseObj::SetChartID(chart_id);
   CGBaseObj::SetTypeGraphObject(CGBaseObj::GraphObjectType(obj_type));
   CGBaseObj::SetTypeElement(elm_type);
   CGBaseObj::SetBelong(belong);
   CGBaseObj::SetSpecies(species);
   CGBaseObj::SetSubwindow(chart_id,name);
   CGBaseObj::SetDigits((int)::SymbolInfoInteger(::ChartSymbol(chart_id),SYMBOL_DIGITS));
   
//--- Save the integer properties inherent in all graphical objects but not present in the current one
   this.SetProperty(GRAPH_OBJ_PROP_CHART_ID,0,CGBaseObj::ChartID());                // Chart ID
   this.SetProperty(GRAPH_OBJ_PROP_WND_NUM,0,CGBaseObj::SubWindow());               // Chart subwindow index
   this.SetProperty(GRAPH_OBJ_PROP_TYPE,0,CGBaseObj::TypeGraphObject());            // Graphical object type (ENUM_OBJECT)
   this.SetProperty(GRAPH_OBJ_PROP_ELEMENT_TYPE,0,CGBaseObj::TypeGraphElement());   // Graphical element type (ENUM_GRAPH_ELEMENT_TYPE)
   this.SetProperty(GRAPH_OBJ_PROP_BELONG,0,CGBaseObj::Belong());                   // Graphical object affiliation
   this.SetProperty(GRAPH_OBJ_PROP_SPECIES,0,CGBaseObj::Species());                 // Graphical object species
   this.SetProperty(GRAPH_OBJ_PROP_GROUP,0,0);                                      // Graphical object group
   this.SetProperty(GRAPH_OBJ_PROP_ID,0,0);                                         // Object ID
   this.SetProperty(GRAPH_OBJ_PROP_BASE_ID,0,0);                                    // Base object ID
   this.SetProperty(GRAPH_OBJ_PROP_NUM,0,0);                                        // Object index in the list
   this.SetProperty(GRAPH_OBJ_PROP_CHANGE_HISTORY,0,false);                         // Flag of storing the change history
   this.SetProperty(GRAPH_OBJ_PROP_BASE_NAME,0,this.Name());                        // Base object name
   
//--- Save the properties inherent in all graphical objects and present in a graphical object
   this.PropertiesRefresh();
   
//--- Save basic properties in the parent object
   this.m_create_time=(datetime)this.GetProperty(GRAPH_OBJ_PROP_CREATETIME,0);
   this.m_back=(bool)this.GetProperty(GRAPH_OBJ_PROP_BACK,0);
   this.m_selected=(bool)(GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : this.GetProperty(GRAPH_OBJ_PROP_SELECTED,0));
   this.m_selectable=(bool)(GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : this.GetProperty(GRAPH_OBJ_PROP_SELECTABLE,0));
   this.m_hidden=(bool)this.GetProperty(GRAPH_OBJ_PROP_HIDDEN,0);

//--- Initialize the extended graphical object toolkit
   if(this.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
     {
      datetime times[];
      double prices[];
      if(::ArrayResize(times,this.Pivots())!=this.Pivots())
         CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_FAILED_ARR_RESIZE_TIME_DATA);
      if(::ArrayResize(prices,this.Pivots())!=this.Pivots())
         CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_FAILED_ARR_RESIZE_PRICE_DATA);
      for(int i=0;i<this.Pivots();i++)
        {
         times[i]=this.Time(i);
         prices[i]=this.Price(i);
        }
      this.ExtToolkit.SetBaseObj(this.TypeGraphObject(),this.Name(),this.ChartID(),this.SubWindow(),this.Pivots(),CTRL_FORM_SIZE,this.XDistance(),this.YDistance(),times,prices);
      this.ExtToolkit.CreateAllControlPointForm();
      this.SetFlagSelected(false,false);
      this.SetFlagSelectable(false,false);
     }

//--- Save the current properties to the previous ones
   this.PropertiesCopyToPrevData();
  }
//+-----------------------------------------------------------------------+
//|Compare CGStdGraphObj objects with each other by the specified property|
//+-----------------------------------------------------------------------+
int CGStdGraphObj::Compare(const CObject *node,const int mode=0) const
  {
   const CGStdGraphObj *obj_compared=node;
//--- compare integer properties of two objects
   if(mode<GRAPH_OBJ_PROP_INTEGER_TOTAL)
     {
      long value_compared=obj_compared.GetProperty((ENUM_GRAPH_OBJ_PROP_INTEGER)mode,0);
      long value_current=this.GetProperty((ENUM_GRAPH_OBJ_PROP_INTEGER)mode,0);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two objects
   else if(mode<GRAPH_OBJ_PROP_DOUBLE_TOTAL+GRAPH_OBJ_PROP_INTEGER_TOTAL)
     {
      double value_compared=obj_compared.GetProperty((ENUM_GRAPH_OBJ_PROP_DOUBLE)mode,0);
      double value_current=this.GetProperty((ENUM_GRAPH_OBJ_PROP_DOUBLE)mode,0);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two objects
   else if(mode<GRAPH_OBJ_PROP_DOUBLE_TOTAL+GRAPH_OBJ_PROP_INTEGER_TOTAL+GRAPH_OBJ_PROP_STRING_TOTAL)
     {
      string value_compared=obj_compared.GetProperty((ENUM_GRAPH_OBJ_PROP_STRING)mode,0);
      string value_current=this.GetProperty((ENUM_GRAPH_OBJ_PROP_STRING)mode,0);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CGStdGraphObj objects by all properties                  |
//+------------------------------------------------------------------+
bool CGStdGraphObj::IsEqual(CGStdGraphObj *compared_obj) const
  {
   int begin=0, end=GRAPH_OBJ_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_INTEGER prop=(ENUM_GRAPH_OBJ_PROP_INTEGER)i;
      for(int j=0;j<this.Prop.CurrSize(prop);j++)
         if(this.GetProperty(prop,j)!=compared_obj.GetProperty(prop,j)) return false; 
     }
   begin=end; end+=GRAPH_OBJ_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_DOUBLE prop=(ENUM_GRAPH_OBJ_PROP_DOUBLE)i;
      for(int j=0;j<this.Prop.CurrSize(prop);j++)
         if(this.GetProperty(prop,j)!=compared_obj.GetProperty(prop,j)) return false; 
     }
   begin=end; end+=GRAPH_OBJ_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_STRING prop=(ENUM_GRAPH_OBJ_PROP_STRING)i;
      for(int j=0;j<this.Prop.CurrSize(prop);j++)
         if(this.GetProperty(prop,j)!=compared_obj.GetProperty(prop,j)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Display object properties in the journal                         |
//+------------------------------------------------------------------+
void CGStdGraphObj::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_BEG)," (",this.Header(),") =============");
   int begin=0, end=GRAPH_OBJ_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_INTEGER prop=(ENUM_GRAPH_OBJ_PROP_INTEGER)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=GRAPH_OBJ_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_DOUBLE prop=(ENUM_GRAPH_OBJ_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=GRAPH_OBJ_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_STRING prop=(ENUM_GRAPH_OBJ_PROP_STRING)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_END)," (",this.Header(),") =============\n");
  }
//+------------------------------------------------------------------+
//| Return the object short name                                     |
//+------------------------------------------------------------------+
string CGStdGraphObj::Header(const bool symbol=false)
  {
   return CGBaseObj::TypeGraphObjectDescription();
  }
//+------------------------------------------------------------------+
//| Display a short description of the object in the journal         |
//+------------------------------------------------------------------+
void CGStdGraphObj::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      CMessage::Text(MSG_GRAPH_ELEMENT_TYPE_STANDARD),": ",
      " \"",CGBaseObj::Name(),"\": ID ",(string)this.GetProperty(GRAPH_OBJ_PROP_ID,0),
      ", ",::TimeToString(CGBaseObj::TimeCreate(),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's integer property                  |
//+------------------------------------------------------------------+
string CGStdGraphObj::GetPropertyDescription(ENUM_GRAPH_OBJ_PROP_INTEGER property,const int index=0)
  {
   return
     (
      property==GRAPH_OBJ_PROP_ID         ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ID)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_BASE_ID    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BASE_ID)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_TYPE       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_TYPE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.TypeDescription()
         )  :
      property==GRAPH_OBJ_PROP_ELEMENT_TYPE  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ELEMENT_TYPE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+CGBaseObj::TypeElementDescription()
         )  :
      property==GRAPH_OBJ_PROP_SPECIES    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+CGBaseObj::SpeciesDescription()
         )  :
      property==GRAPH_OBJ_PROP_GROUP    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_GROUP)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(CGBaseObj::Group()>0 ? (string)this.GetProperty(property,0) : CMessage::Text(MSG_LIB_PROP_EMPTY))
         )  :
      property==GRAPH_OBJ_PROP_BELONG     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BELONG)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+CGBaseObj::BelongDescription()
         )  :
      property==GRAPH_OBJ_PROP_CHART_ID   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CHART_ID)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_WND_NUM    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_WND_NUM)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_CHANGE_HISTORY ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CHANGE_MEMORY)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_CREATETIME   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CREATETIME)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::TimeToString(this.GetProperty(property,0),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
         )  :
      property==GRAPH_OBJ_PROP_TIMEFRAMES ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_TIMEFRAMES)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.VisibleOnTimeframeDescription()
         )  :
      property==GRAPH_OBJ_PROP_BACK       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BACK)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.IsBack() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_ZORDER     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ZORDER)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_HIDDEN     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_HIDDEN)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.IsHidden() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_SELECTED   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SELECTED)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.IsSelected() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_SELECTABLE ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SELECTABLE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.IsSelectable() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_NUM        ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_NUM)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.NumberDescription()
         )  :
      property==GRAPH_OBJ_PROP_TIME       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_TIME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+"\n"+this.TimesDescription()
         )  :
      property==GRAPH_OBJ_PROP_COLOR      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_COLOR)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::ColorToString((color)this.GetProperty(property,0),true)
         )  :
      property==GRAPH_OBJ_PROP_STYLE      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_STYLE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+LineStyleDescription((ENUM_LINE_STYLE)this.GetProperty(property,0))
         )  :
      property==GRAPH_OBJ_PROP_WIDTH     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_WIDTH)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_FILL       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_FILL)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_READONLY   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_READONLY)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_LEVELS     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_LEVELCOLOR ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELCOLOR)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ":\n"+this.LevelsColorDescription()
         )  :
      property==GRAPH_OBJ_PROP_LEVELSTYLE ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELSTYLE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ":\n"+this.LevelsStyleDescription()
         )  :
      property==GRAPH_OBJ_PROP_LEVELWIDTH ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELWIDTH)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ":\n"+this.LevelsWidthDescription()
         )  :
      property==GRAPH_OBJ_PROP_ALIGN      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ALIGN)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+AlignModeDescription((ENUM_ALIGN_MODE)this.GetProperty(property,0))
         )  :
      property==GRAPH_OBJ_PROP_FONTSIZE   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_FONTSIZE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_RAY_LEFT   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_RAY_LEFT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_RAY_RIGHT  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_RAY_RIGHT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_RAY        ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_RAY)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_ELLIPSE    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ELLIPSE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_ARROWCODE  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ARROWCODE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_ANCHOR     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ANCHOR)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.AnchorDescription()
         )  :
      property==GRAPH_OBJ_PROP_XDISTANCE  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_XDISTANCE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_YDISTANCE  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_YDISTANCE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_DIRECTION  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_DIRECTION)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+GannDirectDescription((ENUM_GANN_DIRECTION)this.GetProperty(property,0))
         )  :
      property==GRAPH_OBJ_PROP_DEGREE     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_DEGREE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+ElliotWaveDegreeDescription((ENUM_ELLIOT_WAVE_DEGREE)this.GetProperty(property,0))
         )  :
      property==GRAPH_OBJ_PROP_DRAWLINES  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_DRAWLINES)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_STATE      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_STATE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_BUTTON_STATE_PRESSED) : CMessage::Text(MSG_LIB_TEXT_BUTTON_STATE_DEPRESSED))
         )  :
      property==GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID  ?  CMessage::Text(MSG_CHART_OBJ_ID)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_CHART_OBJ_PERIOD ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CHART_OBJ_PERIOD)+
         (!this.SupportProperty(property)       ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+TimeframeDescription((ENUM_TIMEFRAMES)this.GetProperty(property,0))
         )  :
      property==GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE)+
         (!this.SupportProperty(property)             ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE)+
         (!this.SupportProperty(property)             ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      property==GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE)+
         (!this.SupportProperty(property)             ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_XSIZE      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_XSIZE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_YSIZE      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_YSIZE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_XOFFSET    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_XOFFSET)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_YOFFSET    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_YOFFSET)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property,0)
         )  :
      property==GRAPH_OBJ_PROP_BGCOLOR    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BGCOLOR)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::ColorToString((color)this.GetProperty(property,0),true)
         )  :
      property==GRAPH_OBJ_PROP_CORNER     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_CORNER)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+BaseCornerDescription((ENUM_BASE_CORNER)this.GetProperty(property,0))
         )  :
      property==GRAPH_OBJ_PROP_BORDER_TYPE   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BORDER_TYPE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+BorderTypeDescription((ENUM_BORDER_TYPE)this.GetProperty(property,0))
         )  :
      property==GRAPH_OBJ_PROP_BORDER_COLOR  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BORDER_COLOR)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::ColorToString((color)this.GetProperty(property,0),true)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's real property                     |
//+------------------------------------------------------------------+
string CGStdGraphObj::GetPropertyDescription(ENUM_GRAPH_OBJ_PROP_DOUBLE property,const int index=0)
  {
   int dg=(this.m_digits>0 ? this.m_digits : 1);
   return
     (
      property==GRAPH_OBJ_PROP_PRICE      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_PRICE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+"\n"+this.PricesDescription()
         )  :
      property==GRAPH_OBJ_PROP_LEVELVALUE ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELVALUE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ":\n"+this.LevelsValueDescription()
         )  :
      property==GRAPH_OBJ_PROP_SCALE      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SCALE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property,0),2)
         )  :
      property==GRAPH_OBJ_PROP_ANGLE      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_ANGLE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property,0),2)
         )  :
      property==GRAPH_OBJ_PROP_DEVIATION  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_DEVIATION)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property,0),2)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's string property                   |
//+------------------------------------------------------------------+
string CGStdGraphObj::GetPropertyDescription(ENUM_GRAPH_OBJ_PROP_STRING property,const int index=0)
  {
   return
     (
      property==GRAPH_OBJ_PROP_NAME       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_NAME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+"\""+this.GetProperty(property,0)+"\""
         )  :
      property==GRAPH_OBJ_PROP_BASE_NAME  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BASE_NAME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+"\""+this.GetProperty(property,0)+"\""
         )  :
      property==GRAPH_OBJ_PROP_TEXT       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_TEXT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0)=="" ? CMessage::Text(MSG_LIB_PROP_EMPTY) : "\""+this.GetProperty(property,0)+"\"")
         )  :
      property==GRAPH_OBJ_PROP_TOOLTIP    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_TOOLTIP)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property,0)=="" ? CMessage::Text(MSG_LIB_PROP_AUTO) : 
                this.GetProperty(property,0)=="\n" ? CMessage::Text(MSG_LIB_PROP_EMPTY) :
                "\""+this.GetProperty(property,0)+"\"")
         )  :
      property==GRAPH_OBJ_PROP_LEVELTEXT  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELTEXT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ":\n"+this.LevelsTextDescription()
         )  :
      property==GRAPH_OBJ_PROP_FONT       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_FONT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+"\""+this.GetProperty(property,0)+"\""
         )  :
      property==GRAPH_OBJ_PROP_BMPFILE    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_BMPFILE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ":\n"+this.BMPFilesDescription()
         )  :
      property==GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SYMBOL)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetProperty(property,0)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the object visibility on timeframes    |
//+------------------------------------------------------------------+
string CGStdGraphObj::VisibleOnTimeframeDescription(void)
  {
   string res="";
   int flags=(int)this.GetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0);
   if(flags==OBJ_NO_PERIODS)
      return CMessage::Text(MSG_LIB_TEXT_OBJ_NO_PERIODS);
   if(flags==OBJ_ALL_PERIODS)
      return CMessage::Text(MSG_LIB_TEXT_OBJ_ALL_PERIODS);
   for(int i=1;i<=21;i++)
     {
      ENUM_TIMEFRAMES timeframe=TimeframeByEnumIndex((uchar)i);
      if(!IsVisibleOnTimeframe(timeframe,flags))
         continue;
      res+=TimeframeDescription(timeframe)+", ";
     }
   ::StringSetCharacter(res,::StringLen(res)-2,' ');
   ::StringTrimRight(res);
   return res;
  }
//+------------------------------------------------------------------+
//| Return the description of the graphical object index             |
//| in the list of objects of a composite graphical object           |
//+------------------------------------------------------------------+
string CGStdGraphObj::NumberDescription(void)
  {
   if(CGBaseObj::TypeGraphElement()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
     {
      if(this.Number()==0)
         return CMessage::Text(MSG_GRAPH_OBJ_PROP_NUM_EXT_BASE_OBJ);
     }
   return (string)this.Number();
  }
//+------------------------------------------------------------------+
//| Get and save the integer properties                              |
//+------------------------------------------------------------------+
void CGStdGraphObj::GetAndSaveINT(void)
  {
   //--- Properties inherent in all graphical objects and present in a graphical object
   CGBaseObj::SetVisibleOnTimeframes((int)::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_TIMEFRAMES),true);   // Write Object visibility on timeframes to the base object
   CGBaseObj::SetFlagBack(::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_BACK),true);                         // Write Background object flag to the base object
   CGBaseObj::SetZorder(::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_ZORDER),true);                         // Write Priority of a graphical object for receiving the event of clicking on a chart to the base object
   CGBaseObj::SetFlagHidden(::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_HIDDEN),true);                     // Write Disable displaying the name of a graphical object in the terminal object list to the base object
   CGBaseObj::SetFlagSelectable(::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_SELECTABLE),true);             // Write Object availability to the base object
   CGBaseObj::SetFlagSelected(::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_SELECTED),true);                 // Write Object selection to the base object
   
   this.SetProperty(GRAPH_OBJ_PROP_TIMEFRAMES,0,CGBaseObj::VisibleOnTimeframes());                                   // Object visibility on timeframes
   this.SetProperty(GRAPH_OBJ_PROP_BACK,0,CGBaseObj::IsBack());                                                      // Background object
   this.SetProperty(GRAPH_OBJ_PROP_ZORDER,0,CGBaseObj::Zorder());                                                    // Priority of a graphical object for receiving the event of clicking on a chart
   this.SetProperty(GRAPH_OBJ_PROP_HIDDEN,0,CGBaseObj::IsHidden());                                                  // Disable displaying the name of a graphical object in the terminal object list
   this.SetProperty(GRAPH_OBJ_PROP_SELECTABLE,0,CGBaseObj::IsSelectable());                                          // Object availability
   this.SetProperty(GRAPH_OBJ_PROP_SELECTED,0,CGBaseObj::IsSelected());                                              // Object selection
   
   this.SetProperty(GRAPH_OBJ_PROP_CREATETIME,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_CREATETIME));  // Object creation time
   for(int i=0;i<this.m_pivots;i++)                                                                                  // Point time coordinates
      this.SetTimePivot(i);
   this.SetProperty(GRAPH_OBJ_PROP_COLOR,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_COLOR));            // Color
   this.SetProperty(GRAPH_OBJ_PROP_STYLE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_STYLE));            // Style
   this.SetProperty(GRAPH_OBJ_PROP_WIDTH,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_WIDTH));            // Line width
   //--- Properties belonging to different graphical objects
   this.SetProperty(GRAPH_OBJ_PROP_FILL,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_FILL));              // Fill an object with color
   this.SetProperty(GRAPH_OBJ_PROP_READONLY,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_READONLY));      // Ability to edit text in the Edit object
   this.SetProperty(GRAPH_OBJ_PROP_LEVELS,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_LEVELS));          // Number of levels
   
   if(this.GetProperty(GRAPH_OBJ_PROP_LEVELS,0)!=this.GetPropertyPrev(GRAPH_OBJ_PROP_LEVELS,0))                      // Check if the number of levels has changed
     {
      this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELCOLOR,this.Levels());
      this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELSTYLE,this.Levels());
      this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELWIDTH,this.Levels());
      this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELVALUE,this.Levels());
      this.Prop.SetSizeRange(GRAPH_OBJ_PROP_LEVELTEXT,this.Levels());
     }
   for(int i=0;i<this.Levels();i++)                                                                                  // Level data
     {
      this.SetLevelColor(i);
      this.SetLevelStyle(i);
      this.SetLevelWidth(i);
     }
   this.SetProperty(GRAPH_OBJ_PROP_ALIGN,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_ALIGN));            // Horizontal text alignment in the Edit object (OBJ_EDIT)
   this.SetProperty(GRAPH_OBJ_PROP_FONTSIZE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_FONTSIZE));      // Font size
   this.SetProperty(GRAPH_OBJ_PROP_RAY_LEFT,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_RAY_LEFT));      // Ray goes to the left
   this.SetProperty(GRAPH_OBJ_PROP_RAY_RIGHT,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_RAY_RIGHT));    // Ray goes to the right
   this.SetProperty(GRAPH_OBJ_PROP_RAY,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_RAY));                // Vertical line goes through all windows of a chart
   this.SetProperty(GRAPH_OBJ_PROP_ELLIPSE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_ELLIPSE));        // Display the full ellipse of the Fibonacci Arc object
   this.SetProperty(GRAPH_OBJ_PROP_ARROWCODE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_ARROWCODE));    // Arrow code for the "Arrow" object
   this.SetProperty(GRAPH_OBJ_PROP_ANCHOR,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_ANCHOR));          // Position of the binding point of the graphical object
   this.SetProperty(GRAPH_OBJ_PROP_XDISTANCE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_XDISTANCE));    // Distance from the base corner along the X axis in pixels
   this.SetProperty(GRAPH_OBJ_PROP_YDISTANCE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_YDISTANCE));    // Distance from the base corner along the X axis in pixels
   this.SetProperty(GRAPH_OBJ_PROP_DIRECTION,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_DIRECTION));    // Gann object trend
   this.SetProperty(GRAPH_OBJ_PROP_DEGREE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_DEGREE));          // Elliott wave marking level
   this.SetProperty(GRAPH_OBJ_PROP_DRAWLINES,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_DRAWLINES));    // Display lines for Elliott wave marking
   this.SetProperty(GRAPH_OBJ_PROP_STATE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_STATE));            // Button state (pressed/released)
   this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_CHART_ID));// Chart object ID (OBJ_CHART).
   this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PERIOD,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_PERIOD));    // Chart object period
   this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_DATE_SCALE));  // Time scale display flag for the Chart object
   this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_PRICE_SCALE));// Price scale display flag for the Chart object
   this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_CHART_SCALE));// Chart object scale
   this.SetProperty(GRAPH_OBJ_PROP_XSIZE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_XSIZE));            // Object width along the X axis in pixels.
   this.SetProperty(GRAPH_OBJ_PROP_YSIZE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_YSIZE));            // Object height along the Y axis in pixels.
   this.SetProperty(GRAPH_OBJ_PROP_XOFFSET,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_XOFFSET));        // X coordinate of the upper-left corner of the visibility area.
   this.SetProperty(GRAPH_OBJ_PROP_YOFFSET,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_YOFFSET));        // Y coordinate of the upper-left corner of the visibility area.
   this.SetProperty(GRAPH_OBJ_PROP_BGCOLOR,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_BGCOLOR));        // Background color for OBJ_EDIT, OBJ_BUTTON, OBJ_RECTANGLE_LABEL
   this.SetProperty(GRAPH_OBJ_PROP_CORNER,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_CORNER));          // Chart corner for binding a graphical object
   this.SetProperty(GRAPH_OBJ_PROP_BORDER_TYPE,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_BORDER_TYPE));// Border type for "Rectangle border"
   this.SetProperty(GRAPH_OBJ_PROP_BORDER_COLOR,0,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_BORDER_COLOR));// Border color for OBJ_EDIT and OBJ_BUTTON
  }
//+------------------------------------------------------------------+
//| Get and save the real properties                                 |
//+------------------------------------------------------------------+
void CGStdGraphObj::GetAndSaveDBL(void)
  {
   for(int i=0;i<this.m_pivots;i++)                                                                               // Point price coordinates
      SetPricePivot(i);
   for(int i=0;i<this.Levels();i++)                                                                               // Level values
      this.SetLevelValue(i);
   this.SetProperty(GRAPH_OBJ_PROP_SCALE,0,::ObjectGetDouble(this.ChartID(),this.Name(),OBJPROP_SCALE));          // Scale (property of Gann objects and Fibonacci Arcs objects)
   this.SetProperty(GRAPH_OBJ_PROP_ANGLE,0,::ObjectGetDouble(this.ChartID(),this.Name(),OBJPROP_ANGLE));          // Angle
   this.SetProperty(GRAPH_OBJ_PROP_DEVIATION,0,::ObjectGetDouble(this.ChartID(),this.Name(),OBJPROP_DEVIATION));  // Deviation of the standard deviation channel
  }
//+------------------------------------------------------------------+
//| Get and save the string properties                               |
//+------------------------------------------------------------------+
void CGStdGraphObj::GetAndSaveSTR(void)
  {
   this.SetProperty(GRAPH_OBJ_PROP_TEXT,0,::ObjectGetString(this.ChartID(),this.Name(),OBJPROP_TEXT));            // Object description (the text contained in the object)
   this.SetProperty(GRAPH_OBJ_PROP_TOOLTIP,0,::ObjectGetString(this.ChartID(),this.Name(),OBJPROP_TOOLTIP));      // Tooltip text
   for(int i=0;i<this.Levels();i++)                                                                               // Level descriptions
      this.SetLevelText(i);
   this.SetProperty(GRAPH_OBJ_PROP_FONT,0,::ObjectGetString(this.ChartID(),this.Name(),OBJPROP_FONT));            // Font
   this.SetProperty(GRAPH_OBJ_PROP_BMPFILE,0,::ObjectGetString(this.ChartID(),this.Name(),OBJPROP_BMPFILE));      // BMP file name for the "Bitmap Level" object
   this.SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL,0,::ObjectGetString(this.ChartID(),this.Name(),OBJPROP_SYMBOL));// Symbol for the Chart object 
  }
//+------------------------------------------------------------------+
//| Overwrite all graphical object properties                        |
//+------------------------------------------------------------------+
void CGStdGraphObj::PropertiesRefresh(void)
  {
   this.GetAndSaveINT();
   this.GetAndSaveDBL();
   this.GetAndSaveSTR();
  }
//+------------------------------------------------------------------+
//| Copy the current data to the previous one                        |
//+------------------------------------------------------------------+
void CGStdGraphObj::PropertiesCopyToPrevData(void)
  {
   this.Prop.CurrentToPrevious();
  }
//+------------------------------------------------------------------+
//| Check object property changes                                    |
//+------------------------------------------------------------------+
void CGStdGraphObj::PropertiesCheckChanged(void)
  {
   CGBaseObj::ClearEventsList();
   bool changed=false;
   int begin=0, end=GRAPH_OBJ_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_INTEGER prop=(ENUM_GRAPH_OBJ_PROP_INTEGER)i;
      if(!this.SupportProperty(prop)) continue;
      for(int j=0;j<Prop.CurrSize(prop);j++)
        {
         if(this.GetProperty(prop,j)!=this.GetPropertyPrev(prop,j))
           {
            changed=true;
            this.CreateAndAddNewEvent(GRAPH_OBJ_EVENT_CHANGE,this.ChartID(),prop,this.Name());
           }
        }
     }

   begin=end; end+=GRAPH_OBJ_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_DOUBLE prop=(ENUM_GRAPH_OBJ_PROP_DOUBLE)i;
      if(!this.SupportProperty(prop)) continue;
      for(int j=0;j<Prop.CurrSize(prop);j++)
        {
         if(this.GetProperty(prop,j)!=this.GetPropertyPrev(prop,j))
           {
            changed=true;
            this.CreateAndAddNewEvent(GRAPH_OBJ_EVENT_CHANGE,this.ChartID(),prop,this.Name());
           }
        }
     }

   begin=end; end+=GRAPH_OBJ_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_GRAPH_OBJ_PROP_STRING prop=(ENUM_GRAPH_OBJ_PROP_STRING)i;
      if(!this.SupportProperty(prop)) continue;
      for(int j=0;j<Prop.CurrSize(prop);j++)
        {
         if(this.GetProperty(prop,j)!=this.GetPropertyPrev(prop,j) && prop!=GRAPH_OBJ_PROP_NAME)
           {
            changed=true;
            this.CreateAndAddNewEvent(GRAPH_OBJ_EVENT_CHANGE,this.ChartID(),prop,this.Name());
           }
        }
     }
   if(changed)
     {
      for(int i=0;i<this.m_list_events.Total();i++)
        {
         CGBaseEvent *event=this.m_list_events.At(i);
         if(event==NULL)
            continue;
         ::EventChartCustom(::ChartID(),event.ID(),event.Lparam(),event.Dparam(),event.Sparam());
        }
      if(this.AllowChangeHistory())
        {
         int total=HistoryChangesTotal();
         if(this.CreateNewChangeHistoryObj(total<1))
            ::Print
              (
               DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_SUCCESS_CREATE_SNAPSHOT)," #",(total==0 ? "0-1" : (string)total),
               ": ",this.HistoryChangedObjTimeChangedToString(total-1)
              );
        }
      //--- If subordinate objects are attached to the base one (in a composite graphical object)
      if(this.m_list.Total()>0)
        {
         //--- In the loop by the number of added graphical objects,
         for(int i=0;i<this.m_list.Total();i++)
           {
            //--- get the next graphical object,
            CGStdGraphObj *dep=m_list.At(i);
            if(dep==NULL)
               continue;
            //--- Set X and Y coordinates to all pivot points of a subordinate object and
            //--- save the current properties of a subordinate graphical object as the previous ones
            if(this.SetCoordsXYtoDependentObj(dep))
               dep.PropertiesCopyToPrevData();
           }
         //--- Move reference control points to new coordinates
         if(this.ExtToolkit!=NULL)
           {
            for(int i=0;i<this.Pivots();i++)
              {
               this.ExtToolkit.SetBaseObjTimePrice(this.Time(i),this.Price(i),i);
              }
            this.ExtToolkit.SetBaseObjCoordXY(this.XDistance(),this.YDistance());
            long   lparam=0;
            double dparam=0;
            string sparam="";
            this.ExtToolkit.OnChartEvent(CHARTEVENT_CHART_CHANGE,lparam,dparam,sparam);
           }
         //--- Upon completion of the loop of handling all bound objects, redraw the chart to display all the changes
         ::ChartRedraw(m_chart_id);
        }
      //--- Save the current properties as the previous ones<
      this.PropertiesCopyToPrevData();
     }
  }
//+------------------------------------------------------------------+
//| Read and set the time of the specified pivot point               |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetTimePivot(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_TIME,index,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_TIME,index));
  }
//+------------------------------------------------------------------+
//| Read and set the price of the specified pivot point              |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetPricePivot(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_PRICE,index,::ObjectGetDouble(this.ChartID(),this.Name(),OBJPROP_PRICE,index));
  }
//+------------------------------------------------------------------+
//| Read and set the color of the specified level                    |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetLevelColor(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_LEVELCOLOR,index,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_LEVELCOLOR,index));
  }
//+------------------------------------------------------------------+
//| Read and set the style of the specified level                    |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetLevelStyle(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_LEVELSTYLE,index,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_LEVELSTYLE,index));
  }
//+------------------------------------------------------------------+
//| Read and set the width of the specified level                    |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetLevelWidth(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_LEVELWIDTH,index,::ObjectGetInteger(this.ChartID(),this.Name(),OBJPROP_LEVELWIDTH,index));
  }
//+------------------------------------------------------------------+
//| Read and set the value of the specified level                    |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetLevelValue(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_LEVELVALUE,index,::ObjectGetDouble(this.ChartID(),this.Name(),OBJPROP_LEVELVALUE,index));
  }
//+------------------------------------------------------------------+
//| Read and set the text of the specified level                     |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetLevelText(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_LEVELTEXT,index,::ObjectGetString(this.ChartID(),this.Name(),OBJPROP_LEVELTEXT,index));
  }
//+------------------------------------------------------------------+
//| Read and set the BMP file name                                   |
//| for the Bitmap Label object.                                     |
//| Index: 0 - ON, 1 - OFF                                           |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetBMPFile(const int index)
  {
   this.SetProperty(GRAPH_OBJ_PROP_BMPFILE,index,::ObjectGetString(this.ChartID(),this.Name(),OBJPROP_BMPFILE,index));
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all pivot point times                 |
//+------------------------------------------------------------------+
string CGStdGraphObj::TimesDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.m_pivots;i++)
      txt+=" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_PIVOT)+(string)i+": "+this.TimeDescription(i)+(i<this.m_pivots-1 ? "\n" : "");
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the prices of all pivot points                            |
//+------------------------------------------------------------------+
string CGStdGraphObj::PricesDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.m_pivots;i++)
      txt+=" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_PIVOT)+(string)i+": "+this.PriceDescription(i)+(i<this.m_pivots-1 ? "\n" : "");
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all pivot points                      |
//+------------------------------------------------------------------+
string CGStdGraphObj::TimePricesDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.m_pivots;i++)
      txt+=(" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_PIVOT)+(string)i+": "+this.TimeDescription(i)+" / "+this.PriceDescription(i)+(i<this.m_pivots-1 ? "\n" : ""));
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all level colors                      |
//+------------------------------------------------------------------+
string CGStdGraphObj::LevelsColorDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.Levels();i++)
      txt+=(" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_LEVEL)+(string)i+": "+this.LevelColorDescription(i)+(i<this.Levels()-1 ? "\n" : ""));
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all level styles                      |
//+------------------------------------------------------------------+
string CGStdGraphObj::LevelsStyleDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.Levels();i++)
      txt+=(" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_LEVEL)+(string)i+": "+LineStyleDescription(this.LevelStyle(i))+(i<this.Levels()-1 ? "\n" : ""));
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all level width                       |
//+------------------------------------------------------------------+
string CGStdGraphObj::LevelsWidthDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.Levels();i++)
      txt+=(" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_LEVEL)+(string)i+": "+this.LevelWidthDescription(i)+(i<this.Levels()-1 ? "\n" : ""));
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all level values                      |
//+------------------------------------------------------------------+
string CGStdGraphObj::LevelsValueDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.Levels();i++)
      txt+=(" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_LEVEL)+(string)i+": "+this.LevelValueDescription(i)+(i<this.Levels()-1 ? "\n" : ""));
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all level texts                       |
//+------------------------------------------------------------------+
string CGStdGraphObj::LevelsTextDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.Levels();i++)
      txt+=(" - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_LEVEL)+(string)i+": "+"\""+this.LevelText(i)+"\""+(i<this.Levels()-1 ? "\n" : ""));
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of the graphical object BMP files        |
//+------------------------------------------------------------------+
string CGStdGraphObj::BMPFilesDescription(void) const
  {
   string txt=
     (
      " - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_BMP_FILE_STATE_ON) +" [0]: "+(BMPFile(0)=="" ? CMessage::Text(MSG_LIB_PROP_EMPTY) : "\""+BMPFile(0)+"\"")+"\n"+
      " - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_BMP_FILE_STATE_OFF)+" [1]: "+(BMPFile(1)=="" ? CMessage::Text(MSG_LIB_PROP_EMPTY) : "\""+BMPFile(1)+"\"")
     );
   return txt;
  }
//+------------------------------------------------------------------+
//| Return the descriptions of all values of all levels              |
//+------------------------------------------------------------------+
string CGStdGraphObj::LevelsAllDescription(void) const
  {
   string txt="";
   for(int i=0;i<this.Levels();i++)
     {
      txt+=
        (
         " - "+CMessage::Text(MSG_GRAPH_OBJ_TEXT_LEVEL)+(string)i+"\n"+
         "    "+CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELCOLOR)+": "+LevelColorDescription(i)+"\n"+
         "    "+CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELSTYLE)+": "+LevelStyleDescription(i)+"\n"+
         "    "+CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELWIDTH)+": "+LevelWidthDescription(i)+"\n"+
         "    "+CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELVALUE)+": "+LevelValueDescription(i)+"\n"+
         "    "+CMessage::Text(MSG_GRAPH_OBJ_PROP_LEVELTEXT) +": \""+LevelText(i)+"\"\n"
        );
     }
   return txt;
  }
//+------------------------------------------------------------------+
//| Display the history of renaming the object to the journal        |
//+------------------------------------------------------------------+
void CGStdGraphObj::PrintRenameHistory(void)
  {
   ::Print(DFUN,CMessage::Text(MSG_GRAPH_OBJ_GRAPH_OBJ_PROP_CHANGE_HISTORY),this.GetPropertyDescription(GRAPH_OBJ_PROP_NAME),":");
   int size=this.Properties().CurrSize(GRAPH_OBJ_PROP_NAME);
   ::Print(DFUN,"0: ",this.GetProperty(GRAPH_OBJ_PROP_NAME,0));
   for(int i=size-1;i>0;i--)
      ::Print(DFUN,size-i,": ",this.GetProperty(GRAPH_OBJ_PROP_NAME,i));
  }
//+------------------------------------------------------------------+
//| Set integer property values from the change history              |
//| for the graphical object                                         |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetHistoryINT(const ENUM_GRAPH_OBJ_PROP_INTEGER prop,const long value,const int modifier)
  {
   switch(prop)
     {
      case GRAPH_OBJ_PROP_TIMEFRAMES            :  this.SetVisibleOnTimeframes((int)value,false);        break;  // Object visibility on timeframes
      case GRAPH_OBJ_PROP_BACK                  :  this.SetFlagBack(value,false);                        break;   // Background object
      case GRAPH_OBJ_PROP_ZORDER                :  this.SetZorder(value,false);                          break;   // Priority of a graphical object for receiving the event of clicking on a chart
      case GRAPH_OBJ_PROP_HIDDEN                :  this.SetFlagHidden(value,false);                      break;   // Disable displaying the name of a graphical object in the terminal object list
      case GRAPH_OBJ_PROP_SELECTED              :  this.SetFlagSelected(value,false);                    break;   // Object selection
      case GRAPH_OBJ_PROP_SELECTABLE            :  this.SetFlagSelectable(value,false);                  break;   // Object availability
      case GRAPH_OBJ_PROP_TIME                  :  this.SetTime(value,modifier);                         break;   // Time coordinate
      case GRAPH_OBJ_PROP_COLOR                 :  this.SetColor((color)value);                          break;   // Color
      case GRAPH_OBJ_PROP_STYLE                 :  this.SetStyle((ENUM_LINE_STYLE)value);                break;   // Style
      case GRAPH_OBJ_PROP_WIDTH                 :  this.SetWidth((int)value);                            break;   // Line width
      case GRAPH_OBJ_PROP_FILL                  :  this.SetFlagFill(value);                              break;   // Filling an object with color
      case GRAPH_OBJ_PROP_READONLY              :  this.SetFlagReadOnly(value);                          break;   // Ability to edit text in the Edit object
      case GRAPH_OBJ_PROP_LEVELS                :  this.SetLevels((int)value);                           break;   // Number of levels
      case GRAPH_OBJ_PROP_LEVELCOLOR            :  this.SetLevelColor((color)value,modifier);            break;   // Level line color
      case GRAPH_OBJ_PROP_LEVELSTYLE            :  this.SetLevelStyle((ENUM_LINE_STYLE)value,modifier);  break;   // Level line style
      case GRAPH_OBJ_PROP_LEVELWIDTH            :  this.SetLevelWidth((int)value,modifier);              break;   // Level line width
      case GRAPH_OBJ_PROP_ALIGN                 :  this.SetAlign((ENUM_ALIGN_MODE)value);                break;   // Horizontal text alignment in the Edit object (OBJ_EDIT)
      case GRAPH_OBJ_PROP_FONTSIZE              :  this.SetFontSize((int)value);                         break;   // Font size
      case GRAPH_OBJ_PROP_RAY_LEFT              :  this.SetFlagRayLeft(value);                           break;   // Ray goes to the left
      case GRAPH_OBJ_PROP_RAY_RIGHT             :  this.SetFlagRayRight(value);                          break;   // Ray goes to the right
      case GRAPH_OBJ_PROP_RAY                   :  this.SetFlagRay(value);                               break;   // Vertical line goes through all windows of a chart
      case GRAPH_OBJ_PROP_ELLIPSE               :  this.SetFlagEllipse(value);                           break;   // Display the full ellipse of the Fibonacci Arc object
      case GRAPH_OBJ_PROP_ARROWCODE             :  this.SetArrowCode((uchar)value);                      break;   // Arrow code for the Arrow object
      case GRAPH_OBJ_PROP_ANCHOR                :  this.SetAnchor((int)value);                           break;   // Position of the binding point of the graphical object
      case GRAPH_OBJ_PROP_XDISTANCE             :  this.SetXDistance((int)value);                        break;   // Distance from the base corner along the X axis in pixels
      case GRAPH_OBJ_PROP_YDISTANCE             :  this.SetYDistance((int)value);                        break;   // Distance from the base corner along the Y axis in pixels
      case GRAPH_OBJ_PROP_DIRECTION             :  this.SetDirection((ENUM_GANN_DIRECTION)value);        break;   // Gann object trend
      case GRAPH_OBJ_PROP_DEGREE                :  this.SetDegree((ENUM_ELLIOT_WAVE_DEGREE)value);       break;   // Elliott wave markup level
      case GRAPH_OBJ_PROP_DRAWLINES             :  this.SetFlagDrawLines(value);                         break;   // Display lines for Elliott wave markup
      case GRAPH_OBJ_PROP_STATE                 :  this.SetFlagState(value);                             break;   // Button state (pressed/released)
      case GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID    :  this.SetChartObjChartID(value);                       break;   // Chart object ID (OBJ_CHART)
      case GRAPH_OBJ_PROP_CHART_OBJ_PERIOD      :  this.SetChartObjPeriod((ENUM_TIMEFRAMES)value);       break;   // Chart object period
      case GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE  :  this.SetChartObjChartScale((int)value);               break;   // Time scale display flag for the Chart object
      case GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE :  this.SetFlagChartObjPriceScale(value);                break;   // Price scale display flag for the Chart object
      case GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE :  this.SetFlagChartObjDateScale(value);                 break;   // Chart object scale
      case GRAPH_OBJ_PROP_XSIZE                 :  this.SetXSize((int)value);                            break;   // Object distance along the X axis in pixels
      case GRAPH_OBJ_PROP_YSIZE                 :  this.SetYSize((int)value);                            break;   // Object height along the Y axis in pixels
      case GRAPH_OBJ_PROP_XOFFSET               :  this.SetXOffset((int)value);                          break;   // X coordinate of the upper-left corner of the visibility area
      case GRAPH_OBJ_PROP_YOFFSET               :  this.SetYOffset((int)value);                          break;   // Y coordinate of the upper-left corner of the visibility area
      case GRAPH_OBJ_PROP_BGCOLOR               :  this.SetBGColor((color)value);                        break;   // Background color for OBJ_EDIT, OBJ_BUTTON, OBJ_RECTANGLE_LABEL
      case GRAPH_OBJ_PROP_CORNER                :  this.SetCorner((ENUM_BASE_CORNER)value);              break;   // Chart corner for binding a graphical object
      case GRAPH_OBJ_PROP_BORDER_TYPE           :  this.SetBorderType((ENUM_BORDER_TYPE)value);          break;   // Border type for "Rectangle border"
      case GRAPH_OBJ_PROP_BORDER_COLOR          :  this.SetBorderColor((color)value);                    break;   // Border color for the OBJ_EDIT and OBJ_BUTTON objects
      case GRAPH_OBJ_PROP_ID                    :  // Object ID
      case GRAPH_OBJ_PROP_BASE_ID               :  // Base object ID
      case GRAPH_OBJ_PROP_TYPE                  :  // Graphical object type (ENUM_OBJECT)
      case GRAPH_OBJ_PROP_ELEMENT_TYPE          :  // Graphical element type (ENUM_GRAPH_ELEMENT_TYPE)
      case GRAPH_OBJ_PROP_SPECIES               :  // Graphical object species (ENUM_GRAPH_OBJ_SPECIES)
      case GRAPH_OBJ_PROP_GROUP                 :  // Graphical object group
      case GRAPH_OBJ_PROP_BELONG                :  // Graphical object affiliation
      case GRAPH_OBJ_PROP_CHART_ID              :  // Chart ID
      case GRAPH_OBJ_PROP_WND_NUM               :  // Chart subwindow index
      case GRAPH_OBJ_PROP_NUM                   :  // Object index in the list
      case GRAPH_OBJ_PROP_CHANGE_HISTORY        :  // Flag of storing the change history
      case GRAPH_OBJ_PROP_CREATETIME            :  // Object creation time
      default  : break;
     }
  }
//+------------------------------------------------------------------+
//| Set real property values from the change history                 |
//| for the graphical object                                         |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetHistoryDBL(const ENUM_GRAPH_OBJ_PROP_DOUBLE prop,const double value,const int modifier)
  {
   switch(prop)
     {
      case GRAPH_OBJ_PROP_PRICE                 : this.SetPrice(value,modifier);          break;   // Price coordinate
      case GRAPH_OBJ_PROP_LEVELVALUE            : this.SetLevelValue(value,modifier);     break;   // Level value
      case GRAPH_OBJ_PROP_SCALE                 : this.SetScale(value);                   break;   // Scale (property of Gann objects and Fibonacci Arcs objects)
      case GRAPH_OBJ_PROP_ANGLE                 : this.SetAngle(value);                   break;   // Angle
      case GRAPH_OBJ_PROP_DEVIATION             : this.SetDeviation(value);               break;   // Deviation of the standard deviation channel
      default: break;
     }
  }
//+------------------------------------------------------------------+
//| Set string property values from the change history               |
//| for the graphical object                                         |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetHistorySTR(const ENUM_GRAPH_OBJ_PROP_STRING prop,const string value,const int modifier)
  {
   switch(prop)
     {
      case GRAPH_OBJ_PROP_TEXT                  : this.SetText(value);                    break;   // Object description (the text contained in the object)
      case GRAPH_OBJ_PROP_TOOLTIP               : this.SetTooltip(value);                 break;   // Tooltip text
      case GRAPH_OBJ_PROP_LEVELTEXT             : this.SetLevelText(value,modifier);      break;   // Level description
      case GRAPH_OBJ_PROP_FONT                  : this.SetFont(value);                    break;   // Font
      case GRAPH_OBJ_PROP_BMPFILE               : this.SetBMPFile(value,modifier);        break;   // BMP file name for the "Bitmap Level" object
      case GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL      : this.SetChartObjSymbol(value);          break;   // Chart object symbol
      case GRAPH_OBJ_PROP_BASE_NAME             : this.SetBaseName(value);                break;   // Base object name
      case GRAPH_OBJ_PROP_NAME                  : // Object name
      default :  break;
     }
  }
//+------------------------------------------------------------------+
//| Return the name of a subordinate graphical object by index       |
//+------------------------------------------------------------------+
string CGStdGraphObj::NameDependent(const int index)
  {
   CGStdGraphObj *obj=this.GetDependentObj(index);
   return(obj!=NULL ? obj.Name() : "");
  }
//+------------------------------------------------------------------+
//| Return the form for managing an object pivot point               |
//+------------------------------------------------------------------+
CForm *CGStdGraphObj::GetControlPointForm(const int index)
  {
   return(this.ExtToolkit!=NULL ? this.ExtToolkit.GetControlPointForm(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the number of form objects                                |
//| for managing control points                                      |
//+------------------------------------------------------------------+
int CGStdGraphObj::GetNumControlPointForms(void)
  {
   return(this.ExtToolkit!=NULL ? this.ExtToolkit.GetNumControlPointForms() : 0);
  }
//+------------------------------------------------------------------+
//| Redraw the form for managing the control point                   |
//| of the extended standard graphical object                        |
//+------------------------------------------------------------------+
void CGStdGraphObj::RedrawControlPointForms(const uchar opacity,const color clr)
  {
//--- Leave if the object has no toolkit of an extended standard graphical object
   if(this.ExtToolkit==NULL)
      return;
//--- Get the number of pivot point management forms
   int total_form=this.GetNumControlPointForms();
//--- In the loop by the number of pivot point management forms
   for(int i=0;i<total_form;i++)
     {
      //--- get the next form object
      CFormControl *form=this.ExtToolkit.GetControlPointForm(i);
      if(form==NULL)
         continue;
      //--- Draw a point and a circle with a specified non-transparency and color
      //--- If a point should be completely transparent (deleted)
      //--- and the form still has the point, delete the point,
      if(opacity==0 && form.IsControlAlreadyDrawn())
         this.ExtToolkit.DrawControlPoint(form,0,clr);
      //--- otherwise, draw the point with a specified non-transparency and color
      else
         this.ExtToolkit.DrawControlPoint(form,opacity,clr);
     }
   
//--- Get the total number of bound graphical objects
   int total_dep=this.GetNumDependentObj();
//--- In the loop by all bound graphical objects,
   for(int i=0;i<total_dep;i++)
     {
      //--- get the next graphical object from the list
      CGStdGraphObj *dep=this.GetDependentObj(i);
      if(dep==NULL)
         continue;
      //--- call the method for it
      dep.RedrawControlPointForms(opacity,clr);
     }
  }
//+------------------------------------------------------------------+
//| Add a subordinate standard graphical object to the list          |
//+------------------------------------------------------------------+
bool CGStdGraphObj::AddDependentObj(CGStdGraphObj *obj)
  {
   //--- If the current object is not an extended one, inform of that and return 'false'
   if(this.TypeGraphElement()!=GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
     {
      CMessage::ToLog(MSG_GRAPH_OBJ_NOT_EXT_OBJ);
      return false;
     }
   //--- If failed to add the pointer to the passed object into the list, inform of that and return 'false'
   if(!this.m_list.Add(obj))
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_ADD_DEP_EXT_OBJ_TO_LIST);
      return false;
     }
   //--- Object added to the list - set its number in the list,
   //--- name and ID of the current object as the base one
   //--- set the flags of object availability and selection
   //--- and the graphical element type - standard extended graphical object
   obj.SetNumber(this.m_list.Total()-1);
   obj.SetBaseName(this.Name());
   obj.SetBaseObjectID(this.ObjectID());
   obj.SetFlagSelected(false,false);
   obj.SetFlagSelectable(false,false);
   obj.SetTypeElement(GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED);
   obj.PropertiesCopyToPrevData();
   return true;
  }
//+----------------------------------------------------------------------+
//| Change X and Y coordinates of the current and all dependent objects  |
//+----------------------------------------------------------------------+
bool CGStdGraphObj::ChangeCoordsExtendedObj(const int x,const int y,const int modifier,bool redraw=false)
  {
//--- Set new coordinates for the pivot point specified in 'modifier'
   if(!this.SetTimePrice(x,y,modifier))
      return false;
//--- If the object is a composite graphical object,
//--- and subordinate graphical objects are attached to the object
   if(this.ExtToolkit!=NULL && this.m_list.Total()>0)
     {
      //--- Get the graphical object bound to the 'modifier' point
      CGStdGraphObj *dep=this.GetDependentObj(modifier);
      if(dep==NULL)
         return false;
      //--- Set X and Y coordinates to all pivot points of a subordinate object and
      //--- save the current properties of a subordinate graphical object as the previous ones
      if(this.SetCoordsXYtoDependentObj(dep))
         dep.PropertiesCopyToPrevData();
     }
//--- Move a reference control point to new coordinates
   this.ExtToolkit.SetBaseObjTimePrice(this.Time(modifier),this.Price(modifier),modifier);
   this.ExtToolkit.SetBaseObjCoordXY(this.XDistance(),this.YDistance());
//--- If the flag is active, redraw the chart
   if(redraw)
      ::ChartRedraw(m_chart_id);
//--- All is successful - return 'true'
   return true;
  }
//+------------------------------------------------------------------+
//| Set X and Y coordinates to the associated pivot point            |
//| of a specified subordinate object by index                       |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetCoordsXYtoDependentObj(CGStdGraphObj *dependent_obj,CLinkedPivotPoint *pivot_point,const int index)
  {
//--- get the number of coordinate points of the base object for setting the X coordinate
   int numx=pivot_point.GetBasePivotsNumX(index);
//--- In the loop by each coordinate point for setting the X coordinate,
   for(int nx=0;nx<numx;nx++)
     {
      //--- get the property for setting the X coordinate, its modifier
      //--- and set it to the subordinate graphical object attached to the 'index' point
      int prop_from=pivot_point.GetPropertyX(index,nx);
      int modifier_from=pivot_point.GetPropertyModifierX(index,nx);
      this.SetCoordXToDependentObj(dependent_obj,prop_from,modifier_from,nx);
     }
//--- Get the number of coordinate points of the base object for setting the Y coordinate
   int numy=pivot_point.GetBasePivotsNumY(index);
   //--- In the loop by each coordinate point for setting the Y coordinate,
   for(int ny=0;ny<numy;ny++)
     {
      //--- get the property for setting the Y coordinate, its modifier
      //--- and set it to the subordinate graphical object attached to the 'index' point
      int prop_from=pivot_point.GetPropertyY(index,ny);
      int modifier_from=pivot_point.GetPropertyModifierY(index,ny);
      this.SetCoordYToDependentObj(dependent_obj,prop_from,modifier_from,ny);
     }
  }
//+------------------------------------------------------------------+
//| Set X and Y coordinates to associated pivot points               |
//| of the specified subordinate object                              |
//+------------------------------------------------------------------+
bool CGStdGraphObj::SetCoordsXYtoDependentObj(CGStdGraphObj *dependent_obj)
  {
//--- Get the object of pivot point data of the bound graphical object
   CLinkedPivotPoint *pp=dependent_obj.GetLinkedPivotPoint();
   if(pp==NULL)
      return false;
//--- get the number of coordinate points the object is attached to
   int num=pp.GetNumLinkedCoords();
//--- In the loop by the object coordinate points,
//--- set X and Y to all pivot points of a subordinate object
   for(int j=0;j<num;j++)
      this.SetCoordsXYtoDependentObj(dependent_obj,pp,j);
   return true;
  }
//+------------------------------------------------------------------+
//| Return the minimum XY screen coordinate                          |
//| from all pivot points                                            |
//+------------------------------------------------------------------+
bool CGStdGraphObj::GetMinCoordXY(int &x,int &y)
  {
//--- Declare the variables storing the minimum time and maximum price
   datetime time_min=LONG_MAX;
   double   price_max=0;
//--- Depending on the object type
   switch(this.TypeGraphObject())
     {
      //--- Objects constructed based on screen coordinates
      case OBJ_LABEL             :
      case OBJ_BUTTON            :
      case OBJ_BITMAP_LABEL      :
      case OBJ_EDIT              :
      case OBJ_RECTANGLE_LABEL   :
      case OBJ_CHART             :
         //--- Write XY screen coordinates to x and y variables and return 'true'
         x=this.XDistance();
         y=this.YDistance();
         return true;
      
      //--- Objects constructed in time/price coordinates
      default                    :
         //--- In the loop by all pivot points
         for(int i=0;i<this.Pivots();i++)
           {
            //--- Define the minimum time
            if(this.Time(i)<time_min)
               time_min=this.Time(i);
            //--- Define the maximum price
            if(this.Price(i)>price_max)
               price_max=this.Price(i);
           }
         //--- Return the result of converting time/price coordinates into XY screen coordinates
         return(::ChartTimePriceToXY(this.ChartID(),this.SubWindow(),time_min,price_max,x,y) ? true : false);
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the maximum XY screen coordinate                          |
//| from all pivot points                                            |
//+------------------------------------------------------------------+
bool CGStdGraphObj::GetMaxCoordXY(int &x,int &y)
  {
//--- Declare the variables that store the maximum time and minimum price
   datetime time_max=0;
   double   price_min=DBL_MAX;
//--- Depending on the object type
   switch(this.TypeGraphObject())
     {
      //--- Objects constructed based on screen coordinates
      case OBJ_LABEL             :
      case OBJ_BUTTON            :
      case OBJ_BITMAP_LABEL      :
      case OBJ_EDIT              :
      case OBJ_RECTANGLE_LABEL   :
      case OBJ_CHART             :
         //--- Write XY screen coordinates to x and y variables and return 'true'
         x=this.XDistance();
         y=this.YDistance();
         return true;
      
      //--- Objects constructed in time/price coordinates
      default                    :
         //--- In the loop by all pivot points
         for(int i=0;i<this.Pivots();i++)
           {
            //--- Define the maximum time
            if(this.Time(i)>time_max)
               time_max=this.Time(i);
            //--- Define the maximum price
            if(this.Price(i)<price_min)
               price_min=this.Price(i);
           }
         //--- Return the result of converting time/price coordinates into XY screen coordinates
         return(::ChartTimePriceToXY(this.ChartID(),this.SubWindow(),time_max,price_min,x,y) ? true : false);
     }
   return false;
  }
//+-------------------------------------------------------------------+
//|Set the X coordinate from the specified property of the base object|
//| to the specified subordinate object                               |
//+-------------------------------------------------------------------+
void CGStdGraphObj::SetCoordXToDependentObj(CGStdGraphObj *obj,const int prop_from,const int modifier_from,const int modifier_to)
  {
   int prop=WRONG_VALUE;
   switch(obj.TypeGraphObject())
     {
      case OBJ_LABEL             :
      case OBJ_BUTTON            :
      case OBJ_BITMAP_LABEL      :
      case OBJ_EDIT              :
      case OBJ_RECTANGLE_LABEL   :
      case OBJ_CHART             :
        prop=GRAPH_OBJ_PROP_XDISTANCE; 
        break;
      default:
        prop=GRAPH_OBJ_PROP_TIME;
        break;
     }
   if(prop_from<GRAPH_OBJ_PROP_INTEGER_TOTAL)
     {
      this.SetDependentINT(obj,(ENUM_GRAPH_OBJ_PROP_INTEGER)prop,this.GetProperty((ENUM_GRAPH_OBJ_PROP_INTEGER)prop_from,modifier_from),modifier_to);
     }
   else if(prop_from<GRAPH_OBJ_PROP_INTEGER_TOTAL+GRAPH_OBJ_PROP_DOUBLE_TOTAL)
     {
      //--- Assigning a real property value to the integer value of the X coordinate is a bad idea unless you know what you are doing
      this.SetDependentINT(obj,(ENUM_GRAPH_OBJ_PROP_INTEGER)prop,(long)this.GetProperty((ENUM_GRAPH_OBJ_PROP_DOUBLE)prop_from,modifier_from),modifier_to);
     }
   else if(prop_from<GRAPH_OBJ_PROP_INTEGER_TOTAL+GRAPH_OBJ_PROP_DOUBLE_TOTAL+GRAPH_OBJ_PROP_STRING_TOTAL)
     {
      //--- Assigning a string property value to the integer value of the X coordinate is a bad idea unless you know what you are doing
      this.SetDependentINT(obj,(ENUM_GRAPH_OBJ_PROP_INTEGER)prop,(long)this.GetProperty((ENUM_GRAPH_OBJ_PROP_STRING)prop_from,modifier_from),modifier_to);
     }
  }
//+-------------------------------------------------------------------+
//|Set the Y coordinate from the specified property of the base object|
//| to the specified subordinate object                               |
//+-------------------------------------------------------------------+
void CGStdGraphObj::SetCoordYToDependentObj(CGStdGraphObj *obj,const int prop_from,const int modifier_from,const int modifier_to)
  {
   int prop=WRONG_VALUE;
   switch(obj.TypeGraphObject())
     {
      case OBJ_LABEL             :
      case OBJ_BUTTON            :
      case OBJ_BITMAP_LABEL      :
      case OBJ_EDIT              :
      case OBJ_RECTANGLE_LABEL   :
      case OBJ_CHART             :
        prop=GRAPH_OBJ_PROP_YDISTANCE;
        break;
      default:
        prop=GRAPH_OBJ_PROP_PRICE;
        break;
     }
   if(prop_from<GRAPH_OBJ_PROP_INTEGER_TOTAL)
     {
      if(prop==GRAPH_OBJ_PROP_YDISTANCE)
         this.SetDependentINT(obj,(ENUM_GRAPH_OBJ_PROP_INTEGER)prop,this.GetProperty((ENUM_GRAPH_OBJ_PROP_INTEGER)prop_from,modifier_from),modifier_to);
      else
         //--- Assigning an integer property value to the real value of the Y coordinate is allowed only if you know what you are doing
         this.SetDependentDBL(obj,(ENUM_GRAPH_OBJ_PROP_DOUBLE)prop,this.GetProperty((ENUM_GRAPH_OBJ_PROP_INTEGER)prop_from,modifier_from),modifier_to);
     }
   else if(prop_from<GRAPH_OBJ_PROP_INTEGER_TOTAL+GRAPH_OBJ_PROP_DOUBLE_TOTAL)
     {
      if(prop==GRAPH_OBJ_PROP_YDISTANCE)
         //--- Assigning a real property value to the integer value of the Y coordinate is a bad idea unless you know what you are doing
         this.SetDependentINT(obj,(ENUM_GRAPH_OBJ_PROP_INTEGER)prop,(long)this.GetProperty((ENUM_GRAPH_OBJ_PROP_DOUBLE)prop_from,modifier_from),modifier_to);
      else
         this.SetDependentDBL(obj,(ENUM_GRAPH_OBJ_PROP_DOUBLE)prop,this.GetProperty((ENUM_GRAPH_OBJ_PROP_DOUBLE)prop_from,modifier_from),modifier_to);
     }
   else if(prop_from<GRAPH_OBJ_PROP_INTEGER_TOTAL+GRAPH_OBJ_PROP_DOUBLE_TOTAL+GRAPH_OBJ_PROP_STRING_TOTAL)
     {
      //--- Assigning a string property value to the integer or real value of the Y coordinate is a bad idea unless you know what you are doing
      if(prop==GRAPH_OBJ_PROP_YDISTANCE)
         this.SetDependentINT(obj,(ENUM_GRAPH_OBJ_PROP_INTEGER)prop,(long)this.GetProperty((ENUM_GRAPH_OBJ_PROP_STRING)prop_from,modifier_from),modifier_to);
      else
         this.SetDependentDBL(obj,(ENUM_GRAPH_OBJ_PROP_DOUBLE)prop,(double)this.GetProperty((ENUM_GRAPH_OBJ_PROP_STRING)prop_from,modifier_from),modifier_to);
     }
  }
//+------------------------------------------------------------------+
//| Set the integer property                                         |
//| to the specified dependent object                                |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetDependentINT(CGStdGraphObj *obj,const ENUM_GRAPH_OBJ_PROP_INTEGER prop,const long value,const int modifier)
  {
   if(obj==NULL || obj.BaseObjectID()==0)
      return;
   obj.SetProperty(prop,modifier,value);
   switch(prop)
     {
      case GRAPH_OBJ_PROP_TIMEFRAMES            :  obj.SetVisibleOnTimeframes((int)value,false);         break;   // Object visibility on timeframes
      case GRAPH_OBJ_PROP_BACK                  :  obj.SetFlagBack(value,false);                         break;   // Background object
      case GRAPH_OBJ_PROP_ZORDER                :  obj.SetZorder(value,false);                           break;   // Priority of a graphical object for receiving the event of clicking on a chart
      case GRAPH_OBJ_PROP_HIDDEN                :  obj.SetFlagHidden(value,false);                       break;   // Disable displaying the name of a graphical object in the terminal object list
      case GRAPH_OBJ_PROP_SELECTED              :  obj.SetFlagSelected(value,false);                     break;   // Object selection
      case GRAPH_OBJ_PROP_SELECTABLE            :  obj.SetFlagSelectable(value,false);                   break;   // Object availability
      case GRAPH_OBJ_PROP_TIME                  :  obj.SetTime(value,modifier);                          break;   // Time coordinate
      case GRAPH_OBJ_PROP_COLOR                 :  obj.SetColor((color)value);                           break;   // Color
      case GRAPH_OBJ_PROP_STYLE                 :  obj.SetStyle((ENUM_LINE_STYLE)value);                 break;   // Style
      case GRAPH_OBJ_PROP_WIDTH                 :  obj.SetWidth((int)value);                             break;   // Line width
      case GRAPH_OBJ_PROP_FILL                  :  obj.SetFlagFill(value);                               break;   // Filling an object with color
      case GRAPH_OBJ_PROP_READONLY              :  obj.SetFlagReadOnly(value);                           break;   // Ability to edit text in the Edit object
      case GRAPH_OBJ_PROP_LEVELS                :  obj.SetLevels((int)value);                            break;   // Number of levels
      case GRAPH_OBJ_PROP_LEVELCOLOR            :  obj.SetLevelColor((color)value,modifier);             break;   // Level line color
      case GRAPH_OBJ_PROP_LEVELSTYLE            :  obj.SetLevelStyle((ENUM_LINE_STYLE)value,modifier);   break;   // Level line style
      case GRAPH_OBJ_PROP_LEVELWIDTH            :  obj.SetLevelWidth((int)value,modifier);               break;   // Level line width
      case GRAPH_OBJ_PROP_ALIGN                 :  obj.SetAlign((ENUM_ALIGN_MODE)value);                 break;   // Horizontal text alignment in the Edit object (OBJ_EDIT)
      case GRAPH_OBJ_PROP_FONTSIZE              :  obj.SetFontSize((int)value);                          break;   // Font size
      case GRAPH_OBJ_PROP_RAY_LEFT              :  obj.SetFlagRayLeft(value);                            break;   // Ray goes to the left
      case GRAPH_OBJ_PROP_RAY_RIGHT             :  obj.SetFlagRayRight(value);                           break;   // Ray goes to the right
      case GRAPH_OBJ_PROP_RAY                   :  obj.SetFlagRay(value);                                break;   // Vertical line goes through all windows of a chart
      case GRAPH_OBJ_PROP_ELLIPSE               :  obj.SetFlagEllipse(value);                            break;   // Display the full ellipse of the Fibonacci Arc object
      case GRAPH_OBJ_PROP_ARROWCODE             :  obj.SetArrowCode((uchar)value);                       break;   // Arrow code for the Arrow object
      case GRAPH_OBJ_PROP_ANCHOR                :  obj.SetAnchor((int)value);                            break;   // Position of the binding point of the graphical object
      case GRAPH_OBJ_PROP_XDISTANCE             :  obj.SetXDistance((int)value);                         break;   // Distance from the base corner along the X axis in pixels
      case GRAPH_OBJ_PROP_YDISTANCE             :  obj.SetYDistance((int)value);                         break;   // Distance from the base corner along the Y axis in pixels
      case GRAPH_OBJ_PROP_DIRECTION             :  obj.SetDirection((ENUM_GANN_DIRECTION)value);         break;   // Gann object trend
      case GRAPH_OBJ_PROP_DEGREE                :  obj.SetDegree((ENUM_ELLIOT_WAVE_DEGREE)value);        break;   // Elliott wave markup level
      case GRAPH_OBJ_PROP_DRAWLINES             :  obj.SetFlagDrawLines(value);                          break;   // Display lines for Elliott wave markup
      case GRAPH_OBJ_PROP_STATE                 :  obj.SetFlagState(value);                              break;   // Button state (pressed/released)
      case GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID    :  obj.SetChartObjChartID(value);                        break;   // Chart object ID (OBJ_CHART)
      case GRAPH_OBJ_PROP_CHART_OBJ_PERIOD      :  obj.SetChartObjPeriod((ENUM_TIMEFRAMES)value);        break;   // Chart object period
      case GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE  :  obj.SetChartObjChartScale((int)value);                break;   // Time scale display flag for the Chart object
      case GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE :  obj.SetFlagChartObjPriceScale(value);                 break;   // Price scale display flag for the Chart object
      case GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE :  obj.SetFlagChartObjDateScale(value);                  break;   // Chart object scale
      case GRAPH_OBJ_PROP_XSIZE                 :  obj.SetXSize((int)value);                             break;   // Object distance along the X axis in pixels
      case GRAPH_OBJ_PROP_YSIZE                 :  obj.SetYSize((int)value);                             break;   // Object height along the Y axis in pixels
      case GRAPH_OBJ_PROP_XOFFSET               :  obj.SetXOffset((int)value);                           break;   // X coordinate of the upper-left corner of the visibility area
      case GRAPH_OBJ_PROP_YOFFSET               :  obj.SetYOffset((int)value);                           break;   // Y coordinate of the upper-left corner of the visibility area
      case GRAPH_OBJ_PROP_BGCOLOR               :  obj.SetBGColor((color)value);                         break;   // Background color for OBJ_EDIT, OBJ_BUTTON, OBJ_RECTANGLE_LABEL
      case GRAPH_OBJ_PROP_CORNER                :  obj.SetCorner((ENUM_BASE_CORNER)value);               break;   // Chart corner for binding a graphical object
      case GRAPH_OBJ_PROP_BORDER_TYPE           :  obj.SetBorderType((ENUM_BORDER_TYPE)value);           break;   // Border type for "Rectangle border"
      case GRAPH_OBJ_PROP_BORDER_COLOR          :  obj.SetBorderColor((color)value);                     break;   // Border color for the OBJ_EDIT and OBJ_BUTTON
      case GRAPH_OBJ_PROP_BASE_ID               :  obj.SetBaseObjectID(value);                           break;   // Base object ID
      case GRAPH_OBJ_PROP_GROUP                 :  obj.SetGroup((int)value);                             break;   // Graphical object group
      case GRAPH_OBJ_PROP_CHANGE_HISTORY        :  obj.SetAllowChangeMemory((bool)value);                break;   // Flag of storing the change history
      case GRAPH_OBJ_PROP_ID                    :  // Object ID
      case GRAPH_OBJ_PROP_TYPE                  :  // Graphical object type (ENUM_OBJECT)
      case GRAPH_OBJ_PROP_ELEMENT_TYPE          :  // Graphical element type (ENUM_GRAPH_ELEMENT_TYPE)
      case GRAPH_OBJ_PROP_SPECIES               :  // Graphical object species (ENUM_GRAPH_OBJ_SPECIES)
      case GRAPH_OBJ_PROP_BELONG                :  // Graphical object affiliation
      case GRAPH_OBJ_PROP_CHART_ID              :  // Chart ID
      case GRAPH_OBJ_PROP_WND_NUM               :  // Chart subwindow index
      case GRAPH_OBJ_PROP_NUM                   :  // Object index in the list
      case GRAPH_OBJ_PROP_CREATETIME            :  // Object creation time
      default  : break;
     }
  }
//+------------------------------------------------------------------+
//|Set a real property to the specified subordinate object           |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetDependentDBL(CGStdGraphObj *obj,const ENUM_GRAPH_OBJ_PROP_DOUBLE prop,const double value,const int modifier)
  {
   if(obj==NULL || obj.BaseObjectID()==0)
      return;
   obj.SetProperty(prop,modifier,value);
   switch(prop)
     {
      case GRAPH_OBJ_PROP_PRICE                 : obj.SetPrice(value,modifier);        break;   // Price coordinate
      case GRAPH_OBJ_PROP_LEVELVALUE            : obj.SetLevelValue(value,modifier);   break;   // Level value
      case GRAPH_OBJ_PROP_SCALE                 : obj.SetScale(value);                 break;   // Scale (property of Gann objects and Fibonacci Arcs objects)
      case GRAPH_OBJ_PROP_ANGLE                 : obj.SetAngle(value);                 break;   // Angle
      case GRAPH_OBJ_PROP_DEVIATION             : obj.SetDeviation(value);             break;   // Deviation of the standard deviation channel
      default: break;
     }
  }
//+------------------------------------------------------------------+
//| Set a string property to the specified subordinate object        |
//+------------------------------------------------------------------+
void CGStdGraphObj::SetDependentSTR(CGStdGraphObj *obj,const ENUM_GRAPH_OBJ_PROP_STRING prop,const string value,const int modifier)
  {
   if(obj==NULL || obj.BaseObjectID()==0)
      return;
   obj.SetProperty(prop,modifier,value);
   switch(prop)
     {
      case GRAPH_OBJ_PROP_TEXT                  : obj.SetText(value);                  break;   // Object description (the text contained in the object)
      case GRAPH_OBJ_PROP_TOOLTIP               : obj.SetTooltip(value);               break;   // Tooltip text
      case GRAPH_OBJ_PROP_LEVELTEXT             : obj.SetLevelText(value,modifier);    break;   // Level description
      case GRAPH_OBJ_PROP_FONT                  : obj.SetFont(value);                  break;   // Font
      case GRAPH_OBJ_PROP_BMPFILE               : obj.SetBMPFile(value,modifier);      break;   // BMP file name for the "Bitmap Level" object
      case GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL      : obj.SetChartObjSymbol(value);        break;   // Chart object symbol
      case GRAPH_OBJ_PROP_BASE_NAME             : obj.SetBaseName(value);              break;   // Base object name
      case GRAPH_OBJ_PROP_NAME                  : // Object name
      default :  break;
     }
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CGStdGraphObj::OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   if(GraphElementType()!=GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
      return;
   string name=this.Name();
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      if(ExtToolkit==NULL)
         return;
      for(int i=0;i<this.Pivots();i++)
        {
         ExtToolkit.SetBaseObjTimePrice(this.Time(i),this.Price(i),i);
        }
      ExtToolkit.SetBaseObjCoordXY(this.XDistance(),this.YDistance());
      ExtToolkit.OnChartEvent(id,lparam,dparam,name);
     }
  }
//+------------------------------------------------------------------+
   