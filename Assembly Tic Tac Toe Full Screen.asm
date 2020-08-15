; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
  
  
.stack 1000
  
.data

;rows db "_" 
columns db "|" 
              
click dw ?
positionX dw ? 
positionY dw ?

xmsg db "XOXOXOXOX"

;temp dw 10     
  
 

.code
mov ax,@data
mov ds,ax

mov dl,0 
mov dh,6
 
mov cx,2 
Rows:  
mov  ah, 2                 
mov  bh, 0                 
int  10h
push cx 
mov cx,73
Print: 
mov dl,"_" 
;mov ah,2 
int 21h
loop Print
pop cx
mov dl,0 
mov dh,12
loop Rows


mov dl,25
mov dh,0 
mov cx,24
DrawFirstCol:
mov  ah, 2                 
mov  bh, 0                 
int  10h
push dx 
mov dl,"|"
int 21h 
pop dx 
inc dh 
Loop DrawFirstCol


mov dl,50
mov dh,0 
mov cx,24
DrawSecCol:
mov  ah, 2                 
mov  bh, 0                 
int  10h
push dx 
mov dl,"|"
int 21h 
pop dx 
inc dh 
Loop DrawSecCol 


;mov cx,900
;mov si,0

;L1: 
;mov ah,2 
;mov dl,gameboard[si]
;inc si 
;int 21h
;Loop L1






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
cmp bx,201
jb firstcol
cmp bx,402
jb secondcol
cmp bx,603
jb thirdcol
jmp next


firstcol:
cmp ax,53
ja secondbox 
mov dh,1
mov dl,1
call set_cursor
call print_x
jmp mouseCheck

secondbox:
cmp ax,106
ja thirdbox 
mov dh,8
mov dl,1
call set_cursor
call print_x
jmp mouseCheck



thirdbox:
mov dh,14
mov dl,1
call set_cursor
call print_x
jmp mouseCheck

 
secondcol: 
cmp ax,53
ja sc_secondbox 
mov dh,1
mov dl,29
call set_cursor
call print_x
jmp mouseCheck



sc_secondbox:
cmp ax,106
ja sc_thirdbox 
mov dh,8
mov dl,29
call set_cursor
call print_x
jmp mouseCheck

sc_thirdbox:
mov dh,15
mov dl,29
call set_cursor
call print_x
jmp mouseCheck


thirdcol: 
cmp ax,53
ja tc_secondbox 
mov dh,1
mov dl,55
call set_cursor
call print_x
jmp mouseCheck


tc_secondbox:
cmp ax,106
ja tc_thirdbox 
mov dh,10
mov dl,55
call set_cursor
call print_x
jmp mouseCheck

tc_thirdbox:
mov dh,15
mov dl,55
call set_cursor
call print_x
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

next:
jmp mouseCheck
