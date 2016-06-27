packetXBee* paq_sent;
 int8_t state=0;
 long previous=0;
 char*  data="HELLO WORLD!!";
 int g=0;
 int RSSI1_2=25;
 int RSSI2_4=26;
 int RSSI1_4=52;
 int RSSI1_3=27;
 int RSSI3_4=26;
 
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
  // Set params to send
  paq_sent=(packetXBee*) calloc(1,sizeof(packetXBee)); 
  paq_sent->mode=UNICAST;
  paq_sent->MY_known=0;
  paq_sent->packetID=0x52;
  paq_sent->opt=0; 
  xbee802.hops=0;
  xbee802.setOriginParams(paq_sent, "5678", MY_TYPE);
  if(((RSSI1_2+RSSI2_4)<(RSSI1_4))&&((RSSI1_2+RSSI2_4)<(RSSI1_3+RSSI3_4)))
 { xbee802.setDestinationParams(paq_sent, "0013A200405C5305", data, MAC_TYPE, DATA_ABSOLUTE);}
 else if(((RSSI1_3+RSSI3_4)<(RSSI1_2+RSSI2_4))&&((RSSI1_3+RSSI3_4)<(RSSI1_4)))
 { xbee802.setDestinationParams(paq_sent, "0013A200405C5304", data, MAC_TYPE, DATA_ABSOLUTE);}
  else 
 { xbee802.setDestinationParams(paq_sent, "0013A200405243A7", data, MAC_TYPE, DATA_ABSOLUTE);}
  xbee802.sendXBee(paq_sent);
  if( !xbee802.error_TX )
  {
    XBee.println("ok");
  }
  free(paq_sent);
  paq_sent=NULL;
  
 

  delay(5000);
}

