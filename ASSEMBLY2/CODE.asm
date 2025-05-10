; 23i-2622
; DS A
; COAL SEMESTER PROJECT 

include irvine32.inc

.data
    
    fileName  db "Scores.txt" 
	inputName db "Enter your name ... ",0
    username  db 50 dup(0)

    pmtitle1 db "#################################################################################",0
    pmtitle2 db "#                                                                               #",0
    pmtitle3 db "#      %%%%%%%%  %%%%%%%  %%%%%%%%     %%%%%   %%%%%  %%%%%%%%   %%      %      #",0
	pmtitle4 db "#      %%     %  %     %  %            %   %   %   %  %      %   % %     %      #",0
	pmtitle5 db "#      %%     %  %     %  %            %   %   %   %  %      %   %  %    %      #",0
	pmtitle6 db "#      %%%%%%%%  %%%%%%%  %       %%%  %   %%%%%   %  %%%%%%%%   %   %   %      #",0
	pmtitle7 db "#      %%        %     %  %            %           %  %      %   %    %  %      #",0
	pmtitle8 db "#      %%        %     %  %            %           %  %      %   %     % %      #",0
	pmtitle9 db "#      %%        %     %  %%%%%%%%     %           %  %      %   %      %%      #",0
	pmtitle10 db"#                                                                               #",0
	pmtitle11 db"#################################################################################",0

    menutitle0 db " ___     ___ _________  ___     ___ ___   ___ ",0
    menutitle1 db " |  \   /  | |  ______| |  \    | | | |   | | ",0
    menutitle2 db " | |\\_//| | | |______  | |\\   | | | |   | |",0
    menutitle3 db " | | \_/ | | | _______| | | \\  | | | |   | | ",0
    menutitle4 db " | |     | | | |______  | |  \\ | | | |___| |",0
    menutitle5 db " |_|     |_| |________| |_|   \\|_| |_______| ",0

    menuopt0 db "---------------------------------",0
    menuopt1 db "|  1. Start Game ( 3 levels)    |",0
    menuopt2 db "|  2. Display Game Instructions |",0
    menuopt3 db "|  3. View Highscores /scores   |",0
    menuopt4 db "|  4. Exit Game                 |",0
    menuopt5 db "|_______________________________|",0

    menuoptchoose db "Enter your choice:  ",0

    level1opt0 db "*     ***** *       * *****  *          **    ",0
    level1opt1 db "*     *      *     *  *      *          **    ",0
    level1opt2 db "*     *****   *   *   *****  *          **    ",0
    level1opt3 db "*     *        * *    *      *          **    ",0
    level1opt4 db "***** *****     *     *****  *****      **    ",0

    level2opt0 db "*     ***** *       * *****  *         *****  ",0
    level2opt1 db "*     *      *     *  *      *             *  ",0
    level2opt2 db "*     *****   *   *   *****  *         *****  ",0
    level2opt3 db "*     *        * *    *      *         *      ",0
    level2opt4 db "***** *****     *     *****  *****     *****  ",0

    level3opt0 db "*     ***** *       * *****  *         *****  ",0
    level3opt1 db "*     *      *     *  *      *             *  ",0
    level3opt2 db "*     *****   *   *   *****  *         *****  ",0
    level3opt3 db "*     *        * *    *      *             *  ",0
    level3opt4 db "***** *****     *     *****  *****     *****  ",0

    leveloptchoose1 db " Enter you choice (1: Level 1, 2: Level 2 , 3: Level 3)",0
    leveloptchoose2 db " Return to Main Menu (press 4), Exit Game (press 5)",0


    instruc1 db "                          INSTRUCTIONS                             ",0
    instruc2 db "_______________________________________________________________________",0
    instruc3 db "-----------------------------------------------------------------------",0
    instruc4 db " 1. To earn points eat the pellets.",0
    instruc5 db " 2. Each pellet is worth one point.",0
    instruc6 db " 3  Stay away from the ghosts, if one catches you, You lose a life.",0
    instruc7 db " 4. Use W,A,S,D keys move up,down,left and right respectively.",0
    instruc8 db "________________________________________________________________________",0
    instruc9 db "------------------------------------------------------------------------",0

    instrucChoose db "Press 1 to return to menu, Press 2 to Exit Game",0

    hsTitle0 db "        ______        _____  _____ ______ _____ _____ _____  ",0
    hsTitle1 db "|   | | |      |   |  |      |     |    | |   | |     |      ",0
    hsTitle2 db "|___| | |  ___ |___|  |____  |     |    | |___| |____ |____  ",0
    hsTitle3 db "|   | | |    | |   |       | |     |    | | \   |          | ",0
    hsTitle4 db "|   | | |____| |   |  _____| |____ |____| |  \  |____  ____| ",0

    gamePause1 db "...GAME PAUSED...",0
    gamePause2 db "Press 1: Resume Game",0
    gamePause3 db "Press 2: Go to Menu",0
    gamePause4 db "Press 3: Exit Game",0


   

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
    mov dl,12
    call Gotoxy
    mov edx, offset pmtitle1
    call WriteString

    mov dh, 6
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle2
    call WriteString

    mov dh, 7
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle3
    call WriteString


    ; Blue Color
    mov eax,blueTxt
    call SetTextColor

    mov dh, 8
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle4
    call WriteString

    mov dh, 9
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle5
    call WriteString

    mov dh, 10
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle6
    call WriteString


    mov dh, 11
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle7
    call WriteString


    ; Green Color 
    mov eax, greenTxt
    call SetTextColor

    mov dh, 12
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle8
    call WriteString


    mov dh,13
    mov dl,12
    call Gotoxy
    mov edx, offset pmtitle9
    call WriteString

    mov dh, 14
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle10
    call WriteString

    mov dh, 15
    mov dl, 12
    call Gotoxy
    mov edx, offset pmtitle11
    call WriteString

    ; Yellow for name input of player
    mov eax, yellowTxt
    call SetTextColor

    mov dh, 19
    mov dl, 12
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