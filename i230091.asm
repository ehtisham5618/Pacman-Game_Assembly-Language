
include macros.inc
include Irvine32.inc
includelib winmm.lib

PlaySound PROTO,
pszSound:PTR BYTE, 
hmod:DWORD, 
fdwSound:DWORD

.data

    snd_filename dword 20001h
    musicchomp DB "ingame.wav", 0
    musicintro DB "beginning.wav", 0
    

    speed1 dword 147
    speed2 dword 115
    speed3 dword 96

    levelindicator DB 1
    livesindicator DB 3
    score DW 0

    Menu1InputNamePrompt DB 25 Dup(?)
    buffer db 255 Dup(?)
    scoreBuffer DB "   0",0 

    Name1 db 25 Dup(?)  ; for reading from file
    Name2 db 25 Dup(?)
    Name3 db 25 Dup(?)

    level_1 db 25 Dup(?)   ; for reading from file
    level_2 db 25 Dup(?)
    level_3 db 25 Dup(?)

    Score1 db 25 Dup(?)   ; for reading from file
    Score2 db 25 Dup(?)
    Score3 db 25 Dup(?)


    filename DB  "score.txt", 0
    fileHandle HANDLE ?

    Coins DW 1040

;                                           Player Movement Handles      
    
    wayhandleplayer DB 3
    PlayerMovement1Possibibly DB 1

    handleghost1D DB 1
    ifghost1move DB 1

    wayhandle2ghost DB 1
    move2ghostPossibibly DB 1
    seeway3ghost DB 1
    maybemov3ghost DB 1

    wayhandle4ginn DB 1
    maybemovgin4 DB 1
    wayhandle5ginn DB 2
    walkinginn5Possibibly DB 1
    wayhandle6ginn DB 3
    go6ginnPossibibly DB 1
    wayhandleofgin7 DB 1
    Ghost7MovementPossibibly DB 1

    g1status DB 1
    g2status DB 1
    g3status DB 1
    g4status DB 1
    g5status DB 1
    g6status DB 1
    g7status DB 1

;                                           Player  
; 
    xPos DB 8
    yPos DB 7
    inputChar DB ?
;                                    Coin,Space,Ghost  
    wall DB "A"
    coin DB "-"
    space DB " "

    G1 DB "?"    
    G2 DB "?"     
    G3 DB "?"   
    G4 DB "?"    
    G5 DB "?"    
    G6 DB "?"    
    G7 DB "?"   

    xG1Pos DB 10
    yG1Pos DB 15

    xG2Pos DB 8
    yG2Pos DB 15
    xG3Pos DB 12
    yG3Pos DB 17

    xG4Pos DB 40
    yG4Pos DB 21
    xG5Pos DB 34
    yG5Pos DB 21
    xG6Pos DB 40
    yG6Pos DB 15
    xG7Pos DB 34
    yG7Pos DB 15
;                                       Main Screen

    mr1 DB "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0
    mr2 DB "AAAA                                                                   AAAA",0

    header0 DB "   ,------------------------------------------------------------,",0
    header1 DB "   |   ________                                                 |",0
    header2 DB "   |   \____   \ _____      ____     _____   _____      ____    |",0
    header3 DB "   |    |   ___/ \__  \   _/ ___\   /     \  \__  \    /    \   |",0
    header4 DB "   |    |  |      / __ \_ \  \___  |  | |  \  / __ \_ |   |  \  |",0
    header5 DB "   |    |__|     (____  /  \__  /  |__|_|  / (____  / |___|  /  |",0
    header6 DB "   |                  \/      \/         \/       \/       \/   |",0 
    header7 DB "   |                                                            |",0
    header8 DB "   |                     By: Ehtisham Abid                      |",0
    header9 DB "   '------------------------------------------------------------'",0
    
;                                    Maze 1  

    level101 DB "     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0
    level102 DB "     AA - - - - - - - - - - - - - - AA",0
    level103 DB "     AA - - - AAAAAAAAAAAAAAA - - - AA",0
    level104 DB "     AA - - - AAA         AAA - - - AA",0
    level105 DB "     AA - - - AAA         AAA - - - AA",0
    level106 DB "     AA - - - AAAAAAAAAAAAAAA - - - AA",0
    level107 DB "     AA - - - - - - - - - AAA - - - AA",0    
    level108 DB "     AA - - - - - - - - - AAA - - - AA",0
    level109 DB "     AA - - - - - - - - - AAA - - - AA",0
    level110 DB "     AA - - - - - - - - - AAA - - - AA",0
    level111 DB "     AA - - - - - - - - - - - - - - AA",0
    level112 DB "     AA - - - - - - - - - - - - - - AA",0
    level113 DB "     AA - - - - - - - - - AAA - - - AA",0
    level114 DB "     AA - - - - - - - - - AAA - - - AA",0
    level115 DB "     AA - - - - - - - - - AAA - - - AA",0
    level116 DB "     AA - - - - - - - - - AAA - - - AA",0
    level117 DB "     AA - - - - - - - - - AAA - - - AA",0
    level118 DB "     AA - - - - - - - - - AAA - - - AA",0
    level119 DB "     AA - - - - - - - - - AAA - - - AA",0
    level120 DB "     AA - - - - - - - - - AAA - - - AA",0
    level121 DB "     AA - - - - - - - - - - - - - - AA",0
    level122 DB "     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0
   
;                                               maze 2  

    level2r01 DB "     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0
    level2r02 DB "     AA - - - - - - - - - - - - - - - - - - - - AA",0
    level2r03 DB "     AA * - - - - - - - - - - - - - - - - - - * AA",0
    level2r04 DB "     AA - - - - - - - - - - - - - - - - - - - - AA",0
    level2r05 DB "     AA - - - - - - - - - - - - - - - - - - - - AA",0
    level2r06 DB "     AA - - - AAAAAAAAAAAAAAA - - - - AAA - - - AA",0
    level2r07 DB "     AA - - - AAA         AAA - - - - AAA - - - AA",0
    level2r08 DB "     AA - - - AAA         AAA - - - - AAA - - - AA",0
    level2r09 DB "     AA - - - AAA         AAA - - - - AAA - - - AA",0
    level2r10 DB "     AA - - - AAA         AAA - - - - AAA - - - AA",0
    level2r11 DB "     AA - - - AAAAAAAAAAAAAAA - - - - AAA - - - AA",0
    level2r12 DB "     AA - - - - - - - - - AAA - - - - AAA - - - AA",0
    level2r13 DB "     AA - - - - - - - - - AAA - - - - AAA - - - AA",0
    level2r14 DB "     AA - - - - - - - - - AAA - - - - AAA - - - AA",0
    level2r15 DB "     AA - - - - - - - - - AAA - - - - AAA - - - AA",0
    level2r16 DB "     AA - - - - - - - - - AAA - - - - AAA - - - AA",0
    level2r17 DB "     AA - - - - - - - - - AAA - - - - AAA - - - AA",0
    level2r18 DB "     AA - - - - - - - - - - - - - - - - - - - - AA",0
    level2r19 DB "     AA * - - - - - - - - - - - - - - - - - - * AA",0
    level2r20 DB "     AA - - - - - - - - - - - - - - - - - - - - AA",0
    level2r21 DB "     AA - - - - - - - - - - - - - - - - - - - - AA",0
    level2r22 DB "     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0

;                                          maze 3   

    levelr301 DB "     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0
    levelr302 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - * AA",0
    levelr303 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - AA",0
    levelr304 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - AA",0
    levelr305 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - AA",0
    levelr306 DB "     AA - - - - - - AAAAAAAAAAAAAAAAA - - - - - - AAA - - - - - - - AA",0
    levelr307 DB "     AA * - - - - - AAA           AAA - - - - - - AAA - - - - - - * AA",0    
    levelr308 DB "     AA - - - - - - AAA           AAA - - - - - - AAA - - - - - - - AA",0
    levelr309 DB "     AA - - - - - - AAA           AAA - - - - - - AAA - - - - - - - AA",0
    levelr310 DB "     AA - - - - - - AAA           AAA - - - - - - AAA - - - - - - - AA",0
    levelr311 DB "        - - - - - - AAAAAAAAAAAAAAAAA - - - - - - AAA - - - - - - -   ",0
    levelr312 DB "        - - - - - - - - - - - - - AAA - - - - - - AAA - - - - - - -   ",0
    levelr313 DB "     AA - - - - - - - - - - - - - AAA - - - - - - AAA - - - - - - - AA",0
    levelr314 DB "     AA - - - - - - - - - - - - - AAA - - - - - - AAA - - - - - - - AA",0
    levelr315 DB "     AA - - - - - - - - - - - - - AAA - - - - - - AAA - - - - - - - AA",0
    levelr316 DB "     AA * - - - - - - - - - - - - AAA - - - - - - AAA - - - - - - - AA",0
    levelr317 DB "     AA - - - - - - - - - - - - - AAA - - - - - - AAA - - - - - - * AA",0
    levelr318 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - AA",0
    levelr319 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - * AA",0
    levelr320 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - AA",0
    levelr321 DB "     AA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - AA",0
    levelr322 DB "     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0


.code
main PROC
   
;                                      Ist Page
    call Menu1Name
    call PacmanLogo
    call inputname

    Menu:
    call Menu2Screen
    call Readchar
    cmp al,"1"
    je level1
    cmp al,"2"
    jne n2
    call clrscr
    call InstructionPage
    call readchar
    jmp Menu
    n2:
    cmp al,"3"
    jne SkipL
    call highmenu
    call readchar
    jmp Menu
    SkipL:
    n3:
    cmp al,"4"
    je exitGame
    n4:


    level1:
        call Level1Maze 
    level2:
        call Level2Maze 
    level3:
        call Level3Maze

    exitGame:
    call clrscr
    mov eax, white (black*16)
    call settextcolor
    exit

main ENDP

;                                       pacman Name and userName

Menu1Name PROC  

    mov esi,offset [mr1]
    mov ecx,lengthof mr1
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr1]
    mov ecx,lengthof mr1
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay

    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr2]
    mov ecx,lengthof mr2
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay

    mov esi,offset [mr1]
    mov ecx,lengthof mr1
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay
    mov esi,offset [mr1]
    mov ecx,lengthof mr1
    call Menu1Displayer
    call crlf
    mov eax,1   
    call Delay

    mov eax ,0
    mov eax, black (black*16)
    call settextcolor

    ret
Menu1Name ENDP  
Menu1Displayer PROC

    ld1:
        mov ebx,[esi]  
        cmp bl,' '
        jz C1
        cmp bl,wall
        jz C3
        jmp excape
        C1: call DrawSpace
        jmp excape
        C3: call DrawblueWall
        excape:
        inc esi
        loop ld1    
    ret
Menu1Displayer ENDP 
PacmanLogo PROC  
    mov eax ,0
    mov eax, red (black*16)
    call settextcolor

    mov dh,3
    mov dl,4
    call gotoxy
    mov edx,offset header0
    call writestring
    mov  eax,50    
    call Delay
    mov dh,4
    mov dl,4
    call gotoxy
    mov edx,offset header1
    call writestring
    mov  eax,50    
    call Delay
    mov dh,5
    mov dl,4
    call gotoxy
    mov edx,offset header2
    call writestring
    mov  eax,50   
    call Delay
    mov dh,6
    mov dl,4
    call gotoxy
    mov edx,offset header3
    call writestring
    mov  eax,50   
    call Delay
    mov dh,7
    mov dl,4
    call gotoxy
    mov edx,offset header4
    call writestring
    mov  eax,50    
    call Delay
    mov dh,8
    mov dl,4
    call gotoxy
    mov edx,offset header5
    call writestring
    mov  eax,50    
    call Delay
    mov dh,9
    mov dl,4
    call gotoxy
    mov edx,offset header6
    call writestring
    mov  eax,50   
    call Delay
    mov dh,10
    mov dl,4
    call gotoxy
    mov edx,offset header7
    call writestring
    mov  eax,50   
    call Delay
    mov dh,11
    mov dl,4
    call gotoxy
    mov edx,offset header8
    call writestring
    mov  eax,50   
    call Delay
    mov dh,12
    mov dl,4
    call gotoxy
    mov edx,offset header9
    call writestring
    mov  eax,50   
    call Delay

    mov eax ,0
    mov eax, black (black*16)
    call settextcolor

    ret
PacmanLogo ENDP 
inputname PROC 
    
    mov eax ,0
    mov eax, gray (black*16)
    call settextcolor

    mov dh,21
    mov dl,25
    call gotoxy
    mwrite "Press 'ENTER' to Continue",0

    mov eax ,0
    mov eax, yellow (black*16)
    call settextcolor

    mov dh,17
    mov dl,28
    call gotoxy
    mwrite "Enter Name : ",0

    INVOKE PlaySound, OFFSET musicIntro, NULL, snd_filename
    
    mov ecx,25
    mov edx,offset Menu1InputNamePrompt
    call readstring

    mov eax ,0
    mov eax, black (black*16)
    call settextcolor

    
    ret
inputname ENDP 
 
creategin PROC 
    dec ecx
    ld1:
        mov ebx,[esi]
        cmp bl,' '
        jz C1
        cmp bl,"P"
        jz C2
        cmp bl,"W"
        jz C3
        cmp bl,"B"
        jz C4
        call DrawWall
    C1: call DrawSpace
        jmp excape
    C2: call reddrawwall
        jmp excape
    C3: call whitedrawwall
        jmp excape
    C4: call graydrawwall
        jmp excape
    excape:
    inc esi
    loop ld1

    ret
creategin ENDP 

Redcreategin PROC 
    dec ecx
    ld1:
        mov ebx,[esi]
        cmp bl,' '
        jz C1
        cmp bl,"P"
        jz C2
        cmp bl,"W"
        jz C3
        cmp bl,"B"
        jz C4
        call DrawWall
    C1: call DrawSpace
        jmp excape
    C2: call reddrawwall
        jmp excape
    C3: call whitedrawwall
        jmp excape
    C4: call DrawBlueWall
        jmp excape
    excape:
    inc esi
    loop ld1

    ret
Redcreategin ENDP 

;                                           2nd Page

Menu2Screen PROC
    call clrscr
    call  Menu1Name  
    call PacmanLogo

    mov eax ,0
    mov eax, gray (black*16)
    call settextcolor

    mov dh,21
    mov dl,29
    call gotoxy
    mwrite "Press '1,2,3 or 4'",0
    mov dh,23
    mov dl,30
    call gotoxy
    mwrite "to move forward",0

    mov eax ,0
    mov eax, white (black*16)
    call settextcolor

    mov dh,15
    mov dl,35
    call gotoxy 
    mwrite "Play",0

    mov dh,16
    mov dl,30
    call gotoxy
    mwrite " Instructions",0

    mov dh,17
    mov dl,30
    call gotoxy
    mwrite " Highestscore",0
    
    mov dh,18
    mov dl,35
    call gotoxy
    mwrite "End",0

    mov eax ,0
    mov eax, white (black*16)
    call settextcolor
    
    ret
Menu2Screen ENDP

;                                        Instructions

InstructionPage PROC    
    call clrscr
    call  Menu1Name  
    call PacmanLogo

    mov eax ,0
    mov eax, red (black*16)
    call settextcolor

    mov dh,15
    mov dl,10
    call gotoxy
    mwrite "            Asking for Game Instructions?",0
    mov dh,17
    mov dl,8
    call gotoxy
    mwrite "     Do you also need to know how to live in this world?",0
    mov dh,18
    mov dl,10
    call gotoxy
    mwrite "    Just Play the game. You will know what to do!",0
    mov dh,20
    mov dl,10
    call gotoxy
    mwrite "                Ready for Adventure.",0
    
    mov eax ,0
    mov eax, white (black*16)
    call settextcolor

    mov dh,22
    mov dl,22
    call gotoxy
    mwrite "b for return to previous page",0
    ret
InstructionPage ENDP    

;                                       Read data from file

highmenu PROC
    call clrscr
    call Menu1Name  
    call PacmanLogo 
    mov edx,OFFSET filename
    call OpenInputFile
    mov fileHandle,eax

    letsOpenFile:
        mov edx,offset buffer
        mov ecx,255
        call ReadFromFile
        mov buffer[255],0
    call CloseFile

    mov eax ,0
    mov eax, yellow (black*16)
    call settextcolor

    mov dh,23
    mov dl,25
    call gotoxy
    mwrite "b for return to previous page",0

    mov eax,white(black*16)
    call settextcolor

    mov dh,16
    mov dl,25
    call gotoxy
    mwrite "Name      Score       Level",0
    call crlf

    mov eax,gray(black*16)
    call settextcolor

    mov esi,offset buffer
    mov dh,18
    mov dl,25
    call gotoxy
    mov edi,offset Name1
    call maskin 
    mov dh,18
    mov dl,36
    call gotoxy
    mov edi,offset Score1
    call maskin 
    mov dh,18
    mov dl,49
    call gotoxy
    mov edi,offset level_1
    call maskin 

    mov dh,19
    mov dl,25
    call gotoxy
    mov edi,offset Name2
    call maskin 
    mov dh,19
    mov dl,36
    call gotoxy
    mov edi,offset Score2
    call maskin 
    mov dh,19
    mov dl,49
    call gotoxy
    mov edi,offset level_2
    call maskin 

    mov dh,20
    mov dl,25
    call gotoxy
    mov edi,offset Name3
    call maskin 
    mov dh,20
    mov dl,36
    call gotoxy
    mov edi,offset Score3
    call maskin 
    mov dh,20
    mov dl,49
    call gotoxy
    mov edi,offset level_3
    call maskin 
    ret
highmenu ENDP  
maskin PROC 


    mov ebx," "
    cmp [esi],bl
    jne l1
    inc esi
    l1:
    mov ecx,0
    mov cl,[esi]
    mov eax,[esi]
    call writechar
    mov [edi],cl
    inc esi
    inc edi
    cmp [esi],bl
    jne l1

ret
maskin endp  

;                                       Game Start

getValuesofUser PROC
    mov edx,OFFSET filename
    call OpenInputFile
    mov fileHandle,eax

    letsOpenFile:
        mov edx,offset buffer
        mov ecx,255
        call ReadFromFile
        mov buffer[255],0
    call CloseFile

    mov esi,offset buffer

    mov edi,offset Name1
    call FileReadingMasking 
    mov edi,offset Score1
    call FileReadingMasking 
    mov edi,offset level_1
    call FileReadingMasking 

    mov edi,offset Name2
    call FileReadingMasking 
    mov edi,offset Score2
    call FileReadingMasking 
    mov edi,offset level_2
    call FileReadingMasking 

    mov edi,offset Name3
    call FileReadingMasking 
    mov edi,offset Score3
    call FileReadingMasking 
    mov edi,offset level_3
    call FileReadingMasking 
    ret
getValuesofUser ENDP  
FileReadingMasking PROC 

    mov ebx," "
    cmp [esi],bl
    jne l1
    inc esi
    l1:
    mov ecx,0
    mov cl,[esi]
    mov [edi],cl
    inc esi
    inc edi
    cmp [esi],bl
    jne l1

ret
FileReadingMasking endp  
EndScreen PROC
    
    call clrscr
    call Menu1Name  
    call PacmanLogo
    call getValuesofUser   
   
    mov eax ,0
    mov eax, gray (black*16)
    call settextcolor

    mov dh,21
    mov dl,28
    call gotoxy
    mwrite "Click 'R' to Restart",0

    mov dh,16
    mov dl,28
    call gotoxy
    mov eax, white (black*16)
    call settextcolor
    mwrite "   Name : ",
    mov edx,offset Menu1InputNamePrompt
    call writestring
    mov dh,17
    mov dl,28
    call gotoxy
    mwrite " Scored : ",
    mov ax,score
    call Writedec
    mov dh,18
    mov dl,28
    call gotoxy
    mwrite "  Level : ",
    mov eax,0
    mov al,levelIndicator
    call Writedec
    call readchar
    call clrscr
    call main   
    ret
EndScreen ENDP  

;                                             Maze 1 setup

DrawLevel1 PROC 

    mov esi,offset [level101]
    mov ecx,lengthof level101
    mov dl,0
    mov dh,6
    call Gotoxy
    call LevelDisplayer1

    mov esi,offset [level102]
    mov ecx,lengthof level102
    mov dl,0
    mov dh,7
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level103]
    mov ecx,lengthof level103
    mov dl,0
    mov dh,8
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level104]
    mov ecx,lengthof level104
    mov dl,0
    mov dh,9
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level105]
    mov ecx,lengthof level105
    mov dl,0
    mov dh,10
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level106]
    mov ecx,lengthof level106
    mov dl,0
    mov dh,11
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level107]
    mov ecx,lengthof level107
    mov dl,0
    mov dh,12
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level108]
    mov ecx,lengthof level108
    mov dl,0
    mov dh,13
    call Gotoxy
    call LevelDisplayer1

    mov esi,offset [level109]
    mov ecx,lengthof level109
    mov dl,0
    mov dh,14
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level110]
    mov ecx,lengthof level110
    mov dl,0
    mov dh,15
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level111]
    mov ecx,lengthof level111
    mov dl,0
    mov dh,16
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level112]
    mov ecx,lengthof level112
    mov dl,0
    mov dh,17
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level113]
    mov ecx,lengthof level113
    mov dl,0
    mov dh,18
    call Gotoxy
    call LevelDisplayer1

    mov esi,offset [level114]
    mov ecx,lengthof level114
    mov dl,0
    mov dh,19
    call Gotoxy
    call LevelDisplayer1

    mov esi,offset [level115]
    mov ecx,lengthof level115
    mov dl,0
    mov dh,20
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level116]
    mov ecx,lengthof level116
    mov dl,0
    mov dh,21
    call Gotoxy
    call LevelDisplayer1

    mov esi,offset [level117]
    mov ecx,lengthof level117
    mov dl,0
    mov dh,22
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level118]
    mov ecx,lengthof level118
    mov dl,0
    mov dh,23
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level119]
    mov ecx,lengthof level119
    mov dl,0
    mov dh,24
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level120]
    mov ecx,lengthof level120
    mov dl,0
    mov dh,25
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level121]
    mov ecx,lengthof level121
    mov dl,0
    mov dh,26
    call Gotoxy
    call LevelDisplayer1
    
    mov esi,offset [level122]
    mov ecx,lengthof level122
    mov dl,0
    mov dh,27
    call Gotoxy
    call LevelDisplayer1
    ret 
DrawLevel1 ENDP 
LevelDisplayer1 PROC 
    dec ecx
    ld1:
        mov ebx,[esi]
        cmp bl,' '
        jz C1
        cmp bl,coin
        jz C2
        cmp bl,wall
        jz C3
        call DrawWall
    C1: call DrawSpace
        jmp excape
    C2: call DrawCoin
        jmp excape
    C3: call DrawWall
        jmp excape
    excape:
    inc esi
    loop ld1

    ret
LevelDisplayer1 ENDP 

;                                           Maze 2 setup

DrawLevel2 PROC 

    mov esi,offset [level2r01]
    mov ecx,lengthof level2r01
    mov dl,0
    mov dh,6
    call Gotoxy
    call LevelDisplayer2

    mov esi,offset [level2r02]
    mov ecx,lengthof level2r02
    mov dl,0
    mov dh,7
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r03]
    mov ecx,lengthof level2r03
    mov dl,0
    mov dh,8
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r04]
    mov ecx,lengthof level2r04
    mov dl,0
    mov dh,9
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r05]
    mov ecx,lengthof level2r05
    mov dl,0
    mov dh,10
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r06]
    mov ecx,lengthof level2r06
    mov dl,0
    mov dh,11
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r07]
    mov ecx,lengthof level2r07
    mov dl,0
    mov dh,12
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r08]
    mov ecx,lengthof level2r08
    mov dl,0
    mov dh,13
    call Gotoxy
    call LevelDisplayer2

    mov esi,offset [level2r09]
    mov ecx,lengthof level2r09
    mov dl,0
    mov dh,14
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r10]
    mov ecx,lengthof level2r10
    mov dl,0
    mov dh,15
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r11]
    mov ecx,lengthof level2r11
    mov dl,0
    mov dh,16
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r12]
    mov ecx,lengthof level2r12
    mov dl,0
    mov dh,17
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r13]
    mov ecx,lengthof level2r13
    mov dl,0
    mov dh,18
    call Gotoxy
    call LevelDisplayer2

    mov esi,offset [level2r14]
    mov ecx,lengthof level2r14
    mov dl,0
    mov dh,19
    call Gotoxy
    call LevelDisplayer2

    mov esi,offset [level2r15]
    mov ecx,lengthof level2r15
    mov dl,0
    mov dh,20
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r16]
    mov ecx,lengthof level2r16
    mov dl,0
    mov dh,21
    call Gotoxy
    call LevelDisplayer2

    mov esi,offset [level2r17]
    mov ecx,lengthof level2r17
    mov dl,0
    mov dh,22
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r18]
    mov ecx,lengthof level2r18
    mov dl,0
    mov dh,23
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r19]
    mov ecx,lengthof level2r19
    mov dl,0
    mov dh,24
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r20]
    mov ecx,lengthof level2r20
    mov dl,0
    mov dh,25
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r21]
    mov ecx,lengthof level2r21
    mov dl,0
    mov dh,26
    call Gotoxy
    call LevelDisplayer2
    
    mov esi,offset [level2r22]
    mov ecx,lengthof level2r22
    mov dl,0
    mov dh,27
    call Gotoxy
    call LevelDisplayer2
    ret 
DrawLevel2 ENDP 
LevelDisplayer2 PROC 
    dec ecx
    ld1:
        mov ebx,[esi]
        cmp bl,' '
        jz C1
        cmp bl,coin
        jz C2
        cmp bl,wall
        jz C3
        cmp bl,'*'
        jz C4
        call DrawWall
    C1: call DrawSpace
        jmp excape
    C2: call DrawCoin
        jmp excape
    C3: call DrawWall
        jmp excape
    C4: call DrawFruit
        jmp excape
    excape:
    inc esi
    loop ld1

    ret
LevelDisplayer2 ENDP 

;                                             Maze 3 setup

DrawLevel3 PROC 

    mov esi,offset [levelr301]
    mov ecx,lengthof levelr301
    mov dl,0
    mov dh,6
    call Gotoxy
    call LevelDisplayer3

    mov esi,offset [levelr302]
    mov ecx,lengthof levelr302
    mov dl,0
    mov dh,7
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr303]
    mov ecx,lengthof levelr303
    mov dl,0
    mov dh,8
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr304]
    mov ecx,lengthof levelr304
    mov dl,0
    mov dh,9
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr305]
    mov ecx,lengthof levelr305
    mov dl,0
    mov dh,10
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr306]
    mov ecx,lengthof levelr306
    mov dl,0
    mov dh,11
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr307]
    mov ecx,lengthof levelr307
    mov dl,0
    mov dh,12
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr308]
    mov ecx,lengthof levelr308
    mov dl,0
    mov dh,13
    call Gotoxy
    call LevelDisplayer3

    mov esi,offset [levelr309]
    mov ecx,lengthof levelr309
    mov dl,0
    mov dh,14
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr310]
    mov ecx,lengthof levelr310
    mov dl,0
    mov dh,15
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr311]
    mov ecx,lengthof levelr311
    mov dl,0
    mov dh,16
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr312]
    mov ecx,lengthof levelr312
    mov dl,0
    mov dh,17
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr313]
    mov ecx,lengthof levelr313
    mov dl,0
    mov dh,18
    call Gotoxy
    call LevelDisplayer3

    mov esi,offset [levelr314]
    mov ecx,lengthof levelr314
    mov dl,0
    mov dh,19
    call Gotoxy
    call LevelDisplayer3

    mov esi,offset [levelr315]
    mov ecx,lengthof levelr315
    mov dl,0
    mov dh,20
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr316]
    mov ecx,lengthof levelr316
    mov dl,0
    mov dh,21
    call Gotoxy
    call LevelDisplayer3

    mov esi,offset [levelr317]
    mov ecx,lengthof levelr317
    mov dl,0
    mov dh,22
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr318]
    mov ecx,lengthof levelr318
    mov dl,0
    mov dh,23
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr319]
    mov ecx,lengthof levelr319
    mov dl,0
    mov dh,24
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr320]
    mov ecx,lengthof levelr320
    mov dl,0
    mov dh,25
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr321]
    mov ecx,lengthof levelr321
    mov dl,0
    mov dh,26
    call Gotoxy
    call LevelDisplayer3
    
    mov esi,offset [levelr322]
    mov ecx,lengthof levelr322
    mov dl,0
    mov dh,27
    call Gotoxy
    call LevelDisplayer3
    ret 
DrawLevel3 ENDP 
LevelDisplayer3 PROC 
    dec ecx
    ld1:
        mov ebx,[esi]
        cmp bl,' '
        jz C1
        cmp bl,coin
        jz C2
        cmp bl,wall
        jz C3
        cmp bl,'*'
        jz C4
        call DrawWall
    C1: call DrawSpace
        jmp excape
    C2: call DrawCoin
        jmp excape
    C3: call DrawWall
        jmp excape
    C4: call DrawFruit
        jmp excape
    excape:
    inc esi
    loop ld1

    ret
LevelDisplayer3 ENDP 

;                                               Print setup

DrawSpace PROC
    mov eax,0
    mov al,black (black*16)
    call SetTextColor
    mov al,' '
    call Writechar
    ret
DrawSpace ENDP
DrawCoin PROC
   
    mov eax,0
    mov al,white (black*16)
    call SetTextColor
    mov al,'o'
    call WriteChar
    ret
DrawCoin ENDP
DrawWall PROC
    mov eax,0
    mov eax,gray (gray *16)
    call SetTextColor
    mov al,wall
    call WriteChar
    ret
DrawWall ENDP
DrawFruit PROC
    mov eax,0
    mov eax,1101b
    call SetTextColor
    mov al,'*'
    call WriteChar
    ret
DrawFruit ENDP
reddrawwall PROC 
    mov eax,0
    mov eax,red (red *16)
    call SetTextColor
    mov al,wall
    call WriteChar
    ret
reddrawwall ENDP    
DrawBlueWall PROC 
    mov eax,0
    mov eax,blue (blue *16)
    call SetTextColor
    mov al,wall
    call WriteChar
    ret
DrawBlueWall ENDP  
graydrawwall PROC 
    mov eax,0
    mov eax,1101b (1101b *16)
    call SetTextColor
    mov al,wall
    call WriteChar
    ret
graydrawwall ENDP   
whitedrawwall PROC 
    mov eax,0
    mov eax,white (white *16)
    call SetTextColor
    mov al,wall
    call WriteChar
    ret
whitedrawwall ENDP  

;                                       Live changes Updater

DrawScore PROC 
   
    mov eax,yellow (black * 16)
    call SetTextColor
    mov dl,17
    mov dh,3
    call Gotoxy
    mwrite "Score : ",0
    mov ax,score
    call Writedec

    mov eax,0
    mov dl,7
    mov dh,4
    call Gotoxy
    mwrite "Lives : ",0
    mov al,livesIndicator
    call Writedec


    mov eax,0
    mov dl,27
    mov dh,4
    call Gotoxy
    mwrite "Level : ",0
    mov al,levelIndicator
    call Writedec

    ret

DrawScore ENDP 

;                                       Coordinate Gatter

CoordinaterUpdator PROC 
    mov ebx,0
    mov bh,yPos
    sub bh,6
    mov bl,xPos
    ret
CoordinaterUpdator ENDP 
CoordinaterUpdatorGhost1 PROC 
    mov ebx,0
    mov bh,yG1Pos
    sub bh,6
    mov bl,xG1Pos
    ret
CoordinaterUpdatorGhost1 ENDP 
CoordinaterUpdatorGhost2 PROC 
    mov ebx,0
    mov bh,yG2Pos
    sub bh,6
    mov bl,xG2Pos
    ret
CoordinaterUpdatorGhost2 ENDP 
gin3updatecordinate PROC 
    mov ebx,0
    mov bh,yG3Pos
    sub bh,6
    mov bl,xG3Pos
    ret
gin3updatecordinate ENDP 
gin4changecoordinte PROC 
    mov ebx,0
    mov bh,yG4Pos
    sub bh,6
    mov bl,xG4Pos
    ret
gin4changecoordinte ENDP 
ginn5changecoordinate PROC 
    mov ebx,0
    mov bh,yG5Pos
    sub bh,6
    mov bl,xG5Pos
    ret
ginn5changecoordinate ENDP 
changegin6coordinate PROC 
    mov ebx,0
    mov bh,yG6Pos
    sub bh,6
    mov bl,xG6Pos
    ret
changegin6coordinate ENDP 
CoordinaterUpdatorGhost7 PROC 
    mov ebx,0
    mov bh,yG7Pos
    sub bh,6
    mov bl,xG7Pos
    ret
CoordinaterUpdatorGhost7 ENDP 

;                                           Ghost maze 1

gghostl1row PROC
        cmp bh,1
        je level102_Handle  
        cmp bh,2
        je level103_Handle
        cmp bh,3
        je level104_Handle
        cmp bh,4
        je level105_Handle
        cmp bh,5
        je level106_Handle
        cmp bh,6
        je level107_Handle
        cmp bh,7
        je level108_Handle
        cmp bh,8
        je level109_Handle
        cmp bh,9
        je level110_Handle
        cmp bh,10
        je level111_Handle
        cmp bh,11
        je level112_Handle
        cmp bh,12
        je level113_Handle
        cmp bh,13
        je level114_Handle
        cmp bh,14
        je level115_Handle
        cmp bh,15
        je level116_Handle
        cmp bh,16
        je level117_Handle
        cmp bh,17
        je level118_Handle
        cmp bh,18
        je level119_Handle
        cmp bh,19
        je level120_Handle
        cmp bh,20
        je level121_Handle
        cmp bh,21
        je level122_Handle
            
        level102_Handle:  
        mov esi,offset level102
                        jmp seewalksee
        level103_Handle:  
        mov esi,offset level103
                        jmp seewalksee
        level104_Handle:  mov esi,offset level104
                        jmp seewalksee
        level105_Handle:  mov esi,offset level105
                        jmp seewalksee
        level106_Handle:  mov esi,offset level106
                        jmp seewalksee
        level107_Handle:  mov esi,offset level107
                        jmp seewalksee
        level108_Handle:  mov esi,offset level108
                        jmp seewalksee
        level109_Handle:  mov esi,offset level109
                        jmp seewalksee
        level110_Handle:  mov esi,offset level110
                        jmp seewalksee
        level111_Handle:  mov esi,offset level111
                        jmp seewalksee
        level112_Handle:  mov esi,offset level112
                        jmp seewalksee
        level113_Handle:  mov esi,offset level113
                        jmp seewalksee
        level114_Handle:  mov esi,offset level114
                        jmp seewalksee
        level115_Handle:  mov esi,offset level115
                        jmp seewalksee
        level116_Handle:  mov esi,offset level116
                        jmp seewalksee
        level117_Handle:  mov esi,offset level117
                        jmp seewalksee
        level118_Handle:  mov esi,offset level118
                        jmp seewalksee
        level119_Handle:  mov esi,offset level119
                        jmp seewalksee
        level120_Handle:  mov esi,offset level120
                        jmp seewalksee
        level121_Handle:  mov esi,offset level121
                        jmp seewalksee
        level122_Handle:  mov esi,offset level122
                        jmp seewalksee

        seewalksee:
    ret
gghostl1row ENDP    
DrawGhost1 PROC 
    mov eax,0
    mov al,white (16*1101b)
    call SetTextColor
    mov dl,xG1Pos
    mov dh,yG1Pos
    call Gotoxy
    mov al,G1
    call WriteChar
    mov al,white (16*black)
    call SetTextColor
    ret
DrawGhost1 ENDP  
UpdateGhost1 PROC
    mov dl,xG1Pos
    mov dh,yG1Pos    
    call Gotoxy
    mov ebx,0
    mov bh,yG1Pos
    sub bh,6
    mov bl,xG1Pos
    call gghostl1row
    mov cl,bl

    l1: inc esi
    loop l1

    mov edx,0
    mov dh,"-"
    cmp [esi],dh
    jne next
    mov eax,white (black*16)
    call settextcolor
    mov al,"o"
    call Writechar
    next:
    mov al," "
    call WriteChar
    escape:      
    ret
UpdateGhost1 ENDP   
moveghost1 PROC 
        call Level1Intersection 

        mov ifghost1move,1

        cmp handleghost1D,1
        je L1moveRight
        cmp handleghost1D,2
        je L1moveLeft
        cmp handleghost1D,3
        je L1moveUp
        cmp handleghost1D,4
        je L1MoveDown

        L1moveRight:   
            call UpdateGhost1
            inc xG1Pos
            inc xG1Pos
            mov handleghost1D,1
            call CoordinaterUpdatorGhost1
            call movelevel1ghost1leftright 
            jmp L1SkipLeftRight

        L1moveLeft: 
            call UpdateGhost1
            dec xG1Pos
            dec xG1Pos
            mov handleghost1D,2
            call CoordinaterUpdatorGhost1
            call movelevel1ghost1leftright 
            jmp L1SkipLeftRight

        L1moveUp:
            call UpdateGhost1
            dec yG1Pos
            mov handleghost1D,3
            call CoordinaterUpdatorGhost1
            call ghost1moveuplevel1
            jmp L1SkipLeftRight

        L1MoveDown:
            call UpdateGhost1
            inc yG1Pos
            mov handleghost1D,4
            call CoordinaterUpdatorGhost1
            call downmoveghost1level1
            jmp L1SkipLeftRight

        L1SkipLeftRight:      

        cmp ifghost1move,0
        je setginnmove
        jmp setmovedont

        setginnmove:
        cmp handleghost1D,1
        je RightFixer
        cmp handleghost1D,2
        je LeftFixer
        cmp handleghost1D,3
        je UpFixer
        cmp handleghost1D,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xG1Pos
                    dec xG1Pos
                    jmp NewDirector
        LeftFixer:  inc xG1Pos
                    inc xG1Pos
                    jmp NewDirector
        UpFixer:    inc yG1Pos
                    jmp NewDirector
        DownFixer:  dec yG1Pos

        NewDirector:
        mov  eax,4     
        call RandomRange 
        inc  eax         
        mov  handleghost1D,al  
        setmovedont:

    ret
moveghost1 ENDP 

movelevel1ghost1leftright PROC 

        cmp bh,1
        je level102_Handle  
        cmp bh,2
        je level103_Handle
        cmp bh,3
        je level104_Handle
        cmp bh,4
        je level105_Handle
        cmp bh,5
        je level106_Handle
        cmp bh,6
        je level107_Handle
        cmp bh,7
        je level108_Handle
        cmp bh,8
        je level109_Handle
        cmp bh,9
        je level110_Handle
        cmp bh,10
        je level111_Handle
        cmp bh,11
        je level112_Handle
        cmp bh,12
        je level113_Handle
        cmp bh,13
        je level114_Handle
        cmp bh,14
        je level115_Handle
        cmp bh,15
        je level116_Handle
        cmp bh,16
        je level117_Handle
        cmp bh,17
        je level118_Handle
        cmp bh,18
        je level119_Handle
        cmp bh,19
        je level120_Handle
        cmp bh,20
        je level121_Handle
        cmp bh,21
        je level122_Handle
            
        level102_Handle:  mov esi,offset level102
                        call seewall1ghost
                        jmp seewalksee
        level103_Handle:  mov esi,offset level103
                        call seewall1ghost
                        jmp seewalksee
        level104_Handle:  mov esi,offset level104
                        call seewall1ghost
                        jmp seewalksee
        level105_Handle:  mov esi,offset level105
                        call seewall1ghost
                        jmp seewalksee
        level106_Handle:  mov esi,offset level106
                        call seewall1ghost
                        jmp seewalksee
        level107_Handle:  mov esi,offset level107
                        call seewall1ghost
                        jmp seewalksee
        level108_Handle:  mov esi,offset level108
                        call seewall1ghost
                        jmp seewalksee
        level109_Handle:  mov esi,offset level109
                        call seewall1ghost
                        jmp seewalksee
        level110_Handle:  mov esi,offset level110
                        call seewall1ghost
                        jmp seewalksee
        level111_Handle:  mov esi,offset level111
                        call seewall1ghost
                        jmp seewalksee
        level112_Handle:  mov esi,offset level112
                        call seewall1ghost
                        jmp seewalksee
        level113_Handle:  mov esi,offset level113
                        call seewall1ghost
                        jmp seewalksee
        level114_Handle:  mov esi,offset level114
                        call seewall1ghost
                        jmp seewalksee
        level115_Handle:  mov esi,offset level115
                        call seewall1ghost
                        jmp seewalksee
        level116_Handle:  mov esi,offset level116
                        call seewall1ghost
                        jmp seewalksee
        level117_Handle:  mov esi,offset level117
                        call seewall1ghost
                        jmp seewalksee
        level118_Handle:  mov esi,offset level118
                        call seewall1ghost
                        jmp seewalksee
        level119_Handle:  mov esi,offset level119
                        call seewall1ghost
                        jmp seewalksee
        level120_Handle:  mov esi,offset level120
                        call seewall1ghost
                        jmp seewalksee
        level121_Handle:  mov esi,offset level121
                        call seewall1ghost
                        jmp seewalksee
        level122_Handle:  mov esi,offset level122
                        call seewall1ghost
                        jmp seewalksee

        seewalksee:
    ret
movelevel1ghost1leftright ENDP    
ghost1moveuplevel1 PROC   

        cmp bh,0
        je level101_Handle  
        cmp bh,1
        je level102_Handle
        cmp bh,2
        je level103_Handle
        cmp bh,3
        je level104_Handle
        cmp bh,4
        je level105_Handle
        cmp bh,5
        je level106_Handle
        cmp bh,6
        je level107_Handle
        cmp bh,7
        je level108_Handle
        cmp bh,8
        je level109_Handle
        cmp bh,9
        je level110_Handle
        cmp bh,10
        je level111_Handle
        cmp bh,11
        je level112_Handle
        cmp bh,12
        je level113_Handle
        cmp bh,13
        je level114_Handle
        cmp bh,14
        je level115_Handle
        cmp bh,15
        je level116_Handle
        cmp bh,16
        je level117_Handle
        cmp bh,17
        je level118_Handle
        cmp bh,18
        je level119_Handle
        cmp bh,19
        je level120_Handle
        cmp bh,20
        je level121_Handle

        level101_Handle:  mov esi,offset level101
                        call seewall1ghost
                        jmp seewalksee            
        level102_Handle:  mov esi,offset level102
                        call seewall1ghost
                        jmp seewalksee
        level103_Handle:  mov esi,offset level103
                        call seewall1ghost
                        jmp seewalksee
        level104_Handle:  mov esi,offset level104
                        call seewall1ghost
                        jmp seewalksee
        level105_Handle:  mov esi,offset level105
                        call seewall1ghost
                        jmp seewalksee
        level106_Handle:  mov esi,offset level106
                        call seewall1ghost
                        jmp seewalksee
        level107_Handle:  mov esi,offset level107
                        call seewall1ghost
                        jmp seewalksee
        level108_Handle:  mov esi,offset level108
                        call seewall1ghost
                        jmp seewalksee
        level109_Handle:  mov esi,offset level109
                        call seewall1ghost
                        jmp seewalksee
        level110_Handle:  mov esi,offset level110
                        call seewall1ghost
                        jmp seewalksee
        level111_Handle:  mov esi,offset level111
                        call seewall1ghost
                        jmp seewalksee
        level112_Handle:  mov esi,offset level112
                        call seewall1ghost
                        jmp seewalksee
        level113_Handle:  mov esi,offset level113
                        call seewall1ghost
                        jmp seewalksee
        level114_Handle:  mov esi,offset level114
                        call seewall1ghost
                        jmp seewalksee
        level115_Handle:  mov esi,offset level115
                        call seewall1ghost
                        jmp seewalksee
        level116_Handle:  mov esi,offset level116
                        call seewall1ghost
                        jmp seewalksee
        level117_Handle:  mov esi,offset level117
                        call seewall1ghost
                        jmp seewalksee
        level118_Handle:  mov esi,offset level118
                        call seewall1ghost
                        jmp seewalksee
        level119_Handle:  mov esi,offset level119
                        call seewall1ghost
                        jmp seewalksee
        level120_Handle:  mov esi,offset level120
                        call seewall1ghost
                        jmp seewalksee
        level121_Handle:  mov esi,offset level121
                        call seewall1ghost
                        jmp seewalksee
        level122_Handle:  mov esi,offset level122
                        call seewall1ghost
                        jmp seewalksee
        seewalksee:
    ret
ghost1moveuplevel1 ENDP  
downmoveghost1level1 PROC   

        cmp bh,0
        je level101_Handle  
        cmp bh,1
        je level102_Handle
        cmp bh,2
        je level103_Handle
        cmp bh,3
        je level104_Handle
        cmp bh,4
        je level105_Handle
        cmp bh,5
        je level106_Handle
        cmp bh,6
        je level107_Handle
        cmp bh,7
        je level108_Handle
        cmp bh,8
        je level109_Handle
        cmp bh,9
        je level110_Handle
        cmp bh,10
        je level111_Handle
        cmp bh,11
        je level112_Handle
        cmp bh,12
        je level113_Handle
        cmp bh,13
        je level114_Handle
        cmp bh,14
        je level115_Handle
        cmp bh,15
        je level116_Handle
        cmp bh,16
        je level117_Handle
        cmp bh,17
        je level118_Handle
        cmp bh,18
        je level119_Handle
        cmp bh,19
        je level120_Handle
        cmp bh,20
        je level121_Handle

        level101_Handle:  mov esi,offset level101
                        call seewall1ghost
                        jmp seewalksee            
        level102_Handle:  mov esi,offset level102
                        call seewall1ghost
                        jmp seewalksee
        level103_Handle:  mov esi,offset level103
                        call seewall1ghost
                        jmp seewalksee
        level104_Handle:  mov esi,offset level104
                        call seewall1ghost
                        jmp seewalksee
        level105_Handle:  mov esi,offset level105
                        call seewall1ghost
                        jmp seewalksee
        level106_Handle:  mov esi,offset level106
                        call seewall1ghost
                        jmp seewalksee
        level107_Handle:  mov esi,offset level107
                        call seewall1ghost
                        jmp seewalksee
        level108_Handle:  mov esi,offset level108
                        call seewall1ghost
                        jmp seewalksee
        level109_Handle:  mov esi,offset level109
                        call seewall1ghost
                        jmp seewalksee
        level110_Handle:  mov esi,offset level110
                        call seewall1ghost
                        jmp seewalksee
        level111_Handle:  mov esi,offset level111
                        call seewall1ghost
                        jmp seewalksee
        level112_Handle:  mov esi,offset level112
                        call seewall1ghost
                        jmp seewalksee
        level113_Handle:  mov esi,offset level113
                        call seewall1ghost
                        jmp seewalksee
        level114_Handle:  mov esi,offset level114
                        call seewall1ghost
                        jmp seewalksee
        level115_Handle:  mov esi,offset level115
                        call seewall1ghost
                        jmp seewalksee
        level116_Handle:  mov esi,offset level116
                        call seewall1ghost
                        jmp seewalksee
        level117_Handle:  mov esi,offset level117
                        call seewall1ghost
                        jmp seewalksee
        level118_Handle:  mov esi,offset level118
                        call seewall1ghost
                        jmp seewalksee
        level119_Handle:  mov esi,offset level119
                        call seewall1ghost
                        jmp seewalksee
        level120_Handle:  mov esi,offset level120
                        call seewall1ghost
                        jmp seewalksee
        level121_Handle:  mov esi,offset level121
                        call seewall1ghost
                        jmp seewalksee
        level122_Handle:  mov esi,offset level122
                        call seewall1ghost
                        jmp seewalksee
        seewalksee:
    ret
downmoveghost1level1 ENDP  
seewall1ghost PROC
    mov ecx,0
    mov cl,bl
    l1loop1:
    inc esi
    loop l1loop1

    mov edx,0
    mov dl,wall
    cmp [esi],dl
    jne Replacer 
        mov ifghost1move,0
    Replacer:
    EscapeReplacer:
    ret
seewall1ghost ENDP

;                                           Ghost maze 2

GetGhostRowl2 PROC
        cmp bh,1
        je level2r02_Handle  
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle
        cmp bh,21
        je level2r22_Handle
            
        level2r02_Handle:  mov esi,offset level2r02
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        jmp seewalksee
        seewalksee:
    ret
GetGhostRowl2 ENDP    
gin2maker PROC 
    mov eax,0
    mov al,white (16*1101b)
    call SetTextColor
    mov dl,xG2Pos
    mov dh,yG2Pos
    call Gotoxy
    mov al,G2
    call WriteChar
    mov al,white (16*black)
    call SetTextColor
    ret
gin2maker ENDP  
ginn2change PROC
    mov dl,xG2Pos
    mov dh,yG2Pos    
    call Gotoxy
    mov ebx,0
    mov bh,yG2Pos
    sub bh,6
    mov bl,xG2Pos
    call GetGhostRowl2
    mov cl,bl

    l2: inc esi
    loop l2

    mov edx,0
    mov dl,"-"
    cmp [esi],dl
    jne next
    mov eax,white (black*16)
    call settextcolor
    mov al,"o"
    call Writechar
    next:
    mov dl,"*"
    cmp [esi],dl
    jne skip
    mov eax,1101b (black*16)
    call settextcolor
    mov al,"*"
    call Writechar
    skip:
    mov al," "
    call WriteChar
    escape:      
    ret
ginn2change ENDP  
move2ghost PROC 
        call Level2Intersection 
    
        mov move2ghostPossibibly,1

        cmp wayhandle2ghost,1
        je l2moveRight
        cmp wayhandle2ghost,2
        je l2moveLeft
        cmp wayhandle2ghost,3
        je l2moveUp
        cmp wayhandle2ghost,4
        je l2MoveDown

        l2moveRight:   
            call ginn2change
            inc xG2Pos
            inc xG2Pos
            mov wayhandle2ghost,1
            call CoordinaterUpdatorGhost2
            call walkgin2level2leftright 
            jmp lrskipl2

        l2moveLeft: 
            call ginn2change
            dec xG2Pos
            dec xG2Pos
            mov wayhandle2ghost,2
            call CoordinaterUpdatorGhost2
            call walkgin2level2leftright 
            jmp lrskipl2

        l2moveUp:
            call ginn2change
            dec yG2Pos
            mov wayhandle2ghost,3
            call CoordinaterUpdatorGhost2
            call gin2movupl2
            jmp lrskipl2

        l2MoveDown:
            call ginn2change
            inc yG2Pos
            mov wayhandle2ghost,4
            call CoordinaterUpdatorGhost2
            call gin2movdownl2
            jmp lrskipl2

        lrskipl2:      

        cmp move2ghostPossibibly,0
        je setginnmove
        jmp setmovedont

        setginnmove:
        cmp wayhandle2ghost,1
        je RightFixer
        cmp wayhandle2ghost,2
        je LeftFixer
        cmp wayhandle2ghost,3
        je UpFixer
        cmp wayhandle2ghost,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xG2Pos
                    dec xG2Pos
                    jmp NewDirector
        LeftFixer:  inc xG2Pos
                    inc xG2Pos
                    jmp NewDirector
        UpFixer:    inc yG2Pos
                    jmp NewDirector
        DownFixer:  dec yG2Pos

        NewDirector:
        mov  eax,4    
        call RandomRange 
        inc  eax        
        mov  wayhandle2ghost,al  
        setmovedont:

    ret
move2ghost ENDP 

DrawGhost3 PROC 
    mov eax,0
    mov al,white (16*cyan)
    call SetTextColor
    mov dl,xG3Pos
    mov dh,yG3Pos
    call Gotoxy
    mov al,G3
    call WriteChar
    mov al,white (16*black)
    call SetTextColor
    ret
DrawGhost3 ENDP  
UpdateGhost3 PROC
    mov dl,xG3Pos
    mov dh,yG3Pos    
    call Gotoxy
    mov ebx,0
    mov bh,yG3Pos
    sub bh,6
    mov bl,xG3Pos
    call GetGhostRowl2
    mov cl,bl

    l2: inc esi
    loop l2

    mov edx,0
    mov dl,"-"
    cmp [esi],dl
    jne next
    mov eax,white (black*16)
    call settextcolor
    mov al,"o"
    call Writechar
    next:
    mov dl,"*"
    cmp [esi],dl
    jne skip
    mov eax,1101b (black*16)
    call settextcolor
    mov al,"*"
    call Writechar
    skip:
    mov al," "
    call WriteChar
    escape:      
    ret
UpdateGhost3 ENDP  
Ghost3Movement PROC 
        call Level2Intersection 

        mov maybemov3ghost,1

        cmp seeway3ghost,1
        je l2moveRight
        cmp seeway3ghost,2
        je l2moveLeft
        cmp seeway3ghost,3
        je l2moveUp
        cmp seeway3ghost,4
        je l2MoveDown

        l2moveRight:   
            call UpdateGhost3
            inc xG3Pos
            inc xG3Pos
            mov seeway3ghost,1
            call gin3updatecordinate
            call gin3movleftrightinl2 
            jmp lrskipl2

        l2moveLeft: 
            call UpdateGhost3
            dec xG3Pos
            dec xG3Pos
            mov seeway3ghost,2
            call gin3updatecordinate
            call gin3movleftrightinl2 
            jmp lrskipl2

        l2moveUp:
            call UpdateGhost3
            dec yG3Pos
            mov seeway3ghost,3
            call gin3updatecordinate
            call Level2MovementUpGhost3
            jmp lrskipl2

        l2MoveDown:
            call UpdateGhost3
            inc yG3Pos
            mov seeway3ghost,4
            call gin3updatecordinate
            call Level2MovementDownGhost3
            jmp lrskipl2

        lrskipl2:      

        cmp maybemov3ghost,0
        je setginnmove
        jmp setmovedont

        setginnmove:
        cmp seeway3ghost,1
        je RightFixer
        cmp seeway3ghost,2
        je LeftFixer
        cmp seeway3ghost,3
        je UpFixer
        cmp seeway3ghost,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xG3Pos
                    dec xG3Pos
                    jmp NewDirector
        LeftFixer:  inc xG3Pos
                    inc xG3Pos
                    jmp NewDirector
        UpFixer:    inc yG3Pos
                    jmp NewDirector
        DownFixer:  dec yG3Pos

        NewDirector:
        mov  eax,4     
        call RandomRange 
        inc  eax       
        mov  seeway3ghost,al  
        setmovedont:

    ret
Ghost3Movement ENDP 

walkgin2level2leftright PROC 

        cmp bh,1
        je level2r02_Handle  
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle
        cmp bh,21
        je level2r22_Handle
            
        level2r02_Handle:  mov esi,offset level2r02
                        call seewall2gin
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seewall2gin
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seewall2gin
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seewall2gin
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seewall2gin
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seewall2gin
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seewall2gin
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seewall2gin
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seewall2gin
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seewall2gin
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seewall2gin
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seewall2gin
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seewall2gin
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seewall2gin
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seewall2gin
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seewall2gin
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seewall2gin
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seewall2gin
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seewall2gin
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seewall2gin
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seewall2gin
                        jmp seewalksee

        seewalksee:
    ret
walkgin2level2leftright ENDP    
gin2movupl2 PROC   

        cmp bh,0
        je level2r01_Handle  
        cmp bh,1
        je level2r02_Handle
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle

        level2r01_Handle:  mov esi,offset level2r01
                        call seewall2gin
                        jmp seewalksee            
        level2r02_Handle:  mov esi,offset level2r02
                        call seewall2gin
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seewall2gin
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seewall2gin
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seewall2gin
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seewall2gin
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seewall2gin
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seewall2gin
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seewall2gin
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seewall2gin
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seewall2gin
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seewall2gin
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seewall2gin
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seewall2gin
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seewall2gin
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seewall2gin
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seewall2gin
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seewall2gin
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seewall2gin
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seewall2gin
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seewall2gin
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seewall2gin
                        jmp seewalksee
        seewalksee:
    ret
gin2movupl2 ENDP  
gin2movdownl2 PROC   

        cmp bh,0
        je level2r01_Handle  
        cmp bh,1
        je level2r02_Handle
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle

        level2r01_Handle:  mov esi,offset level2r01
                        call seewall2gin
                        jmp seewalksee            
        level2r02_Handle:  mov esi,offset level2r02
                        call seewall2gin
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seewall2gin
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seewall2gin
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seewall2gin
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seewall2gin
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seewall2gin
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seewall2gin
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seewall2gin
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seewall2gin
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seewall2gin
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seewall2gin
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seewall2gin
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seewall2gin
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seewall2gin
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seewall2gin
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seewall2gin
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seewall2gin
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seewall2gin
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seewall2gin
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seewall2gin
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seewall2gin
                        jmp seewalksee
        seewalksee:
    ret
gin2movdownl2 ENDP  
seewall2gin PROC
    mov ecx,0
    mov cl,bl
    l2loop1:
    inc esi
    loop l2loop1

    mov edx,0
    mov dl,wall
    cmp [esi],dl
    jne Replacer 
        mov move2ghostPossibibly,0
    Replacer:
    EscapeReplacer:
    ret
seewall2gin ENDP

gin3movleftrightinl2 PROC 

        cmp bh,1
        je level2r02_Handle  
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle
        cmp bh,21
        je level2r22_Handle
            
        level2r02_Handle:  mov esi,offset level2r02
                        call seewall3ginn
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seewall3ginn
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seewall3ginn
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seewall3ginn
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seewall3ginn
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seewall3ginn
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seewall3ginn
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seewall3ginn
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seewall3ginn
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seewall3ginn
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seewall3ginn
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seewall3ginn
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seewall3ginn
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seewall3ginn
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seewall3ginn
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seewall3ginn
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seewall3ginn
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seewall3ginn
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seewall3ginn
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seewall3ginn
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seewall3ginn
                        jmp seewalksee

        seewalksee:
    ret
gin3movleftrightinl2 ENDP    
Level2MovementUpGhost3 PROC   

        cmp bh,0
        je level2r01_Handle  
        cmp bh,1
        je level2r02_Handle
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle

        level2r01_Handle:  mov esi,offset level2r01
                        call seewall3ginn
                        jmp seewalksee            
        level2r02_Handle:  mov esi,offset level2r02
                        call seewall3ginn
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seewall3ginn
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seewall3ginn
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seewall3ginn
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seewall3ginn
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seewall3ginn
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seewall3ginn
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seewall3ginn
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seewall3ginn
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seewall3ginn
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seewall3ginn
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seewall3ginn
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seewall3ginn
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seewall3ginn
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seewall3ginn
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seewall3ginn
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seewall3ginn
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seewall3ginn
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seewall3ginn
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seewall3ginn
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seewall3ginn
                        jmp seewalksee
        seewalksee:
    ret
Level2MovementUpGhost3 ENDP  
Level2MovementDownGhost3 PROC   

        cmp bh,0
        je level2r01_Handle  
        cmp bh,1
        je level2r02_Handle
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle

        level2r01_Handle:  mov esi,offset level2r01
                        call seewall3ginn
                        jmp seewalksee            
        level2r02_Handle:  mov esi,offset level2r02
                        call seewall3ginn
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seewall3ginn
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seewall3ginn
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seewall3ginn
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seewall3ginn
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seewall3ginn
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seewall3ginn
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seewall3ginn
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seewall3ginn
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seewall3ginn
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seewall3ginn
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seewall3ginn
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seewall3ginn
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seewall3ginn
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seewall3ginn
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seewall3ginn
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seewall3ginn
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seewall3ginn
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seewall3ginn
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seewall3ginn
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seewall3ginn
                        jmp seewalksee
        seewalksee:
    ret
Level2MovementDownGhost3 ENDP  
seewall3ginn PROC
    mov ecx,0
    mov cl,bl
    l2loop1:
    inc esi
    loop l2loop1

    mov edx,0
    mov dl,wall
    cmp [esi],dl
    jne Replacer 
        mov maybemov3ghost,0
    Replacer:
    EscapeReplacer:
    ret
seewall3ginn ENDP

;                                           Ghost maze 3

gingetinrowl3 PROC
        cmp bh,1
        je levelr302_Handle  
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle
        cmp bh,21
        je levelr322_Handle
            
        levelr302_Handle:  mov esi,offset levelr302
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        jmp seewalksee
        seewalksee:
    ret
gingetinrowl3 ENDP 

now4ginn PROC 
    mov eax,0
    mov al,white (110b*16)
    call SetTextColor
    mov dl,xG4Pos
    mov dh,yG4Pos
    call Gotoxy
    mov al,G4
    call WriteChar
    mov al,black (black*16)
    call SetTextColor
    ret
now4ginn ENDP  
changein4ginn PROC
    mov dl,xG4Pos
    mov dh,yG4Pos    
    call Gotoxy
    mov ebx,0
    mov bh,yG4Pos
    sub bh,6
    mov bl,xG4Pos
    call gingetinrowl3
    mov cl,bl

    l3: inc esi
    loop l3

    mov edx,0
    mov dl,"-"
    cmp [esi],dl
    jne next
    mov eax,white (black*16)
    call settextcolor
    mov al,"o"
    call Writechar
    next:
    mov dl,"*"
    cmp [esi],dl
    jne skip
    mov eax,1101b (black*16)
    call settextcolor
    mov al,"*"
    call Writechar
    skip:
    mov al," "
    call WriteChar
    escape:      
    ret
changein4ginn ENDP  
Ghost4Movement PROC 
        call insertionofl3 

        mov maybemovgin4,1

        cmp wayhandle4ginn,1
        je l3moveRight
        cmp wayhandle4ginn,2
        je l3moveLeft
        cmp wayhandle4ginn,3
        je l3moveUp
        cmp wayhandle4ginn,4
        je l3MoveDown

        l3moveRight:   
            call changein4ginn
            inc xG4Pos
            inc xG4Pos
            mov wayhandle4ginn,1
            call gin4changecoordinte
            call gin4goleftrightinl3 
            jmp l3SkipLeftRight

        l3moveLeft: 
            call changein4ginn
            dec xG4Pos
            dec xG4Pos
            mov wayhandle4ginn,2
            call gin4changecoordinte
            call gin4goleftrightinl3 
            jmp l3SkipLeftRight

        l3moveUp:
            call changein4ginn
            dec yG4Pos
            mov wayhandle4ginn,3
            call gin4changecoordinte
            call Level3MovementUpGhost4
            jmp l3SkipLeftRight

        l3MoveDown:
            call changein4ginn
            inc yG4Pos
            mov wayhandle4ginn,4
            call gin4changecoordinte
            call Level3MovementDownGhost4
            jmp l3SkipLeftRight

        l3SkipLeftRight:      

        cmp maybemovgin4,0
        je setginnmove
        jmp setmovedont

        setginnmove:
        cmp wayhandle4ginn,1
        je RightFixer
        cmp wayhandle4ginn,2
        je LeftFixer
        cmp wayhandle4ginn,3
        je UpFixer
        cmp wayhandle4ginn,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xG4Pos
                    dec xG4Pos
                    jmp NewDirector
        LeftFixer:  inc xG4Pos
                    inc xG4Pos
                    jmp NewDirector
        UpFixer:    inc yG4Pos
                    jmp NewDirector
        DownFixer:  dec yG4Pos

        NewDirector:
        mov  eax,4    
        call RandomRange 
        inc  eax         
        mov  wayhandle4ginn,al  
        setmovedont:

    ret
Ghost4Movement ENDP 

DrawGhost6 PROC 
    mov eax,0
    mov al,white (1100b * 16)
    call SetTextColor
    mov dl,xG6Pos
    mov dh,yG6Pos
    call Gotoxy
    mov al,G6
    call WriteChar
    ret
DrawGhost6 ENDP  
changegin6 PROC
    mov dl,xG6Pos
    mov dh,yG6Pos    
    call Gotoxy
    mov ebx,0
    mov bh,yG6Pos
    sub bh,6
    mov bl,xG6Pos
    call gingetinrowl3
    mov cl,bl

    l3: inc esi
    loop l3

    mov edx,0
    mov dl,"-"
    cmp [esi],dl
    jne next
    mov eax,white (black*16)
    call settextcolor
    mov al,"o"
    call Writechar
    next:
    mov dl,"*"
    cmp [esi],dl
    jne skip
    mov eax,1101b (black*16)
    call settextcolor
    mov al,"*"
    call Writechar
    skip:
    mov al," "
    call WriteChar
    escape:      
    ret
changegin6 ENDP  
go6ginn PROC 
        call insertionofl3 
    
        mov go6ginnPossibibly,1

        cmp wayhandle6ginn,1
        je l3moveRight
        cmp wayhandle6ginn,2
        je l3moveLeft
        cmp wayhandle6ginn,3
        je l3moveUp
        cmp wayhandle6ginn,4
        je l3MoveDown

        l3moveRight:   
            call changegin6
            inc xG6Pos
            inc xG6Pos
            mov wayhandle6ginn,1
            call changegin6coordinate
            call goginn6inleftrightinl3 
            jmp l3SkipLeftRight

        l3moveLeft: 
            call changegin6
            dec xG6Pos
            dec xG6Pos
            mov wayhandle6ginn,2
            call changegin6coordinate
            call goginn6inleftrightinl3 
            jmp l3SkipLeftRight

        l3moveUp:
            call changegin6
            dec yG6Pos
            mov wayhandle6ginn,3
            call changegin6coordinate
            call Level3MovementUpGhost6
            jmp l3SkipLeftRight

        l3MoveDown:
            call changegin6
            inc yG6Pos
            mov wayhandle6ginn,4
            call changegin6coordinate
            call Level3MovementDownGhost6
            jmp l3SkipLeftRight

        l3SkipLeftRight:      

        cmp go6ginnPossibibly,0
        je setginnmove
        jmp setmovedont

        setginnmove:
        cmp wayhandle6ginn,1
        je RightFixer
        cmp wayhandle6ginn,2
        je LeftFixer
        cmp wayhandle6ginn,3
        je UpFixer
        cmp wayhandle6ginn,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xG6Pos
                    dec xG6Pos
                    jmp NewDirector
        LeftFixer:  inc xG6Pos
                    inc xG6Pos
                    jmp NewDirector
        UpFixer:    inc yG6Pos
                    jmp NewDirector
        DownFixer:  dec yG6Pos

        NewDirector:
        mov  eax,4    
        call RandomRange 
        inc  eax      
        mov  wayhandle6ginn,al 
        setmovedont:

    ret
go6ginn ENDP 

gin7maker PROC 
    mov eax,0
    mov al,white (1101b*16)
    call SetTextColor
    mov dl,xG7Pos
    mov dh,yG7Pos
    call Gotoxy
    mov al,G7
    call WriteChar
    ret
gin7maker ENDP  
changergin7 PROC
    mov dl,xG7Pos
    mov dh,yG7Pos    
    call Gotoxy
    mov ebx,0
    mov bh,yG7Pos
    sub bh,6
    mov bl,xG7Pos
    call gingetinrowl3
    mov cl,bl

    l3: inc esi
    loop l3

    mov edx,0
    mov dl,"-"
    cmp [esi],dl
    jne next
    mov eax,white (black*16)
    call settextcolor
    mov al,"o"
    call Writechar
    next:
    mov dl,"*"
    cmp [esi],dl
    jne skip
    mov eax,1101b (black*16)
    call settextcolor
    mov al,"*"
    call Writechar
    skip:
    mov al," "
    call WriteChar
    escape:      
    ret
changergin7 ENDP  
Ghost7Movement PROC 
        call insertionofl3 
        
        mov Ghost7MovementPossibibly,1

        cmp wayhandleofgin7,1
        je l3moveRight
        cmp wayhandleofgin7,2
        je l3moveLeft
        cmp wayhandleofgin7,3
        je l3moveUp
        cmp wayhandleofgin7,4
        je l3MoveDown

        l3moveRight:   
            call changergin7
            inc xG7Pos
            inc xG7Pos
            mov wayhandleofgin7,1
            call CoordinaterUpdatorGhost7
            call goginn7inleftrightl3 
            jmp l3SkipLeftRight

        l3moveLeft: 
            call changergin7
            dec xG7Pos
            dec xG7Pos
            mov wayhandleofgin7,2
            call CoordinaterUpdatorGhost7
            call goginn7inleftrightl3 
            jmp l3SkipLeftRight

        l3moveUp:
            call changergin7
            dec yG7Pos
            mov wayhandleofgin7,3
            call CoordinaterUpdatorGhost7
            call gin3movupinl3
            jmp l3SkipLeftRight

        l3MoveDown:
            call changergin7
            inc yG7Pos
            mov wayhandleofgin7,4
            call CoordinaterUpdatorGhost7
            call ginn7movdowninl3
            jmp l3SkipLeftRight

        l3SkipLeftRight:      

        cmp Ghost7MovementPossibibly,0
        je setginnmove
        jmp setmovedont

        setginnmove:
        cmp wayhandleofgin7,1
        je RightFixer
        cmp wayhandleofgin7,2
        je LeftFixer
        cmp wayhandleofgin7,3
        je UpFixer
        cmp wayhandleofgin7,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xG7Pos
                    dec xG7Pos
                    jmp NewDirector
        LeftFixer:  inc xG7Pos
                    inc xG7Pos
                    jmp NewDirector
        UpFixer:    inc yG7Pos
                    jmp NewDirector
        DownFixer:  dec yG7Pos
       
        NewDirector:
        mov  eax,4     
        call RandomRange 
        inc  eax         
        mov  wayhandleofgin7,al 
        setmovedont:

    ret
Ghost7Movement ENDP 

gin4goleftrightinl3 PROC 

        cmp bh,1
        je levelr302_Handle  
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle
        cmp bh,21
        je levelr322_Handle
            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn4wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn4wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn4wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn4wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn4wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn4wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn4wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn4wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn4wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn4wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn4wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn4wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn4wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn4wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn4wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn4wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn4wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn4wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn4wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn4wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn4wall
                        jmp seewalksee

        seewalksee:
    ret
gin4goleftrightinl3 ENDP    
Level3MovementUpGhost4 PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seeginn4wall
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn4wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn4wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn4wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn4wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn4wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn4wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn4wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn4wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn4wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn4wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn4wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn4wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn4wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn4wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn4wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn4wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn4wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn4wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn4wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn4wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn4wall
                        jmp seewalksee
        seewalksee:
    ret
Level3MovementUpGhost4 ENDP  
Level3MovementDownGhost4 PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seeginn4wall
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn4wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn4wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn4wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn4wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn4wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn4wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn4wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn4wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn4wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn4wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn4wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn4wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn4wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn4wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn4wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn4wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn4wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn4wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn4wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn4wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn4wall
                        jmp seewalksee
        seewalksee:
    ret
Level3MovementDownGhost4 ENDP  
seeginn4wall PROC
    mov ecx,0
    mov cl,bl
    l3loop1:
    inc esi
    loop l3loop1

    mov edx,0
    mov dl,wall
    cmp [esi],dl
    jne Replacer 
        mov maybemovgin4,0
    Replacer:
    EscapeReplacer:
    ret
seeginn4wall ENDP

goginn6inleftrightinl3 PROC 

        cmp bh,1
        je levelr302_Handle  
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle
        cmp bh,21
        je levelr322_Handle
            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn6wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn6wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn6wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn6wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn6wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn6wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn6wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn6wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn6wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn6wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn6wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn6wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn6wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn6wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn6wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn6wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn6wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn6wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn6wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn6wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn6wall
                        jmp seewalksee

        seewalksee:
    ret
goginn6inleftrightinl3 ENDP    
Level3MovementUpGhost6 PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seeginn6wall
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn6wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn6wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn6wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn6wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn6wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn6wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn6wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn6wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn6wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn6wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn6wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn6wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn6wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn6wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn6wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn6wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn6wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn6wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn6wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn6wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn6wall
                        jmp seewalksee
        seewalksee:
    ret
Level3MovementUpGhost6 ENDP  
Level3MovementDownGhost6 PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seeginn6wall
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn6wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn6wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn6wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn6wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn6wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn6wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn6wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn6wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn6wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn6wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn6wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn6wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn6wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn6wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn6wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn6wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn6wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn6wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn6wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn6wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn6wall
                        jmp seewalksee
        seewalksee:
    ret
Level3MovementDownGhost6 ENDP  
seeginn6wall PROC
    mov ecx,0
    mov cl,bl
    l3loop1:
    inc esi
    loop l3loop1

    mov edx,0
    mov dl,wall
    cmp [esi],dl
    jne Replacer 
        mov go6ginnPossibibly,0
    Replacer:
    EscapeReplacer:
    ret
seeginn6wall ENDP

goginn7inleftrightl3 PROC 

        cmp bh,1
        je levelr302_Handle  
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle
        cmp bh,21
        je levelr322_Handle
            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn7wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn7wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn7wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn7wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn7wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn7wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn7wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn7wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn7wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn7wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn7wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn7wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn7wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn7wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn7wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn7wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn7wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn7wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn7wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn7wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn7wall
                        jmp seewalksee

        seewalksee:
    ret
goginn7inleftrightl3 ENDP    
gin3movupinl3 PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seeginn7wall
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn7wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn7wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn7wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn7wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn7wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn7wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn7wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn7wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn7wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn7wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn7wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn7wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn7wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn7wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn7wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn7wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn7wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn7wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn7wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn7wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn7wall
                        jmp seewalksee
        seewalksee:
    ret
gin3movupinl3 ENDP  
ginn7movdowninl3 PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seeginn7wall
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seeginn7wall
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seeginn7wall
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seeginn7wall
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seeginn7wall
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seeginn7wall
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seeginn7wall
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seeginn7wall
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seeginn7wall
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seeginn7wall
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seeginn7wall
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seeginn7wall
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seeginn7wall
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seeginn7wall
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seeginn7wall
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seeginn7wall
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seeginn7wall
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seeginn7wall
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seeginn7wall
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seeginn7wall
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seeginn7wall
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seeginn7wall
                        jmp seewalksee
        seewalksee:
    ret
ginn7movdowninl3 ENDP  
seeginn7wall PROC
    mov ecx,0
    mov cl,bl
    l3loop1:
    inc esi
    loop l3loop1

    mov edx,0
    mov dl,wall
    cmp [esi],dl
    jne Replacer 
        mov Ghost7MovementPossibibly,0
    Replacer:
    EscapeReplacer:
    ret
seeginn7wall ENDP

;                                           Player

DrawPlayer PROC
    mov eax,0
    mov al,gray (red*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,'C'
    call WriteChar
    ret
DrawPlayer ENDP
UpdatePlayer PROC
    mov al,black (black*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP

Level1Intersection PROC 
	
	mov eax,0
	mov ebx,0
	mov al,xPos
	mov ah,yPos
	mov bl,xG1Pos
	mov bh,yG1Pos
	cmp al,bl
	jne skip
	cmp ah,bh
	jne skip
	dec livesIndicator
    cmp livesIndicator,0
    je EndScreen    
    mov eax,200
    call delay
    call Level1Maze 
    mov eax,200
    call delay
	skip:

	ret
Level1Intersection ENDP 
Level2Intersection PROC 
	
	mov eax,0
	mov ebx,0
	mov al,xPos
	mov ah,yPos
	mov bl,xG2Pos
	mov bh,yG2Pos
	cmp al,bl
	jne skip1
	cmp ah,bh
	jne skip1
	dec livesIndicator
    cmp livesIndicator,0
    je EndScreen 
    mov eax,200
    call delay
    call Level2Maze 

	skip1:
	mov bl,xG3Pos
	mov bh,yG3Pos
	cmp al,bl
	jne skip2
	cmp ah,bh
	jne skip2
	dec livesIndicator
    cmp livesIndicator,0
    je EndScreen 
    mov eax,200
    call delay
    call Level2Maze 
	skip2:

	ret
Level2Intersection ENDP 
insertionofl3 PROC 
	
	mov eax,0
	mov ebx,0
	mov al,xPos
	mov ah,yPos
	mov bl,xG4Pos
	mov bh,yG4Pos
	cmp al,bl
	jne skip1
	cmp ah,bh
	jne skip1
	dec livesIndicator
    cmp livesIndicator,0
    je EndScreen 
    mov eax,200
    call delay
    call Level3Maze 

	skip1:
	mov bl,xG5Pos
	mov bh,yG5Pos
	cmp al,bl
	jne skip2
	cmp ah,bh
	jne skip2
	dec livesIndicator
    cmp livesIndicator,0
    je EndScreen 
    mov eax,200
    call delay
    call Level3Maze 

	skip2:
	mov bl,xG6Pos
	mov bh,yG6Pos
	cmp al,bl
	jne skip3
	cmp ah,bh
	jne skip3
	dec livesIndicator
    cmp livesIndicator,0
    je EndScreen 
    mov eax,200
    call delay
    call Level3Maze 
	skip3:
	mov bl,xG7Pos
	mov bh,yG7Pos
	cmp al,bl
	jne skip4
	cmp ah,bh
	jne skip4
	dec livesIndicator
    cmp livesIndicator,0
    je EndScreen 
    mov eax,200
    call delay
    call Level3Maze 
	skip4:

	ret
insertionofl3 ENDP 

PlayerMovement1 PROC 
        mov PlayerMovement1Possibibly,1
        call Level1Intersection 
        LookForKey:
            
            mov  eax,speed1   
            call Delay
            INVOKE PlaySound, OFFSET musicChomp, NULL, snd_filename
            call ReadKey       
            mov inputChar,al
            jnz seewalkseeCharacter
        cmp wayhandleplayer,1
        je L1moveRight
        cmp wayhandleplayer,2
        je L1moveLeft
        cmp wayhandleplayer,3
        je L1moveUp
        cmp wayhandleplayer,4
        je L1MoveDown

        seewalkseeCharacter:
        cmp inputChar,"d"
        je L1moveRight
        cmp inputChar,"a"
        je L1moveLeft
        cmp inputChar,"w"
        je L1moveUp
        cmp inputChar,"s"
        je L1MoveDown
        cmp inputChar,"p"
        call readchar
        jmp LookForKey

        jmp L1SkipLeftRight

        L1moveRight:
            call UpdatePlayer
            inc xPos
            inc xPos
            mov wayhandleplayer,1
            call CoordinaterUpdator
            call goleftrightl1 
            jmp L1SkipLeftRight

        L1moveLeft:
            call UpdatePlayer
            dec xPos
            dec xPos
            mov wayhandleplayer,2
            call CoordinaterUpdator
            call goleftrightl1 
            jmp L1SkipLeftRight

        L1moveUp:
            call UpdatePlayer
            dec yPos
            mov wayhandleplayer,3
            call CoordinaterUpdator
            call goupl1
            jmp L1SkipLeftRight

        L1MoveDown:
            call UpdatePlayer
            inc yPos
            mov wayhandleplayer,4
            call CoordinaterUpdator
            call godownlev1
            jmp L1SkipLeftRight

        L1SkipLeftRight:

       

        cmp PlayerMovement1Possibibly,0
        je PlayerMovement1Fixer
        jmp setmovedont

        PlayerMovement1Fixer:
        cmp wayhandleplayer,1
        je RightFixer
        cmp wayhandleplayer,2
        je LeftFixer
        cmp wayhandleplayer,3
        je UpFixer
        cmp wayhandleplayer,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xPos
                    dec xPos
                    jmp setmovedont
        LeftFixer:  inc xPos
                    inc xPos
                    jmp setmovedont
        UpFixer:    inc yPos
                    jmp setmovedont
        DownFixer:  dec yPos

        setmovedont:
    ret
PlayerMovement1 ENDP 
goleftrightl1 PROC 

        cmp bh,1
        je level102_Handle  
        cmp bh,2
        je level103_Handle
        cmp bh,3
        je level104_Handle
        cmp bh,4
        je level105_Handle
        cmp bh,5
        je level106_Handle
        cmp bh,6
        je level107_Handle
        cmp bh,7
        je level108_Handle
        cmp bh,8
        je level109_Handle
        cmp bh,9
        je level110_Handle
        cmp bh,10
        je level111_Handle
        cmp bh,11
        je level112_Handle
        cmp bh,12
        je level113_Handle
        cmp bh,13
        je level114_Handle
        cmp bh,14
        je level115_Handle
        cmp bh,15
        je level116_Handle
        cmp bh,16
        je level117_Handle
        cmp bh,17
        je level118_Handle
        cmp bh,18
        je level119_Handle
        cmp bh,19
        je level120_Handle
        cmp bh,20
        je level121_Handle
        cmp bh,21
        je level122_Handle
            
        level102_Handle:  mov esi,offset level102
                        call seecoinwal
                        jmp seewalksee
        level103_Handle:  mov esi,offset level103
                        call seecoinwal
                        jmp seewalksee
        level104_Handle:  mov esi,offset level104
                        call seecoinwal
                        jmp seewalksee
        level105_Handle:  mov esi,offset level105
                        call seecoinwal
                        jmp seewalksee
        level106_Handle:  mov esi,offset level106
                        call seecoinwal
                        jmp seewalksee
        level107_Handle:  mov esi,offset level107
                        call seecoinwal
                        jmp seewalksee
        level108_Handle:  mov esi,offset level108
                        call seecoinwal
                        jmp seewalksee
        level109_Handle:  mov esi,offset level109
                        call seecoinwal
                        jmp seewalksee
        level110_Handle:  mov esi,offset level110
                        call seecoinwal
                        jmp seewalksee
        level111_Handle:  mov esi,offset level111
                        call seecoinwal
                        jmp seewalksee
        level112_Handle:  mov esi,offset level112
                        call seecoinwal
                        jmp seewalksee
        level113_Handle:  mov esi,offset level113
                        call seecoinwal
                        jmp seewalksee
        level114_Handle:  mov esi,offset level114
                        call seecoinwal
                        jmp seewalksee
        level115_Handle:  mov esi,offset level115
                        call seecoinwal
                        jmp seewalksee
        level116_Handle:  mov esi,offset level116
                        call seecoinwal
                        jmp seewalksee
        level117_Handle:  mov esi,offset level117
                        call seecoinwal
                        jmp seewalksee
        level118_Handle:  mov esi,offset level118
                        call seecoinwal
                        jmp seewalksee
        level119_Handle:  mov esi,offset level119
                        call seecoinwal
                        jmp seewalksee
        level120_Handle:  mov esi,offset level120
                        call seecoinwal
                        jmp seewalksee
        level121_Handle:  mov esi,offset level121
                        call seecoinwal
                        jmp seewalksee
        level122_Handle:  mov esi,offset level122
                        call seecoinwal
                        jmp seewalksee

        seewalksee:
    ret
goleftrightl1 ENDP    
goupl1 PROC   

        cmp bh,0
        je level101_Handle  
        cmp bh,1
        je level102_Handle
        cmp bh,2
        je level103_Handle
        cmp bh,3
        je level104_Handle
        cmp bh,4
        je level105_Handle
        cmp bh,5
        je level106_Handle
        cmp bh,6
        je level107_Handle
        cmp bh,7
        je level108_Handle
        cmp bh,8
        je level109_Handle
        cmp bh,9
        je level110_Handle
        cmp bh,10
        je level111_Handle
        cmp bh,11
        je level112_Handle
        cmp bh,12
        je level113_Handle
        cmp bh,13
        je level114_Handle
        cmp bh,14
        je level115_Handle
        cmp bh,15
        je level116_Handle
        cmp bh,16
        je level117_Handle
        cmp bh,17
        je level118_Handle
        cmp bh,18
        je level119_Handle
        cmp bh,19
        je level120_Handle
        cmp bh,20
        je level121_Handle

        level101_Handle:  mov esi,offset level101
                        call seecoinwal
                        jmp seewalksee            
        level102_Handle:  mov esi,offset level102
                        call seecoinwal
                        jmp seewalksee
        level103_Handle:  mov esi,offset level103
                        call seecoinwal
                        jmp seewalksee
        level104_Handle:  mov esi,offset level104
                        call seecoinwal
                        jmp seewalksee
        level105_Handle:  mov esi,offset level105
                        call seecoinwal
                        jmp seewalksee
        level106_Handle:  mov esi,offset level106
                        call seecoinwal
                        jmp seewalksee
        level107_Handle:  mov esi,offset level107
                        call seecoinwal
                        jmp seewalksee
        level108_Handle:  mov esi,offset level108
                        call seecoinwal
                        jmp seewalksee
        level109_Handle:  mov esi,offset level109
                        call seecoinwal
                        jmp seewalksee
        level110_Handle:  mov esi,offset level110
                        call seecoinwal
                        jmp seewalksee
        level111_Handle:  mov esi,offset level111
                        call seecoinwal
                        jmp seewalksee
        level112_Handle:  mov esi,offset level112
                        call seecoinwal
                        jmp seewalksee
        level113_Handle:  mov esi,offset level113
                        call seecoinwal
                        jmp seewalksee
        level114_Handle:  mov esi,offset level114
                        call seecoinwal
                        jmp seewalksee
        level115_Handle:  mov esi,offset level115
                        call seecoinwal
                        jmp seewalksee
        level116_Handle:  mov esi,offset level116
                        call seecoinwal
                        jmp seewalksee
        level117_Handle:  mov esi,offset level117
                        call seecoinwal
                        jmp seewalksee
        level118_Handle:  mov esi,offset level118
                        call seecoinwal
                        jmp seewalksee
        level119_Handle:  mov esi,offset level119
                        call seecoinwal
                        jmp seewalksee
        level120_Handle:  mov esi,offset level120
                        call seecoinwal
                        jmp seewalksee
        level121_Handle:  mov esi,offset level121
                        call seecoinwal
                        jmp seewalksee
        level122_Handle:  mov esi,offset level122
                        call seecoinwal
                        jmp seewalksee
        seewalksee:
    ret
goupl1 ENDP  
godownlev1 PROC   

        cmp bh,0
        je level101_Handle  
        cmp bh,1
        je level102_Handle
        cmp bh,2
        je level103_Handle
        cmp bh,3
        je level104_Handle
        cmp bh,4
        je level105_Handle
        cmp bh,5
        je level106_Handle
        cmp bh,6
        je level107_Handle
        cmp bh,7
        je level108_Handle
        cmp bh,8
        je level109_Handle
        cmp bh,9
        je level110_Handle
        cmp bh,10
        je level111_Handle
        cmp bh,11
        je level112_Handle
        cmp bh,12
        je level113_Handle
        cmp bh,13
        je level114_Handle
        cmp bh,14
        je level115_Handle
        cmp bh,15
        je level116_Handle
        cmp bh,16
        je level117_Handle
        cmp bh,17
        je level118_Handle
        cmp bh,18
        je level119_Handle
        cmp bh,19
        je level120_Handle
        cmp bh,20
        je level121_Handle

        level101_Handle:  mov esi,offset level101
                        call seecoinwal
                        jmp seewalksee            
        level102_Handle:  mov esi,offset level102
                        call seecoinwal
                        jmp seewalksee
        level103_Handle:  mov esi,offset level103
                        call seecoinwal
                        jmp seewalksee
        level104_Handle:  mov esi,offset level104
                        call seecoinwal
                        jmp seewalksee
        level105_Handle:  mov esi,offset level105
                        call seecoinwal
                        jmp seewalksee
        level106_Handle:  mov esi,offset level106
                        call seecoinwal
                        jmp seewalksee
        level107_Handle:  mov esi,offset level107
                        call seecoinwal
                        jmp seewalksee
        level108_Handle:  mov esi,offset level108
                        call seecoinwal
                        jmp seewalksee
        level109_Handle:  mov esi,offset level109
                        call seecoinwal
                        jmp seewalksee
        level110_Handle:  mov esi,offset level110
                        call seecoinwal
                        jmp seewalksee
        level111_Handle:  mov esi,offset level111
                        call seecoinwal
                        jmp seewalksee
        level112_Handle:  mov esi,offset level112
                        call seecoinwal
                        jmp seewalksee
        level113_Handle:  mov esi,offset level113
                        call seecoinwal
                        jmp seewalksee
        level114_Handle:  mov esi,offset level114
                        call seecoinwal
                        jmp seewalksee
        level115_Handle:  mov esi,offset level115
                        call seecoinwal
                        jmp seewalksee
        level116_Handle:  mov esi,offset level116
                        call seecoinwal
                        jmp seewalksee
        level117_Handle:  mov esi,offset level117
                        call seecoinwal
                        jmp seewalksee
        level118_Handle:  mov esi,offset level118
                        call seecoinwal
                        jmp seewalksee
        level119_Handle:  mov esi,offset level119
                        call seecoinwal
                        jmp seewalksee
        level120_Handle:  mov esi,offset level120
                        call seecoinwal
                        jmp seewalksee
        level121_Handle:  mov esi,offset level121
                        call seecoinwal
                        jmp seewalksee
        level122_Handle:  mov esi,offset level122
                        call seecoinwal
                        jmp seewalksee
        seewalksee:
    ret
godownlev1 ENDP  
PlayerMovement2 PROC 
        call Level2Intersection 
        mov PlayerMovement1Possibibly,1
        LookForKey:
            mov  eax,speed2  
            call Delay
            INVOKE PlaySound, OFFSET musicChomp, NULL, snd_filename
            call ReadKey       
            mov inputChar,al
            jnz seewalkseeCharacter
        cmp wayhandleplayer,1
        je L1moveRight
        cmp wayhandleplayer,2
        je L1moveLeft
        cmp wayhandleplayer,3
        je L1moveUp
        cmp wayhandleplayer,4
        je L1MoveDown

        seewalkseeCharacter:
        cmp inputChar,"d"
        je L1moveRight
        cmp inputChar,"a"
        je L1moveLeft
        cmp inputChar,"w"
        je L1moveUp
        cmp inputChar,"s"
        je L1MoveDown
        cmp inputChar,"p"
        call readchar
        jmp LookForKey

        jmp L1SkipLeftRight

        L1moveRight:
            call UpdatePlayer
            inc xPos
            inc xPos
            mov wayhandleplayer,1
            call CoordinaterUpdator
            call goinl2leftright 
            jmp L1SkipLeftRight

        L1moveLeft:
            call UpdatePlayer
            dec xPos
            dec xPos
            mov wayhandleplayer,2
            call CoordinaterUpdator
            call goinl2leftright 
            jmp L1SkipLeftRight

        L1moveUp:
            call UpdatePlayer
            dec yPos
            mov wayhandleplayer,3
            call CoordinaterUpdator
            call Level2MovementUp
            jmp L1SkipLeftRight

        L1MoveDown:
            call UpdatePlayer
            inc yPos
            mov wayhandleplayer,4
            call CoordinaterUpdator
            call Level2MovementDown
            jmp L1SkipLeftRight

        L1SkipLeftRight:

       

        cmp PlayerMovement1Possibibly,0
        je PlayerMovement1Fixer
        jmp setmovedont

        PlayerMovement1Fixer:
        cmp wayhandleplayer,1
        je RightFixer
        cmp wayhandleplayer,2
        je LeftFixer
        cmp wayhandleplayer,3
        je UpFixer
        cmp wayhandleplayer,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xPos
                    dec xPos
                    jmp setmovedont
        LeftFixer:  inc xPos
                    inc xPos
                    jmp setmovedont
        UpFixer:    inc yPos
                    jmp setmovedont
        DownFixer:  dec yPos

        setmovedont:
    ret
PlayerMovement2 ENDP
goinl2leftright PROC 

        cmp bh,1
        je level2r02_Handle  
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle
        cmp bh,21
        je level2r22_Handle
            
        level2r02_Handle:  mov esi,offset level2r02
                        call seecoinwal
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seecoinwal
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seecoinwal
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seecoinwal
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seecoinwal
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seecoinwal
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seecoinwal
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seecoinwal
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seecoinwal
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seecoinwal
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seecoinwal
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seecoinwal
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seecoinwal
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seecoinwal
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seecoinwal
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seecoinwal
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seecoinwal
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seecoinwal
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seecoinwal
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seecoinwal
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seecoinwal
                        jmp seewalksee

        seewalksee:
    ret
goinl2leftright ENDP    
Level2MovementUp PROC   

        cmp bh,0
        je level2r01_Handle  
        cmp bh,1
        je level2r02_Handle
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle

        level2r01_Handle:  mov esi,offset level2r01
                        call seecoinwal
                        jmp seewalksee            
        level2r02_Handle:  mov esi,offset level2r02
                        call seecoinwal
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seecoinwal
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seecoinwal
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seecoinwal
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seecoinwal
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seecoinwal
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seecoinwal
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seecoinwal
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seecoinwal
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seecoinwal
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seecoinwal
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seecoinwal
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seecoinwal
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seecoinwal
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seecoinwal
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seecoinwal
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seecoinwal
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seecoinwal
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seecoinwal
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seecoinwal
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seecoinwal
                        jmp seewalksee
        seewalksee:
    ret
Level2MovementUp ENDP  
Level2MovementDown PROC   

        cmp bh,0
        je level2r01_Handle  
        cmp bh,1
        je level2r02_Handle
        cmp bh,2
        je level2r03_Handle
        cmp bh,3
        je level2r04_Handle
        cmp bh,4
        je level2r05_Handle
        cmp bh,5
        je level2r06_Handle
        cmp bh,6
        je level2r07_Handle
        cmp bh,7
        je level2r08_Handle
        cmp bh,8
        je level2r09_Handle
        cmp bh,9
        je level2r10_Handle
        cmp bh,10
        je level2r11_Handle
        cmp bh,11
        je level2r12_Handle
        cmp bh,12
        je level2r13_Handle
        cmp bh,13
        je level2r14_Handle
        cmp bh,14
        je level2r15_Handle
        cmp bh,15
        je level2r16_Handle
        cmp bh,16
        je level2r17_Handle
        cmp bh,17
        je level2r18_Handle
        cmp bh,18
        je level2r19_Handle
        cmp bh,19
        je level2r20_Handle
        cmp bh,20
        je level2r21_Handle

        level2r01_Handle:  mov esi,offset level2r01
                        call seecoinwal
                        jmp seewalksee            
        level2r02_Handle:  mov esi,offset level2r02
                        call seecoinwal
                        jmp seewalksee
        level2r03_Handle:  mov esi,offset level2r03
                        call seecoinwal
                        jmp seewalksee
        level2r04_Handle:  mov esi,offset level2r04
                        call seecoinwal
                        jmp seewalksee
        level2r05_Handle:  mov esi,offset level2r05
                        call seecoinwal
                        jmp seewalksee
        level2r06_Handle:  mov esi,offset level2r06
                        call seecoinwal
                        jmp seewalksee
        level2r07_Handle:  mov esi,offset level2r07
                        call seecoinwal
                        jmp seewalksee
        level2r08_Handle:  mov esi,offset level2r08
                        call seecoinwal
                        jmp seewalksee
        level2r09_Handle:  mov esi,offset level2r09
                        call seecoinwal
                        jmp seewalksee
        level2r10_Handle:  mov esi,offset level2r10
                        call seecoinwal
                        jmp seewalksee
        level2r11_Handle:  mov esi,offset level2r11
                        call seecoinwal
                        jmp seewalksee
        level2r12_Handle:  mov esi,offset level2r12
                        call seecoinwal
                        jmp seewalksee
        level2r13_Handle:  mov esi,offset level2r13
                        call seecoinwal
                        jmp seewalksee
        level2r14_Handle:  mov esi,offset level2r14
                        call seecoinwal
                        jmp seewalksee
        level2r15_Handle:  mov esi,offset level2r15
                        call seecoinwal
                        jmp seewalksee
        level2r16_Handle:  mov esi,offset level2r16
                        call seecoinwal
                        jmp seewalksee
        level2r17_Handle:  mov esi,offset level2r17
                        call seecoinwal
                        jmp seewalksee
        level2r18_Handle:  mov esi,offset level2r18
                        call seecoinwal
                        jmp seewalksee
        level2r19_Handle:  mov esi,offset level2r19
                        call seecoinwal
                        jmp seewalksee
        level2r20_Handle:  mov esi,offset level2r20
                        call seecoinwal
                        jmp seewalksee
        level2r21_Handle:  mov esi,offset level2r21
                        call seecoinwal
                        jmp seewalksee
        level2r22_Handle:  mov esi,offset level2r22
                        call seecoinwal
                        jmp seewalksee
        seewalksee:
    ret
Level2MovementDown ENDP  
PlayerMovement3 PROC 
    
        call insertionofl3 
        cmp xPos,6
        jne SkipA
        cmp yPos,16
        jne SkipA
        
        mov xPos,66
        call DrawLevel3

        SkipA:
        cmp xPos,68
        jne SkipB
        cmp yPos,16
        jne SkipB
        mov xPos,8
        call DrawLevel3
        SkipB:

        
        mov PlayerMovement1Possibibly,1
        LookForKey:
            mov  eax,speed3   
            call Delay
            INVOKE PlaySound, OFFSET musicChomp, NULL, snd_filename
            call Readkey       
            mov inputChar,al
            jnz seewalkseeCharacter
        cmp wayhandleplayer,1
        je L1moveRight
        cmp wayhandleplayer,2
        je L1moveLeft
        cmp wayhandleplayer,3
        je L1moveUp
        cmp wayhandleplayer,4
        je L1MoveDown

        seewalkseeCharacter:
        cmp inputChar,"d"
        je L1moveRight
        cmp inputChar,"a"
        je L1moveLeft
        cmp inputChar,"w"
        je L1moveUp
        cmp inputChar,"s"
        je L1MoveDown
        cmp inputChar,"p"
        call readchar
        jmp LookForKey

        jmp L1SkipLeftRight

        L1moveRight:
            call UpdatePlayer
            inc xPos
            inc xPos
            mov wayhandleplayer,1
            call CoordinaterUpdator
            call goinl3leftright 
            jmp L1SkipLeftRight

        L1moveLeft:
            call UpdatePlayer
            dec xPos
            dec xPos
            mov wayhandleplayer,2
            call CoordinaterUpdator
            call goinl3leftright 
            jmp L1SkipLeftRight

        L1moveUp:
            call UpdatePlayer
            dec yPos
            mov wayhandleplayer,3
            call CoordinaterUpdator
            call Level3MovementUp
            jmp L1SkipLeftRight

        L1MoveDown:
            call UpdatePlayer
            inc yPos
            mov wayhandleplayer,4
            call CoordinaterUpdator
            call Level3MovementDown
            jmp L1SkipLeftRight

        L1SkipLeftRight:

       

        cmp PlayerMovement1Possibibly,0
        je PlayerMovement1Fixer
        jmp setmovedont

        PlayerMovement1Fixer:
        cmp wayhandleplayer,1
        je RightFixer
        cmp wayhandleplayer,2
        je LeftFixer
        cmp wayhandleplayer,3
        je UpFixer
        cmp wayhandleplayer,4
        je DownFixer
        jmp setmovedont

        RightFixer: dec xPos
                    dec xPos
                    jmp setmovedont
        LeftFixer:  inc xPos
                    inc xPos
                    jmp setmovedont
        UpFixer:    inc yPos
                    jmp setmovedont
        DownFixer:  dec yPos

        setmovedont:
    ret
PlayerMovement3 ENDP
goinl3leftright PROC 

        cmp bh,1
        je levelr302_Handle  
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle
        cmp bh,21
        je levelr322_Handle
            
        levelr302_Handle:  mov esi,offset levelr302
                        call seecoinwal
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seecoinwal
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seecoinwal
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seecoinwal
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seecoinwal
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seecoinwal
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seecoinwal
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seecoinwal
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seecoinwal
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seecoinwal
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seecoinwal
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seecoinwal
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seecoinwal
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seecoinwal
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seecoinwal
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seecoinwal
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seecoinwal
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seecoinwal
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seecoinwal
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seecoinwal
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seecoinwal
                        jmp seewalksee

        seewalksee:
    ret
goinl3leftright ENDP    
Level3MovementUp PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seecoinwal
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seecoinwal
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seecoinwal
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seecoinwal
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seecoinwal
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seecoinwal
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seecoinwal
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seecoinwal
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seecoinwal
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seecoinwal
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seecoinwal
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seecoinwal
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seecoinwal
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seecoinwal
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seecoinwal
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seecoinwal
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seecoinwal
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seecoinwal
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seecoinwal
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seecoinwal
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seecoinwal
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seecoinwal
                        jmp seewalksee
        seewalksee:
    ret
Level3MovementUp ENDP  
Level3MovementDown PROC   

        cmp bh,0
        je levelr301_Handle  
        cmp bh,1
        je levelr302_Handle
        cmp bh,2
        je levelr303_Handle
        cmp bh,3
        je levelr304_Handle
        cmp bh,4
        je levelr305_Handle
        cmp bh,5
        je levelr306_Handle
        cmp bh,6
        je levelr307_Handle
        cmp bh,7
        je levelr308_Handle
        cmp bh,8
        je levelr309_Handle
        cmp bh,9
        je levelr310_Handle
        cmp bh,10
        je levelr311_Handle
        cmp bh,11
        je levelr312_Handle
        cmp bh,12
        je levelr313_Handle
        cmp bh,13
        je levelr314_Handle
        cmp bh,14
        je levelr315_Handle
        cmp bh,15
        je levelr316_Handle
        cmp bh,16
        je levelr317_Handle
        cmp bh,17
        je levelr318_Handle
        cmp bh,18
        je levelr319_Handle
        cmp bh,19
        je levelr320_Handle
        cmp bh,20
        je levelr321_Handle

        levelr301_Handle:  mov esi,offset levelr301
                        call seecoinwal
                        jmp seewalksee            
        levelr302_Handle:  mov esi,offset levelr302
                        call seecoinwal
                        jmp seewalksee
        levelr303_Handle:  mov esi,offset levelr303
                        call seecoinwal
                        jmp seewalksee
        levelr304_Handle:  mov esi,offset levelr304
                        call seecoinwal
                        jmp seewalksee
        levelr305_Handle:  mov esi,offset levelr305
                        call seecoinwal
                        jmp seewalksee
        levelr306_Handle:  mov esi,offset levelr306
                        call seecoinwal
                        jmp seewalksee
        levelr307_Handle:  mov esi,offset levelr307
                        call seecoinwal
                        jmp seewalksee
        levelr308_Handle:  mov esi,offset levelr308
                        call seecoinwal
                        jmp seewalksee
        levelr309_Handle:  mov esi,offset levelr309
                        call seecoinwal
                        jmp seewalksee
        levelr310_Handle:  mov esi,offset levelr310
                        call seecoinwal
                        jmp seewalksee
        levelr311_Handle:  mov esi,offset levelr311
                        call seecoinwal
                        jmp seewalksee
        levelr312_Handle:  mov esi,offset levelr312
                        call seecoinwal
                        jmp seewalksee
        levelr313_Handle:  mov esi,offset levelr313
                        call seecoinwal
                        jmp seewalksee
        levelr314_Handle:  mov esi,offset levelr314
                        call seecoinwal
                        jmp seewalksee
        levelr315_Handle:  mov esi,offset levelr315
                        call seecoinwal
                        jmp seewalksee
        levelr316_Handle:  mov esi,offset levelr316
                        call seecoinwal
                        jmp seewalksee
        levelr317_Handle:  mov esi,offset levelr317
                        call seecoinwal
                        jmp seewalksee
        levelr318_Handle:  mov esi,offset levelr318
                        call seecoinwal
                        jmp seewalksee
        levelr319_Handle:  mov esi,offset levelr319
                        call seecoinwal
                        jmp seewalksee
        levelr320_Handle:  mov esi,offset levelr320
                        call seecoinwal
                        jmp seewalksee
        levelr321_Handle:  mov esi,offset levelr321
                        call seecoinwal
                        jmp seewalksee
        levelr322_Handle:  mov esi,offset levelr322
                        call seecoinwal
                        jmp seewalksee
        seewalksee:
    ret
Level3MovementDown ENDP  
seecoinwal PROC
    mov ecx,0
    mov cl,bl
    l1loop1:
    inc esi
    loop l1loop1
    mov edx,0
    mov dl,wall
    cmp [esi],dl
    jne replacewithspace 
        mov PlayerMovement1Possibibly,0
        jmp EscapeReplacer
    replacewithspace:
    mov ecx,20h
    mov edx,0
    mov dl,"-"
    cmp [esi],dl
    jne SkipScreIncrease
    add score,5
    dec Coins

    SkipScreIncrease:
    mov edx,0
    mov dl,"*"
    cmp [esi],dl
    jne Skip
    add score,100
    
   

    jmp Skip
    Skip:
    mov [esi],cl
    EscapeReplacer:
    ret
seecoinwal ENDP

;                                           player's levels

Level1Maze PROC
        mov xPos,10
        mov yPos,7
        mov xG1Pos,10
        mov yG1Pos,15

        call clrscr
        call DrawLevel1
    gameLoop1:

        call DrawScore    
        call moveghost1
        call DrawGhost1

        
        call PlayerMovement1
        call DrawPlayer

        cmp Coins,816
        ja skip
        call Level2Maze 
        skip:
        cmp livesIndicator,0  
        jne gameLoop1
    ret
Level1Maze ENDP 
Level2Maze PROC 
        mov levelIndicator,2
        mov xPos,8
        mov yPos,7
        mov xG3Pos,12
        mov yG3Pos,17
        mov xG2Pos,8
        mov yG2Pos,15

        mov eax,black (black*16)
        call settextcolor
        mov eax,1500
        call delay
        call clrscr
        call DrawLevel2
    gameLoop2:

        call DrawScore
        call Ghost3Movement
        call move2ghost
        call DrawGhost3
        call gin2maker
        call PlayerMovement2
        call DrawPlayer
        cmp Coins,504
        ja skip
        call Level3Maze 
        skip:
        cmp livesIndicator,0  
        jne gameLoop2
ret
Level2Maze ENDP 
Level3Maze PROC  
        mov levelIndicator,3
        mov xPos,8
        mov yPos,7
        mov xG4Pos,40
        mov yG4Pos,21
        mov xG5Pos,34
        mov yG5Pos,21
        mov xG6Pos,40
        mov yG6Pos,15
        mov xG7Pos,37
        mov yG7Pos,15

        mov eax,black (black*16)
        call settextcolor
        mov eax,1500
        call delay
        call clrscr
        call DrawLevel3

    gameLoop3:
        call DrawScore
        call Ghost7Movement
        call go6ginn
        call Ghost4Movement
        call gin7maker
        call DrawGhost6
        call now4ginn
        call PlayerMovement3
        call DrawPlayer
        cmp livesIndicator,0  
        cmp Coins,0
        jne skip
        call EndScreen  
        skip:
        jne gameLoop3
ret
Level3Maze ENDP 

ExitGame PROC
    call clrscr
    mov eax, white (black*16)
    call settextcolor
    exit
ExitGame ENDP   

end main