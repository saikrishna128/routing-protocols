packetXBee* paq_sent;
long previous=0;
int8_t state=0;
int g=0;
char* send2="asjkjkjkklAKSLKLLDKKSDKVGSVHAGHGDJHJADHKJAKJDAKJKDJKDAJKLKJLKKADLK";
uint8_t  PANID[2]={0x12,0x34};

void setup()
{
  // Inits the XBee 802.15.4 library
  xbee802.init(XBEE_802_15_4,FREQ2_4G,NORMAL);

  // Powers XBee
  xbee802.ON();
}
void loop()
{

  previous=millis();
  while( (millis()-previous) < 20000 )
  {
    if( XBee.available() )
    { 
      xbee802.treatData();
      if( !xbee802.error_RX )
      {
        // Writing the parameters of the packet received
        while(xbee802.pos>0)
        {
          
          XBee.print("Network Address Origin: ");          
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naO[0],HEX);
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naO[1],HEX);
          XBee.println("");
          XBee.print("MAC Address Origin: ");          
          for(int d=0;d<4;d++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macOH[d],HEX);
          }
          for(int e=0;e<4;e++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macOL[e],HEX);
          }
          XBee.println("");
          XBee.print("RSSI: ");                    
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->RSSI,HEX);
          XBee.println("");         
          XBee.print("Data: ");                    
          for(int f=0;f<xbee802.packet_finished[xbee802.pos-1]->data_length;f++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->data[f],BYTE);
          }
          strcpy(send2,xbee802.packet_finished[xbee802.pos-1]->data);
          XBee.println("");
          XBee.print("PacketID: ");                    
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->packetID,HEX);
          XBee.println("");      
          XBee.print("Type Source ID: ");                              
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->typeSourceID,HEX);
          XBee.println("");     
          XBee.print("Network Identifier Origin: ");          
          while( xbee802.packet_finished[xbee802.pos-1]->niO[g]!='#' )
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->niO[g],BYTE);
            g++;
          }
          g=0;
          XBee.println("");
         
          paq_sent=(packetXBee*) calloc(1,sizeof(packetXBee)); 
  paq_sent->mode=BROADCAST;
  paq_sent->MY_known=0;
  paq_sent->packetID=0x52;
  paq_sent->opt=0; 
  xbee802.hops=0;
  xbee802.setOriginParams(paq_sent, "5679", MY_TYPE);
  xbee802.setDestinationParams(paq_sent, "0013A200405242F4",send2, MAC_TYPE, DATA_ABSOLUTE);
  xbee802.sendXBee(paq_sent);
  if( !xbee802.error_TX )
  {
    XBee.println("ok");
  }
  else
  { XBee.println("error");}
  free(paq_sent);
  paq_sent=NULL;
  
 

 
          
           delay(5000);
        }

previous=millis();
}
else 
{
  XBee.println("error");
  XBee.println(xbee802.error_RX);
}

}
}

delay(5000);


}

