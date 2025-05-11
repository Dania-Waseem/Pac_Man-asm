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
;level 1 vars for drawing
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

;------------------------------------------
;level 1 logic vars
    ; Player position
    pacmanX db 40
    pacmanY db 12
    
    ; Ghosts positions
    ghost1X db 20
    ghost1Y db 10

    
    ; Ghost directions (1=right, 2=left, 3=up, 4=down)
    ghost1Dir db 1
    ghost2Dir db 2
    
    ; Pellets array (0 = eaten, 1 = exists)
    pellets db GAME_WIDTH * 25 dup(0)
    
    ; Wall positions (x,y,width,height)
    walls db 10,5,15,1,   ; Horizontal wall
          30,8,1,10,     ; Vertical wall
          50,15,10,1,    ; Horizontal wall
          20,20,5,1,     ; Horizontal wall
          40,10,1,5      ; Vertical wall
    wallCount db 5
    
    ; Movement keys
    moveUp db 'W'
    moveLeft db 'A'
    moveDown db 'S'
    moveRight db 'D'
    exitKey db 'Q'        ; ESC key
    


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


Level1Screen PROC
    call Clrscr
    call levelSound
    
    ; Draw borders
    call DrawBorders
    
    ; Draw walls
    call DrawWallsLevel1
    
    ; Initialize pellets
    call InitializePellets
    
    
    ; Initialize ghost position
    mov ghost1X, 20
    mov ghost1Y, 10
    
    ; Draw initial positions
    call DrawPlayer
    call DrawGhost1
    
    ; Main game loop
gameLoop:
    ; Handle input
    call ReadKey
    jz no_input
    mov inputChar, al
    
    ; Check for exit
    cmp inputChar, 'Q'
    je exitLevel
    
    ; Movement handling
    cmp inputChar, 'W'
    je moveUp
    cmp inputChar, 'A'
    je moveLeft
    cmp inputChar, 'S'
    je moveDown
    cmp inputChar, 'D'
    je moveRight
    
no_input:
    ; Update ghost
    call UpdateGhost1
    
    ; Check collisions
    call CheckPelletCollision
    call CheckGhostCollision
    
    ; Check win condition (all pellets collected)
    cmp num_coins, 0
    je levelComplete
    
    ; Delay for game speed
    mov eax, 100
    call Delay
    
    jmp gameLoop
    
moveUp:
    ; Handle up movement
    ; (Include wall collision checks)
    jmp gameLoop
    
moveLeft:
    ; Handle left movement
    jmp gameLoop
    
moveDown:
    ; Handle down movement
    jmp gameLoop
    
moveRight:
    ; Handle right movement
    jmp gameLoop
    
levelComplete:
    ; Handle level completion
    inc currentLevel
    ; Proceed to next level or game complete
    
exitLevel:
    ret
Level1Screen ENDP

DrawBorders proc

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
DrawBorders endp

DrawWallsLevel1 PROC
    ; Set wall color
    mov eax, lightblue
    call SetTextColor
    
    ; First set of 2 horizontal walls
    mov eax, 10      ; X position
    mov ebx, 5       ; Y position
    mov ecx, 15      ; Length
    call DrawHorizontalWall
    
    mov eax, 10      ; X position
    mov ebx, 6       ; Y position (right below first wall)
    mov ecx, 15      ; Length
    call DrawHorizontalWall
    
    ; Gap of 2 rows
    
    ; Next set of 5 horizontal walls
    mov eax, 20      ; X position
    mov ebx, 9       ; Y position
    mov ecx, 10      ; Length
    call DrawHorizontalWall
    
    mov eax, 20
    mov ebx, 10
    mov ecx, 10
    call DrawHorizontalWall
    
    mov eax, 20
    mov ebx, 11
    mov ecx, 10
    call DrawHorizontalWall
    
    mov eax, 20
    mov ebx, 12
    mov ecx, 10
    call DrawHorizontalWall
    
    mov eax, 20
    mov ebx, 13
    mov ecx, 10
    call DrawHorizontalWall
    
    ; Gap of 2 rows
    
    ; Next set of 2 horizontal walls
    mov eax, 30
    mov ebx, 16
    mov ecx, 12
    call DrawHorizontalWall
    
    mov eax, 30
    mov ebx, 17
    mov ecx, 12
    call DrawHorizontalWall
    
    ; Final 2 vertical walls
    mov eax, 40
    mov ebx, 5
    mov ecx, 10      ; Height
    call DrawVerticalWall
    
    mov eax, 50
    mov ebx, 5
    mov ecx, 10
    call DrawVerticalWall
    
    ret
DrawWallsLevel1 ENDP

DrawHorizontalWall PROC
    ; Draws a horizontal wall
    ; Input: eax = x, ebx = y, ecx = length
    push eax
    push ebx
    push ecx
    
    mov dl, al      ; X position
    mov dh, bl      ; Y position
    call Gotoxy
    
    mov al, '#'     ; Wall character
    draw_hor_loop:
        call WriteChar
        inc dl
        loop draw_hor_loop
    
    pop ecx
    pop ebx
    pop eax
    ret
DrawHorizontalWall ENDP

DrawVerticalWall PROC
    ; Draws a vertical wall
    ; Input: eax = x, ebx = y, ecx = height
    push eax
    push ebx
    push ecx
    
    mov dl, al      ; X position
    mov dh, bl      ; Y position
    call Gotoxy
    
    mov al, '#'     ; Wall character
    draw_vert_loop:
        call WriteChar
        inc dh
        call Gotoxy
        loop draw_vert_loop
    
    pop ecx
    pop ebx
    pop eax
    ret
DrawVerticalWall ENDP

UpdateGhost1 PROC
    ; Ghost movement logic - tries to come closer to Pacman
    ; Compare ghost position with pacman position
    
    ; First check X direction
    mov al, ghost1X
    cmp al, pacmanX
    jl move_ghost_right   ; If ghost is left of pacman, move right
    jg move_ghost_left    ; If ghost is right of pacman, move left
    
    ; If X positions are equal, check Y direction
    mov al, ghost1Y
    cmp al, pacmanY
    jl move_ghost_down    ; If ghost is above pacman, move down
    jg move_ghost_up      ; If ghost is below pacman, move up
    
    ; If positions are equal, don't move
    ret
    
move_ghost_right:
    call CanMoveRight
    cmp dl, 1
    je move_right
    jmp check_y_direction
    
move_right:
    call UpdateGhost
    inc ghost1X
    call DrawGhost1
    ret
    
move_ghost_left:
    call CanMoveLeft
    cmp dl, 1
    je move_left
    jmp check_y_direction
    
move_left:
    call UpdateGhost
    dec ghost1X
    call DrawGhost1
    ret
    
check_y_direction:
    mov al, ghost1Y
    cmp al, pacmanY
    jl move_ghost_down
    jg move_ghost_up
    ret
    
move_ghost_down:
    call CanMoveDown
    cmp dl, 1
    je move_down
    ret
    
move_down:
    call UpdateGhost
    inc ghost1Y
    call DrawGhost1
    ret
    
move_ghost_up:
    call CanMoveUp
    cmp dl, 1
    je move_up
    ret
    
move_up:
    call UpdateGhost
    dec ghost1Y
    call DrawGhost1
    ret
UpdateGhost1 ENDP

CanMoveRight PROC
    ; Check if ghost can move right
    movzx ecx, ghost1X
    inc ecx             ; Check position to the right
    movzx edx, ghost1Y
    call CheckWallCollision
    ret
CanMoveRight ENDP

CanMoveLeft PROC
    ; Check if ghost can move left
    movzx ecx, ghost1X
    dec ecx             ; Check position to the left
    movzx edx, ghost1Y
    call CheckWallCollision
    ret
CanMoveLeft ENDP

CanMoveUp PROC
    ; Check if ghost can move up
    movzx ecx, ghost1X
    movzx edx, ghost1Y
    dec edx             ; Check position above
    call CheckWallCollision
    ret
CanMoveUp ENDP

CanMoveDown PROC
    ; Check if ghost can move down
    movzx ecx, ghost1X
    movzx edx, ghost1Y
    inc edx             ; Check position below
    call CheckWallCollision
    ret
CanMoveDown ENDP

CheckWallCollision PROC
    ; Checks if position (ecx, edx) is a wall
    ; Returns dl = 1 if can move (no wall), dl = 0 if wall
    mov ebx, ecx
    imul ebx, 30        ; Assuming grid is 70x30
    add ebx, edx
    mov al, BYTE PTR [grid + ebx]
    cmp al, 1           ; 1 represents wall
    je is_wall
    mov dl, 1           ; Can move
    ret
is_wall:
    mov dl, 0           ; Cannot move
    ret
CheckWallCollision ENDP

InitializePellets PROC
    ; Initialize pellets for Level 1
    mov ecx, 50         ; Number of pellets for Level 1
    mov num_coins, cl
    
    ; Clear pellet array
    mov edi, OFFSET pellets
    mov ecx, GAME_WIDTH * 25
    mov al, 0
    rep stosb
    
    ; Place pellets in valid positions
    mov ecx, 50
place_pellets:
    call GetRandomPosition
    ; Check if position is valid (not wall and not already pellet)
    mov ebx, eax
    imul ebx, 30
    add ebx, edx
    cmp BYTE PTR [grid + ebx], 1   ; Wall
    je place_pellets
    cmp BYTE PTR [pellets + ebx], 1 ; Already pellet
    je place_pellets
    
    ; Place pellet
    mov BYTE PTR [pellets + ebx], 1
    
    ; Draw pellet
    mov dl, al
    mov dh, dl
    call Gotoxy
    mov al, '.'
    call WriteChar
    
    loop place_pellets
    
    ret
InitializePellets ENDP

GetRandomPosition PROC
    ; Returns random position in eax (x), edx (y)
    mov eax, GAME_WIDTH - 2
    call RandomRange
    inc eax             ; Avoid left border
    mov edx, eax        ; Save x in edx
    
    mov eax, 24         ; 25 rows (0-24)
    call RandomRange
    inc eax             ; Avoid top border
    
    xchg eax, edx       ; Now eax has x, edx has y
    ret
GetRandomPosition ENDP

CheckPelletCollision PROC
    ; Check if pacman is on a pellet
    movzx eax, pacmanX
    movzx edx, pacmanY
    mov ebx, eax
    imul ebx, 30
    add ebx, edx
    cmp BYTE PTR [pellets + ebx], 1
    jne no_pellet
    
    ; Pellet collected
    mov BYTE PTR [pellets + ebx], 0  ; Remove pellet
    inc score
    
    ; Update score display
    mov eax, yellow
    call SetTextColor
    mov dl, 75
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, score
    call WriteDec
    
    dec num_coins       ; Decrement remaining pellets
    
no_pellet:
    ret
CheckPelletCollision ENDP

UpdateLivesDisplay PROC
    ; Update lives display
    mov eax, lightblue
    call SetTextColor
    mov dl, 75
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET livesText
    call WriteString
    movzx eax, lives
    call WriteDec
    ret
UpdateLivesDisplay ENDP

CheckGhostCollision PROC
    ; Check collision with ghost
    mov al, ghost1X
    cmp al, pacmanX
    jne no_collision
    mov al, ghost1Y
    cmp al, pacmanY
    jne no_collision
    
    ; Collision occurred
    dec lives
    call UpdateLivesDisplay
    
    ; Reset positions
    mov pacmanX, 40
    mov pacmanY, 12
    
    ; Check if game over
    cmp lives, 0
    jg no_collision
    call GameOver
    
no_collision:
    ret
CheckGhostCollision ENDP

GameOver PROC
    ; Handle game over
    call SaveHighScore
    ; Display game over message
    ; Return to menu
    ret
GameOver ENDP

SaveHighScore PROC
    ; Save highscore to file if current score is higher
    mov eax, score
    cmp eax, highScore
    jle no_new_high
    
    ; New high score
    mov highScore, eax
    
    ; Open file for writing
    mov edx, OFFSET fileName
    call CreateOutputFile
    mov fileHandle, eax
    
    ; Write player name and score
    mov edx, OFFSET userName
    mov ecx, LENGTHOF userName
    call WriteToFile
    
    ; Write space separator
    mov edx, OFFSET space
    mov ecx, 1
    call WriteToFile
    
    ; Write score
    mov eax, score
    call WriteInt
    
    ; Write space separator
    mov edx, OFFSET space
    mov ecx, 1
    call WriteToFile
    
    ; Write level
    mov al, currentLevel
    call WriteInt
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    
no_new_high:
    ret
SaveHighScore ENDP


;-----------------------------------------------------

Level2Screen proc
Level2Screen endp

Level3Screen proc
Level3Screen endp

end main

