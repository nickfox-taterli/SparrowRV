#ifndef SYSTEM_H_
#define SYSTEM_H_

#include <stdint.h>
//#include <stdio.h>
#include "utils.h"
#include "trap.h"
#include "xprintf.h"
#include "uart.h"
#include "spi.h"
#include "fpioa.h"
#include "gpio.h"

#include "nor25_flash.h"
//系统主频
#define CPU_FREQ_HZ   24000000UL
#define CPU_FREQ_MHZ  (CPU_FREQ_HZ/1000000UL)

#define ENABLE 1
#define DISABLE 0

//自定义CSR
#define msprint    0x346  //仿真打印
#define mends      0x347  //仿真结束
#define minstret   0xB02  //minstret低32位
#define minstreth  0xB82  //minstret高32位
#define mtime      0xB03  //mtime低32位
#define mtimeh     0xB83  //mtime高32位
#define mtimecmp   0xB04  //mtimecmp低32位
#define mtimecmph  0xB84  //mtimecmp高32位
#define mcctr      0xB88  //系统控制
//[0]:保留
//[1]:minstret使能
//[2]:mtime使能
//[3]:soft_rst写1复位
//[4]:从bootrom 0 / appram 1 取指

#define SYS_RWMEM_W(addr) (*((volatile uint32_t *)(addr)))   //必须4字节对齐访问(低2位为0)
#define SYS_RWMEM_B(addr) (*((volatile uint8_t  *)(addr)))   //允许访问4G地址空间任意字节，但是部分外设不支持字节寻址写

#endif
