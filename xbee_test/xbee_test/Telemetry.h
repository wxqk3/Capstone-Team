/*
 * Telemetry.h
 *
 * Created: 10/24/2017 5:13:39 PM
 *  Author: MizzouRacing
 */ 


#ifndef TELEMETRY_H_
#define TELEMETRY_H_

#include "XBee.h"
#include "config.h"
#include "compiler.h"
#include "at90can_drv.h"

#include <util/delay.h>
#include <avr/wdt.h>

extern "C" {
	#include "uart/uart_lib.h"
	#include "timer/timer16_drv.h"
	#include "timer/timer8_drv.h"
	#include "millis/millis.h"
	#include "can/can_lib.h"
	#include "can/can_drv.h"

	
	/*c++ is dumb, I shouldn't have to do this: 
	restrict g++ from mangling function names
	*/
	#include "uart/uart_lib.c"
	#include "timer/timer16_drv.c"
	#include "timer/timer8_drv.c"
	#include "millis/millis.c"
	#include "can/can_lib.c"
	#include "can/can_drv.c"

}


/*
* Can Structure Settings Constants
*/
#define EXTENDED_ID 1
#define STND_ID		0
#define RTR_REQUEST	1
#define NO_RTR		0

/*
* CAN interrupt handling constants
*/
#define NOMOB		0xff	

enum data_length
{
	ONE_BYTE = 1,
	TWO_BYTE,
	THREE_BYTE,
	FOUR_BYTE,
	FIVE_BYTE,
	SIX_BYTE,
	SEVEN_BYTE,
	EIGHT_BYTE
};


#define CAN_ERROR_THRESHOLD 90

/* Bitebene */
#define 	setbit(ADR,BIT)		(ADR|=(1<<BIT))			// Makro zum Setzen von Bits
#define 	clearbit(ADR,BIT)	(ADR&=~(1<<BIT))		// Makro zum Löschen von Bits
#define 	getbit(ADR, BIT)	(ADR & (1<<BIT))		// Makro zum Abfragen eines Bits


struct xbee_datum{
	uint32_t id;
	U8 datums[8];
	};

//_____ D E C L A R A T I O N S ________________________________________________


st_cmd_t datum, output;
U8 datum_buff[8];
int ret_code, loop_count;

unsigned char save_reg;
unsigned char save_canpage;
unsigned char mob;
uint32_t	  id;

xbee_datum		packet;
XBeeAddress64	addr64;
XBee			xbee;
U8				*byte_ptr;		//byte poiners are an awful thing

static void sys_init();
static uint8_t can_getMOBInterrupt();


#endif /* TELEMETRY_H_ */