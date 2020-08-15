; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
  
  
.stack 1000
  
.data

gameboard db "     |     |     ", 13, 10
              db "     |     |     ", 13, 10
              db "_____|_____|_____", 13, 10 
              
              db "     |     |     ", 13, 10 
              db "     |     |     ", 13, 10
              db "_____|_____|_____", 13, 10
              db "     |     |     ", 13, 10
              db "     |     |     ", 13, 10
              db "     |     |     ", 13, 10
              
click dw ?
positionX dw ? 
positionY dw ?

xmsg db "XOXOXOXOX"    
  
 

.code
mov ax,@data
mov ds,ax



mov ax, 1
int 33h

mov di,0

mov cx,169
mov si,0

L1: 
mov ah,2 
mov dl,gameboard[si]
inc si 
int 21h
Loop L1



mouseCheck:
mov  ax, 3h
int  33h
mov  click, bx
mov positionX,cx 
mov positionY,dx
cmp  bx, 1h
je   mouseClick
jmp next 


mouseClick:
mov ax,positionY
mov bx,positionX
;mov dh, al
;mov dl, bl
cmp bx,42
jb firstcol
cmp bx,84
jb secondcol
cmp bx,126
jb thirdcol
jmp next
;call set_cursor
;call print_x

firstcol:
cmp ax,22
ja secondbox 
mov dh,0
mov dl,0
call set_cursor
call print_x
jmp mouseCheck 


secondbox:
cmp ax,44
ja thirdbox 
mov dh,3
mov dl,0
call set_cursor
call print_x
jmp mouseCheck


thirdbox:
mov dh,6
mov dl,0
call set_cursor
call print_x
jmp mouseCheck


secondcol: 
cmp ax,22
ja sc_secondbox 
mov dh,0
mov dl,6
call set_cursor
call print_x
jmp mouseCheck

sc_secondbox:
cmp ax,44
ja sc_thirdbox 
mov dh,3
mov dl,6
call set_cursor
call print_x
jmp mouseCheck


sc_thirdbox:
mov dh,6
mov dl,6
call set_cursor
call print_x
jmp mouseCheck

thirdcol: 
cmp ax,22
ja tc_secondbox 
mov dh,0
mov dl,12
call set_cursor
call print_x
jmp mouseCheck


tc_secondbox:
cmp ax,44
ja tc_thirdbox 
mov dh,3
mov dl,12
call set_cursor
call print_x
jmp mouseCheck

tc_thirdbox:
mov dh,6
mov dl,12
call set_cursor
call print_x
jmp mouseCheck 



next:
jmp mouseCheck



;INPUT : DL=X, DH=Y.
set_cursor proc
      mov  ah, 2                 
      mov  bh, 0                 
      int  10h                    
      RET
set_cursor endp


print_x proc
    mov ah,2
    mov dl,xmsg[di] 
    int 21h
    inc di
    ret
print_x endp 


