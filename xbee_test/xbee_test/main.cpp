/*
 * xbee_test.cpp
 *
 * Created: 10/24/2017 5:11:44 PM
 * Author : MizzouRacing
 */ 

#include <avr/io.h>
#include "Telemetry.h"
#include <string.h>


int main(void)
{		
	
	sys_init();
	DDRE |= (1<<DDE6);
	xbee = XBee();
		
	// Specify the address of the remote XBee (this is the SH + SL)
	//This value is a constant for this application
	addr64 = XBeeAddress64(0x0, BROADCAST_ADDRESS);

		// Create a TX Request
		//ZBTxRequest zbTx = ZBTxRequest(addr64, datum_buff, sizeof(datum_buff));
	packet.id = 0;
	packet.counter = 0;
	
	byte_ptr = (U8 *)&packet;
		
		datum.dlc = EIGHT_BYTE;
    while( can_cmd(&datum) != CAN_CMD_ACCEPTED );
	
    while (1) 
    {	//while( can_cmd(&datum) != CAN_CMD_ACCEPTED );
		//while( can_cmd(&output) != CAN_CMD_ACCEPTED );
		//while( can_get_status(&datum) != CAN_STATUS_COMPLETED);
		packet.id = datum.id.ext;
		memcpy(packet.datums, datum_buff, 8);
		packet.counter++;
		// Send your request
		//ZBTxRequest zbTx = ZBTxRequest(addr64, byte_ptr, sizeof(packet));
		//xbee.send(zbTx);
		//
		_delay_ms(10);
    }
}


void sys_init(){
	wdt_disable();
	Disable_interrupt();
	
	
	/*Initialize currently used can bus messages */
	//init message as rx
	datum.pt_data = &datum_buff[0];//point msg data pointer to data buffer
	datum.dlc = EIGHT_BYTE;				//all IMU vals are 6bytes + 1 byte compound address
	datum.cmd = CMD_RX;
	
	output.pt_data = datum_buff;
	output.dlc = EIGHT_BYTE;
	output.cmd = CMD_TX;
	output.ctrl.ide = 0;
	output.id.std = 0x70;
	
	loop_count = 0;
	
	/*
	Peripheral initialization section
	*/
	
	uart_init(CONF_8BIT_NOPAR_1STOP, 0);
	
	Can_reset();
	ret_code = can_init(0);	//init can bus
	while(ret_code == 0)
	{
		ret_code = can_init(1);
		++loop_count;
		if( loop_count >= CAN_ERROR_THRESHOLD ) soft_reset();
	}
	
	setbit(CANGIE, ENIT);
	setbit(CANGIE, ENRX);
	clearbit(CANGIE, ENTX);
	CANIE = 0xFFFF;
	
	//start the system timer

	Enable_interrupt();
}

ISR( CANIT_vect){
	Disable_interrupt();
	
	PORTE ^= (1 << PE6);
	save_canpage =  CANPAGE;
	
	mob = can_getMOBInterrupt();
	
	if( mob == NOMOB){
		Enable_interrupt();
		return;
	}
	
	CANPAGE = mob << 4;
		
	/*
	* Check the extended ID bit in the Control register
	* A 1 in this bit indicates message being processsed has
	* an extended ID
	*/
	if(Can_get_ide())
	{
		Can_get_ext_id(packet.id);
	}
	else{
		Can_get_std_id(packet.id);
	}
	
	can_get_data(packet.datums);
	
	
#ifdef API_MODE
	
	ZBTxRequest zbTx = ZBTxRequest(addr64, byte_ptr, sizeof(packet));
	xbee.send(zbTx);
	
	_delay_ms(10);
	
#else
	uart_mini_printf()
#endif

	
	save_reg = CANSTMOB;
	CANSTMOB=0;		// reset INT reason
	setbit(CANCDMOB, IDE);
	Can_set_dlc(EIGHT_BYTE);
	Can_clear_rtrmsk();
	Can_clear_idemsk();
	Can_config_rx();
	
	
	CANPAGE = save_canpage;
	PORTE = (0 << PE6);
	Enable_interrupt();
	
}

// Overflow of CAN timer
ISR(OVRIT_vect) {}

//////////////////////////////////////////////////////////////////////////////////
//																				//
// Funktion:		CAN_getMOBInterrupt()										//
//																				//
// Parameter:																	//
//																				//
// Rückgabe:		uint8_t mob		- Nummer des Objekts das den Interrupt		//
//										ausgelöst hat							//
//																				//
// Beschreibung: 	Diese Funktion ermittelt, welches Objekt einen Interrupt	//
//					ausgelöst hat.												//
//																				//
//////////////////////////////////////////////////////////////////////////////////
uint8_t can_getMOBInterrupt(){
	
	uint8_t 	mob;
	uint16_t	maske;
	maske		= CANSIT2 | (CANSIT1 << 8);

	// Wenn alle 32 Bit der Bitmaske 0 sind dann ist ein Fehler aufgetreten
	if(maske == 0){
		return NOMOB;
	}

	// Die Bitmaske wird so lange nach rechts geschoben, bis Bit0 eine 1 hat.
	// Die Anzahl der Schiebeoperatoren gibt somit die Nummer
	// Des MOBs zurück
	for( mob=0; (maske & 0x01)==0; maske >>= 1, ++mob);

	// Kontrolle: Wenn mob größer als die Anzahl der verfügbaren
	// Message Objects ist das Ergebnis falsch
	if ( mob > 14 ){
		return NOMOB;
		}else{
		return mob;
	}
}