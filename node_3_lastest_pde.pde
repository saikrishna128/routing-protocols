/*
 *  ------Waspmote XBee 802.15.4 Sending & Receiving Example------
 *
 *  Explanation: This example shows how to send and receive packets
 *  using Waspmote XBee 802.15.4 API
 *
 *  This code sends a packet to another node and waits for an answer from
 *  it. When the answer is received it is shown.
 *
 *  Copyright (C) 2009 Libelium Comunicaciones Distribuidas S.L.
 *  http://www.libelium.com
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 * 
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  Version:                0.2
 *  Design:                 David Gascón
 *  Implementation:    Alberto Bielsa
 */
 
 packetXBee* paq_sent;
 int8_t state=0;
 long previous=0;
 
 int g=0;
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
  
  
  // Waiting the answer
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
          XBee.print("Network Address Source: ");
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naS[0],HEX);
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->naS[1],HEX);
          XBee.println("");
          XBee.print("MAC Address Source: ");          
          for(int b=0;b<4;b++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macSH[b],HEX);
          }
          for(int c=0;c<4;c++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->macSL[c],HEX);
          }
          XBee.println("");
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
          XBee.print("16B(0) or 64B(1): ");                    
          XBee.print(xbee802.packet_finished[xbee802.pos-1]->mode,HEX);
          XBee.println("");
          XBee.print("Data: ");                    
          for(int f=0;f<xbee802.packet_finished[xbee802.pos-1]->data_length;f++)
          {
            XBee.print(xbee802.packet_finished[xbee802.pos-1]->data[f],BYTE);
          }
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
          free(xbee802.packet_finished[xbee802.pos-1]);
          xbee802.packet_finished[xbee802.pos-1]=NULL;
          xbee802.pos--;
        }
        previous=millis();
      }
      else { XBee.println("error");}
    }
  }

  delay(1000);
}


