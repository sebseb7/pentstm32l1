#include "main.h"
#include "arm_math.h" 

/*
 *	boot loader: http://www.st.com/stonline/stappl/st/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/APPLICATION_NOTE/CD00167594.pdf (page 31)
 *
 *
 *
 */

static __IO uint32_t TimingDelay;
static __IO uint32_t tick;
void Delay(__IO uint32_t nTime)
{
	TimingDelay = nTime*10;

	while(TimingDelay != 0);
}

void TimingDelay_Decrement(void)
{
	if (TimingDelay != 0x00)
	{ 
		TimingDelay--;
	}
	tick++;
}



int main(void)
{
	RCC_ClocksTypeDef RCC_Clocks;



	RCC_GetClocksFreq(&RCC_Clocks);
	/* SysTick end of count event each 0.1ms */
	SysTick_Config(RCC_Clocks.HCLK_Frequency / 10000);




	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;

	GPIOB->MODER  |=    0x01<<(2*12) ; 
	GPIOB->MODER  |=    0x01<<(2*13) ; 

	
	while(1)
	{
		GPIOB->ODR           |=       1<<12;
		GPIOB->ODR           &=       ~(1<<13);
		Delay(1000);
		GPIOB->ODR           &=       ~(1<<12);
		GPIOB->ODR           |=       1<<13;
		Delay(1000);
	}

}
