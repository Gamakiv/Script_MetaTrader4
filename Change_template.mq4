//+------------------------------------------------------------------+
//|                                                     ChangeTF.mq4 |
//|                                              jce (jce@yandex.ru) |
//|                                           http://pavel.viroma.ru |
//+------------------------------------------------------------------+
#property copyright "jce (jce@yandex.ru)"
#property link      "http://pavel.viroma.ru"
#property version   "1.01"
#property strict
#property script_show_inputs

#include <WinUser32.mqh>

extern string tpl = "default.tpl";
extern bool SetAutoScrooll = false;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+  

//Отключить автопрокрутку
bool ChartAutoscrollSet(const bool value,const long chart_ID=0)
  {

   ResetLastError();
   
//--- установим значение свойства
   if(!ChartSetInteger(chart_ID,CHART_AUTOSCROLL,0,value))
     {      
      Print(__FUNCTION__+", Error Code = ",GetLastError());
      return(false);
     }
   
   return(true);
  }


void OnStart(){
   long curr = ChartFirst();      

   while(curr != -1)
      {
         ChartApplyTemplate(curr, tpl);         
         ChartAutoscrollSet(SetAutoScrooll, curr);
         curr = ChartNext(curr);
      }
      
   }
//+------------------------------------------------------------------+
