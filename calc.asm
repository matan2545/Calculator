;my name is matan antebi
IDEAL
MODEL small
STACK 100h
DATASEG
	num1 db 0
	peula db 0
	num2 db 0
	reasult_db db ?   
	reasult_dw dw ?  
	var1 db ?       
	sheerit db ?       
	var2 db ?       
	msg db '='  
	sum db 0
	ints1 db 10, 13, '$'
	msg2 db 'welocme to the calculator', 10, 13, 'you can use one digit numbers and (+, -, /, *)', 10, 13, 'press esc to exit', 10, 13,'$'
	errormsg db 10, 13,'Error, try again, $', 10, 13
	;--------------------
; Your variables here
;-------------------
CODESEG
proc sidraa
	xor ax, ax
	mov cl, [num2]
	mov al, [num1]
	sub cl, 1
	mov [sum], al
se:
	add al, [num2]
	add [sum], al
	loop se
	mov al, [sum]
	mov [reasult_db], al
	cmp [reasult_db], 9
	jbe meow
	call Print2
	jmp endd
meow:
	call Print1
	jmp endd
endd:
ret
endp sidraa
proc Print1
	mov dl, '='
	mov ah, 2h
	int 21h
	mov dl, [reasult_db]
	add dl, 48d
	mov ah, 2h
	int 21h
	mov dl, 13
	mov ah, 2h
	int 21h
	mov dl, 10
	mov ah, 2h
	int 21h
ret
endp Print1
;=========================
proc Print2
	mov dl, '='
	mov ah, 2h
	int 21h
	xor ah, ah
	mov al, [reasult_db]
	mov bl, 10d
	div bl
	mov [var1], al
	mov [var2], ah
	add [var1], 48d
	add [var2], 48d
	mov dl, [var1]
	mov ah, 2h
	int 21h
	mov dl, [var2]
	mov ah, 2h
	int 21h
	mov dl, 13
	mov ah, 2h
	int 21h
	mov dl, 10
	mov ah, 2h
	int 21h
ret
endp Print2
;=============================
proc print_2_dw
	mov dl, '='
	mov ah, 2h
	int 21h
	xor ah, ah
	mov ax, [reasult_dw]
	mov bl, 10d
	div bl
	mov [var1], al
	mov [var2], ah
	add [var1], 48d
	add [var2], 48d
	mov dl, [var1]
	mov ah, 2h
	int 21h
	mov dl, [var2]
	mov ah, 2h
	int 21h
	mov dl, 13
	mov ah, 2h
	int 21h
	mov dl, 10
	mov ah, 2h
	int 21h
	ret
endp print_2_dw
;===============================
proc print_1_dw
	mov dl, '='
	mov ah, 2h
	int 21h
	mov ax, [reasult_dw]
	mov bl, 1
	div bl
	mov dl, al
	add dl, 48d
	mov ah, 2h
	int 21h
	mov dl, 13
	mov ah, 2h
	int 21h
	mov dl, 10
	mov ah, 2h
	int 21h
ret
endp print_1_dw
;===============================
proc printdiv
	mov dl, '='
	mov ah, 2h
	int 21h
	add [reasult_db], 48d
	mov dl, [reasult_db]
	mov ah, 2h
	int 21h
	mov dl, '.'
	mov ah, 2h
	int 21h
	add [sheerit], 48d
	mov dl, [sheerit]
	mov ah, 2h
	int 21h
	mov dl, 13
	mov ah, 2h
	int 21h
	mov dl, 10
	mov ah, 2h
	int 21h
ret
endp printdiv
start:
	mov ax, @data
	mov ds, ax
;---------------------
; your code here
;---------------------
	mov dx, offset msg2
	mov ah, 9h
	int 21h
start_here:
	xor ax, ax
	xor bx, bx
	xor cx, cx
	mov [sum], 0
	mov ah, 1
	int 21h	
	mov [num1], al
	cmp [num1] ,27d
	je mid_jmp
	sub [num1], 48d
	mov ah, 1
	int 21h	
	mov [peula], al
	mov ah, 1
	int 21h	
	mov [num2], al
	sub [num2], 48d
	cmp [peula], '+'
	je plusAdd
	cmp [peula], '-'
	je minuSub
	cmp [peula],'*'
	je mulnum
	cmp [peula],'/'
	je divnum
	cmp [peula],'s'
	jne errorso
	jmp sidra
errorso:
	mov dx, offset errormsg
	mov ah, 9h
	int 21h
	mov dx, offset ints1
	mov ah, 9h
	int 21h
	jmp start_here
plusAdd:
	mov al, [num2]
	add al, [num1]
	mov [reasult_db], al
	cmp [reasult_db], 9
	jbe digit_1
	call Print2
	jmp start_here
digit_1:	
	call Print1
	jmp start_here
mid_jmp:
	jmp exit 
minuSub:
	mov cl,[num1]
	sub cl, [num2]
	mov [reasult_db], cl
	call Print1
	jmp start_here
mulnum:
	xor ax, ax
	mov al, [num2]
	mul [num1]
	mov [reasult_dw], ax
	cmp [reasult_dw], 9
	jbe digit_1mul
	call print_2_dw
	jmp start_here
digit_1mul:	
	call print_1_dw
	jmp start_here
divnum:
	cmp [num2], 0
	je errorso
	xor ax, ax
	mov al, [num1]
	div [num2]
	mov [reasult_db], al
	mov [sheerit], ah
	call printdiv
	jmp start_here
sidra:
	call sidraa
exit:
mov ax, 4c00h
int 21h
END start
