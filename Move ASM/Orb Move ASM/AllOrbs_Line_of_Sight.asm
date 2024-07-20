; 
; ------------------------------------------------------------------------------
; By happylappy & Gelius
; This move effect should be set to targeting: Line of Sight!
; This move effect can be applied to the following Line of Sight Orbs!
;			Mug_Orb, Warp_Orb, Switcher_Orb, Blowback_Orb, Stayaway_Orb, 
;			Silence_Orb, Shocker_Orb
; Notes: All move effects here will share one projectile animation! Keep that
;		 in mind, and choose that animation inside the move slot animation!
; 
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel DoMoveWarp, 0x23296F8
.definelabel DoMoveTakeaway, 0x232C310
.definelabel DoMoveSwitchPositions, 0x232C538
.definelabel DoMoveStayAway, 0x232C560
.definelabel DoMoveBlowback, 0x232B500
.definelabel DoMoveSilence, 0x232C818
.definelabel DoMoveShocker, 0x232CE94

.definelabel PlayEffectAnimationEntity, 0x22E35E4

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DoMoveWarp, 0x232A164
;.definelabel DoMoveTakeaway, 0x232CD80
;.definelabel DoMoveSwitchPositions, 0x232CFA8
;.definelabel DoMoveStayAway, 0x232CFD0
;.definelabel DoMoveBlowback, 0x232BF6C
;.definelabel DoMoveSilence, 0x232D288
;.definelabel DoMoveShocker, 0x232D904
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
	ldr r12,=#309
	cmp r7, r12;
		beq Mug_Orb;
	ldr r12,=#312
	cmp r7, r12;
		beq Switcher_Orb;
	ldr r12,=#313
	cmp r7, r12;
		beq Blowback_Orb;
	ldr r12,=#314
	cmp r7, r12;
		beq Warp_Orb;
	ldr r12,=#320
	cmp r7, r12;
		beq Stayaway_Orb;
	ldr r12,=#329
	cmp r7, r12;
		beq Silence_Orb;
	ldr r12,=#340
	cmp r7, r12;
		beq Shocker_Orb;
	b return;
	Mug_Orb: ; Works but no animation!
		mov r0, r9
		mov r1, #47
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #48
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveTakeaway;
		b return;
	Switcher_Orb: ; Works!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		mov r1, #4
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSwitchPositions;
		b return;
	Blowback_Orb: ; Works! 
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #4
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveBlowback;
		b return;
	Warp_Orb: ; Works!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveWarp;
		b return;
	Stayaway_Orb: ; Works!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #4
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveStayaway;
		b return;
	Silence_Orb: ; Works!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #154
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSilence;
		b return;
	Shocker_Orb: ; Works!
		mov r0, r4
		mov r1, #208
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveShocker;
		b return;

    return:
        add sp,sp,#0x8
        b MoveJumpAddress
        .pool
    .endarea
.close
