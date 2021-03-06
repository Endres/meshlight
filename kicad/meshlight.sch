EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:LED DB2
U 1 1 5E2D2F54
P 9100 2200
F 0 "DB2" V 9139 2082 50  0000 R CNN
F 1 "LED" V 9048 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 9100 2200 50  0001 C CNN
F 3 "~" H 9100 2200 50  0001 C CNN
	1    9100 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9100 2350 9100 2600
Wire Wire Line
	9100 1950 9100 2050
$Comp
L power:+7.5V #PWR019
U 1 1 5E2D2F69
P 10400 1450
F 0 "#PWR019" H 10400 1300 50  0001 C CNN
F 1 "+7.5V" H 10415 1623 50  0000 C CNN
F 2 "" H 10400 1450 50  0001 C CNN
F 3 "" H 10400 1450 50  0001 C CNN
	1    10400 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 5E2D2F71
P 9100 3250
F 0 "R13" H 9170 3296 50  0000 L CNN
F 1 "42R2" H 9170 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9030 3250 50  0001 C CNN
F 3 "~" H 9100 3250 50  0001 C CNN
	1    9100 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 3700 8700 3600
$Comp
L power:GND #PWR018
U 1 1 5E2D2F78
P 8700 3700
F 0 "#PWR018" H 8700 3450 50  0001 C CNN
F 1 "GND" H 8705 3527 50  0000 C CNN
F 2 "" H 8700 3700 50  0001 C CNN
F 3 "" H 8700 3700 50  0001 C CNN
	1    8700 3700
	1    0    0    -1  
$EndComp
Text Label 8600 1950 2    50   ~ 0
LED_B
$Comp
L Device:LED DB1
U 1 1 5E2D2F88
P 9100 1800
F 0 "DB1" V 9139 1682 50  0000 R CNN
F 1 "LED" V 9048 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 9100 1800 50  0001 C CNN
F 3 "~" H 9100 1800 50  0001 C CNN
	1    9100 1800
	0    -1   -1   0   
$EndComp
$Comp
L ESP8266:ESP-01v090 U2
U 1 1 5E324FB3
P 6450 5050
F 0 "U2" H 6450 5565 50  0000 C CNN
F 1 "ESP-01v090" H 6450 5474 50  0000 C CNN
F 2 "ESP8266:ESP-01" H 6450 5050 50  0001 C CNN
F 3 "http://l0l.org.uk/2014/12/esp8266-modules-hardware-guide-gotta-catch-em-all/" H 6450 5050 50  0001 C CNN
	1    6450 5050
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:AP1117-33 U1
U 1 1 5E327F25
P 4400 5200
F 0 "U1" H 4400 5442 50  0000 C CNN
F 1 "AP1117-33" H 4400 5351 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 4400 5400 50  0001 C CNN
F 3 "http://www.diodes.com/datasheets/AP1117.pdf" H 4500 4950 50  0001 C CNN
	1    4400 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 5200 4800 5200
$Comp
L power:GND #PWR07
U 1 1 5E32AD7D
P 4400 5800
F 0 "#PWR07" H 4400 5550 50  0001 C CNN
F 1 "GND" H 4405 5627 50  0000 C CNN
F 2 "" H 4400 5800 50  0001 C CNN
F 3 "" H 4400 5800 50  0001 C CNN
	1    4400 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 5800 4400 5700
$Comp
L power:+7.5V #PWR06
U 1 1 5E32BBF6
P 4000 5100
F 0 "#PWR06" H 4000 4950 50  0001 C CNN
F 1 "+7.5V" H 4015 5273 50  0000 C CNN
F 2 "" H 4000 5100 50  0001 C CNN
F 3 "" H 4000 5100 50  0001 C CNN
	1    4000 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 5100 4000 5200
Wire Wire Line
	4000 5200 4100 5200
$Comp
L power:GND #PWR011
U 1 1 5E32CC13
P 7500 5800
F 0 "#PWR011" H 7500 5550 50  0001 C CNN
F 1 "GND" H 7505 5627 50  0000 C CNN
F 2 "" H 7500 5800 50  0001 C CNN
F 3 "" H 7500 5800 50  0001 C CNN
	1    7500 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 5800 7500 4900
Wire Wire Line
	7500 4900 7400 4900
$Comp
L Device:C C2
U 1 1 5E32DE43
P 4800 5450
F 0 "C2" H 4915 5496 50  0000 L CNN
F 1 "4u7" H 4915 5405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4838 5300 50  0001 C CNN
F 3 "~" H 4800 5450 50  0001 C CNN
	1    4800 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 5300 4800 5200
Connection ~ 4800 5200
Wire Wire Line
	4400 5700 4800 5700
Wire Wire Line
	4800 5700 4800 5600
Connection ~ 4400 5700
Wire Wire Line
	4400 5700 4400 5500
$Comp
L Device:C C1
U 1 1 5E336009
P 4000 5450
F 0 "C1" H 3885 5404 50  0000 R CNN
F 1 "4u7" H 3885 5495 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4038 5300 50  0001 C CNN
F 3 "~" H 4000 5450 50  0001 C CNN
	1    4000 5450
	1    0    0    1   
$EndComp
Wire Wire Line
	4000 5300 4000 5200
Connection ~ 4000 5200
Wire Wire Line
	4000 5600 4000 5700
Wire Wire Line
	4000 5700 4400 5700
$Comp
L Device:CP C3
U 1 1 5E33A82B
P 9600 5450
F 0 "C3" H 9718 5496 50  0000 L CNN
F 1 "10u" H 9718 5405 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_4x5.4" H 9638 5300 50  0001 C CNN
F 3 "~" H 9600 5450 50  0001 C CNN
	1    9600 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 5500 9300 5500
Wire Wire Line
	9300 5500 9300 5200
Wire Wire Line
	9300 5200 9600 5200
Wire Wire Line
	9600 5300 9600 5200
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5E33FC1D
P 9300 5100
F 0 "#FLG01" H 9300 5175 50  0001 C CNN
F 1 "PWR_FLAG" H 9300 5273 50  0000 C CNN
F 2 "" H 9300 5100 50  0001 C CNN
F 3 "~" H 9300 5100 50  0001 C CNN
	1    9300 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 5100 9300 5200
Connection ~ 9300 5200
$Comp
L power:+7.5V #PWR016
U 1 1 5E341817
P 9600 5100
F 0 "#PWR016" H 9600 4950 50  0001 C CNN
F 1 "+7.5V" H 9615 5273 50  0000 C CNN
F 2 "" H 9600 5100 50  0001 C CNN
F 3 "" H 9600 5100 50  0001 C CNN
	1    9600 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 5100 9600 5200
Connection ~ 9600 5200
$Comp
L power:GND #PWR015
U 1 1 5E3433AA
P 9300 5800
F 0 "#PWR015" H 9300 5550 50  0001 C CNN
F 1 "GND" H 9305 5627 50  0000 C CNN
F 2 "" H 9300 5800 50  0001 C CNN
F 3 "" H 9300 5800 50  0001 C CNN
	1    9300 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 5800 9300 5700
Wire Wire Line
	9300 5700 9200 5700
Wire Wire Line
	9300 5700 9600 5700
Wire Wire Line
	9600 5700 9600 5600
Connection ~ 9300 5700
Text Label 7600 5100 0    50   ~ 0
LED_R
Text Label 5300 4900 2    50   ~ 0
LED_G
Text Label 7600 5000 0    50   ~ 0
LED_B
Wire Wire Line
	7600 5000 7400 5000
Wire Wire Line
	7400 5100 7600 5100
Wire Wire Line
	5300 4900 5500 4900
Wire Wire Line
	5500 5100 5400 5100
Wire Wire Line
	5400 5100 5400 5200
Connection ~ 5400 5200
Wire Wire Line
	5400 5200 5500 5200
Wire Wire Line
	5500 5000 5300 5000
Wire Wire Line
	5300 5000 5300 5200
Connection ~ 5300 5200
Wire Wire Line
	5300 5200 5400 5200
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5E411F7E
P 9600 5800
F 0 "#FLG02" H 9600 5875 50  0001 C CNN
F 1 "PWR_FLAG" H 9600 5973 50  0000 C CNN
F 2 "" H 9600 5800 50  0001 C CNN
F 3 "~" H 9600 5800 50  0001 C CNN
	1    9600 5800
	-1   0    0    1   
$EndComp
Wire Wire Line
	9600 5700 9600 5800
Connection ~ 9600 5700
NoConn ~ 7400 5200
Wire Wire Line
	9100 3000 9100 3100
Wire Wire Line
	8700 3600 9100 3600
Wire Wire Line
	9100 3600 9100 3400
Wire Wire Line
	8700 2900 8700 2800
Wire Wire Line
	8700 2800 8800 2800
$Comp
L Device:R R11
U 1 1 5E3210FD
P 8700 1700
F 0 "R11" H 8770 1746 50  0000 L CNN
F 1 "10k" H 8770 1655 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 8630 1700 50  0001 C CNN
F 3 "~" H 8700 1700 50  0001 C CNN
	1    8700 1700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR017
U 1 1 5E322171
P 8700 1450
F 0 "#PWR017" H 8700 1300 50  0001 C CNN
F 1 "+3.3V" H 8715 1623 50  0000 C CNN
F 2 "" H 8700 1450 50  0001 C CNN
F 3 "" H 8700 1450 50  0001 C CNN
	1    8700 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 1450 8700 1550
$Comp
L Device:R R12
U 1 1 5E33ADCE
P 8700 2200
F 0 "R12" H 8770 2246 50  0000 L CNN
F 1 "1k" H 8770 2155 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 8630 2200 50  0001 C CNN
F 3 "~" H 8700 2200 50  0001 C CNN
	1    8700 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 1950 8700 1950
Wire Wire Line
	8700 1850 8700 1950
Connection ~ 8700 1950
Wire Wire Line
	8700 1950 8700 2050
Wire Wire Line
	8700 2800 8700 2550
Connection ~ 8700 2800
$Comp
L Transistor_BJT:BC847 Q8
U 1 1 5E357469
P 9650 2800
F 0 "Q8" H 9841 2846 50  0000 L CNN
F 1 "BC847" H 9841 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 9850 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 9650 2800 50  0001 L CNN
	1    9650 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DB4
U 1 1 5E357473
P 9750 2200
F 0 "DB4" V 9789 2082 50  0000 R CNN
F 1 "LED" V 9698 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 9750 2200 50  0001 C CNN
F 3 "~" H 9750 2200 50  0001 C CNN
	1    9750 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9750 2350 9750 2600
Wire Wire Line
	9750 1950 9750 2050
$Comp
L Device:R R14
U 1 1 5E35747F
P 9750 3250
F 0 "R14" H 9820 3296 50  0000 L CNN
F 1 "42R2" H 9820 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9680 3250 50  0001 C CNN
F 3 "~" H 9750 3250 50  0001 C CNN
	1    9750 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DB3
U 1 1 5E357489
P 9750 1800
F 0 "DB3" V 9789 1682 50  0000 R CNN
F 1 "LED" V 9698 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 9750 1800 50  0001 C CNN
F 3 "~" H 9750 1800 50  0001 C CNN
	1    9750 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9750 3000 9750 3100
Wire Wire Line
	9750 3600 9750 3400
$Comp
L Transistor_BJT:BC847 Q9
U 1 1 5E35E1E9
P 10300 2800
F 0 "Q9" H 10491 2846 50  0000 L CNN
F 1 "BC847" H 10491 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 10500 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 10300 2800 50  0001 L CNN
	1    10300 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DB6
U 1 1 5E35E1F3
P 10400 2200
F 0 "DB6" V 10439 2082 50  0000 R CNN
F 1 "LED" V 10348 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 10400 2200 50  0001 C CNN
F 3 "~" H 10400 2200 50  0001 C CNN
	1    10400 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10400 2350 10400 2600
Wire Wire Line
	10400 1950 10400 2050
$Comp
L Device:R R15
U 1 1 5E35E1FF
P 10400 3250
F 0 "R15" H 10470 3296 50  0000 L CNN
F 1 "42R2" H 10470 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 10330 3250 50  0001 C CNN
F 3 "~" H 10400 3250 50  0001 C CNN
	1    10400 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DB5
U 1 1 5E35E209
P 10400 1800
F 0 "DB5" V 10439 1682 50  0000 R CNN
F 1 "LED" V 10348 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 10400 1800 50  0001 C CNN
F 3 "~" H 10400 1800 50  0001 C CNN
	1    10400 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10400 1450 10400 1550
Wire Wire Line
	10400 3000 10400 3100
Wire Wire Line
	10400 3600 10400 3400
Wire Wire Line
	10400 1550 9750 1550
Connection ~ 10400 1550
Wire Wire Line
	10400 1550 10400 1650
Wire Wire Line
	9100 1550 9100 1650
Wire Wire Line
	9750 1650 9750 1550
Connection ~ 9750 1550
Wire Wire Line
	9750 1550 9100 1550
Connection ~ 8700 3600
Wire Wire Line
	9100 3600 9750 3600
Connection ~ 9100 3600
Wire Wire Line
	9750 3600 10400 3600
Connection ~ 9750 3600
Connection ~ 8700 2550
Wire Wire Line
	8700 2550 8700 2350
Wire Wire Line
	10000 2550 10000 2800
Wire Wire Line
	10000 2800 10100 2800
Wire Wire Line
	8700 2550 9350 2550
Wire Wire Line
	9350 2550 9350 2800
Wire Wire Line
	9350 2800 9450 2800
Connection ~ 9350 2550
Wire Wire Line
	9350 2550 10000 2550
$Comp
L Device:LED_RGB D1
U 1 1 5E3B728B
P 1600 1750
F 0 "D1" H 1600 2247 50  0000 C CNN
F 1 "LED_RGB" H 1600 2156 50  0000 C CNN
F 2 "LED_SMD:LED_RGB_5050-6" H 1600 1700 50  0001 C CNN
F 3 "~" H 1600 1700 50  0001 C CNN
	1    1600 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:LED_RGB D4
U 1 1 5E3BB4B3
P 2100 1750
F 0 "D4" H 2100 2247 50  0000 C CNN
F 1 "LED_RGB" H 2100 2156 50  0000 C CNN
F 2 "LED_SMD:LED_RGB_5050-6" H 2100 1700 50  0001 C CNN
F 3 "~" H 2100 1700 50  0001 C CNN
	1    2100 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 1550 1900 1550
Wire Wire Line
	1900 1750 1800 1750
Wire Wire Line
	1900 1950 1800 1950
Wire Wire Line
	2300 1950 2400 1950
Wire Wire Line
	2400 1950 2400 1750
Wire Wire Line
	2400 1550 2300 1550
Wire Wire Line
	2300 1750 2400 1750
Connection ~ 2400 1750
Wire Wire Line
	2400 1750 2400 1550
$Comp
L power:+7.5V #PWR03
U 1 1 5E3CED33
P 2400 1450
F 0 "#PWR03" H 2400 1300 50  0001 C CNN
F 1 "+7.5V" H 2415 1623 50  0000 C CNN
F 2 "" H 2400 1450 50  0001 C CNN
F 3 "" H 2400 1450 50  0001 C CNN
	1    2400 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 1450 2400 1550
Connection ~ 2400 1550
Text Label 1300 1550 2    50   ~ 0
LR1
Wire Wire Line
	1300 1550 1400 1550
Text Label 1300 1750 2    50   ~ 0
LG1
Wire Wire Line
	1300 1750 1400 1750
Text Label 1300 1950 2    50   ~ 0
LB1
Wire Wire Line
	1300 1950 1400 1950
$Comp
L Device:LED_RGB D2
U 1 1 5E3E2EFE
P 1600 2650
F 0 "D2" H 1600 3147 50  0000 C CNN
F 1 "LED_RGB" H 1600 3056 50  0000 C CNN
F 2 "LED_SMD:LED_RGB_5050-6" H 1600 2600 50  0001 C CNN
F 3 "~" H 1600 2600 50  0001 C CNN
	1    1600 2650
	1    0    0    -1  
$EndComp
$Comp
L Device:LED_RGB D5
U 1 1 5E3E2F08
P 2100 2650
F 0 "D5" H 2100 3147 50  0000 C CNN
F 1 "LED_RGB" H 2100 3056 50  0000 C CNN
F 2 "LED_SMD:LED_RGB_5050-6" H 2100 2600 50  0001 C CNN
F 3 "~" H 2100 2600 50  0001 C CNN
	1    2100 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 2450 1900 2450
Wire Wire Line
	1900 2650 1800 2650
Wire Wire Line
	1900 2850 1800 2850
Wire Wire Line
	2300 2850 2400 2850
Wire Wire Line
	2400 2850 2400 2650
Wire Wire Line
	2400 2450 2300 2450
Wire Wire Line
	2300 2650 2400 2650
Connection ~ 2400 2650
Wire Wire Line
	2400 2650 2400 2450
$Comp
L power:+7.5V #PWR04
U 1 1 5E3E2F1B
P 2400 2350
F 0 "#PWR04" H 2400 2200 50  0001 C CNN
F 1 "+7.5V" H 2415 2523 50  0000 C CNN
F 2 "" H 2400 2350 50  0001 C CNN
F 3 "" H 2400 2350 50  0001 C CNN
	1    2400 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 2350 2400 2450
Connection ~ 2400 2450
Text Label 1300 2450 2    50   ~ 0
LR2
Wire Wire Line
	1300 2450 1400 2450
Text Label 1300 2650 2    50   ~ 0
LG2
Wire Wire Line
	1300 2650 1400 2650
Text Label 1300 2850 2    50   ~ 0
LB2
Wire Wire Line
	1300 2850 1400 2850
$Comp
L Device:LED_RGB D3
U 1 1 5E3F0C3C
P 1600 3550
F 0 "D3" H 1600 4047 50  0000 C CNN
F 1 "LED_RGB" H 1600 3956 50  0000 C CNN
F 2 "LED_SMD:LED_RGB_5050-6" H 1600 3500 50  0001 C CNN
F 3 "~" H 1600 3500 50  0001 C CNN
	1    1600 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:LED_RGB D6
U 1 1 5E3F0C46
P 2100 3550
F 0 "D6" H 2100 4047 50  0000 C CNN
F 1 "LED_RGB" H 2100 3956 50  0000 C CNN
F 2 "LED_SMD:LED_RGB_5050-6" H 2100 3500 50  0001 C CNN
F 3 "~" H 2100 3500 50  0001 C CNN
	1    2100 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 3350 1900 3350
Wire Wire Line
	1900 3550 1800 3550
Wire Wire Line
	1900 3750 1800 3750
Wire Wire Line
	2300 3750 2400 3750
Wire Wire Line
	2400 3750 2400 3550
Wire Wire Line
	2400 3350 2300 3350
Wire Wire Line
	2300 3550 2400 3550
Connection ~ 2400 3550
Wire Wire Line
	2400 3550 2400 3350
$Comp
L power:+7.5V #PWR05
U 1 1 5E3F0C59
P 2400 3250
F 0 "#PWR05" H 2400 3100 50  0001 C CNN
F 1 "+7.5V" H 2415 3423 50  0000 C CNN
F 2 "" H 2400 3250 50  0001 C CNN
F 3 "" H 2400 3250 50  0001 C CNN
	1    2400 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 3250 2400 3350
Connection ~ 2400 3350
Text Label 1300 3350 2    50   ~ 0
LR3
Wire Wire Line
	1300 3350 1400 3350
Text Label 1300 3550 2    50   ~ 0
LG3
Wire Wire Line
	1300 3550 1400 3550
Text Label 1300 3750 2    50   ~ 0
LB3
Wire Wire Line
	1300 3750 1400 3750
Text Label 9100 2450 2    50   ~ 0
LB1
Text Label 9750 2450 2    50   ~ 0
LB2
Text Label 10400 2450 2    50   ~ 0
LB3
$Comp
L Transistor_BJT:BC847 Q4
U 1 1 5E42CC95
P 6400 2800
F 0 "Q4" H 6591 2846 50  0000 L CNN
F 1 "BC847" H 6591 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6600 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 6400 2800 50  0001 L CNN
	1    6400 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DG2
U 1 1 5E42CC9F
P 6500 2200
F 0 "DG2" V 6539 2082 50  0000 R CNN
F 1 "LED" V 6448 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 6500 2200 50  0001 C CNN
F 3 "~" H 6500 2200 50  0001 C CNN
	1    6500 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6500 2350 6500 2600
Wire Wire Line
	6500 1950 6500 2050
$Comp
L power:+7.5V #PWR014
U 1 1 5E42CCAB
P 7800 1450
F 0 "#PWR014" H 7800 1300 50  0001 C CNN
F 1 "+7.5V" H 7815 1623 50  0000 C CNN
F 2 "" H 7800 1450 50  0001 C CNN
F 3 "" H 7800 1450 50  0001 C CNN
	1    7800 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5E42CCB5
P 6500 3250
F 0 "R8" H 6570 3296 50  0000 L CNN
F 1 "42R2" H 6570 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6430 3250 50  0001 C CNN
F 3 "~" H 6500 3250 50  0001 C CNN
	1    6500 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 3700 6100 3600
$Comp
L power:GND #PWR013
U 1 1 5E42CCC0
P 6100 3700
F 0 "#PWR013" H 6100 3450 50  0001 C CNN
F 1 "GND" H 6105 3527 50  0000 C CNN
F 2 "" H 6100 3700 50  0001 C CNN
F 3 "" H 6100 3700 50  0001 C CNN
	1    6100 3700
	1    0    0    -1  
$EndComp
Text Label 6000 1950 2    50   ~ 0
LED_G
$Comp
L Device:LED DG1
U 1 1 5E42CCCB
P 6500 1800
F 0 "DG1" V 6539 1682 50  0000 R CNN
F 1 "LED" V 6448 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 6500 1800 50  0001 C CNN
F 3 "~" H 6500 1800 50  0001 C CNN
	1    6500 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6500 3000 6500 3100
Wire Wire Line
	6100 3600 6500 3600
Wire Wire Line
	6500 3600 6500 3400
Wire Wire Line
	6100 2900 6100 2800
Wire Wire Line
	6100 2800 6200 2800
$Comp
L Device:R R6
U 1 1 5E42CCF0
P 6100 1700
F 0 "R6" H 6170 1746 50  0000 L CNN
F 1 "10k" H 6170 1655 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6030 1700 50  0001 C CNN
F 3 "~" H 6100 1700 50  0001 C CNN
	1    6100 1700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR012
U 1 1 5E42CCFA
P 6100 1450
F 0 "#PWR012" H 6100 1300 50  0001 C CNN
F 1 "+3.3V" H 6115 1623 50  0000 C CNN
F 2 "" H 6100 1450 50  0001 C CNN
F 3 "" H 6100 1450 50  0001 C CNN
	1    6100 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 1450 6100 1550
$Comp
L Device:R R7
U 1 1 5E42CD05
P 6100 2200
F 0 "R7" H 6170 2246 50  0000 L CNN
F 1 "1k" H 6170 2155 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6030 2200 50  0001 C CNN
F 3 "~" H 6100 2200 50  0001 C CNN
	1    6100 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 1950 6100 1950
Wire Wire Line
	6100 1850 6100 1950
Connection ~ 6100 1950
Wire Wire Line
	6100 1950 6100 2050
Wire Wire Line
	6100 2800 6100 2550
Connection ~ 6100 2800
$Comp
L Transistor_BJT:BC847 Q5
U 1 1 5E42CD15
P 7050 2800
F 0 "Q5" H 7241 2846 50  0000 L CNN
F 1 "BC847" H 7241 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7250 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 7050 2800 50  0001 L CNN
	1    7050 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DG4
U 1 1 5E42CD1F
P 7150 2200
F 0 "DG4" V 7189 2082 50  0000 R CNN
F 1 "LED" V 7098 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 7150 2200 50  0001 C CNN
F 3 "~" H 7150 2200 50  0001 C CNN
	1    7150 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7150 2350 7150 2600
Wire Wire Line
	7150 1950 7150 2050
$Comp
L Device:R R9
U 1 1 5E42CD2B
P 7150 3250
F 0 "R9" H 7220 3296 50  0000 L CNN
F 1 "42R2" H 7220 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7080 3250 50  0001 C CNN
F 3 "~" H 7150 3250 50  0001 C CNN
	1    7150 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DG3
U 1 1 5E42CD35
P 7150 1800
F 0 "DG3" V 7189 1682 50  0000 R CNN
F 1 "LED" V 7098 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 7150 1800 50  0001 C CNN
F 3 "~" H 7150 1800 50  0001 C CNN
	1    7150 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7150 3000 7150 3100
Wire Wire Line
	7150 3600 7150 3400
$Comp
L Transistor_BJT:BC847 Q6
U 1 1 5E42CD41
P 7700 2800
F 0 "Q6" H 7891 2846 50  0000 L CNN
F 1 "BC847" H 7891 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7900 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 7700 2800 50  0001 L CNN
	1    7700 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DG6
U 1 1 5E42CD4B
P 7800 2200
F 0 "DG6" V 7839 2082 50  0000 R CNN
F 1 "LED" V 7748 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 7800 2200 50  0001 C CNN
F 3 "~" H 7800 2200 50  0001 C CNN
	1    7800 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7800 2350 7800 2600
Wire Wire Line
	7800 1950 7800 2050
$Comp
L Device:R R10
U 1 1 5E42CD57
P 7800 3250
F 0 "R10" H 7870 3296 50  0000 L CNN
F 1 "42R2" H 7870 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7730 3250 50  0001 C CNN
F 3 "~" H 7800 3250 50  0001 C CNN
	1    7800 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DG5
U 1 1 5E42CD61
P 7800 1800
F 0 "DG5" V 7839 1682 50  0000 R CNN
F 1 "LED" V 7748 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 7800 1800 50  0001 C CNN
F 3 "~" H 7800 1800 50  0001 C CNN
	1    7800 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7800 1450 7800 1550
Wire Wire Line
	7800 3000 7800 3100
Wire Wire Line
	7800 3600 7800 3400
Wire Wire Line
	7800 1550 7150 1550
Connection ~ 7800 1550
Wire Wire Line
	7800 1550 7800 1650
Wire Wire Line
	6500 1550 6500 1650
Wire Wire Line
	7150 1650 7150 1550
Connection ~ 7150 1550
Wire Wire Line
	7150 1550 6500 1550
Connection ~ 6100 3600
Wire Wire Line
	6500 3600 7150 3600
Connection ~ 6500 3600
Wire Wire Line
	7150 3600 7800 3600
Connection ~ 7150 3600
Connection ~ 6100 2550
Wire Wire Line
	6100 2550 6100 2350
Wire Wire Line
	7400 2550 7400 2800
Wire Wire Line
	7400 2800 7500 2800
Wire Wire Line
	6100 2550 6750 2550
Wire Wire Line
	6750 2550 6750 2800
Wire Wire Line
	6750 2800 6850 2800
Connection ~ 6750 2550
Wire Wire Line
	6750 2550 7400 2550
Text Label 6500 2450 2    50   ~ 0
LG1
Text Label 7150 2450 2    50   ~ 0
LG2
Text Label 7800 2450 2    50   ~ 0
LG3
$Comp
L Connector:Conn_01x05_Female J2
U 1 1 5E460AEA
P 2550 5250
F 0 "J2" H 2578 5276 50  0000 L CNN
F 1 "Conn_01x05_Female" H 2578 5185 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x05_P2.54mm_Horizontal" H 2550 5250 50  0001 C CNN
F 3 "~" H 2550 5250 50  0001 C CNN
	1    2550 5250
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05_Male J1
U 1 1 5E461F35
P 1550 5250
F 0 "J1" H 1658 5631 50  0000 C CNN
F 1 "Conn_01x05_Male" H 1658 5540 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Horizontal" H 1550 5250 50  0001 C CNN
F 3 "~" H 1550 5250 50  0001 C CNN
	1    1550 5250
	1    0    0    -1  
$EndComp
$Comp
L power:+7.5V #PWR02
U 1 1 5E473ED4
P 2100 4950
F 0 "#PWR02" H 2100 4800 50  0001 C CNN
F 1 "+7.5V" H 2115 5123 50  0000 C CNN
F 2 "" H 2100 4950 50  0001 C CNN
F 3 "" H 2100 4950 50  0001 C CNN
	1    2100 4950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5E474957
P 2000 5550
F 0 "#PWR01" H 2000 5300 50  0001 C CNN
F 1 "GND" H 2005 5377 50  0000 C CNN
F 2 "" H 2000 5550 50  0001 C CNN
F 3 "" H 2000 5550 50  0001 C CNN
	1    2000 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 5450 2000 5450
Wire Wire Line
	2000 5450 2000 5550
Connection ~ 2000 5450
Wire Wire Line
	2000 5450 2350 5450
Wire Wire Line
	1750 5050 2100 5050
Wire Wire Line
	2100 5050 2100 4950
Wire Wire Line
	2100 5050 2350 5050
Connection ~ 2100 5050
Text Label 1950 5150 0    50   ~ 0
LED_R
Text Label 1950 5250 0    50   ~ 0
LED_G
Text Label 1950 5350 0    50   ~ 0
LED_B
Wire Wire Line
	1750 5150 2350 5150
Wire Wire Line
	2350 5250 1750 5250
Wire Wire Line
	1750 5350 2350 5350
$Comp
L Transistor_BJT:BC847 Q1
U 1 1 5E4B1905
P 3800 2800
F 0 "Q1" H 3991 2846 50  0000 L CNN
F 1 "BC847" H 3991 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4000 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 3800 2800 50  0001 L CNN
	1    3800 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DR2
U 1 1 5E4B190F
P 3900 2200
F 0 "DR2" V 3939 2082 50  0000 R CNN
F 1 "LED" V 3848 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 3900 2200 50  0001 C CNN
F 3 "~" H 3900 2200 50  0001 C CNN
	1    3900 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3900 2350 3900 2600
Wire Wire Line
	3900 1950 3900 2050
$Comp
L power:+7.5V #PWR010
U 1 1 5E4B191B
P 5200 1450
F 0 "#PWR010" H 5200 1300 50  0001 C CNN
F 1 "+7.5V" H 5215 1623 50  0000 C CNN
F 2 "" H 5200 1450 50  0001 C CNN
F 3 "" H 5200 1450 50  0001 C CNN
	1    5200 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5E4B1925
P 3900 3250
F 0 "R3" H 3970 3296 50  0000 L CNN
F 1 "42R2" H 3970 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3830 3250 50  0001 C CNN
F 3 "~" H 3900 3250 50  0001 C CNN
	1    3900 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 3700 3500 3600
$Comp
L power:GND #PWR09
U 1 1 5E4B1930
P 3500 3700
F 0 "#PWR09" H 3500 3450 50  0001 C CNN
F 1 "GND" H 3505 3527 50  0000 C CNN
F 2 "" H 3500 3700 50  0001 C CNN
F 3 "" H 3500 3700 50  0001 C CNN
	1    3500 3700
	1    0    0    -1  
$EndComp
Text Label 3400 1950 2    50   ~ 0
LED_R
$Comp
L Device:LED DR1
U 1 1 5E4B193B
P 3900 1800
F 0 "DR1" V 3939 1682 50  0000 R CNN
F 1 "LED" V 3848 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 3900 1800 50  0001 C CNN
F 3 "~" H 3900 1800 50  0001 C CNN
	1    3900 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3900 3000 3900 3100
Wire Wire Line
	3500 3600 3900 3600
Wire Wire Line
	3900 3600 3900 3400
Wire Wire Line
	3500 2900 3500 2800
Wire Wire Line
	3500 2800 3600 2800
$Comp
L Device:R R1
U 1 1 5E4B1960
P 3500 1700
F 0 "R1" H 3570 1746 50  0000 L CNN
F 1 "10k" H 3570 1655 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3430 1700 50  0001 C CNN
F 3 "~" H 3500 1700 50  0001 C CNN
	1    3500 1700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR08
U 1 1 5E4B196A
P 3500 1450
F 0 "#PWR08" H 3500 1300 50  0001 C CNN
F 1 "+3.3V" H 3515 1623 50  0000 C CNN
F 2 "" H 3500 1450 50  0001 C CNN
F 3 "" H 3500 1450 50  0001 C CNN
	1    3500 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 1450 3500 1550
$Comp
L Device:R R2
U 1 1 5E4B1975
P 3500 2200
F 0 "R2" H 3570 2246 50  0000 L CNN
F 1 "1k" H 3570 2155 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3430 2200 50  0001 C CNN
F 3 "~" H 3500 2200 50  0001 C CNN
	1    3500 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 1950 3500 1950
Wire Wire Line
	3500 1850 3500 1950
Connection ~ 3500 1950
Wire Wire Line
	3500 1950 3500 2050
Wire Wire Line
	3500 2800 3500 2550
Connection ~ 3500 2800
$Comp
L Transistor_BJT:BC847 Q2
U 1 1 5E4B1985
P 4450 2800
F 0 "Q2" H 4641 2846 50  0000 L CNN
F 1 "BC847" H 4641 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4650 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 4450 2800 50  0001 L CNN
	1    4450 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DR4
U 1 1 5E4B198F
P 4550 2200
F 0 "DR4" V 4589 2082 50  0000 R CNN
F 1 "LED" V 4498 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 4550 2200 50  0001 C CNN
F 3 "~" H 4550 2200 50  0001 C CNN
	1    4550 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4550 2350 4550 2600
Wire Wire Line
	4550 1950 4550 2050
$Comp
L Device:R R4
U 1 1 5E4B199B
P 4550 3250
F 0 "R4" H 4620 3296 50  0000 L CNN
F 1 "42R2" H 4620 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4480 3250 50  0001 C CNN
F 3 "~" H 4550 3250 50  0001 C CNN
	1    4550 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DR3
U 1 1 5E4B19A5
P 4550 1800
F 0 "DR3" V 4589 1682 50  0000 R CNN
F 1 "LED" V 4498 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 4550 1800 50  0001 C CNN
F 3 "~" H 4550 1800 50  0001 C CNN
	1    4550 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4550 3000 4550 3100
Wire Wire Line
	4550 3600 4550 3400
$Comp
L Transistor_BJT:BC847 Q3
U 1 1 5E4B19B1
P 5100 2800
F 0 "Q3" H 5291 2846 50  0000 L CNN
F 1 "BC847" H 5291 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 5300 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 5100 2800 50  0001 L CNN
	1    5100 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DR6
U 1 1 5E4B19BB
P 5200 2200
F 0 "DR6" V 5239 2082 50  0000 R CNN
F 1 "LED" V 5148 2082 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 5200 2200 50  0001 C CNN
F 3 "~" H 5200 2200 50  0001 C CNN
	1    5200 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5200 2350 5200 2600
Wire Wire Line
	5200 1950 5200 2050
$Comp
L Device:R R5
U 1 1 5E4B19C7
P 5200 3250
F 0 "R5" H 5270 3296 50  0000 L CNN
F 1 "42R2" H 5270 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5130 3250 50  0001 C CNN
F 3 "~" H 5200 3250 50  0001 C CNN
	1    5200 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:LED DR5
U 1 1 5E4B19D1
P 5200 1800
F 0 "DR5" V 5239 1682 50  0000 R CNN
F 1 "LED" V 5148 1682 50  0000 R CNN
F 2 "LED_Special:LED_SuperFlux_5x5_4pin_D5.00mm_combi" H 5200 1800 50  0001 C CNN
F 3 "~" H 5200 1800 50  0001 C CNN
	1    5200 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5200 1450 5200 1550
Wire Wire Line
	5200 3000 5200 3100
Wire Wire Line
	5200 3600 5200 3400
Wire Wire Line
	5200 1550 4550 1550
Connection ~ 5200 1550
Wire Wire Line
	5200 1550 5200 1650
Wire Wire Line
	3900 1550 3900 1650
Wire Wire Line
	4550 1650 4550 1550
Connection ~ 4550 1550
Wire Wire Line
	4550 1550 3900 1550
Wire Wire Line
	3900 3600 4550 3600
Connection ~ 3900 3600
Wire Wire Line
	4550 3600 5200 3600
Connection ~ 4550 3600
Connection ~ 3500 2550
Wire Wire Line
	3500 2550 3500 2350
Wire Wire Line
	4800 2550 4800 2800
Wire Wire Line
	4800 2800 4900 2800
Wire Wire Line
	3500 2550 4150 2550
Wire Wire Line
	4150 2550 4150 2800
Wire Wire Line
	4150 2800 4250 2800
Connection ~ 4150 2550
Wire Wire Line
	4150 2550 4800 2550
Text Label 3900 2450 2    50   ~ 0
LR1
Text Label 4550 2450 2    50   ~ 0
LR2
Text Label 5200 2450 2    50   ~ 0
LR3
$Comp
L power:+3.3V #PWR0101
U 1 1 5E61E1AE
P 4800 5050
F 0 "#PWR0101" H 4800 4900 50  0001 C CNN
F 1 "+3.3V" H 4815 5223 50  0000 C CNN
F 2 "" H 4800 5050 50  0001 C CNN
F 3 "" H 4800 5050 50  0001 C CNN
	1    4800 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 5050 4800 5200
Wire Wire Line
	4800 5200 5300 5200
$Comp
L Connector:Barrel_Jack_Switch J3
U 1 1 5E735307
P 8900 5600
F 0 "J3" H 8957 5917 50  0000 C CNN
F 1 "Barrel_Jack_Switch" H 8957 5826 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 8950 5560 50  0001 C CNN
F 3 "~" H 8950 5560 50  0001 C CNN
	1    8900 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 5600 9300 5600
Wire Wire Line
	9300 5600 9300 5700
$Comp
L Diode:BAV99 D7
U 1 1 5E75324B
P 3500 3200
F 0 "D7" V 3454 3279 50  0000 L CNN
F 1 "BAV99" V 3545 3279 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3500 2700 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 3500 3200 50  0001 C CNN
	1    3500 3200
	0    1    1    0   
$EndComp
$Comp
L Diode:BAV99 D8
U 1 1 5E75A58A
P 6100 3200
F 0 "D8" V 6054 3279 50  0000 L CNN
F 1 "BAV99" V 6145 3279 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6100 2700 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 6100 3200 50  0001 C CNN
	1    6100 3200
	0    1    1    0   
$EndComp
Wire Wire Line
	3500 3500 3500 3600
Connection ~ 3500 3600
NoConn ~ 3300 3200
$Comp
L Diode:BAV99 D9
U 1 1 5E75B0F5
P 8700 3200
F 0 "D9" V 8654 3279 50  0000 L CNN
F 1 "BAV99" V 8745 3279 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 8700 2700 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 8700 3200 50  0001 C CNN
	1    8700 3200
	0    1    1    0   
$EndComp
$Comp
L Transistor_BJT:BC847 Q7
U 1 1 5E2D2F4E
P 9000 2800
F 0 "Q7" H 9191 2846 50  0000 L CNN
F 1 "BC847" H 9191 2755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 9200 2725 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 9000 2800 50  0001 L CNN
	1    9000 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 3500 8700 3600
Wire Wire Line
	6100 3500 6100 3600
NoConn ~ 5900 3200
NoConn ~ 8500 3200
$Comp
L Mechanical:MountingHole H1
U 1 1 5E57AD7B
P 1250 6800
F 0 "H1" H 1350 6846 50  0000 L CNN
F 1 "MountingHole" H 1350 6755 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4" H 1250 6800 50  0001 C CNN
F 3 "~" H 1250 6800 50  0001 C CNN
	1    1250 6800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5E57BB35
P 1550 6800
F 0 "H2" H 1650 6846 50  0000 L CNN
F 1 "MountingHole" H 1650 6755 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4" H 1550 6800 50  0001 C CNN
F 3 "~" H 1550 6800 50  0001 C CNN
	1    1550 6800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5E57BE2A
P 1250 7000
F 0 "H4" H 1350 7046 50  0000 L CNN
F 1 "MountingHole" H 1350 6955 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4" H 1250 7000 50  0001 C CNN
F 3 "~" H 1250 7000 50  0001 C CNN
	1    1250 7000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 5E5E1EB3
P 1550 7050
F 0 "H3" H 1650 7099 50  0000 L CNN
F 1 "MountingHole_Pad" H 1650 7008 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4" H 1550 7050 50  0001 C CNN
F 3 "~" H 1550 7050 50  0001 C CNN
	1    1550 7050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5E5E2564
P 1550 7250
F 0 "#PWR0102" H 1550 7000 50  0001 C CNN
F 1 "GND" H 1555 7077 50  0000 C CNN
F 2 "" H 1550 7250 50  0001 C CNN
F 3 "" H 1550 7250 50  0001 C CNN
	1    1550 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 7150 1550 7250
$EndSCHEMATC
