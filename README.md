# Conversor de Código ASCII para Hexadecimal

![GitHub repo size](https://img.shields.io/github/repo-size/iuricode/README-template?style=for-the-badge)
![GitHub language count](https://img.shields.io/github/languages/count/joaosnet/uart_7display/README?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/iuricode/README-template?style=for-the-badge)
![Bitbucket open issues](https://img.shields.io/bitbucket/issues/iuricode/README-template?style=for-the-badge)
![Bitbucket open pull requests](https://img.shields.io/bitbucket/pr-raw/iuricode/README-template?style=for-the-badge)

<img src="imagem.png" alt="Exemplo de imagem">

> Este código é um exemplo de programa em Assembly para o microcontrolador AVR ATmega328P. O programa configura a comunicação serial UART, as portas de entrada e saída, e decodifica valores de 0 a 15 para serem exibidos em um display de sete segmentos.

## Conversor de Código ASCII para Hexadecimal

### Autores

- João da Cruz de Natividade e Silva Neto
- Alydson de Araujo Lustoza

## Configurações

```assembly
.equ DISPLAY = PORTB ; PORTB é onde está conectado o Display (seg a = LSB)
.equ F_CPU = 8000000 ; define a frequência do clock
.equ baud = 2400 ; Taxa de transmissão
.equ bps = (F_CPU/16/baud) - 1 ; Taxa de prescala para a UART
.def AUX = r18 ; registrador auxiliar
```

## Inicialização do Programa

```assembly
.ORG 0x00 ; Diretiva para iniciar o programa
RJMP initDisplay ; Desvia para o início do programa
```

## Inicialização do Display de Sete Segmentos

```assembly
initDisplay:
    LDI AUX, 0xFF
    OUT DDRB, AUX ; PORTB como saída
    OUT PORTB, AUX ; Desliga o display
```

## Inicialização da Comunicação Serial UART

```assembly
initUART:
    LDI R16, (1<<RXCIE0)|(1<<RXEN0)|(1<<TXEN0) ; Habilita USART recepção completa, recepção e transmissão
    STS UCSR0B, R16

    LDI R16, LOW(bps) ; Carregar pré-escala de transmissão
    LDI R17, HIGH(bps)
    STS UBRR0L, R16 ; Carregar pré-escala de transmissão para UBRR0
    STS UBRR0H, R17

    LDI R19, 0
    STS UCSR0A, R19 ; Desabilitar velocidade dupla

    SEI ; Habilita interrupções globais
```

## Programa Principal

```assembly
main:
    RJMP main ; Laço infinito
```

## Interrupção Interna UART (Recepção de Dados)

```assembly
USART_RX:
    rcall Get_N ; Chama a sub-rotina Get_N
    reti ; Retorna para o programa principal
```

## Sub-rotina para Tratar a Interrupção de Recepção de Dados

```assembly
Get_N:
    lds R20, UDR0 ; Carrega o byte recebido em r20

    ; Verifica o valor recebido e chama a sub-rotina correspondente
    cpi r20, 48
    BREQ num0
    ; ... (repete para os demais números e letras)

    rcall traco ; Se não corresponder a nenhum, chama a sub-rotina traco
    reti
```

## Sub-rotinas para Exibir Números e Letras no Display de Sete Segmentos

```assembly
; Exemplos para os números
num0: ldi AUX, 0x40 ; Carrega o valor 0x40 no registrador auxiliar
      OUT DISPLAY, AUX ; Mostra o valor do registrador auxiliar no display
      reti

num1: ldi AUX, 0x79
      OUT DISPLAY, AUX
      reti

; Repete para os demais números e letras...
```

## Sub-rotina para Exibir o Traço no Display de Sete Segmentos

```assembly
traco:
    LDI AUX, 0x3F
    OUT DISPLAY, AUX ; Liga o traço
    reti
```

Este programa é um exemplo educacional e pode ser modificado para atender às necessidades específicas do projeto. Certifique-se de entender completamente o código antes de aplicá-lo ao seu projeto.
