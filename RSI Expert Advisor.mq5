#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade/Trade.mqh>


CTrade trade;
int rsiHandle;
ulong posTicket;

int OnInit()
  {
  
   
   
    rsiHandle= iRSI(_Symbol,PERIOD_CURRENT,14,PRICE_CLOSE);
   
   

   return 0;
  }


void OnDeinit(const int reason)
  {
  
  

   
  }


void OnTick()
  {
   double rsi[];
   CopyBuffer(rsiHandle,0,1,1,rsi);
   
   if(rsi[0]>55 && rsi[0]<70){
     
      if (posTicket<=0){
      trade.Sell(0.01,_Symbol);
      posTicket = trade.ResultOrder();
      }
      
      }else if(rsi[0]>70){
   
     if(posTicket<=0){
     trade.Buy(0.01,_Symbol);
     posTicket = trade.ResultOrder();
       
   }
      
      }
   if(rsi[0]>25 && rsi[0]<40){
     
     if(posTicket<=0){
     trade.Buy(0.01,_Symbol);
     posTicket = trade.ResultOrder();
     
     }
     
     }else if(rsi[0]<25){
     
     if(posTicket<=0){
     trade.Sell(0.01,_Symbol);
     posTicket = trade.ResultOrder();
       
   }
   }
   
   if(PositionSelectByTicket(posTicket)){
      double posPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      double posSl = PositionGetDouble(POSITION_SL);
      double posTp = PositionGetDouble(POSITION_TP);
      int posType = (int)PositionGetInteger(POSITION_TYPE);
      
      if(posType == POSITION_TYPE_BUY){
      if(posSl == 0){
         double sl = posPrice - 0.00150;
         double tp = posPrice + 0.00450;
         trade.PositionModify(posTicket,sl,tp);
      
      
      }
      
      }else if (posType == POSITION_TYPE_SELL){
      if(posSl == 0){
         double sl = posPrice + 0.00150;
         double tp = posPrice - 0.00450;
         trade.PositionModify(posTicket,sl,tp);
      
      
      }
      
      
      
   }
   
  }else{
    posTicket = 0;
  }
  
  Comment(rsi[0],"\n",posTicket);
   }
  