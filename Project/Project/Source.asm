include Irvine32.inc

asmcode PROTO C
login PROTO C
menu PROTO C
phone PROTO C
mod1 PROTO C
mod2 PROTO C
mod3 PROTO C
mod4 PROTO C
mod5 PROTO C
receipt PROTO C

.data
MAX = 80                      ;max chars to read
userinput BYTE MAX+1 DUP (?)  ;room for null
userinput2 BYTE MAX+1 DUP (?)  ;room for null
userselect BYTE MAX+1 DUP (?)  ;room for null
userinputmodel BYTE MAX+1 DUP (?)  ;room for null


askusername BYTE "Enter your username: ",0
askpassword BYTE "Enter your password: ",0
askselection BYTE "Please enter your selection: ",0
askmodel BYTE "Please enter the model ID to buy (X001) : ",0
askorder BYTE "Confirm the purchase by enter 1 (anykey to back to main): "
wrong BYTE "Invalid password or username, please enter again",0
correct BYTE " , Welcome Back!!",0
errormodel BYTE "Invalid model, please enter again",0
taxdesc BYTE "TAX (10%)       : RM",0
totaldesc BYTE "TOTAL           : RM",0
paymentdesc BYTE "Payment         : RM",0
payerrordesc BYTE "Your payment is failed. You will be redirect back menu.",0
refunddesc BYTE "Your refund     : RM",0
payerrordesc2 BYTE " (error)", 0
backtomain BYTE "Confirm the purchase by enter 1 (anykey to back to main): ", 0
userdesc BYTE "Customer: ",0
qtydesc BYTE "Quantity(Max 10): ",0
qtyprice BYTE "Price * Qty     : RM", 0


price1 dw 3000
price2 dw 3050
price3 dw 2500
price4 dw 2450
price5 dw 3100
errorrefund dw 2439
restrict dw 10
restrict2 dw 1

total dw ?
paid dw ?
tax dw ?
refund dw ?
temp dw ?
qty dw ?
qtytotal dw ?

username BYTE "User1" ,0
username2 BYTE "E002" ,0
username3 BYTE "E003" ,0
password BYTE "abc123" ,0
hidepassword BYTE "*****", 0

model1 BYTE "X001" ,0
model2 BYTE "X002" ,0
model3 BYTE "XR001" ,0
model4 BYTE "XR002" ,0
model5 BYTE "E001" ,0




.code

asmcode PROC C
invoke login 

loginagain:
call crlf
mov edx,OFFSET askusername
call WriteString

mov  edx,OFFSET userinput
mov  ecx,MAX            
call ReadString

INVOKE Str_compare, ADDR username , ADDR userinput
lea edx,username
je validuser 
jne invaliduser

validuser:
mov edx,OFFSET askpassword
call WriteString
mov  edx,OFFSET userinput2 

call ReadString

INVOKE Str_compare, ADDR password , ADDR userinput2
je validpassword 
jne invaliduser


validpassword:
call crlf
mov edx, OFFSET userinput
call writestring
mov edx,OFFSET correct
call WriteString
call crlf
call Waitmsg
jmp selectmenu


invaliduser:
mov edx,OFFSET wrong
call WriteString
call crlf
jmp loginagain

selectmenu:
invoke menu
mov edx, OFFSET askselection
call WriteString
call readchar
cmp al, '1'
call WriteChar
je showphone
cmp al, '2'
je orderphone
cmp al, '3'
je logout
jne stop

logout:
jmp asmcode

showphone:
invoke phone
call Waitmsg
jmp selectMenu

stop:
call crlf
call Waitmsg
invoke ExitProcess, 0

orderphone:
invoke phone
mov edx,OFFSET askmodel
call WriteString
mov  edx,OFFSET userinputmodel
mov  ecx,MAX            
call ReadString

INVOKE Str_compare, ADDR model1 , ADDR userinputmodel
je modelone
INVOKE Str_compare, ADDR model2 , ADDR userinputmodel
je modeltwo
INVOKE Str_compare, ADDR model3 , ADDR userinputmodel
je modelthree
INVOKE Str_compare, ADDR model4 , ADDR userinputmodel
je modelfour
INVOKE Str_compare, ADDR model5 , ADDR userinputmodel
je modelfive
jne error


modelone:
invoke mod1
mov edx,OFFSET backtomain
call WriteString
call readchar
call Writechar
cmp al, '1'
je calculate1
jne selectmenu

calculate1:

call crlf
mov edx, OFFSET qtydesc
call WriteString
call readDec
mov qty, ax

mov bx, restrict
cmp bx, qty
jl qtyerror
mov bx, restrict2
cmp bx, qty
jg qtyerror



mov bx, price1
imul bx
mov edx, OFFSET qtyprice
call WriteString
mov qtytotal, ax
call writedec
call crlf

mov ax, qtytotal
mov bx, 000AH
xor dx, dx          
div bx
mov edx,OFFSET taxdesc
call WriteString
call WriteDec
mov tax, ax
call crlf
mov edx,OFFSET totaldesc
mov ax, qtytotal
add ax, tax
call WriteString
call WriteDec
mov total, ax
call crlf
jmp payment1

payment1:
mov edx,OFFSET paymentdesc
call WriteString
call readDec
mov paid, ax

sub ax, total
mov edx,OFFSET refunddesc
call WriteString
call WriteDec

cmp ax, refund
jl paymenterror


mov refund, ax
mov ax , paid
cmp ax , total
jl paymenterror
cmp ax , tax
jl paymenterror

call crlf
call Waitmsg
call clrscr
jmp genreceipt1

genreceipt1:
invoke receipt

mov edx,OFFSET userdesc
call WriteString
mov edx,OFFSET userinput
call WriteString
call crlf

invoke mod1
call crlf
mov edx,OFFSET taxdesc
call WriteString
mov ax, tax
call WriteDec
call crlf

mov edx,OFFSET totaldesc
call WriteString
mov ax, total
call WriteDec
call crlf

mov edx,OFFSET paymentdesc
call WriteString
mov ax, paid
call WriteDec
call crlf

mov edx,OFFSET refunddesc
call WriteString
mov ax, refund
call WriteDec
call crlf

call Waitmsg
jmp selectmenu



modeltwo:

invoke mod2
mov edx,OFFSET backtomain
call WriteString
call readchar
call Writechar
cmp al, '1'
je calculate2
jne selectmenu

calculate2:

call crlf
mov edx, OFFSET qtydesc
call WriteString
call readDec
mov qty, ax

mov bx, restrict
cmp bx, qty
jl qtyerror
mov bx, restrict2
cmp bx, qty
jg qtyerror



mov bx, price2
imul bx
mov edx, OFFSET qtyprice
call WriteString
mov qtytotal, ax
call writedec
call crlf

mov ax, qtytotal
mov bx, 000AH
xor dx, dx          
div bx
mov edx,OFFSET taxdesc
call WriteString
call WriteDec
mov tax, ax
call crlf
mov edx,OFFSET totaldesc
mov ax, qtytotal
add ax, tax
call WriteString
call WriteDec
mov total, ax
call crlf
jmp payment2


payment2:
mov edx,OFFSET paymentdesc
call WriteString
call readDec
mov paid, ax

sub ax, total
mov edx,OFFSET refunddesc
call WriteString
call WriteDec

cmp ax, refund
jl paymenterror


mov refund, ax
mov ax , paid
cmp ax , total
jl paymenterror
cmp ax , tax
jl paymenterror

call crlf
call Waitmsg
call clrscr
jmp genreceipt2

genreceipt2:
invoke receipt

mov edx,OFFSET userdesc
call WriteString
mov edx,OFFSET userinput
call WriteString
call crlf

invoke mod2
call crlf
mov edx,OFFSET taxdesc
call WriteString
mov ax, tax
call WriteDec
call crlf

mov edx,OFFSET totaldesc
call WriteString
mov ax, total
call WriteDec
call crlf

mov edx,OFFSET paymentdesc
call WriteString
mov ax, paid
call WriteDec
call crlf

mov edx,OFFSET refunddesc
call WriteString
mov ax, refund
call WriteDec

call crlf

call Waitmsg
jmp selectmenu

modelthree:
invoke mod3
mov edx,OFFSET backtomain
call WriteString
call readchar
call Writechar
cmp al, '1'
je calculate3
jne selectmenu

calculate3:

call crlf
mov edx, OFFSET qtydesc
call WriteString
call readDec
mov qty, ax

mov bx, restrict
cmp bx, qty
jl qtyerror
mov bx, restrict2
cmp bx, qty
jg qtyerror



mov bx, price3
imul bx
mov edx, OFFSET qtyprice
call WriteString
mov qtytotal, ax
call writedec
call crlf

mov ax, qtytotal
mov bx, 000AH
xor dx, dx          
div bx
mov edx,OFFSET taxdesc
call WriteString
call WriteDec
mov tax, ax
call crlf
mov edx,OFFSET totaldesc
mov ax, qtytotal
add ax, tax
call WriteString
call WriteDec
mov total, ax
call crlf
jmp payment3

payment3:
mov edx,OFFSET paymentdesc
call WriteString
call readDec
mov paid, ax

sub ax, total
mov edx,OFFSET refunddesc
call WriteString
call WriteDec

cmp ax, refund
jl paymenterror


mov refund, ax
mov ax , paid
cmp ax , total
jl paymenterror
cmp ax , tax
jl paymenterror

call crlf
call Waitmsg
call clrscr
jmp genreceipt3

genreceipt3:
invoke receipt

mov edx,OFFSET userdesc
call WriteString
mov edx,OFFSET userinput
call WriteString
call crlf

invoke mod3
call crlf
mov edx,OFFSET taxdesc
call WriteString
mov ax, tax
call WriteDec
call crlf

mov edx,OFFSET totaldesc
call WriteString
mov ax, total
call WriteDec
call crlf

mov edx,OFFSET paymentdesc
call WriteString
mov ax, paid
call WriteDec
call crlf

mov edx,OFFSET refunddesc
call WriteString
mov ax, refund
call WriteDec
call crlf

call Waitmsg
jmp selectmenu

modelfour:

invoke mod4
mov edx,OFFSET backtomain
call WriteString
call readchar
call Writechar
cmp al, '1'
je calculate4
jne selectmenu

calculate4:

call crlf
mov edx, OFFSET qtydesc
call WriteString
call readDec
mov qty, ax

mov bx, restrict
cmp bx, qty
jl qtyerror
mov bx, restrict2
cmp bx, qty
jg qtyerror

mov bx, price4
imul bx
mov edx, OFFSET qtyprice
call WriteString
mov qtytotal, ax
call writedec
call crlf

mov ax, qtytotal
mov bx, 000AH
xor dx, dx          
div bx
mov edx,OFFSET taxdesc
call WriteString
call WriteDec
mov tax, ax
call crlf
mov edx,OFFSET totaldesc
mov ax, qtytotal
add ax, tax
call WriteString
call WriteDec
mov total, ax
call crlf
jmp payment4

payment4:
mov edx,OFFSET paymentdesc
call WriteString
call readDec
mov paid, ax

sub ax, total
mov edx,OFFSET refunddesc
call WriteString
call WriteDec

cmp ax, refund
jl paymenterror


mov refund, ax
mov ax , paid
cmp ax , total
jl paymenterror
cmp ax , tax
jl paymenterror

call crlf
call Waitmsg
call clrscr
jmp genreceipt4

genreceipt4:
invoke receipt

mov edx,OFFSET userdesc
call WriteString
mov edx,OFFSET userinput
call WriteString
call crlf

invoke mod4
call crlf
mov edx,OFFSET taxdesc
call WriteString
mov ax, tax
call WriteDec
call crlf

mov edx,OFFSET totaldesc
call WriteString
mov ax, total
call WriteDec
call crlf

mov edx,OFFSET paymentdesc
call WriteString
mov ax, paid
call WriteDec
call crlf

mov edx,OFFSET refunddesc
call WriteString
mov ax, refund
call WriteDec
call crlf

call Waitmsg
jmp selectmenu

modelfive:

invoke mod5
mov edx, 0
mov edx,OFFSET backtomain
call WriteString
call readchar
call Writechar
cmp al, '1'
je calculate5
jne selectmenu

calculate5:

call crlf
mov edx, OFFSET qtydesc
call WriteString
call readDec
mov qty, ax

mov bx, restrict
cmp bx, qty
jl qtyerror
mov bx, restrict2
cmp bx, qty
jg qtyerror

mov bx, price5
imul bx
mov edx, OFFSET qtyprice
call WriteString
mov qtytotal, ax
call writedec
call crlf

mov ax, qtytotal
mov bx, 000AH
xor dx, dx          
div bx
mov edx,OFFSET taxdesc
call WriteString
call WriteDec
mov tax, ax
call crlf
mov edx,OFFSET totaldesc
mov ax, qtytotal
add ax, tax
call WriteString
call WriteDec
mov total, ax
call crlf
jmp payment5


payment5:
mov edx,OFFSET paymentdesc
call WriteString
call readDec
mov paid, ax

sub ax, total
mov edx,OFFSET refunddesc
call WriteString
call WriteDec

cmp ax, refund
jl paymenterror


mov refund, ax
mov ax , paid
cmp ax , total
jl paymenterror
cmp ax , tax
jl paymenterror

call crlf
call Waitmsg
call clrscr
jmp genreceipt5

genreceipt5:
invoke receipt

mov edx,OFFSET userdesc
call WriteString
mov edx,OFFSET userinput
call WriteString
call crlf

invoke mod5
call crlf
mov edx,OFFSET taxdesc
call WriteString
mov ax, tax
call WriteDec
call crlf

mov edx,OFFSET totaldesc
call WriteString
mov ax, total
call WriteDec
call crlf

mov edx,OFFSET paymentdesc
call WriteString
mov ax, paid
call WriteDec
call crlf

mov edx,OFFSET refunddesc
call WriteString
mov ax, refund
call WriteDec
call crlf

call Waitmsg
jmp selectmenu




error:
mov edx, OFFSET errormodel
call WriteString
call crlf
call Waitmsg
jmp orderphone

paymenterror:
mov edx, OFFSET payerrordesc2
call WriteString
call crlf
mov edx, OFFSET payerrordesc
call WriteString
call crlf
call Waitmsg
jmp selectmenu

qtyerror:
mov edx, OFFSET payerrordesc2
call WriteString
call crlf
mov edx, OFFSET payerrordesc
call WriteString
call crlf
call Waitmsg
jmp selectmenu


asmcode ENDP
end
