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
    
	inputName db "Enter your name ... ",0
    username  db 50 dup(0)

    returnMsg db 'Press 1 to return to main menu...', 0



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


    gameOverMsg1 db "  ____                         ___                 ",0
    gameOverMsg2 db " / ___| __ _ _ __ ___   ___   / _ \__   _____ _ __",0
    gameOverMsg3 db "| |  _ / _` | '_ ` _ \ / _ \ | | | \ \ / / _ \ '__|",0
    gameOverMsg4 db "| |_| | (_| | | | | | |  __/ | |_| |\ V /  __/ |   ",0
    gameOverMsg5 db " \____|\__,_|_| |_| |_|\___|  \___/  \_/ \___|_|   ",0
    scoreDisplay db "YOUR FINAL SCORE: ",0
    returnOption db "PRESS 1 TO RETURN TO MENU",0


    levelCompleteMsg1 db " *       *   *****   *     * ",0
    levelCompleteMsg2 db " *       *   *   *   **    * ",0
    levelCompleteMsg3 db " *   *   *   *   *   * *   * ",0
    levelCompleteMsg4 db " *  * *  *   *   *   *  *  * ",0
    levelCompleteMsg5 db " * *   * *   *   *   *   * * ",0
    levelCompleteMsg6 db " *       *   *****   *    ** ",0




    ;yeh colors hain 
    redTxt = red+(black*16);
    yellowTxt =yellow+(black*16);
    greenTxt =green+ (black*16);
    blueTxt =blue+ (black*16);
    whiteTxt =white+ (black *16);
    purpleTxt = magenta + (black*16)
    blackTxt= black +(black*16)



; Add these procedures to your code section

    userChoice db ?
    temp db ?
    currentLevel db ?

;-----------------------------------------
;level 1 vars for drawing
    playerName  BYTE "Player 1", 0
    scoreMsg    BYTE "Score: ", 0
    livesMsg    BYTE "Lives: ", 0
    levelMsg    BYTE "Level: ", 0


wallChar    BYTE '#'
emptyChar   BYTE ' '

;---------------------------------------
;other level 1 vars 

pelletChar db 'o',0
pacmanChar db 'X',0
ghostChar db 'G',0
pelletCount db 20
pelletPositions db 20 dup(0,0) ; Array of x,y positions
pacmanX db 10
pacmanY db 15
ghostX db 50
ghostY db 15
score dd 0
lives dd 3
level dd 1
oldPacmanX db ?
oldPacmanY db ?

;.................................................
;level 1 ghost vars
    ghostDir db 1  ; 1=right, 2=left, 3=up, 4=down
    oldGhostX db ?
    oldGhostY db ?

;.................................
;pause variables
    pauseMsg db "PRESS Q TO PAUSE GAME",0
    pausedMsg db "GAME PAUSED - PRESS Q TO RESUME ",0
    gamePaused db 0
    prevPauseState db 0  ; To track state changes
; ==================== FILE HANDLING DATA ====================
; File handling constants
BUFFER_SIZE = 1024
MAX_SCORES = 10
MAX_NAME_LEN = 16

; File operations
filename    BYTE "scores.txt",0
fileHandle  DWORD ?
bytesRead   DWORD ?

; Buffers
fileBuffer  BYTE BUFFER_SIZE DUP(?)
tempBuffer  BYTE BUFFER_SIZE DUP(?)

; Formatting
comma       BYTE ",",0
newline     BYTE 0Dh,0Ah,0

; Score storage
scores      DWORD MAX_SCORES DUP(0)
names       BYTE MAX_SCORES * MAX_NAME_LEN DUP(0)
levels      BYTE MAX_SCORES DUP(0)
scoreCount  DWORD 0

; Score processing
arr_score   BYTE 10 DUP(0)
arr_name    BYTE MAX_NAME_LEN DUP(0)
score_size  BYTE 0
name_size   BYTE 0
score1      DWORD 0
userCount   DWORD 0
; ============================================================

; Display strings
hsHeader1 db "Rank  Name            Score  Level", 0
hsHeader2 db "-------------------------------", 0
noScoresMsg db "No high scores yet!", 0



;=============================================================================================
;============================================================================================
.code
main proc
    call Clrscr
    call WelcomeScreen
    call MenuScreen
    call Level1Screen
    
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
    ret

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
  ;  call LoadScores
  ;  call SortScores

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
        cmp userCount, 0
    je NoScores
    
    ; Display headers
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 10
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET hsHeader1
    call WriteString
    
    mov dh, 11
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET hsHeader2
    call WriteString
    
    ; Display each score (top 10)
    mov ecx, userCount
    cmp ecx, 10
    jbe DisplayLoop
    mov ecx, 10
    
DisplayLoop:
    push ecx
    mov eax, 10
    sub eax, ecx    ; Calculate rank (10,9,...1)
    inc eax
    
    ; Position cursor
    mov dh, al
    add dh, 11      ; Start at row 12
    mov dl, 20
    call Gotoxy
    
    ; Display rank
    call WriteDec
    add dl, 6
    call Gotoxy
    
    ; Display name
    mov eax, 10
    sub eax, ecx
    imul eax, MAX_NAME_LEN
    add eax, OFFSET names
    mov edx, eax
    call WriteString
    
    ; Display score
    add dl, 16
    call Gotoxy
    mov eax, 10
    sub eax, ecx
    mov eax, scores[eax*4]
    call WriteDec
    
    ; Display level
    add dl, 8
    call Gotoxy
    mov eax, 10
    sub eax, ecx
    movzx eax, levels[eax]
    call WriteDec
    
    pop ecx
    loop DisplayLoop
    
    jmp DisplayReturn
    
NoScores:
    mov eax, redTxt
    call SetTextColor
    mov dh, 12
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET noScoresMsg
    call WriteString
    
DisplayReturn:
    ; Display return message
    mov eax, whiteTxt
    call SetTextColor
    mov dh, 23
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET returnOption
    call WriteString
    
    ; Wait for key press
    call ReadChar
    ret

HighscoresScreen endp

;***********************************************************
;***********************************************************
;***********************************************************
Level1Screen PROC
    call Clrscr
    call levelSound

    ; Initialize game state
    mov pacmanX, 10
    mov pacmanY, 15
    mov oldPacmanX, 10     
    mov oldPacmanY, 15
    mov ghostX, 50
    mov ghostY, 15
    mov oldGhostX, 50
    mov oldGhostY, 15
    mov score, 0
    mov pelletCount, 20
    mov gamePaused, 0    
    mov currentLevel,1
    call InitializePellets
    call DrawStaticElements

GameLoop:
    call ReadKey
    jz NoPlayerInput     ; No key pressed

    ; Check for pause input
    cmp al, 'q'
    je TogglePause
    cmp al, 'Q'
    je TogglePause

    ; Handle movement and menu keys
    cmp al, 'w'
    je MoveUp
    cmp al, 'a'
    je MoveLeft
    cmp al, 's'
    je MoveDown
    cmp al, 'd'
    je MoveRight
    cmp al, '1'    ; Return to menu
    je ExitLevel
    jmp NoPlayerInput

MoveUp:
    mov al, pacmanX
    mov oldPacmanX, al
    mov al, pacmanY
    mov oldPacmanY, al
    dec pacmanY
    call CheckWallCollision
    jc CancelMoveUp
    jmp AfterMove
CancelMoveUp:
    inc pacmanY
    jmp AfterMove

MoveLeft:
    mov al, pacmanX
    mov oldPacmanX, al
    mov al, pacmanY
    mov oldPacmanY, al
    dec pacmanX
    call CheckWallCollision
    jc CancelMoveLeft
    jmp AfterMove
CancelMoveLeft:
    inc pacmanX
    jmp AfterMove

MoveDown:
    mov al, pacmanX
    mov oldPacmanX, al
    mov al, pacmanY
    mov oldPacmanY, al
    inc pacmanY
    call CheckWallCollision
    jc CancelMoveDown
    jmp AfterMove
CancelMoveDown:
    dec pacmanY
    jmp AfterMove

MoveRight:
    mov al, pacmanX
    mov oldPacmanX, al
    mov al, pacmanY
    mov oldPacmanY, al
    inc pacmanX
    call CheckWallCollision
    jc CancelMoveRight
    jmp AfterMove
CancelMoveRight:
    dec pacmanX
    jmp AfterMove

AfterMove:
    call CheckPelletCollision
    call CheckGhostCollision
    cmp eax, 1
    je GameLost

NoPlayerInput:
    ; Skip ghost and game logic if paused
    cmp gamePaused, 1
    je PausedLoop

    call ClearOldPositions
    call GhostMovement
    call DrawGameElements

    ; Small delay
    mov eax, 100
    call Delay

    ; Check win condition
    cmp pelletCount, 0
    jne GameLoop
    je LevelWon

PausedLoop:
    ; Show pause message once
    mov eax, yellowTxt
    call SetTextColor
    mov dh, 12
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET pausedMsg
    call WriteString

WaitWhilePaused:
    call ReadKey
    jz WaitWhilePaused

    cmp al, 'q'
    je TogglePause
    cmp al, 'Q'
    je TogglePause
    jmp WaitWhilePaused

TogglePause:
    xor gamePaused, 1

    ; Clear pause message
    mov eax, blackTxt
    call SetTextColor
    mov dh, 12
    mov dl, 20
    call Gotoxy
    mov ecx, 40
ClearPauseText:
    mov al, ' '
    call WriteChar
    loop ClearPauseText

    jmp GameLoop

ExitLevel:
    ret

LevelWon:
    call SaveScore
    call LevelCompleteScreen
    ret

GameLost:
    call SaveScore
    call GameOverScreen
    ret

GameOverScreen:
    call Clrscr
    mov eax, redTxt
    call SetTextColor

    ; Draw game over message
    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET gameOverMsg1
    call WriteString

    mov dh, 6
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET gameOverMsg2
    call WriteString

    mov dh, 6
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET gameOverMsg3
    call WriteString

    mov dh, 7
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET gameOverMsg4
    call WriteString

    mov dh, 8
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET gameOverMsg5
    call WriteString

    ; Display score
    mov dh, 12
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET scoreDisplay
    call WriteString
    mov eax, score
    call WriteDec

    ; Display return option
    mov dh, 14
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET returnOption
    call WriteString

WaitForInput:
    call ReadChar
    cmp al, '1'
    jne WaitForInput
    ret


LevelCompleteScreen:
    call Clrscr
    mov eax, greenTxt
    call SetTextColor

    ; Draw level complete message
    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelCompleteMsg1
    call WriteString

    mov dh, 6
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelCompleteMsg2
    call WriteString

    mov dh, 7
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelCompleteMsg3
    call WriteString

    mov dh, 8
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelCompleteMsg4
    call WriteString

    mov dh, 9
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelCompleteMsg5
    call WriteString

    mov dh, 10
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET levelCompleteMsg6
    call WriteString

    
    ; Display score
    mov dh, 12
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET scoreDisplay
    call WriteString
    mov eax, score
    call WriteDec

    ; Display return option
    mov dh, 14
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET returnOption
    call WriteString

WaitForInput2:
    call ReadChar
    cmp al, '1'
    jne WaitForInput2
    ret

Level1Screen ENDP
;***********************************************************

;***********************************************************

DrawStaticElements PROC
    ; Draw info bar
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 0
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET livesMsg
    call WriteString
    mov eax, lives
    call WriteDec

    mov dh, 1
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET userName
    call WriteString

    mov dh,2
    mov dl, 75
    call Gotoxy
    mov edx, OFFSET levelMsg
    call WriteString
    mov eax, level
    call WriteDec

    mov dh, 4       
    mov dl, 1
    call Gotoxy
    mov edx, OFFSET pauseMsg
    call WriteString

    ; Draw borders and walls (your existing code)
    ; Top border
    mov dh, 5
    mov dl, 0
    mov ecx, 115
    mov al, wallChar
topBorder:
    call Gotoxy
    call WriteChar
    inc dl
    loop topBorder

    ; Bottom border
    mov dh, 29
    mov dl, 0
    mov ecx, 115
bottomBorder:
    call Gotoxy
    call WriteChar
    inc dl
    loop bottomBorder

    ; Left and right borders 
    mov dh, 5
    mov ecx, 27        ; Height
sideBorders:
    ; Left border
    mov dl, 0
    call Gotoxy
    mov al, wallChar
    call WriteChar
    ; Right border
    mov dl, 114
    call Gotoxy
    mov al, wallChar
    call WriteChar
    inc dh
    loop sideBorders

    ; Inner walls (your existing code)
    call DrawInnerWalls

    ; Return message
    mov dh, 3
    mov dl, 2
    call Gotoxy
    mov edx, offset returnMsg
    call WriteString
    
    ret
DrawStaticElements ENDP
;...........................................
DrawGameElements PROC
    ; Draw pellets
    mov eax, purpleTxt
    call SetTextColor
    mov esi, OFFSET pelletPositions
    mov ecx, 20

DrawPellets:
    cmp byte ptr [esi], 0  ; Skip if pellet collected
    je SkipPellet
    
    mov dl, [esi]    ; X
    mov dh, [esi+1]  ; Y
    call Gotoxy
    mov al, pelletChar
    call WriteChar

SkipPellet:
    add esi, 2
    loop DrawPellets

    ; Draw Pac-Man
    mov eax, whiteTxt
    call SetTextColor
    mov dl, pacmanX
    mov dh, pacmanY
    call Gotoxy
    mov al, pacmanChar
    call WriteChar

    ; Draw Ghost
    mov dl, ghostX
    mov dh, ghostY
    call Gotoxy
    mov al, ghostChar
    call WriteChar

    ret
DrawGameElements ENDP
;...........................................
InitializePellets PROC
    pushad
    mov ecx, 20
    mov esi, OFFSET pelletPositions

PlacePellet:
    ; Generate random position within play area
    mov eax, 113    
    call RandomRange
    inc eax          ; X = 1-114
    mov [esi], al    ; Store X
    
    mov eax, 23      ; Max Y (29-6)
    call RandomRange
    add eax, 6       ; Y = 6-29
    mov [esi+1], al  ; Store Y

    ; Check if position is valid (not on wall)
    mov dl, [esi]
    mov dh, [esi+1]
    call CheckWallPosition
    jc PlacePellet  ; If invalid, try again

    add esi, 2
    loop PlacePellet

    popad
    ret
InitializePellets ENDP
;..........................................
CheckWallPosition PROC
    ; Checks if position (dl=X, dh=Y) is a wall
    ; Returns CF=1 if wall, CF=0 if empty
    
    ; Check borders
    cmp dl, 0
    je IsWall
    cmp dl, 114
    je IsWall
    cmp dh, 5
    je IsWall
    cmp dh, 29
    je IsWall

    ; Check inner walls (based on your DrawInnerWalls)
    
    ; Horizontal wall at Y=10, X=20-34
    cmp dh, 10
    jne NotWall1
    cmp dl, 20
    jb NotWall1
    cmp dl, 34
    ja NotWall1
    jmp IsWall

NotWall1:
    ; Horizontal wall at Y=10, X=70-84
    cmp dh, 10
    jne NotWall2
    cmp dl, 70
    jb NotWall2
    cmp dl, 84
    ja NotWall2
    jmp IsWall

NotWall2:
    ; Horizontal walls at Y=14
    cmp dh, 14
    jne NotWall3
    ; X=15-22
    cmp dl, 15
    jb NotWall3a
    cmp dl, 22
    ja NotWall3a
    jmp IsWall
NotWall3a:
    ; X=35-42
    cmp dl, 35
    jb NotWall3b
    cmp dl, 42
    ja NotWall3b
    jmp IsWall
NotWall3b:
    ; X=55-62
    cmp dl, 55
    jb NotWall3c
    cmp dl, 62
    ja NotWall3c
    jmp IsWall
NotWall3c:
    ; X=75-82
    cmp dl, 75
    jb NotWall3d
    cmp dl, 82
    ja NotWall3d
    jmp IsWall
NotWall3d:
    ; X=95-102
    cmp dl, 95
    jb NotWall3
    cmp dl, 102
    ja NotWall3
    jmp IsWall

NotWall3:
    ; Horizontal walls at Y=17
    cmp dh, 17
    jne NotWall4
    ; X=30-39
    cmp dl, 30
    jb NotWall4a
    cmp dl, 39
    ja NotWall4a
    jmp IsWall
NotWall4a:
    ; X=80-89
    cmp dl, 80
    jb NotWall4
    cmp dl, 89
    ja NotWall4
    jmp IsWall

NotWall4:
    ; Horizontal walls at Y=22
    cmp dh, 22
    jne NotWall
    ; X=25-44
    cmp dl, 25
    jb NotWall5a
    cmp dl, 44
    ja NotWall5a
    jmp IsWall
NotWall5a:
    ; X=85-104
    cmp dl, 85
    jb NotWall
    cmp dl, 104
    ja NotWall
    jmp IsWall

NotWall:
    clc
    ret
IsWall:
    stc
    ret
CheckWallPosition ENDP
;...........................................
CheckWallCollision PROC
    ; Checks if Pac-Man's current position is a wall
    ; Returns CF=1 if collision
    mov dl, pacmanX
    mov dh, pacmanY
    call CheckWallPosition
    ret
CheckWallCollision ENDP
;.........................................
CheckPelletCollision PROC
    pushad
    mov esi, OFFSET pelletPositions
    mov ecx, 20

CheckPellets:
    cmp byte ptr [esi], 0  ; Skip if pellet already collected
    je NextPellet
    
    mov al, [esi]    ; Pellet X
    cmp al, pacmanX
    jne NextPellet
    
    mov al, [esi+1]  ; Pellet Y
    cmp al, pacmanY
    jne NextPellet

    ; Pac-Man is on this pellet!
    mov byte ptr [esi], 0  ; Remove pellet
    inc score
    dec pelletCount

    ; Update score display
    mov eax, whiteTxt
    call SetTextColor
    mov dh, 1
    mov dl, 55
    call Gotoxy
    mov edx, OFFSET scoreMsg
    call WriteString
    mov eax, score
    call WriteDec

NextPellet:
    add esi, 2
    loop CheckPellets

    popad
    ret
CheckPelletCollision ENDP

;.....................................
DrawInnerWalls PROC
    mov dh, 10
    mov dl, 20
    mov ecx, 15
    call DrawWall
    mov dl, 70
    mov ecx, 15
    call DrawWall

    mov dh, 14
    mov dl, 15
    mov ecx, 8
    call DrawWall
    mov dl, 35
    call DrawWall
    mov dl, 55
    call DrawWall
    mov dl, 75
    call DrawWall
    mov dl, 95
    call DrawWall

    mov dh, 17
    mov dl, 30
    mov ecx, 10
    call DrawWall
    mov dl, 80
    call DrawWall

    mov dh, 22
    mov dl, 25
    mov ecx, 20
    call DrawWall
    mov dl, 85
    call DrawWall
    ret
DrawInnerWalls ENDP
;.................................................
DrawWall PROC
    push ecx
wallLoop:
    call Gotoxy
    mov al, wallChar
    call WriteChar
    inc dl
    loop wallLoop
    pop ecx
    ret
DrawWall ENDP
;....................................................
ClearOldPositions PROC
    ; Clear old Pac-Man position
    mov eax, blackTxt
    call SetTextColor
    mov dl, oldPacmanX
    mov dh, oldPacmanY
    call Gotoxy
    mov al, emptyChar
    call WriteChar
    
    ; Clear old ghost position
    mov dl, oldGhostX
    mov dh, oldGhostY
    call Gotoxy
    mov al, emptyChar
    call WriteChar
    ret
ClearOldPositions ENDP
;.................................................
GhostMovement PROC
    mov al, ghostX
    mov oldGhostX, al
    mov al, ghostY
    mov oldGhostY, al
    
    ; 70% chance to move toward Pac-Man, 30% random
    call Randomize
    mov eax, 10
    call RandomRange
    cmp eax, 7  ; 0-2 = random (30%), 3-9 = toward (70%)
    jb RandomMove
    
    ; Move toward Pac-Man
    mov bl, pacmanX
    mov bh, pacmanY
    
    cmp ghostX, bl
    jl MoveGhostRight
    jg MoveGhostLeft
    cmp ghostY, bh
    jl MoveGhostDown
    jg MoveGhostUp
    jmp RandomMove

MoveGhostRight:
    inc ghostX
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret
MoveGhostLeft:
    dec ghostX
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret
MoveGhostUp:
    dec ghostY
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret
MoveGhostDown:
    inc ghostY
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret

RandomMove:
    ; Random direction (1-4)
    mov eax, 4
    call RandomRange
    inc eax
    
    cmp eax, 1
    je TryRight
    cmp eax, 2
    je TryLeft
    cmp eax, 3
    je TryUp
    cmp eax, 4
    je TryDown

TryRight:
    inc ghostX
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret
TryLeft:
    dec ghostX
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret
TryUp:
    dec ghostY
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret
TryDown:
    inc ghostY
    call CheckGhostWallCollision
    jc UndoGhostMove
    ret

UndoGhostMove:
    mov al, oldGhostX
    mov ghostX, al
    mov al, oldGhostY
    mov ghostY, al
    ret
GhostMovement ENDP
;.......................................
CheckGhostWallCollision PROC
    mov dl, ghostX
    mov dh, ghostY
    call CheckWallPosition
    ret
CheckGhostWallCollision ENDP
;............................................
CheckGhostCollision PROC
    ; Check X proximity (pacmanX - ghostX <= 1)
    mov al, pacmanX
    sub al, ghostX
    cmp al, -1
    jl NoCollisionX
    cmp al, 1
    jg NoCollisionX

    ; Check Y proximity
    mov al, pacmanY
    sub al, ghostY
    cmp al, -1
    jl NoCollision
    cmp al, 1
    jg NoCollision

    ; Close enough in both X and Y — COLLISION
    dec lives

    ; Update lives display
    mov eax, whiteTxt
    call SetTextColor
    mov dh, 0
    mov dl, 7
    call Gotoxy
    mov eax, lives
    movzx eax, al
    call WriteDec

    ; Clear ghost from screen
    mov dl, ghostX
    mov dh, ghostY
    call Gotoxy
    mov al, emptyChar
    call WriteChar

    ; Reset positions
    mov pacmanX, 10
    mov pacmanY, 15
    mov ghostX, 50
    mov ghostY, 15

    cmp lives, 0
    jle GameOver

    mov eax, 0
    ret

NoCollisionX:
NoCollision:
    mov eax, 0
    ret

GameOver:
    mov eax, 1
    ret
CheckGhostCollision ENDP

; ==================== FILE HANDLING PROCEDURES ====================


; Save current score to file
saveScore PROC
    pushad
    
    ; Prepare data for writing
    mov esi, OFFSET userName
    mov edi, OFFSET tempBuffer
    call CopyStringToBuffer
    
    ; Add comma
    mov al, ','
    mov [edi], al
    inc edi
    
    ; Convert score to string
    mov eax, score
    call ConvertNumberToString
    
    ; Add comma
    mov al, ','
    mov [edi], al
    inc edi
    
    ; Convert level to string
    movzx eax, currentLevel
    call ConvertNumberToString
    
    ; Add newline
    mov al, 0Dh
    mov [edi], al
    inc edi
    mov al, 0Ah
    mov [edi], al
    inc edi
    
    ; Open/Create file
    mov edx, OFFSET filename
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je CreateNew
    
    ; File exists - close and reopen for append
    mov fileHandle, eax
    call CloseFile
    mov edx, OFFSET filename
    call CreateOutputFile
    jmp FileReady
    
CreateNew:
    mov edx, OFFSET filename
    call CreateOutputFile
    
FileReady:
    mov fileHandle, eax
    cmp eax, INVALID_HANDLE_VALUE
    je ErrorExit
    
    ; Write the prepared buffer
    mov edx, OFFSET tempBuffer
    mov ecx, edi
    sub ecx, edx
    call WriteToFile
    
ErrorExit:
    mov eax, fileHandle
    call CloseFile
    popad
    ret
saveScore ENDP

; Read scores from file
readScoresFromFile PROC
    pushad

    mov edx, OFFSET filename
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je Done

    mov fileHandle, eax
    mov edx, OFFSET fileBuffer
    mov ecx, BUFFER_SIZE
    call ReadFromFile
    mov bytesRead, eax

    ; Parse the file buffer
    mov esi, OFFSET fileBuffer
    mov edi, 0
    call ParseScoreData

Done:
    mov eax, fileHandle
    call CloseFile
    popad
    ret
readScoresFromFile ENDP

; Helper procedure to parse score data
ParseScoreData PROC
ParseLoop:
    cmp edi, MAX_SCORES
    jge DoneReading

    ; Read name
    mov ebx, edi
    imul ebx, MAX_NAME_LEN
    call ReadName

    ; Read score
    call ReadNumber
    mov scores[edi*4], eax

    ; Read level
    call ReadNumber
    mov levels[edi], al

    inc edi
    jmp ParseLoop

DoneReading:
    mov scoreCount, edi
    ret
ParseScoreData ENDP

; Helper to read a name from buffer
ReadName PROC
    xor ecx, ecx
ReadNameChar:
    mov al, [esi]
    cmp al, ','
    je StoreName
    mov names[ebx], al
    inc ebx
    inc ecx
    inc esi
    jmp ReadNameChar
StoreName:
    mov names[ebx], 0
    inc esi
    ret
ReadName ENDP

; Helper to read a number from buffer
ReadNumber PROC
    xor eax, eax
ReadDigit:
    mov bl, [esi]
    cmp bl, ','
    je NumberDone
    cmp bl, 0Dh
    je NumberDone
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    inc esi
    jmp ReadDigit
NumberDone:
    inc esi
    cmp bl, 0Dh
    jne Return
    inc esi  ; Skip LF
Return:
    ret
ReadNumber ENDP

; Helper to convert number to string
ConvertNumberToString PROC
    push ebx
    push edx
    push ecx
    
    mov ebx, 10
    xor ecx, ecx
    
DivLoop:
    xor edx, edx
    div ebx
    push dx
    inc cx
    test eax, eax
    jnz DivLoop
    
WriteDigits:
    pop ax
    add al, '0'
    mov [edi], al
    inc edi
    dec cx
    jnz WriteDigits
    
    pop ecx
    pop edx
    pop ebx
    ret
ConvertNumberToString ENDP

; Helper to copy string to buffer
CopyStringToBuffer PROC
CopyChar:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    test al, al
    jnz CopyChar
    dec edi  ; Back up over null terminator
    ret
CopyStringToBuffer ENDP

; Add new score to arrays
addNewScore PROC
    pushad
    mov eax, scoreCount
    cmp eax, MAX_SCORES
    jge SkipAdd

    ; Copy name
    mov ecx, MAX_NAME_LEN
    mov esi, OFFSET userName
    mov edi, eax
    imul edi, MAX_NAME_LEN
    add edi, OFFSET names
    rep movsb

    ; Store score and level
    mov ebx, scoreCount
    mov eax, score
    mov scores[ebx*4], eax
    mov al, currentLevel
    mov levels[ebx], al

    inc scoreCount
SkipAdd:
    popad
    ret
addNewScore ENDP

; Sort scores in descending order
sortScores PROC
    pushad
    
    mov ecx, scoreCount
    dec ecx
    jle DoneSorting
    
OuterLoop:
    push ecx
    mov esi, 0
    
InnerLoop:
    mov eax, scores[esi*4]
    cmp eax, scores[esi*4 + 4]
    jge NoSwap
    
    ; Swap scores
    mov edx, scores[esi*4 + 4]
    mov scores[esi*4], edx
    mov scores[esi*4 + 4], eax
    
    ; Swap names
    push esi
    imul esi, MAX_NAME_LEN
    lea edi, names[esi]
    lea esi, names[esi + MAX_NAME_LEN]
    mov ecx, MAX_NAME_LEN
    call SwapMemory
    
    ; Swap levels
    pop esi
    mov al, levels[esi]
    mov bl, levels[esi+1]
    mov levels[esi+1], al
    mov levels[esi], bl
    
NoSwap:
    inc esi
    dec ecx
    jnz InnerLoop
    
    pop ecx
    dec ecx
    jnz OuterLoop
    
DoneSorting:
    popad
    ret
sortScores ENDP

; Helper to swap memory blocks
SwapMemory PROC
SwapByte:
    mov al, [edi]
    mov bl, [esi]
    mov [esi], al
    mov [edi], bl
    inc edi
    inc esi
    loop SwapByte
    ret
SwapMemory ENDP

; Write all scores to file
writeAllScoresToFile PROC
    pushad
    mov edx, OFFSET filename
    call CreateOutputFile
    mov fileHandle, eax

    mov ecx, scoreCount
    mov esi, 0
WriteLoop:
    ; Prepare record in tempBuffer
    mov edi, OFFSET tempBuffer
    
    ; Write name
    mov eax, esi
    imul eax, MAX_NAME_LEN
    add eax, OFFSET names
    mov esi, eax
    call CopyStringToBuffer
    mov esi, eax
    
    ; Add comma
    mov al, ','
    mov [edi], al
    inc edi
    
    ; Write score
    mov eax, scores[esi*4]
    call ConvertNumberToString
    
    ; Add comma
    mov al, ','
    mov [edi], al
    inc edi
    
    ; Write level
    movzx eax, levels[esi]
    call ConvertNumberToString
    
    ; Add newline
    mov al, 0Dh
    mov [edi], al
    inc edi
    mov al, 0Ah
    mov [edi], al
    inc edi
    
    ; Write record to file
    mov edx, OFFSET tempBuffer
    mov ecx, edi
    sub ecx, edx
    call WriteToFile
    
    inc esi
    dec ecx
    jnz WriteLoop

    mov eax, fileHandle
    call CloseFile
    popad
    ret
writeAllScoresToFile ENDP

; Helper procedure to write string to file
WriteStringToFile PROC
    pushad
    mov ecx, 0
NextChar:
    mov al, [edx + ecx]
    cmp al, 0
    je WriteStr
    inc ecx
    jmp NextChar
WriteStr:
    call WriteToFile
    popad
    ret
WriteStringToFile ENDP
; ============================================================


Level2Screen proc
Level2Screen endp

Level3Screen proc
Level3Screen endp

end main




