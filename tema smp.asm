include 'emu8086.inc'
ORG 100h ;setam originea la 256px;

.model small
.stack 100h
.data
    msg1 db "Prima cifra a lungimii primei laturi: $"
    msg2 db "A doua cifra a lungimii primei laturi: $"
    msg3 db "Prima cifra a lungimii laturii 2: $" 
    msg4 db "A doua cifra a lungimii laturii 2: $"
    num1 dw 0
    num2 dw 0
    num3 dw 0
    num4 dw 0
    num5 dw 0
    num6 dw 0
    num7 dw 0
    num8 dw 0         ;variabile auxiliare
    num9 dw 0
    num10 dw 0
    num11 dw 0
    num12 dw 0
code:
 mov dx,offset msg1
        mov ah,09h
        int 21h

        mov ah,01h           ;citeste prima cifra 
        int 21h
        sub al,48
        mov b.num1,al 
                    
 mov ah, 02
mov dl, 0DH
int 21h           ;trece la linie noua
mov dl, 0AH
int 21H
                               
                    
                    
  mov dx,offset msg2
        mov ah,09h
        int 21h
                                  ;citeste a doua cifra
        mov ah,01h
        int 21h
        sub al,48
        mov b.num2,al    
        
  mov ah, 02
mov dl, 0DH
int 21h
mov dl, 0AH
int 21H       

 mov dx,offset msg3
        mov ah,09h
        int 21h

        mov ah,01h          ;citeste cifra 3
        int 21h
        sub al,48
        mov b.num3,al 
                    
 mov ah, 02
mov dl, 0DH
int 21h
mov dl, 0AH
int 21H
                               
                    
                    
  mov dx,offset msg4
        mov ah,09h
        int 21h
                            ;citeste cifra 4
        mov ah,01h
        int 21h
        sub al,48
        mov b.num4,al   
        
mov ax,num1
mov bx,10
imul bx
mov num5,ax       ;creeaza numarul compus din cele 2 cifre inmultind-o pe prima cu 10 si o aduna cu a doua
mov ax,num2
add num5,ax  

mov ax,num3
mov bx,10
imul bx
mov num6,ax       ;creeaza numarul compus din cele 2 cifre inmultind-o pe prima cu 10 si o aduna cu a doua
mov ax,num4
add num6,ax  

mov dx, 0     
mov ax, num5
mov bx, 3
div bx       ; Imparte num5 la 3. DX = rest si AX = cat   
mov num7,ax

mov dx, 0     
mov ax, num6
mov bx, 3
div bx       ; Imparte num6 la 3. DX = rest si AX = cat
mov num8,ax

mov ax,40
add num9,ax
mov ax,num8
add num9,ax 
mov ax,num8     
add num9,ax    
mov ax,num6
sub num9,ax 

mov ax,100
add num10,ax       ;calcule necesare pentru calculul coordonatelor punctelor paralelipipedului
mov ax,num7
add num10,ax 

mov ax,40
add num11,ax
mov ax,num8
add num11,ax
mov ax,num8
add num11,ax

mov ax,100
add num12,ax
mov ax,num5
add num12,ax



mov ah,0
mov al,13h ; trecere in mod grafic
int 10h

;patratul din fata

;sus
mov cx,100          ;coloana   
add cx,num5         ;adauga la cx lungimea laturii
mov dx, 40          ;rand
mov al, 8           ;culoarea
u1: mov ah, 0ch     ;afisare pixeli
int 10h
dec cx
cmp cx, 100
jae u1    
   
;jos 
mov cx,100
add cx,num5
mov dx, 40
add dx,num6
mov al,8
u2:mov ah, 0ch
int 10h
dec cx
cmp cx, 100
ja u2 

;stanga
mov cx,100
mov dx,40
add dx,num6
mov al,8
u3: mov ah, 0ch
int 10h
dec dx
cmp dx, 40
ja u3 
 
;dreapta
mov cx,100  
add cx,num5
mov dx,40  
add dx,num6
mov al,8
u4: mov ah, 0ch
int 10h
dec dx
cmp dx, 40
ja u4 
           

;stanga 2
mov cx,100
add cx,num7
mov dx,40 
add dx,num8
add dx,num8
mov al,8
u5: mov ah, 0ch
int 10h
dec dx
cmp dx,num9
ja u5
  
;jos 2
mov cx,100
add cx,num7 
add cx,num5
mov dx,40
add dx,num8
add dx,num8
mov al,8
u6: mov ah,0ch
int 10h
dec cx
cmp cx,num10
ja u6

;dreapta 2
mov cx,100
add cx,num7
add cx,num5
mov dx,40
add dx,num8
add dx,num8
mov al,8
u7: mov ah, 0ch
int 10h
dec dx
cmp dx,num9
ja u7

;sus 2
mov cx,100
add cx,num7
add cx,num5
mov dx,40
add dx,num8
add dx,num8
sub dx,num6
mov al,8
u8:mov ah, 0ch
int 10h
dec cx
cmp cx,num10
ja u8  

;muchie stanga/jos
mov cx,100
mov dx,40
add dx,num6
mov al,8
u9: mov ah, 0ch
int 10h
inc cx
dec dx
cmp dx,num11
ja u9   

;muchie dreapta/jos
mov cx,100
add cx,num5
mov dx,40
add dx,num6
mov al,8
u10: mov ah, 0ch
int 10h
inc cx
dec dx
cmp dx,num11
ja u10

;muchie dreapta-sus
mov cx,100
add cx,num7
add cx,num5
mov dx,40
add dx,num8
add dx,num8
sub dx,num6
mov al,8
u11: mov ah, 0ch
int 10h
dec cx
inc dx
cmp cx,num12
ja u11
 
;muchie stanga-sus
mov cx,100
add cx,num7
mov dx,40
add dx,num8
add dx,num8
sub dx,num6
mov al,8
u12: mov ah, 0ch
int 10h
dec cx
inc dx
cmp cx,100
ja u12 


;sunet terminare program
mov dl, 07h
mov ah, 2 
int 21h 
int 20h 

ret     
