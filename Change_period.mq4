//+------------------------------------------------------------------+
//|                                                     ChangeTF.mq4 |
//|                                              jce (jce@yandex.ru) |
//|                                           http://pavel.viroma.ru |
//+------------------------------------------------------------------+
#property copyright "jce (jce@yandex.ru)"
#property link      "http://pavel.viroma.ru"
#property version   "1.00"
#property strict
#property script_show_inputs

#include <WinUser32.mqh>
extern string tf = "60 - H1, 240 - H4, 1440 - D1";
extern int period = 60;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart(){
   long curr = ChartFirst();      

   while(curr != -1)
      {
         fChangePeriod(period, ChartSymbol(curr));
         curr = ChartNext(curr);
      }
}
//+------------------------------------------------------------------+

void fChangePeriod(int nPeriod, string sym){
    int hWnd, wParam;
    
    switch(nPeriod)
      {
       case PERIOD_M1:   wParam = 33137; break;
       case PERIOD_M5:   wParam = 33138; break;
       case PERIOD_M15:  wParam = 33139; break;
       case PERIOD_M30:  wParam = 33140; break;
       case PERIOD_H1:   wParam = 33135; break;
       case PERIOD_H4:   wParam = 33136; break;
       case PERIOD_D1:   wParam = 33134; break;
       case PERIOD_W1:   wParam = 33141; break;
       case PERIOD_MN1:  wParam = 33334; break;
      }
      
      hWnd = WindowHandle(sym, Period());
      
      PostMessageA(hWnd, WM_COMMAND, wParam, 0);
}

//+------------------------------------------------------------------+