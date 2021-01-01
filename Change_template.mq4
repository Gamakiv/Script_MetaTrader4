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

//Для выбора таймфрейма
input ENUM_TIMEFRAMES  SetTimeFrame = PERIOD_H4;        // SetTimeframe


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


//Установить таймфрем
//+------------------------------------------------------------------+
//| Функция смены таймфрейма                                               |
//+------------------------------------------------------------------+
void fChangePeriod(int nPeriod)
{
   int hWnd, wParam;
   
   switch(nPeriod)
   {
      case PERIOD_M1:  wParam = 33137; break;
      case PERIOD_M5:  wParam = 33138; break;
      case PERIOD_M15: wParam = 33139; break;
      case PERIOD_M30: wParam = 33140; break;
      case PERIOD_H1:  wParam = 33135; break;
      case PERIOD_H4:  wParam = 33136; break;
      case PERIOD_D1:  wParam = 33134; break;
      case PERIOD_W1:  wParam = 33141; break;
      case PERIOD_MN1: wParam = 33334; break;
   }
	
   hWnd = WindowHandle(Symbol(),Period());
	
   PostMessageA(hWnd,WM_COMMAND,wParam,0);
}


void OnStart(){
   long curr = ChartFirst();      

   while(curr != -1)
      {
         ChartApplyTemplate(curr, tpl);         
         ChartAutoscrollSet(SetAutoScrooll, curr);
         fChangePeriod(SetTimeFrame);
         curr = ChartNext(curr);
      }
      
   }
//+------------------------------------------------------------------+
