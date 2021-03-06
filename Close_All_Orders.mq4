//+------------------------------------------------------------------+
//|                                                      Strelka.mq4 |
//|                                          Copyright 2020, GamaKiv |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, GamaKiv"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "Закрывает ордера Buy и Sell на всех графиках!" 
#property strict

#include <WinUser32.mqh>

void start()
{
   string title="flapper ORDER";
   string msg="Close all order BUY и SELL ???";
   if (MessageBox(msg,title,MB_YESNO|MB_ICONQUESTION)!=IDYES) return;
   int slippage=2;
   for (int i=OrdersTotal()-1; i>=0; i--)
   {
      if (!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) break;
      if (OrderType()==OP_BUY ) OrderClose (OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),slippage);
      if (OrderType()==OP_SELL) OrderClose (OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),slippage);
   }
}

