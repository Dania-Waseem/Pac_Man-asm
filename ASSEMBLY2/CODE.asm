; 23i-2622
; DS A
; COAL SEMESTER PROJECT 

include irvine32.inc

.data

	inputName db "Enter your name ... ",0
    username db 50 dup(0)

    pmtitle1 db "#################################################################################",0
    pmtitle2 db "#                                                                               # ",0
    pmtitle3 db "#      %%%%%%%%  %%%%%%%  %%%%%%%%     %%%%%   %%%%%  %%%%%%%%   %%      %      #",0
	pmtitle4 db "#      %%     %  %     %  %            %   %   %   %  %      %   % %     %      #",0
	pmtitle5 db "#      %%     %  %     %  %            %   %   %   %  %      %   %  %    %      #",0
	pmtitle6 db "#      %%%%%%%%  %%%%%%%  %       %%%  %   %%%%%   %  %%%%%%%%   %   %   %      #",0
	pmtitle7 db "#      %%        %     %  %            %           %  %      %   %    %  %      #",0
	pmtitle8 db "#      %%        %     %  %            %           %  %      %   %     % %      #",0
	pmtitle9 db "#      %%        %     %  %%%%%%%%     %           %  %      %   %      %%      #",0
	pmtitle10 db"#                                                                               #",0
	pmtitle11 db"#################################################################################",0

    redTxt = red+(black*16);
    yellowTxt =yellow+(black*16);
    greenTxt =green+ (black*16);
    blueTxt =blue+ (black*16);


.code
main proc

    call Clrscr         

    ; Red Color
    mov eax, redTxt
    call SetTextColor

    
    mov dh,5
    mov dl,10
    call Gotoxy
    mov edx, offset pmtitle1
    call WriteString

    mov dh, 6
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle2
    call WriteString

    mov dh, 7
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle3
    call WriteString


    ; Blue Color
    mov eax,blueTxt
    call SetTextColor

    mov dh, 8
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle4
    call WriteString

    mov dh, 9
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle5
    call WriteString

    mov dh, 10
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle6
    call WriteString


    mov dh, 11
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle7
    call WriteString


    ; Green Color 
    mov eax, greenTxt
    call SetTextColor

    mov dh, 12
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle8
    call WriteString


    mov dh,13
    mov dl,10
    call Gotoxy
    mov edx, offset pmtitle9
    call WriteString

    mov dh, 14
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle10
    call WriteString

    mov dh, 15
    mov dl, 10
    call Gotoxy
    mov edx, offset pmtitle11
    call WriteString

    ; Yellow for name input of player
    mov eax, yellowTxt
    call SetTextColor

    mov dh, 19
    mov dl, 10
    call Gotoxy
    mov edx, offset inputName
    call WriteString

   ;asking for user input
    mov edx, offset userName
    mov ecx, lengthof userName
    call ReadString


    exit
main endp
end main