; 
; ------------------------------------------------------------------------------
; By happylappy & Gelius
; This move effect should be set to targeting: User & Allies!
; This move effect can be applied to the following Ally-Targeting Orbs!
;		 Quick_Orb, AllMach_Orb, AllHit_Orb
; Notes: AllMach_Orb is technically a floor-wide orb! If you want exact parity
;        with the base-game, retain AllMach_Orb's move slot! Keep in mind, if
;		 you do this, AllMach_Orb will be a perfect clone of Quick_Orb.
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel DoMoveBoostSpeed1, 0x2327928
.definelabel DoMoveFocusEnergy, 0x23268BC
.definelabel PlayEffectAnimationEntity, 0x22E35E4

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DoMoveBoostSpeed1, 0x2328390 
;.definelabel DoMoveFocusEnergy, 0x2327324
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
	ldr r12,=#358
	cmp r7, r12;
		beq AllHit_Orb;
	;If it's NOT an All-Hit Orb, it raises team speed by 1.
	Other: ; Will run the user animation for each ally! If you don't care, uncomment it!
		;mov r0, r9
		;mov r1, #22
		;mov r2, #1
		;bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveBoostSpeed1;
		b return;
	AllHit_Orb: ; Will run the user animation for each ally! If you don't care, uncomment it!
		mov r0, r4
		mov r1, #130
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveFocusEnergy;
		b return;
    return:
        add sp,sp,#0x8
        b MoveJumpAddress
        .pool
    .endarea
.close