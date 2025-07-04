//+------------------------------------------------------------------+
//|                                                    XDimArray.mqh |
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
#include <Arrays\ArrayObj.mqh>
#include "Message.mqh"
//+------------------------------------------------------------------+
//| Abstract data unit class                                         |
//+------------------------------------------------------------------+
class CDataUnit : public CObject
  {
private:
   int               m_type;  
protected:
                     CDataUnit(int type)  { this.m_type=type;        }
public:
   virtual int       Type(void)     const { return this.m_type;      }
                     CDataUnit(){ this.m_type=OBJECT_DE_TYPE_OBJECT; }
  };
//+------------------------------------------------------------------+
//| Integer data unit class                                          |
//+------------------------------------------------------------------+
class CDataUnitLong : public CDataUnit
  {
public:
   long              Value;
                     CDataUnitLong() : CDataUnit(OBJECT_DE_TYPE_LONG){}
  };
//+------------------------------------------------------------------+
//| Class of a single long array dimension                           |
//+------------------------------------------------------------------+
class CDimLong : public CArrayObj
  {
private:
//--- Create a new data object
   CDataUnitLong    *CreateData(const string source,const long value=0)
                       {
                        //--- Create a new long data object
                        CDataUnitLong *data=new CDataUnitLong();
                        //--- If failed to create an object, inform of that in the journal
                        if(data==NULL)
                           ::Print(source,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_LONG_DATA_OBJ));
                        //--- Otherwise, set the value passed to the method for the object
                        else
                           data.Value=value;
                        //--- Return the pointer to the object or NULL
                        return data;
                       }
//--- Get long data object from the array
   CDataUnitLong    *GetData(const string source,const int index) const
                       {
                        //--- Get the pointer to the object by the index passed to the method. If the passed index is less than zero, it is set to zero
                        CDataUnitLong *data=this.At(index<0 ? 0 : index);
                        //--- If failed to receive the object
                        if(data==NULL)
                          {
                           //--- if the passed index exceeds the number of objects in the list, display a message informing of exceeding the list size
                           if(index>this.Total()-1)
                              ::Print(source,CMessage::Text(MSG_LIB_SYS_REQUEST_OUTSIDE_LONG_ARRAY)," (",index,"/",this.Total(),")");
                           //--- otherwise, display the message informing of failing to get the pointer to the object
                           else
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_GET_LONG_DATA_OBJ);
                          }
                        //--- Return the pointer to the object or NULL in case of an error
                        return data;
                       }
//--- Add the specified number of cells with data to the end of the array
   bool              AddQuantity(const string source,const int total,const long value=0)
                       {
                        //--- Declare the variable for storing the result of adding objects to the list
                        bool res=true;
                        //--- in the list by the number of added objects passed to the method
                        for(int i=0;i<total;i++)
                          {
                           //--- Create a new long data object
                           CDataUnitLong *data=this.CreateData(DFUN,value);
                           //--- If failed to create an object, inform of that and move on to the next iteration
                           if(data==NULL)
                             {
                              res &=false;
                              continue;
                             }
                           data.Value=value;
                           //--- if failed to add the object to the list
                           if(!this.Add(data))
                             {
                              //--- display the appropriate message, remove the object and add 'false' to the variable value
                              //--- and move on to the loop next iteration
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                              delete data;
                              res &=false;
                              continue;
                             }
                          }
                        //--- Return the total result of adding the specified number of objects to the list
                        return res;
                       }
public:
//--- Initialize the array
   void              Initialize(const int total,const long value=0)
                       {
                        //--- Clear the array and increase its size by the value specified in the parameters by setting the default value
                        this.Clear();
                        this.Increase(total,value);
                       }
//--- Increase the number of data cells by the specified value, return the number of added elements
   int               Increase(const int total,const long value=0)
                       {
                        //--- Save the current array size
                        int size_prev=this.Total();
                        //--- Add the specified number of object instances to the list
                        //--- and return the difference between the obtained and previous array size
                        this.AddQuantity(DFUN,total,value);
                        return this.Total()-size_prev;
                       }
//--- Decrease the number of data cells by the specified value, return the number of removed elements. The very first element always remains
   int               Decrease(const int total)
                       {
                        //--- If not a single cell remains after removing array cells, return zero
                        if(total>this.Total()-1)
                           return 0;
                        //--- Save the current array size
                        int total_prev=this.Total();
                        //--- Calculate the initial index the array cells should be removed from
                        int from=this.Total()-total;
                        //--- The final index is always an array end
                        int to=this.Total()-1;
                        //--- If failed to remove the specified number of array cells, inform of that in the journal
                        if(!this.DeleteRange(from,to))
                           CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_DECREASE_LONG_ARRAY);
                        //--- return the difference between the previous array size and the one obtained as a result of deleting cells
                        return total_prev-this.Total();
                       }
//--- Set a new array size
   bool              SetSize(const int size,const long initial_value=0)
                       {
                        //--- If the zero size is passed, return 'false'
                        if(size==0)
                           return false;
                        //--- Calculate the number of cells to be added or removed for receiving the required array size
                        int total=fabs(size-this.Total());
                        //--- If the passed array size exceeds the current one,
                        //--- return the result of adding the calculated number of arrays to the array
                        if(size>this.Total())
                           return(this.Increase(total,initial_value)==total);
                        //--- otherwise, if the passed array size is less than the current one, 
                        //--- return the result of removing the calculated number of arrays from the array
                        else if(size<this.Total())
                           return(this.Decrease(total)==total);
                        //--- If the passed size is equal to the current one, simply return 'true'
                        return true;
                       }
//--- Set the value to the specified array cell
   bool              Set(const int index,const long value)
                       {
                        //--- Get the pointer to the data object by a specified index
                        CDataUnitLong *data=this.GetData(DFUN,index);
                        //--- If failed to get the object, return 'false'
                        if(data==NULL)
                           return false;
                        //--- Return the value, passed to the method, to the obtained object and return 'true'
                        data.Value=value;
                        return true;
                       }
//--- Return the amount of data (the array size is defined using the Total() method of the CArrayObj parent class)
   int               Size(void) const { return this.Total(); }
   
//--- Returns the value at the specified index
   long              Get(const int index) const
                       {
                        //--- Get the pointer to the data object by index
                        CDataUnitLong *data=this.GetData(DFUN,index);
                        //--- If the object is received successfully,
                        //--- return the value set in the object,
                        //--- otherwise, return zero
                        return(data!=NULL ? data.Value : 0);
                       }
   bool              Get(const int index, long &value) const
                       {
                        //--- Set the initial value to 'value' passed to the method via a link
                        value=0;
                        //--- Get the pointer to the data object by index
                        CDataUnitLong *data=this.GetData(DFUN,index);
                        //--- If failed to get the object, return 'false'
                        if(data==NULL)
                           return false;
                        //--- Set the value stored in the object to 'value' and return 'true'
                        value = data.Value;
                        return true;
                       }
//--- Constructors
                     CDimLong(void)                               { this.Initialize(1);            }
                     CDimLong(const int total,const long value=0) { this.Initialize(total,value);  }
//--- Destructor
                    ~CDimLong(void)
                       {
                        this.Clear();
                        this.Shutdown();
                       }
  };
//+------------------------------------------------------------------+
//| Dynamic multidimensional long array class                        |
//+------------------------------------------------------------------+
class CXDimArrayLong : public CArrayObj
  {
private:
//--- Return the data array from the first dimensionality
   CDimLong         *GetDim(const string source,const int index) const
                       {
                        //--- Get the first dimension array object by index
                        CDimLong *dim=this.At(index<0 ? 0 : index);
                        //--- If failed to get the pointer to the object,
                        if(dim==NULL)
                          {
                           //--- if the index is outside the array, inform of the request outside the array
                           if(index>this.Total()-1)
                              ::Print(source,CMessage::Text(MSG_LIB_SYS_REQUEST_OUTSIDE_LONG_ARRAY)," (",index,"/",this.Total(),")");
                           //--- otherwise, inform of the error when receiving the pointer to the array
                           else
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_GET_LONG_DATA_OBJ);
                          }
                        //--- Return either the pointer to the object or NULL in case of an error
                        return dim;
                       }
//--- Add a new dimension to the first dimensionality
   bool              AddNewDim(const string source,const int size,const long initial_value=0)
                       {
                        //--- Create a new array object 
                        CDimLong *dim=new CDimLong(size,initial_value);
                        //--- If failed to create an object, inform of that and return 'false'
                        if(dim==NULL)
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_CREATE_LONG_DATA_OBJ);
                           return false;
                          }
                        //--- If failed to add the object to the list, remove the object, inform of the error in the journal and return 'false'
                        if(!this.Add(dim))
                          {
                           delete dim;
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                           return false;
                          }
                        //--- Object successfully created and added to the list
                        return true;
                       }
public:
//--- Increase the number of data cells by the specified 'total' value in the first dimensionality,
//--- return the number of added elements to the dimensionality. Added cells' size is 'size'
   int               IncreaseRangeFirst(const int total,const int size,const long initial_value=0)
                       {
                        //--- Save the current array size
                        int total_prev=this.Total();
                        //--- In the loop by the specified number, add new objects to the array
                        for(int i=0;i<total;i++)
                           this.AddNewDim(DFUN,size,initial_value);
                        //--- Return the difference between the obtained and previous array size
                        return(this.Total()-total_prev);
                       }
//--- Increase the number of data cells by the specified 'total' value in the specified 'range' dimensionality,
//--- return the number of added elements to the changed dimensionality
   int               IncreaseRange(const int range,const int total,const long initial_value=0)
                       {
                        //--- Get the pointer to the array by 'range' index
                        CDimLong *dim=this.GetDim(DFUN,range);
                        //--- Return the result of increasing the array size by 'total' or zero in case of an error
                        return(dim!=NULL ? dim.Increase(total,initial_value) : 0);
                       }
//--- Decrease the number of cells with data in the first dimensionality by the specified value,
//--- return the number of removed elements. The very first element always remains
   int               DecreaseRangeFirst(const int total)
                       {
                        //--- Make sure at least one element remains in the array after the decrease,
                        //--- if not, return 'false'
                        if(total>this.Total()-1)
                           return 0;
                        //--- Save the current array size
                        int total_prev=this.Total();
                        //--- Calculate the initial index to remove the array elements from
                        int from=this.Total()-total;
                        //--- The final index is always the last array element
                        int to=this.Total()-1;
                        //--- If failed to remove the specified number of elements, inform of that in the journal
                        if(!this.DeleteRange(from,to))
                           CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_DECREASE_LONG_ARRAY);
                        //--- Return the number of removed array elements
                        return total_prev-this.Total();
                       }                      
//--- Decrease the number of data cells by the specified value in the specified dimensionality,
//--- return the number of removed elements. The very first element always remains
   int               DecreaseRange(const int range,const int total)
                       {
                        //--- Get the pointer to the array by 'range' index
                        CDimLong *dim=this.GetDim(DFUN,range);
                        //--- Return the result of decreasing the array size by 'total' or zero in case of an error
                        return(dim!=NULL ? dim.Decrease(total) : 0);
                       }
//--- Set the new array size in the specified dimensionality
   bool              SetSizeRange(const int range,const int size,const long initial_value=0)
                       {
                        //--- Get the pointer to the array by 'range' index
                        CDimLong *dim=this.GetDim(DFUN,range);
                        //--- Return the result of setting the array size to 'size' or 'false' in case of an error
                        return(dim!=NULL ? dim.SetSize(size,initial_value) : false);
                       }
//--- Set the value to the specified array cell of the specified dimension
   bool              Set(const int index,const int range,const long value)
                       {
                        //--- Get the pointer to the array by 'index'
                        CDimLong *dim=this.GetDim(DFUN,index);
                        //--- Return the result of setting the value to the array cell by 'range' index or 'false' in case of an error
                        return(dim!=NULL ? dim.Set(range,value) : false);
                       }
//--- Return the value at the specified index of the specified dimension
   long              Get(const int index,const int range) const
                       {
                        //--- Get the pointer to the array by 'index'
                        CDimLong *dim=this.GetDim(DFUN,index);
                        //--- Return the result of receiving the value from the array cell by 'range' index or 0 in case of an error
                        return(dim!=NULL ? dim.Get(range) : 0);
                       }
   bool              Get(const int index,const int range,long &value) const
                       {
                        //--- Get the pointer to the array by 'index'
                        CDimLong *dim=this.GetDim(DFUN,index);
                        //--- Return the result of receiving the value from the array cell by 'range' index to the 'value' variable
                        //--- or 'false' in case of an error ('value' is set to zero)
                        return(dim!=NULL ? dim.Get(range,value) : false);
                       }
//--- Return the amount of data (size of the specified dimension array)
   int               Size(const int range) const
                       {
                        //--- Get the pointer to the array by 'range' index
                        CDimLong *dim=this.GetDim(DFUN,range);
                        //--- Return the size of the obtained array by index or zero in case of an error
                        return(dim!=NULL ? dim.Size() : 0);
                       }
//--- Return the total amount of data (the total size of all dimensions)
   int               Size(void) const
                       {
                        //--- Set the initial size
                        int size=0;
                        //--- In the loop by all arrays in the list,
                        for(int i=0;i<this.Total();i++)
                          {
                           //--- get the next array.
                           CDimLong *dim=this.GetDim(DFUN,i);
                           //--- If failed to get the array, move on to the next one
                           if(dim==NULL)
                              continue;
                           //--- Add the array size to the size value
                           size+=dim.Size();
                          }
                        //--- Return the obtained value
                        return size;
                       }
//--- Constructor
                     CXDimArrayLong()
                       {
                        //--- Clear the list and add a single array to it
                        this.Clear();
                        this.Add(new CDimLong(1));
                       }
                     CXDimArrayLong(int first_dim_size,const int dim_size,const long initial_value=0)
                       {
                        //--- Clear the list
                        this.Clear();
                        int total=(first_dim_size<1 ? 1 : first_dim_size);
                        //--- In the loop by the necessary number of arrays calculated in 'total' from first_dim_size,
                        //--- add new arrays with the specified number of elements in dim_size to the list
                        for(int i=0;i<total;i++)
                           this.Add(new CDimLong(dim_size,initial_value));
                       }
//--- Destructor
                    ~CXDimArrayLong()
                       {
                        //--- Remove array elements and
                        //--- clear the array while completely freeing the array memory
                        this.Clear();
                        this.Shutdown();
                       }
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Real data unit class                                             |
//+------------------------------------------------------------------+
class CDataUnitDouble : public CDataUnit
  {
public:
   double            Value;
//--- Constructor
                     CDataUnitDouble() : CDataUnit(OBJECT_DE_TYPE_DOUBLE){}
  };
//+------------------------------------------------------------------+
//| Class of a single double array dimension                         |
//+------------------------------------------------------------------+
class CDimDouble : public CArrayObj
  {
private:
//--- Create a new data object
   CDataUnitDouble  *CreateData(const string source,const double value=0)
                       {
                        CDataUnitDouble *data=new CDataUnitDouble();
                        if(data==NULL)
                           ::Print(source,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_DOUBLE_DATA_OBJ));
                        else
                           data.Value=value;
                        return data;
                       }
//--- Get double data object from the array
   CDataUnitDouble  *GetData(const string source,const int index) const
                       {
                        CDataUnitDouble *data=this.At(index<0 ? 0 : index);
                        if(data==NULL)
                          {
                           if(index>this.Total()-1)
                              ::Print(source,CMessage::Text(MSG_LIB_SYS_REQUEST_OUTSIDE_DOUBLE_ARRAY)," (",index,"/",this.Total(),")");
                           else
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_GET_DOUBLE_DATA_OBJ);
                          }
                        return data;
                       }
//--- Add the specified number of cells with data to the end of the array
   bool              AddQuantity(const string source,const int total,const double value=0)
                       {
                        bool res=true;
                        for(int i=0;i<total;i++)
                          {
                           CDataUnitDouble *data=this.CreateData(DFUN,value);
                           if(data==NULL)
                             {
                              res &=false;
                              continue;
                             }
                           data.Value=value;
                           if(!this.Add(data))
                             {
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                              delete data;
                              res &=false;
                              continue;
                             }
                          }
                        return res;
                       }
public:
//--- Initialize the array
   void              Initialize(const int total,const double value=0)
                       {
                        this.Clear();
                        this.Increase(total,value);
                       }
//--- Increase the number of data cells by the specified value, return the number of added elements
   int               Increase(const int total,const double value=0)
                       {
                        int size_prev=this.Total();
                        this.AddQuantity(DFUN,total,value);
                        return this.Total()-size_prev;
                       }
//--- Decrease the number of data cells by the specified value, return the number of removed elements. The very first element always remains
   int               Decrease(const int total)
                       {
                        if(total>this.Total()-1)
                           return 0;
                        int total_prev=this.Total();
                        int from=this.Total()-total;
                        int to=this.Total()-1;
                        if(!this.DeleteRange(from,to))
                           CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_DECREASE_DOUBLE_ARRAY);
                        return total_prev-this.Total();
                       }
//--- Set a new array size
   bool              SetSize(const int size,const double initial_value=0)
                       {
                        if(size==0)
                           return false;
                        int total=fabs(size-this.Total());
                        if(size>this.Total())
                           return(this.Increase(total,initial_value)==total);
                        else if(size<this.Total())
                           return(this.Decrease(total)==total);
                        return true;
                       }
//--- Set the value to the specified array cell
   bool              Set(const int index,const double value)
                       {
                        CDataUnitDouble *data=this.GetData(DFUN,index);
                        if(data==NULL)
                           return false;
                        data.Value=value;
                        return true;
                       }
//--- Return the amount of data (array size)
   int               Size(void) const { return this.Total(); }
   
//--- Returns the value at the specified index
   double            Get(const int index) const
                       {
                        CDataUnitDouble *data=this.GetData(DFUN,index);
                        return(data!=NULL ? data.Value : 0);
                       }
   bool              Get(const int index, double &value) const
                       {
                        value=0;
                        CDataUnitDouble *data=this.GetData(DFUN,index);
                        if(data==NULL)
                           return false;
                        value = data.Value;
                        return true;
                       }
//--- Constructors
                     CDimDouble(void)                                { this.Initialize(1);            }
                     CDimDouble(const int total,const double value=0){ this.Initialize(total,value);  }
//--- Destructor
                    ~CDimDouble(void)
                       {
                        this.Clear();
                        this.Shutdown();
                       }
  };
//+------------------------------------------------------------------+
//| Dynamic multidimensional double array class                      |
//+------------------------------------------------------------------+
class CXDimArrayDouble : public CArrayObj
  {
private:
//--- Return the data array from the first dimensionality
   CDimDouble       *GetDim(const string source,const int index) const
                       {
                        CDimDouble *dim=this.At(index<0 ? 0 : index);
                        if(dim==NULL)
                          {
                           if(index>this.Total()-1)
                              ::Print(source,CMessage::Text(MSG_LIB_SYS_REQUEST_OUTSIDE_DOUBLE_ARRAY)," (",index,"/",this.Total(),")");
                           else
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_GET_DOUBLE_DATA_OBJ);
                          }
                        return dim;
                       }
//--- Add a new dimension to the first dimensionality
   bool              AddNewDim(const string source,const int size,const double initial_value=0)
                       {
                        CDimDouble *dim=new CDimDouble(size,initial_value);
                        if(dim==NULL)
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_CREATE_DOUBLE_DATA_OBJ);
                           return false;
                          }
                        if(!this.Add(dim))
                          {
                           delete dim;
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                           return false;
                          }
                        return true;
                       }
public:
//--- Increase the number of data cells by the specified 'total' value in the first dimensionality,
//--- return the number of added elements to the dimensionality. Added cells' size is 'size'
   int               IncreaseRangeFirst(const int total,const int size,const long initial_value=0)
                       {
                        int total_prev=this.Total();
                        for(int i=0;i<total;i++)
                           this.AddNewDim(DFUN,size,initial_value);
                        return(this.Total()-total_prev);
                       }
//--- Increase the number of data cells by the specified 'total' value in the specified 'range' dimensionality,
//--- return the number of added elements to the changed dimensionality
   int               IncreaseRange(const int range,const int total,const double initial_value=0)
                       {
                        CDimDouble *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.Increase(total,initial_value) : 0);
                       }
//--- Decrease the number of cells with data in the first dimensionality by the specified value,
//--- return the number of removed elements. The very first element always remains
   int               DecreaseRangeFirst(const int total)
                       {
                        if(total>this.Total()-1)
                           return 0;
                        int total_prev=this.Total();
                        int from=this.Total()-total;
                        int to=this.Total()-1;
                        if(!this.DeleteRange(from,to))
                           CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_DECREASE_DOUBLE_ARRAY);
                        return total_prev-this.Total();
                       }                      
//--- Decrease the number of data cells by the specified value in the specified dimensionality,
//--- return the number of removed elements. The very first element always remains
   int               DecreaseRange(const int range,const int total)
                       {
                        CDimDouble *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.Decrease(total) : 0);
                       }
//--- Set the new array size in the specified dimensionality
   bool              SetSizeRange(const int range,const int size,const double initial_value=0)
                       {
                        CDimDouble *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.SetSize(size,initial_value) : false);
                       }
//--- Set the value to the specified array cell of the specified dimension
   bool              Set(const int index,const int range,const double value)
                       {
                        CDimDouble *dim=this.GetDim(DFUN,index);
                        return(dim!=NULL ? dim.Set(range,value) : false);
                       }
//--- Return the value at the specified index of the specified dimension
   double            Get(const int index,const int range) const
                       {
                        CDimDouble *dim=this.GetDim(DFUN,index);
                        return(dim!=NULL ? dim.Get(range) : 0);
                       }
   bool              Get(const int index,const int range,double &value) const
                       {
                        CDimDouble *dim=this.GetDim(DFUN,index);
                        return(dim!=NULL ? dim.Get(range,value) : false);
                       }
//--- Return the amount of data (size of the specified dimension array)
   int               Size(const int range) const
                       {
                        CDimDouble *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.Size() : 0);
                       }
//--- Return the total amount of data (the total size of all dimensions)
   int               Size(void) const
                       {
                        int size=0;
                        for(int i=0;i<this.Total();i++)
                          {
                           CDimDouble *dim=this.GetDim(DFUN,i);
                           if(dim==NULL)
                              continue;
                           size+=dim.Size();
                          }
                        return size;
                       }
//--- Constructor
                     CXDimArrayDouble()
                       {
                        this.Clear();
                        this.Add(new CDimDouble(1));
                       }
                     CXDimArrayDouble(int first_dim_size,const int dim_size,const double initial_value=0)
                       {
                        this.Clear();
                        int total=(first_dim_size<1 ? 1 : first_dim_size);
                        for(int i=0;i<total;i++)
                           this.Add(new CDimDouble(dim_size,initial_value));
                       }
//--- Destructor
                    ~CXDimArrayDouble()
                       {
                        this.Clear();
                        this.Shutdown();
                       }
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| String data unit class                                           |
//+------------------------------------------------------------------+
class CDataUnitString : public CDataUnit
  {
public:
   string            Value;
                     CDataUnitString() : CDataUnit(OBJECT_DE_TYPE_STRING){}
  };
//+------------------------------------------------------------------+
//| Class of a single string array dimension                         |
//+------------------------------------------------------------------+
class CDimString : public CArrayObj
  {
private:
//--- Create a new data object
   CDataUnitString  *CreateData(const string source,const string value="")
                       {
                        CDataUnitString *data=new CDataUnitString();
                        if(data==NULL)
                           ::Print(source,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_STRING_DATA_OBJ));
                        else
                           data.Value=value;
                        return data;
                       }
//--- Get string data object from the array
   CDataUnitString  *GetData(const string source,const int index) const
                       {
                        CDataUnitString *data=this.At(index<0 ? 0 : index);
                        if(data==NULL)
                          {
                           if(index>this.Total()-1)
                              ::Print(source,CMessage::Text(MSG_LIB_SYS_REQUEST_OUTSIDE_STRING_ARRAY)," (",index,"/",this.Total(),")");
                           else
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_GET_STRING_DATA_OBJ);
                          }
                        return data;
                       }
//--- Add the specified number of cells with data to the end of the array
   bool              AddQuantity(const string source,const int total,const string value="")
                       {
                        bool res=true;
                        for(int i=0;i<total;i++)
                          {
                           CDataUnitString *data=this.CreateData(DFUN,value);
                           if(data==NULL)
                             {
                              res &=false;
                              continue;
                             }
                           data.Value=value;
                           if(!this.Add(data))
                             {
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                              delete data;
                              res &=false;
                              continue;
                             }
                          }
                        return res;
                       }
public:
//--- Initialize the array
   void              Initialize(const int total,const string value="")
                       {
                        this.Clear();
                        this.Increase(total,value);
                       }
//--- Increase the number of data cells by the specified value, return the number of added elements
   int               Increase(const int total,const string value="")
                       {
                        int size_prev=this.Total();
                        this.AddQuantity(DFUN,total,value);
                        return this.Total()-size_prev;
                       }
//--- Decrease the number of data cells by the specified value, return the number of removed elements. The very first element always remains
   int               Decrease(const int total)
                       {
                        if(total>this.Total()-1)
                           return 0;
                        int total_prev=this.Total();
                        int from=this.Total()-total;
                        int to=this.Total()-1;
                        if(!this.DeleteRange(from,to))
                           CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_DECREASE_STRING_ARRAY);
                        return total_prev-this.Total();
                       }
//--- Set a new array size
   bool              SetSize(const int size,const string initial_value="")
                       {
                        if(size==0)
                           return false;
                        int total=fabs(size-this.Total());
                        if(size>this.Total())
                           return(this.Increase(total,initial_value)==total);
                        else if(size<this.Total())
                           return(this.Decrease(total)==total);
                        return true;
                       }
//--- Set the value to the specified array cell
   bool              Set(const int index,const string value)
                       {
                        CDataUnitString *data=this.GetData(DFUN,index);
                        if(data==NULL)
                           return false;
                        data.Value=value;
                        return true;
                       }
//--- Return the amount of data (array size)
   int               Size(void) const { return this.Total(); }
   
//--- Returns the value at the specified index
   string            Get(const int index)
                       {
                        CDataUnitString *data=this.GetData(DFUN,index);
                        return(data!=NULL ? data.Value : "");
                       }
   bool              Get(const int index, string &value)
                       {
                        value="";
                        CDataUnitString *data=this.GetData(DFUN,index);
                        if(data==NULL)
                           return false;
                        value = data.Value;
                        return true;
                       }
//--- Constructors
                     CDimString(void)                                   { this.Initialize(1);            }
                     CDimString(const int total,const string value="")  { this.Initialize(total,value);  }
//--- Destructor
                    ~CDimString(void)
                       {
                        this.Clear();
                        this.Shutdown();
                       }
  };
//+------------------------------------------------------------------+
//| Dynamic multidimensional string array class                      |
//+------------------------------------------------------------------+
class CXDimArrayString : public CArrayObj
  {
private:
//--- Return the data array from the first dimensionality
   CDimString       *GetDim(const string source,const int index) const
                       {
                        CDimString *dim=this.At(index<0 ? 0 : index);
                        if(dim==NULL)
                          {
                           if(index>this.Total()-1)
                              ::Print(source,CMessage::Text(MSG_LIB_SYS_REQUEST_OUTSIDE_STRING_ARRAY)," (",index,"/",this.Total(),")");
                           else
                              CMessage::ToLog(source,MSG_LIB_SYS_FAILED_GET_STRING_DATA_OBJ);
                          }
                        return dim;
                       }
//--- Add a new dimension to the first dimensionality
   bool              AddNewDim(const string source,const int size,const string initial_value="")
                       {
                        CDimString *dim=new CDimString(size,initial_value);
                        if(dim==NULL)
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_CREATE_STRING_DATA_OBJ);
                           return false;
                          }
                        if(!this.Add(dim))
                          {
                           delete dim;
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                           return false;
                          }
                        return true;
                       }
public:
//--- Increase the number of data cells by the specified 'total' value in the first dimensionality,
//--- return the number of added elements to the dimensionality. Added cells' size is 'size'
   int               IncreaseRangeFirst(const int total,const int size,const string initial_value="")
                       {
                        int total_prev=this.Total();
                        for(int i=0;i<total;i++)
                           this.AddNewDim(DFUN,size,initial_value);
                        return(this.Total()-total_prev);
                       }
//--- Increase the number of data cells by the specified 'total' value in the specified 'range' dimensionality,
//--- return the number of added elements to the changed dimensionality
   int               IncreaseRange(const int range,const int total,const string initial_value="")
                       {
                        CDimString *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.Increase(total,initial_value) : 0);
                       }
//--- Decrease the number of cells with data in the first dimensionality by the specified value,
//--- return the number of removed elements. The very first element always remains
   int               DecreaseRangeFirst(const int total)
                       {
                        if(total>this.Total()-1)
                           return 0;
                        int total_prev=this.Total();
                        int from=this.Total()-total;
                        int to=this.Total()-1;
                        if(!this.DeleteRange(from,to))
                           CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_DECREASE_STRING_ARRAY);
                        return total_prev-this.Total();
                       }                      
//--- Decrease the number of data cells by the specified value in the specified dimensionality,
//--- return the number of removed elements. The very first element always remains
   int               DecreaseRange(const int range,const int total)
                       {
                        CDimString *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.Decrease(total) : 0);
                       }
//--- Set the new array size in the specified dimensionality
   bool              SetSizeRange(const int range,const int size,const string initial_value="")
                       {
                        CDimString *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.SetSize(size,initial_value) : false);
                       }
//--- Set the value to the specified array cell of the specified dimension
   bool              Set(const int index,const int range,const string value)
                       {
                        CDimString *dim=this.GetDim(DFUN,index);
                        return(dim!=NULL ? dim.Set(range,value) : false);
                       }
//--- Return the value at the specified index of the specified dimension
   string            Get(const int index,const int range) const
                       {
                        CDimString *dim=this.GetDim(DFUN,index);
                        return(dim!=NULL ? dim.Get(range) : "");
                       }
   bool              Get(const int index,const int range, string &value) const
                       {
                        CDimString *dim=this.GetDim(DFUN,index);
                        return(dim!=NULL ? dim.Get(range,value) : false);
                       }
//--- Return the amount of data (size of the specified dimension array)
   int               Size(const int range) const
                       {
                        CDimString *dim=this.GetDim(DFUN,range);
                        return(dim!=NULL ? dim.Size() : 0);
                       }
//--- Return the total amount of data (the total size of all dimensions)
   int               Size(void) const
                       {
                        int size=0;
                        for(int i=0;i<this.Total();i++)
                          {
                           CDimString *dim=this.GetDim(DFUN,i);
                           if(dim==NULL)
                              continue;
                           size+=dim.Size();
                          }
                        return size;
                       }
//--- Constructor
                     CXDimArrayString()
                       {
                        this.Clear();
                        this.Add(new CDimString(1));
                       }
                     CXDimArrayString(int first_dim_size,const int dim_size,const string initial_value="")
                       {
                        this.Clear();
                        int total=(first_dim_size<1 ? 1 : first_dim_size);
                        for(int i=0;i<total;i++)
                           this.Add(new CDimString(dim_size,initial_value));
                       }
//--- Destructor
                    ~CXDimArrayString()
                       {
                        this.Clear();
                        this.Shutdown();
                       }
  };
//+------------------------------------------------------------------+
