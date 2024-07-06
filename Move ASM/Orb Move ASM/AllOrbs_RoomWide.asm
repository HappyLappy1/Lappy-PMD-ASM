; 
; ------------------------------------------------------------------------------
; By happylappy & Gelius
; This move effect should be set to targeting: Enemies in Room!
; This move effect can be applied to the following Room-Targeting Orbs!
;			 Petrify_Orb, Slumber_Orb, Totter_Orb, TwoEdge_Orb, Spurn_Orb, 
;            FoeHold_Orb (This is normally FLOOR wide!), FoeFear_Orb, 
;			 FoeSeal_Orb, Slow_Orb
; Notes: - FoeHold_Orb is typically a Floor-wide Orb! 
;		 - All of these Orbs would run the user animation per foe inflicted!
;		   so I commented all of them out! If you don't care, put them back!
;
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel DoMovePetrify, 0x232CA3C
.definelabel DoMoveSiesta, 0x232C6B4
.definelabel DoMoveTwoEdge, 0x232C6F0
.definelabel DoMoveConfuse, 0x23293CC
.definelabel DoMoveWarp, 0x23296F8
.definelabel DoMovePause, 0x232AFA0
.definelabel DoMoveTerrify, 0x232E734
.definelabel DoMoveSlowDown, 0x232CA14
.definelabel PlayEffectAnimationEntity, 0x22E35E4

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DoMovePetrify, 0x232D4AC
;.definelabel DoMoveSiesta, 0x232D124
;.definelabel DoMoveTwoEdge, 0x232D160
;.definelabel DoMoveConfuse, 0x2329E38
;.definelabel DoMoveWarp, 0x232A164
;.definelabel DoMovePause, 0x232BA0C
;.definelabel DoMoveTerrify, 0x232F174
;.definelabel DoMoveSlowDown, 0x232D484
;.definelabel PlayEffectAnimationEntity, 0x22E3F94


; File creation
.create "./code_out.bin", 0x02330134 ; Change to the actual offset as this directive doesn't accept labels
    .org MoveStartAddress
    .area MaxSize ; Define the size of the area
    sub sp,sp,#0x8
	; Usable Variables: 
	; r6 = Move ID
	; r9 = User Monster Structure Pointer
	; r4 = Target Monster Structure Pointer
	; r8 = Move Data Structure Pointer (8 bytes: flags [4 bytes], move_id [2 bytes], pp_left [1 byte], boosts [1 byte])
	; r7 = ID of the item that called this move (0 if the move effect isn't from an item)
	; Returns: 
	; r10 (bool) = ???
	; Registers r4 to r9, r11 and r13 must remain unchanged after the execution of that code


	; Check which orb is being used
	ldr r12,=#319;
	cmp r7, r12;
		beq Petrify_Orb;
	ldr r12,=#326;
	cmp r7, r12;
		beq Slumber_Orb;
	ldr r12,=#327
	cmp r7, r12;
		beq Totter_Orb;
	ldr r12,=#328
	cmp r7, r12;
		beq TwoEdge_Orb;
	ldr r12,=#354
	cmp r7, r12;
		beq Spurn_Orb;
	ldr r12,=#355
	cmp r7, r12;
		beq FoeHold_Orb;
	ldr r12,=#357
	cmp r7, r12;
		beq FoeFear_Orb;
	ldr r12,=#359
	cmp r7, r12;
		beq FoeSeal_Orb;
	ldr r12,=#316
	cmp r7, r12;
		beq Slow_Orb;

	Petrify_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		;mov r0, r9
		;ldr r1, =#360
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMovePetrify;
		b return;
	Slumber_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		;mov r0, r9
		;mov r1, #12
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSiesta;
		b return;
	Totter_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		;mov r0, r9
		;ldr r1, =#346
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveConfuse;
		b return;
	TwoEdge_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		mov r0, r9
		mov r1, #47
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		mov r1, #48
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveTwoEdge;
		b return;
	Spurn_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveWarp;
		b return;
	FoeHold_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMovePetrify;
		b return;
	FoeFear_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveTerrify;
		b return;
	FoeSeal_Orb: ; Softlock????
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #4
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMovePause;
		b return;
	Slow_Orb: ; Works, but the user animation is replayed for each foe! If you want the user animation anyway, uncomment it below!
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #80
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSlowDown;
		b return;

    return:
        add sp,sp,#0x8
        b MoveJumpAddress
        .pool
    .endarea
.close