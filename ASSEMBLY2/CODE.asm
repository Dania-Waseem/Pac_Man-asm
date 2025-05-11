; 23i-2622
; DS A
; COAL SEMESTER PROJECT 

GRID_WIDTH = 40
GRID_HEIGHT = 20

include irvine32.inc

.data
    
    fileName  db "Scores.txt" 
	inputName db "Enter your name ... ",0
    username  db 50 dup(0)
    pacmanChar db 'X',0
    ghostChar db 'G',0
    dotChar db '.',0
    wallChar db '#',0

    score dd 0
    lives db 3
    gameOver db 0
    levelComplete db 0
    currentLevel db 1 

    grid db (40*20) dup(' ')

    ghost1X db 10
    ghost1Y db 5
    ghost2X db 30
    ghost2Y db 5
    
    pacmanX db 0
    pacmanY db 0


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


    level1Text db "LEVEL 1",0
    scoreText db "Score: ",0
    livesText db "Lives: ",0
    gameOverText db "GAME OVER",0
    playAgainText db "1. Return to Menu",0
    exitText db "2. Exit Game",0
    chooseOptionText db "Choose option: ",0

    dotsRemaining db ?
    ghost1Dir db ?
    ghost2Dir db ?

.code
main proc
    call Clrscr
    call WelcomeScreen
    call MenuScreen
    
    exit
main endp

;-----------------------------------------------------
WelcomeScreen proc

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

    call Clrscr
    
    ; Display level selection title
    mov eax, blueTxt
    call SetTextColor
    
    
    ; level options
    mov eax, redTxt
    call SetTextColor
    
    ; Level 1
    mov dh, 5
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt0
    call WriteString
    
    mov dh, 6
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt1
    call WriteString
    
    mov dh, 7
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt2
    call WriteString
    
    mov dh, 8
    mov dl, 30
    call Gotoxy
    mov edx, offset level1opt3
    call WriteString
    
    mov dh, 9
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
    mov dh, 15
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt0
    call WriteString
    
    mov dh, 16
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt1
    call WriteString
    
    mov dh, 17
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt2
    call WriteString
    
    mov dh, 18
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt3
    call WriteString
    
    mov dh, 19
    mov dl, 30
    call Gotoxy
    mov edx, offset level3opt4
    call WriteString
    
    ;user choice
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 22
    mov dl, 20
    call Gotoxy
    mov edx, offset leveloptchoose1
    call WriteString
    
    mov dh, 23
    mov dl, 20
    call Gotoxy
    mov edx, offset leveloptchoose2
    call WriteString
    
    mov dh, 24
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
    jmp ReturnToMenu

StartLevel2:
    mov currentLevel, 2
    ; call Level2Screen  ; You'll implement this later
    jmp ReturnToMenu

StartLevel3:
    mov currentLevel, 3
    ; call Level3Screen  ; You'll implement this later
    jmp ReturnToMenu
    
ReturnToMenu:
    ret
    
ExitGame:
    call Clrscr
    exit
LevelSelectScreen endp

;-----------------------------------------------------
InstructionsScreen proc
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

;-----------------------------------------------------

Level1Screen proc
    call InitializeLevel1
    call DrawLevel1Screen
    
GameLoop:
    ; Handle input
    call ReadKey
    jz NoKeyPress
    
    ; Check for WASD keys
    cmp al, 'w'
    je MoveUp
    cmp al, 'a'
    je MoveLeft
    cmp al, 's'
    je MoveDown
    cmp al, 'd'
    je MoveRight
    jmp NoKeyPress
    
MoveUp:
    mov al, pacmanY
    dec al
    cmp al, 0
    jle NoKeyPress
    call CheckCollision
    jc NoKeyPress
    mov pacmanY, al
    jmp UpdateGame
    
MoveLeft:
    mov al, pacmanX
    dec al
    cmp al, 0
    jle NoKeyPress
    call CheckCollision
    jc NoKeyPress
    mov pacmanX, al
    jmp UpdateGame
    
MoveDown:
    mov al, pacmanY
    inc al
    cmp al, 19
    jge NoKeyPress
    call CheckCollision
    jc NoKeyPress
    mov pacmanY, al
    jmp UpdateGame
    
MoveRight:
    mov al, pacmanX
    inc al
    cmp al, 39
    jge NoKeyPress
    call CheckCollision
    jc NoKeyPress
    mov pacmanX, al
    
UpdateGame:
    ; Move ghosts
    call MoveGhosts
    
    ; Check ghost collisions
    call CheckGhostCollision
    
    ; Check if game over
    cmp gameOver, 1
    je GameEnd
    
    ; Check if level complete
    call CheckLevelComplete
    cmp levelComplete, 1
    je LevelCompleted
    
NoKeyPress:
    call DrawLevel1Screen
    mov eax, 100 ; Delay to control game speed
    call Delay
    jmp GameLoop
    
GameEnd:
    call GameOverScreen
    ret
    
LevelCompleted:
    ; Handle level completion
    ret
Level1Screen endp

;-----------------------------------------------------
InitializeLevel1 proc
    ; Clear the entire grid with spaces
    mov edi, offset grid
    mov ecx, GRID_WIDTH * GRID_HEIGHT
    mov al, ' '
    rep stosb

    ; Draw border walls
    ; Top border
    mov ecx, GRID_WIDTH
    mov esi, offset grid ; Top row
DrawTopBorder:
    mov byte ptr [esi], '#' ; Wall character
    inc esi
    loop DrawTopBorder

    ; Bottom border
    mov ecx, GRID_WIDTH
    mov edi, offset grid + (GRID_HEIGHT-1)*GRID_WIDTH ; Bottom row
DrawBottomBorder:
    mov byte ptr [edi], '#'
    inc edi
    loop DrawBottomBorder

    ; Left and right borders
    mov ecx, GRID_HEIGHT-2 ; Skip top and bottom rows
    mov esi, offset grid + GRID_WIDTH ; Start at first column of second row
    mov edi, offset grid + GRID_WIDTH + (GRID_WIDTH-1) ; Last column of second row
DrawSideWalls:
    mov byte ptr [esi], '#'
    mov byte ptr [edi], '#'
    add esi, GRID_WIDTH
    add edi, GRID_WIDTH
    loop DrawSideWalls

    ; Add internal walls with proper patterns
    ; Horizontal wall 1
    mov edi, offset grid + 5*GRID_WIDTH + 5
    mov ecx, 10
HorizontalWall1:
    mov byte ptr [edi], '#'
    inc edi
    loop HorizontalWall1

    ; Vertical wall 1
    mov edi, offset grid + 2*GRID_WIDTH + 15
    mov ecx, 8
VerticalWall1:
    mov byte ptr [edi], '#'
    add edi, GRID_WIDTH
    loop VerticalWall1

    ; L-shaped wall
    mov edi, offset grid + 8*GRID_WIDTH + 25
    mov ecx, 7
LShapeHorizontal:
    mov byte ptr [edi], '#'
    inc edi
    loop LShapeHorizontal
    
    mov ecx, 5
LShapeVertical:
    mov byte ptr [edi], '#'
    add edi, GRID_WIDTH
    loop LShapeVertical

    ; T-shaped wall
    mov edi, offset grid + 12*GRID_WIDTH + 10
    mov ecx, 7
TShapeHorizontal:
    mov byte ptr [edi], '#'
    inc edi
    loop TShapeHorizontal
    
    mov edi, offset grid + 12*GRID_WIDTH + 13
    mov ecx, 6
TShapeVertical:
    mov byte ptr [edi], '#'
    add edi, GRID_WIDTH
    loop TShapeVertical

    ; Place dots only in empty spaces
    mov ecx, GRID_WIDTH * GRID_HEIGHT
    mov esi, offset grid
PlaceDots:
    cmp byte ptr [esi], ' '
    jne SkipDotPlacement
    mov byte ptr [esi], '.' ; Dot character
SkipDotPlacement:
    inc esi
    loop PlaceDots

    ; Initialize player and ghost positions
    ; Pacman starting position (center)
    mov pacmanX, 20
    mov pacmanY, 10
    
    ; Ghost 1 (top-left area)
    mov ghost1X, 10
    mov ghost1Y, 5
    mov ghost1Dir, 1 ; Right
    
    ; Ghost 2 (top-right area)
    mov ghost2X, 30
    mov ghost2Y, 5
    mov ghost2Dir, 3 ; Left
    

    ; Initialize game state
    mov score, 0
    mov lives, 3
    mov gameOver, 0
    mov levelComplete, 0
    mov dotsRemaining, 0 ; Will be calculated
    
    ; Count initial dots
    mov ecx, GRID_WIDTH * GRID_HEIGHT
    mov esi, offset grid
CountDots:
    cmp byte ptr [esi], '.'
    jne NotADot
    inc dotsRemaining
NotADot:
    inc esi
    loop CountDots
    
    ret
InitializeLevel1 endp
;-----------------------------------------------------
GenerateWalls proc
    ; First line (2 walls)
    mov ecx, 2
    call GenerateWallLine
    
    ; Second line (5 walls)
    mov ecx, 5
    call GenerateWallLine
    
    ; Third line (2 walls)
    mov ecx, 2
    call GenerateWallLine
    
    ; Fourth line (2 walls)
    mov ecx, 2
    call GenerateWallLine
    ret
GenerateWalls endp

;-----------------------------------------------------
GenerateWallLine proc
    ; ECX = number of walls to generate
    push ecx
    
    ; Get random Y position (1-18)
    mov eax, 18
    call RandomRange
    inc eax
    
    ; Calculate row offset
    mov edx, 40
    mul edx
    mov edi, offset grid
    add edi, eax
    
    ; Generate walls
    mov ecx, [esp] ; Get count from stack
GenerateWall:
    push ecx
    
    ; Get random X position (1-38)
    mov eax, 38
    call RandomRange
    inc eax
    
    ; Place wall (FIXED: added byte ptr)
    mov byte ptr [edi + eax], '#'
    
    ; Randomly extend wall (create L-shapes, etc.)
    mov eax, 4
    call RandomRange
    cmp eax, 1
    jl NoExtend
    je ExtendRight
    cmp eax, 2
    je ExtendDown
    cmp eax, 3
    je ExtendLeft
    
ExtendRight:
    inc eax
    cmp eax, 39
    jge NoExtend
    mov byte ptr [edi + eax], '#'  ; FIXED: added byte ptr
    jmp NoExtend
    
ExtendDown:
    mov edx, 40
    add edx, edi
    add edx, eax
    cmp edx, offset grid + 40*20
    jge NoExtend
    mov byte ptr [edx], '#'        ; FIXED: added byte ptr
    jmp NoExtend
    
ExtendLeft:
    dec eax
    cmp eax, 0
    jle NoExtend
    mov byte ptr [edi + eax], '#'  ; FIXED: added byte ptr
    
NoExtend:
    pop ecx
    loop GenerateWall
    
    pop ecx
    ret
GenerateWallLine endp

;-----------------------------------------------------
DrawLevel1Screen proc
    call Clrscr
    
    ; Draw game stats on left side
    mov dl, 5
    mov dh, 2
    call Gotoxy
    mov edx, offset level1Text
    call WriteString
    
    mov dl, 5
    mov dh, 4
    call Gotoxy
    mov edx, offset scoreText
    call WriteString
    mov eax, score
    call WriteDec
    
    mov dl, 5
    mov dh, 6
    call Gotoxy
    mov edx, offset livesText
    call WriteString
    movzx eax, lives
    call WriteDec
    
    ; Draw game grid on right side
    mov ecx, 20
    mov dh, 0
    mov dl, 30  ; Start grid at column 30
DrawRow:
    push ecx
    push edx
    
    ; Calculate row offset
    mov eax, 40
    mul dh
    mov esi, offset grid
    add esi, eax
    
    ; Draw row
    mov ecx, 40
DrawColumn:
    mov al, [esi]
    call WriteChar
    inc esi
    inc dl
    loop DrawColumn
    
    pop edx
    pop ecx
    inc dh
    loop DrawRow
    
    ; Draw pacman and ghosts...
    ret
DrawLevel1Screen endp

;-----------------------------------------------------
CheckCollision proc
    ; Check if position (al=X, ah=Y) is valid
    ; Returns CF=1 if collision with wall
    
    ; Calculate grid offset
    movzx edx, ah
    imul edx, 40
    movzx ecx, al
    add edx, ecx
    
    ; Check grid position (FIXED: added byte ptr)
    cmp byte ptr grid[edx], '#'
    je WallCollision
    
    ; Check if dot was collected (FIXED: added byte ptr)
    cmp byte ptr grid[edx], '.'
    jne NoCollision
    
    ; Collect dot (FIXED: added byte ptr)
    mov byte ptr grid[edx], ' '
    inc score
    
NoCollision:
    clc
    ret
    
WallCollision:
    stc
    ret
CheckCollision endp

;-----------------------------------------------------
MoveGhosts proc
    ; Move ghost 1
    mov al, ghost1X
    mov ah, ghost1Y
    call MoveGhost
    mov ghost1X, al
    mov ghost1Y, ah
    
    ; Move ghost 2
    mov al, ghost2X
    mov ah, ghost2Y
    call MoveGhost
    mov ghost2X, al
    mov ghost2Y, ah
    
    ret
MoveGhosts endp

;-----------------------------------------------------
MoveGhost proc
    ; Simple random ghost movement
    ; Input: al=X, ah=Y
    ; Output: Updated X,Y in al,ah
    
    push eax
    
    ; Get random direction (0-3)
    mov eax, 4
    call RandomRange
    
    pop ebx ; Restore original position
    
    cmp al, 0
    je MoveRight
    cmp al, 1
    je MoveLeft
    cmp al, 2
    je MoveUp
    jmp MoveDown
    
MoveRight:
    inc bl
    cmp bl, 39
    jge GhostNoMove
    jmp CheckGhostMove
    
MoveLeft:
    dec bl
    cmp bl, 0
    jle GhostNoMove
    jmp CheckGhostMove
    
MoveUp:
    dec bh
    cmp bh, 0
    jle GhostNoMove
    jmp CheckGhostMove
    
MoveDown:
    inc bh
    cmp bh, 19
    jge GhostNoMove
    
CheckGhostMove:
    ; Check if new position is walkable
    movzx edx, bh
    imul edx, 40
    movzx ecx, bl
    add edx, ecx
    cmp grid[edx], '#'
    je GhostNoMove
    
    ; Move is valid
    mov al, bl
    mov ah, bh
    ret
    
GhostNoMove:
    mov al, bl
    mov ah, bh
    ret
MoveGhost endp

;-----------------------------------------------------
CheckGhostCollision proc
    ; Check if pacman collided with any ghost
    mov al, pacmanX
    mov ah, pacmanY
    
    ; Check ghost 1
    cmp al, ghost1X
    jne CheckGhost2
    cmp ah, ghost1Y
    jne CheckGhost2
    jmp GhostCollision
    
CheckGhost2:
    cmp al, ghost2X
    jne NoGhostCollision
    cmp ah, ghost2Y
    jne NoGhostCollision
    
GhostCollision:
    ; Lose a life
    dec lives
    cmp lives, 0
    jg ResetPositions
    
    ; Game over
    mov gameOver, 1
    ret
    
ResetPositions:
    ; Reset positions after collision
    mov pacmanX, 20
    mov pacmanY, 10
    ret
    
NoGhostCollision:
    ret
CheckGhostCollision endp

;-----------------------------------------------------
CheckLevelComplete proc
    ; Check if all dots are collected
    mov ecx, 40*20
    mov esi, offset grid
CheckDots:
    cmp byte ptr [esi], '.'
    je DotFound
    inc esi
    loop CheckDots
    
    ; No dots found - level complete
    mov levelComplete, 1
    ret
    
DotFound:
    ret
CheckLevelComplete endp

;-----------------------------------------------------
GameOverScreen proc
    call Clrscr
    
    ; Display game over message
    mov eax, redTxt
    call SetTextColor
    
    mov dh, 10
    mov dl, 35
    call Gotoxy
    mov edx, offset gameOverText
    call WriteString
    
    ; Display score
    mov eax, whiteTxt
    call SetTextColor
    
    mov dh, 12
    mov dl, 35
    call Gotoxy
    mov edx, offset scoreText
    call WriteString
    mov eax, score
    call WriteDec
    
    ; Display options
    mov dh, 14
    mov dl, 35
    call Gotoxy
    mov edx, offset playAgainText
    call WriteString
    
    mov dh, 15
    mov dl, 35
    call Gotoxy
    mov edx, offset exitText
    call WriteString
    
    mov dh, 17
    mov dl, 35
    call Gotoxy
    mov edx, offset chooseOptionText
    call WriteString
    
    ; Get user choice
    call ReadInt
    cmp al, 1
    je ReturnToMenu
    cmp al, 2
    je ExitGame
    
ReturnToMenu:
    ret
    
ExitGame:
    call Clrscr
    exit
GameOverScreen endp

end main