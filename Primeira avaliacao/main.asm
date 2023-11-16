; Este código é um exemplo de programa em Assembly para o microcontrolador AVR ATmega328P.
; O programa configura a comunicação serial UART, configura as portas de entrada e saída,
; e decodifica valores de 0 a 15 para serem exibidos em um display de sete segmentos.

; Conversor de código ASCII para hexadecimal

; Autores : Joao da Cruz de Natividade e Silva Neto e Alydson de Araujo Lustoza

.equ DISPLAY = PORTB ; PORTB é onde está conectado o Display (seg a = LSB)
.equ F_CPU = 8000000 ; define a frequência do clock
.equ baud = 2400 ; Taxa de transmissão
.equ bps = (F_CPU/16/baud) - 1 ; Taxa de prescala para a UART
.def AUX = r18 ; registrador auxiliar

.ORG 0x00 ;Diretiva ara iniciar o programa
RJMP initDisplay ;desvia para o início do programa

.ORG 0x12 ;Diretiva para para tratamento de interrupção interna UART
RJMP USART_RX ;desvia para interrupção interna de recepção de dados

initDisplay: ;Sub-rotina inicializa o display de sete segmentos
    LDI AUX, 0xFF; carrega o valor 0xFF no registrador auxiliar
    OUT DDRB, AUX ; PORTB como saída
    OUT PORTB, AUX ; desliga o display

initUART: ; Sub-rotina de inicialização da UART   
    LDI R16,(1<<RXCIE0)|(1<<RXEN0)|(1<<TXEN0) ;habilita USART recepção completa, recepção e transmissão
    STS UCSR0B,R16

    LDI R16,LOW(bps) ;carregar pr-escala de transmissão
    LDI R17,HIGH(bps)
    STS UBRR0L,R16 ; carregar pr-escala de transmissão
    STS UBRR0H,R17 ; para UBRR0

    LDI R19,0
    STS UCSR0A,R19 ;desabilitar velocidade dupla:

    SEI ;habilita interrupções globais

main: ; Programa principal
    RJMP main ; Laço infinito

USART_RX:
    rcall Get_N ; Chama a sub-rotina getc
    reti ; Retorna para o programa principal

Get_N: ; trata interrupção de recepção de dados
    lds	R20,UDR0			; Carrega o byte recebido em r20

    cpi r20, 48  ; compara o valor recebido com o valor ASCII do algarismo 0
    BREQ num0      ; se for igual, chama a sub-rotina num1

    cpi r20, 49  ; compara o valor recebido com o valor ASCII do algarismo 1
    BREQ num1      ; se for igual, chama a sub-rotina num2

    cpi r20, 50  ; compara o valor recebido com o valor ASCII do algarismo 2
    BREQ num2      ; se for igual, chama a sub-rotina num3

    cpi r20, 51  ; compara o valor recebido com o valor ASCII do algarismo 3
    BREQ num3      ; se for igual, chama a sub-rotina num4

    cpi r20, 52  ; compara o valor recebido com o valor ASCII do algarismo 4
    BREQ num4      ; se for igual, chama a sub-rotina num5

    cpi r20, 53  ; compara o valor recebido com o valor ASCII do algarismo 5
    BREQ num5      ; se for igual, chama a sub-rotina num6

    cpi r20, 54  ; compara o valor recebido com o valor ASCII do algarismo 6
    BREQ num6      ; se for igual, chama a sub-rotina num7

    cpi r20, 55  ; compara o valor recebido com o valor ASCII do algarismo 7
    BREQ num7      ; se for igual, chama a sub-rotina num8

    cpi r20, 56  ; compara o valor recebido com o valor ASCII do algarismo 8
    BREQ num8      ; se for igual, chama a sub-rotina num9

    cpi r20, 57  ; compara o valor recebido com o valor ASCII do algarismo 9
    BREQ num9      ; se for igual, chama a sub-rotina numA

    cpi r20, 65  ; compara o valor recebido com o valor ASCII do algarismo A
    BREQ numA      ; se for igual, chama a sub-rotina numB

    cpi r20, 66  ; compara o valor recebido com o valor ASCII do algarismo B
    BREQ numB      ; se for igual, chama a sub-rotina numC

    cpi r20, 67  ; compara o valor recebido com o valor ASCII do algarismo C
    BREQ numC      ; se for igual, chama a sub-rotina numD

    cpi r20, 68  ; compara o valor recebido com o valor ASCII do algarismo D
    BREQ numD      ; se for igual, chama a sub-rotina numE

    cpi r20, 69  ; compara o valor recebido com o valor ASCII do algarismo E
    BREQ numE      ; se for igual, chama a sub-rotina numF

    cpi r20, 70  ; compara o valor recebido com o valor ASCII do algarismo F
    BREQ numF      ; se for igual, chama a sub-rotina traco
    
    rcall traco
	reti

num0: ; Rotina para exibir o número 0 no display de sete segmentos.
    ldi AUX, 0x40 ; Carrega o valor 0x40 no registrador auxilia
    OUT DISPLAY, AUX ; Mostra o valor do registrador auxiliar no display
    reti ; Retorna para o programa principal

num1: ; Rotina para exibir o número 1 no display de sete segmentos.
    ldi AUX, 0x79
    OUT DISPLAY, AUX
    reti

num2: ; Rotina para exibir o número 2 no display de sete segmentos.
    ldi AUX, 0x24
    OUT DISPLAY, AUX
    reti

num3: ; Rotina para exibir o número 3 no display de sete segmentos.
    ldi AUX, 0x30
    OUT DISPLAY, AUX
    reti

num4: ; Rotina para exibir o número 4 no display de sete segmentos.
    ldi AUX, 0x19
    OUT DISPLAY, AUX
    reti

num5: ; Rotina para exibir o número 5 no display de sete segmentos.
    ldi AUX, 0x12
    OUT DISPLAY, AUX
    reti

num6:; Rotina para exibir o número 6 no display de sete segmentos.
    ldi AUX, 0x02
    OUT DISPLAY, AUX
    reti

num7: ; Rotina para exibir o número 7 no display de sete segmentos.
    ldi AUX, 0x78
    OUT DISPLAY, AUX
    reti

num8: ; Rotina para exibir o número 8 no display de sete segmentos.
    ldi AUX, 0x00
    OUT DISPLAY, AUX
    reti

num9: ; Rotina para exibir o número 9 no display de sete segmentos.
    ldi AUX, 0x18
    OUT DISPLAY, AUX
    reti

numA: ; Rotina para exibir a letra A no display de sete segmentos.
    ldi AUX, 0x08
    OUT DISPLAY, AUX
    reti

numB: ; Rotina para exibir a letra B no display de sete segmentos.
    ldi AUX, 0x03
    OUT DISPLAY, AUX
    reti

numC: ; Rotina para exibir a letra C no display de sete segmentos.
    ldi AUX, 0x46
    OUT DISPLAY, AUX
    reti

numD: ; Rotina para exibir a letra D no display de sete segmentos.
    ldi AUX, 0x21
    OUT DISPLAY, AUX
    reti

numE: ; Rotina para exibir a letra E no display de sete segmentos.
    ldi AUX, 0x06
    OUT DISPLAY, AUX
    reti

numF: ; Rotina para exibir a letra F no display de sete segmentos.
    ldi AUX, 0x0E
    OUT DISPLAY, AUX
    reti

traco: ; Rotina para exibir o traço no display de sete segmentos.
    LDI AUX, 0x3F
    OUT DISPLAY, AUX ; liga o traco
    reti
