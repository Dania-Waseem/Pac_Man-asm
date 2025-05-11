; 23i-2622
; DS A
; COAL SEMESTER PROJECT 



include irvine32.inc
includelib winmm.lib  ; Windows multimedia library

; the below are variables for sound (took help from internet to load sounds)

SND_FILENAME      EQU 00020000h
SND_ASYNC         EQU 00000001h
SND_SYNC          EQU 00000000h
NULL              EQU 0


PlaySound PROTO STDCALL, 
    pszSound:DWORD, 
    hmod:DWORD, 
    fdwSound:DWORD


GAME_WIDTH = 80 
INFO_START = 90

.data

    midSound db "C:\Users\DELL\OneDrive\Desktop\game.wav",0
    PacmanIntro db "C:\Users\DELL\OneDrive\Desktop\pacman_beginning.wav",0

    SoundError db "Sound file not found or couldn't be played!",0
    
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

    leveloptchoose1 db " Enter you choice (1: Level 1, 2: Level 2 , 3: Level 3) ",0
    leveloptchoose2 db " Return to Main Menu (press 4), Exit Game (press 5) ",0


    instruc1 db "                          INSTRUCTIONS                             ",0
    instruc2 db "_______________________________________________________________________",0
    instruc3 db "-----------------------------------------------------------------------",0
    instruc4 db " 1. To earn points eat the pellets.",0
    instruc5 db " 2. Each pellet is worth one point.",0
    instruc6 db " 3  Stay away from the ghosts, if one catches you, You lose a life.",0
    instruc7 db " 4. Use W,A,S,D keys move up,down,left and right respectively.",0
    instruc8 db "________________________________________________________________________",0
    instruc9 db "------------------------------------------------------------------------",0

    instrucChoose db "Press 1 to return to menu, Press 2 to Exit Game: ",0

    hsTitle0 db "        ______        _____  _____ ______ _____ _____ _____  ",0
    hsTitle1 db "|   | | |      |   |  |      |     |    | |   | |     |      ",0
    hsTitle2 db "|___| | |  ___ |___|  |____  |     |    | |___| |____ |____  ",0
    hsTitle3 db "|   | | |    | |   |       | |     |    | | \   |          | ",0
    hsTitle4 db "|   | | |____| |   |  _____| |____ |____| |  \  |____  ____| ",0

    gamePause1 db "...GAME PAUSED...",0
    gamePause2 db "Press 1: Resume Game",0
    gamePause3 db "Press 2: Go to Menu",0
    gamePause4 db "Press 3: Exit Game",0


    ;yeh colors hain 
    redTxt = red+(black*16);
    yellowTxt =yellow+(black*16);
    greenTxt =green+ (black*16);
    blueTxt =blue+ (black*16);
    whiteTxt =white+ (black *16);

    userChoice db ?
    temp db ?
    currentLevel db ?
;-----------------------------------------
;level 1 vars
    score dd 0
    highScore dd 0
    lives db 3
    playerName db 20 dup(' ')   ; From your welcome screen
    
    levelText db "LEVEL 1",0
    scoreText db "SCORE: ",0
    highScoreText db "HIGHSCORE: ",0
    livesText db "LIVES: ",0
    playerText db "PLAYER: ",0
    
    wallChar db '#'


.code
main proc
    call Clrscr
    call WelcomeScreen
    call MenuScreen
    
    exit
main endp

;-----------------------------------------------------
introSound PROC
    push eax
    push edx

    INVOKE PlaySound, OFFSET PacmanIntro, NULL, SND_FILENAME OR SND_ASYNC
    
    test eax, eax
    jnz no_error1
    mov edx, OFFSET SoundError
    call WriteString
no_error1:
    pop edx
    pop eax
    ret
introSound ENDP

;-----------------------------------------------------
levelSound PROC
    push eax
    push edx
    INVOKE PlaySound, OFFSET midSound, NULL, SND_FILENAME OR SND_ASYNC
    test eax, eax
    jnz no_error2
    mov edx, OFFSET SoundError
    call WriteString
no_error2:
    pop edx
    pop eax
    ret
levelSound ENDP

;-----------------------------------------------------
WelcomeScreen proc

    call introSound

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
    mov eax, blueTxt
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

    
    mov eax, yellowTxt
    call SetTextColor

    mov dh, 19
    mov dl, 12
    call Gotoxy
    mov edx, offset inputName
    call WriteString

    ; asking for user input
    mov edx, offset userName
    mov ecx, lengthof userName
    call ReadString

    mov dh, 22
    mov dl,11
    call Gotoxy
    mov edx, offset temp
    call WaitMsg
    call Clrscr
    ret
WelcomeScreen endp


;-----------------------------------------------------
MenuScreen proc

    call introSound

    call Clrscr
    
    mov eax, blueTxt
    call SetTextColor
    
    mov dh, 5
    mov dl, 30
    call Gotoxy
    mov edx, offset menutitle0
    call WriteString
    
    mov dh, 6
    mov dl, 30
    call Gotoxy
    mov edx, offset menutitle1
    call WriteString
    
    mov dh, 7
    mov dl, 30
    call Gotoxy
    mov edx, offset menutitle2
    call WriteString
    
    mov dh, 8
    mov dl, 30
    call Gotoxy
    mov edx, offset menutitle3
    call WriteString
    
    mov dh, 9
    mov dl, 30
    call Gotoxy
    mov edx, offset menutitle4
    call WriteString
    
    mov dh, 10
    mov dl, 30
    call Gotoxy
    mov edx, offset menutitle5
    call WriteString
    
    ;menu options in green
    mov eax, greenTxt
    call SetTextColor
    
    mov dh, 13
    mov dl, 35
    call Gotoxy
    mov edx, offset menuopt0
    call WriteString
    
    mov dh, 14
    mov dl, 35
    call Gotoxy
    mov edx, offset menuopt1
    call WriteString
    
    mov dh, 15
    mov dl, 35
    call Gotoxy
    mov edx, offset menuopt2
    call WriteString
    
    mov dh, 16
    mov dl, 35
    call Gotoxy
    mov edx, offset menuopt3
    call WriteString
    
    mov dh, 17
    mov dl, 35
    call Gotoxy
    mov edx, offset menuopt4
    call WriteString
    
    mov dh, 18
    mov dl, 35
    call Gotoxy
    mov edx, offset menuopt5
    call WriteString
    
    ; user choice
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 20
    mov dl, 35
    call Gotoxy
    mov edx, offset menuoptchoose
    call WriteString
    
    call ReadInt
    mov userChoice, al
    
  
    cmp userChoice, 1
    je LevelSelection
    cmp userChoice, 2
    je ShowInstructions
    cmp userChoice, 3
    je ShowHighscores
    cmp userChoice, 4
    je ExitGame
    
    ;if user ghalat option then go to menu (already udhr he)
    jmp MenuScreen
    
LevelSelection:
    call LevelSelectScreen
    jmp MenuScreen
    
ShowInstructions:
    call InstructionsScreen
    jmp MenuScreen
    
ShowHighscores:
    call HighscoresScreen
    jmp MenuScreen
    
ExitGame:
    call Clrscr
    exit
MenuScreen endp

;-----------------------------------------------------
LevelSelectScreen proc

    call introSound

    call Clrscr
    
    ; Display level selection title
    mov eax, blueTxt
    call SetTextColor
    
    
    ; level options
    mov eax, redTxt
    call SetTextColor
    
    ; Level 1
    mov dh, 3
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt0
    call WriteString
    
    mov dh, 4
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt1
    call WriteString
    
    mov dh, 5
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt2
    call WriteString
    
    mov dh, 6
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt3
    call WriteString
    
    mov dh, 7
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt4
    call WriteString
    
    ; Level 2
    mov dh, 10
    mov dl, 30
    call Gotoxy
    mov edx, offset level2opt0
    call WriteString
    
    mov dh, 11
    mov dl, 30
    call Gotoxy
    mov edx, offset level2opt1
    call WriteString
    
    mov dh, 12
    mov dl, 30
    call Gotoxy
    mov edx, offset level2opt2
    call WriteString
    
    mov dh, 13
    mov dl, 30
    call Gotoxy
    mov edx, offset level2opt3
    call WriteString
    
    mov dh, 14
    mov dl, 30
    call Gotoxy
    mov edx, offset level2opt4
    call WriteString
    
    ; Level 3
    mov dh, 17
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt0
    call WriteString
    
    mov dh, 18
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt1
    call WriteString
    
    mov dh, 19
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt2
    call WriteString
    
    mov dh, 20
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt3
    call WriteString
    
    mov dh, 21
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt4
    call WriteString
    
    ;user choice
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 23
    mov dl, 20
    call Gotoxy
    mov edx, offset leveloptchoose1
    call WriteString
    
    mov dh, 24
    mov dl, 20
    call Gotoxy
    mov edx, offset leveloptchoose2
    call WriteString
    
    mov dh, 25
    mov dl, 20
    call Gotoxy
    call ReadInt
    
    ; Processing choice made
    cmp al, 1
    je StartLevel1
    cmp al, 2
    je StartLevel2
    cmp al, 3
    je StartLevel3
    cmp al, 4
    je ReturnToMenu
    cmp al, 5
    je ExitGame
    
    ; Invalid choice - show menu again
    jmp LevelSelectScreen

StartLevel1:
    mov currentLevel, 1
    call Level1Screen
    ;jmp ReturnToMenu

StartLevel2:
    mov currentLevel, 2
    call Level2Screen  

StartLevel3:
    mov currentLevel, 3
    call Level3Screen  
    
ReturnToMenu:
    ret
    
ExitGame:
    call Clrscr
    exit
LevelSelectScreen endp

;-----------------------------------------------------
InstructionsScreen proc

    call introSound

    call Clrscr
    
    ; Display instructions title
    mov eax, blueTxt
    call SetTextColor
    
    mov dh, 5
    mov dl, 15
    call Gotoxy
    mov edx, offset instruc1
    call WriteString
    
    mov dh, 6
    mov dl, 15
    call Gotoxy
    mov edx, offset instruc2
    call WriteString
    
    ; Display instructions text
    mov eax, greenTxt
    call SetTextColor
    
    mov dh, 8
    mov dl, 15
    call Gotoxy
    mov edx, offset instruc4
    call WriteString
    
    mov dh, 9
    mov dl, 15
    call Gotoxy
    mov edx, offset instruc5
    call WriteString
    
    mov dh, 10
    mov dl, 15
    call Gotoxy
    mov edx, offset instruc6
    call WriteString
    
    mov dh, 11
    mov dl, 15
    call Gotoxy
    mov edx, offset instruc7
    call WriteString
    
    mov dh, 12
    mov dl, 15
    call Gotoxy
    mov edx, offset instruc8
    call WriteString
    
    ; Get user choice
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 14
    mov dl, 15
    call Gotoxy
    mov edx, offset instrucChoose
    call WriteString
    
    call ReadInt
    
    ; Process choice
    cmp al, 1
    je ReturnToMenu
    cmp al, 2
    je ExitGame
    
ReturnToMenu:
    ret
    
ExitGame:
    call Clrscr
    exit
InstructionsScreen endp

;-----------------------------------------------------
HighscoresScreen proc


    call introSound

    call Clrscr
    

    mov eax, yellowTxt
    call SetTextColor
    
    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov edx, offset hsTitle0
    call WriteString
    
    mov dh, 6
    mov dl, 20
    call Gotoxy
    mov edx, offset hsTitle1
    call WriteString
    
    mov dh, 7
    mov dl, 20
    call Gotoxy
    mov edx, offset hsTitle2
    call WriteString
    
    mov dh, 8
    mov dl, 20
    call Gotoxy
    mov edx, offset hsTitle3
    call WriteString
    
    mov dh, 9
    mov dl, 20
    call Gotoxy
    mov edx, offset hsTitle4
    call WriteString
    
    ; Here you would normally display the actual high scores
    ; For now, just display a message
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 12
    mov dl, 30
    call Gotoxy
    mov edx, offset instrucChoose
    call WriteString
    
    call ReadInt
    
    ; Any key returns to menu
    ret
HighscoresScreen endp

;***********************************************************

Level1Screen proc

    call Clrscr
   ; call levelSound

    mov eax, blueTxt
    call SetTextColor


   ; Top border 
    mov dh, 0
    mov dl, 0
    mov ecx, GAME_WIDTH
    mov al, '#'
    draw_top:
        call Gotoxy
        call WriteChar
        inc dl
        loop draw_top
    
    ; Bottom border
    mov dh, 25
    mov dl, 0
    mov ecx, GAME_WIDTH
    draw_bottom:
        call Gotoxy
        call WriteChar
        inc dl
        loop draw_bottom
    
    ; Left border (rows 1-25)
    mov dh, 1
    mov dl, 0
    mov ecx, 25
    draw_left:
        call Gotoxy
        call WriteChar
        inc dh
        loop draw_left
    
    ; Right border ( rows 1-25)
    mov dh, 1
    mov dl, GAME_WIDTH-1
    mov ecx, 25
    draw_right:
        call Gotoxy
        call WriteChar
        inc dh
        loop draw_right
    
    ; 2.  info panel
    mov eax, yellowTxt
    call SetTextColor
    
    ; Level text
    mov dh, 5
    mov dl, INFO_START
    call Gotoxy
    mov edx, offset levelText
    call WriteString
    
    ; Score
    mov dh, 7
    mov dl, INFO_START
    call Gotoxy
    mov edx, offset scoreText
    call WriteString
    mov eax, score
    call WriteDec
    
    ; High score
    mov dh, 9
    mov dl, INFO_START
    call Gotoxy
    mov edx, offset highScoreText
    call WriteString
    mov eax, highScore
    call WriteDec
    
    ; Lives
    mov dh, 11
    mov dl, INFO_START
    call Gotoxy
    mov edx, offset livesText
    call WriteString
    movzx eax, lives
    call WriteDec
    
    ; Player name
    mov dh, 13
    mov dl, INFO_START
    call Gotoxy
    mov edx, offset playerText
    call WriteString
    mov edx, offset userName
    call WriteString
    
  
    
    ret
Level1Screen endp

;-----------------------------------------------------

Level2Screen proc
Level2Screen endp

Level3Screen proc
Level3Screen endp

end main