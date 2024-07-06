; 
; ------------------------------------------------------------------------------
; By happylappy & Gelius
; This move effect should be set to targeting: User
; This move effect can be applied to the following orbs affecting the user!
;	  Hail_Orb, Sunny_Orb, Rainy_Orb, Evasion_Orb, Sandy_Orb, Snatch_Orb,
;	  See-Trap_Orb, Rebound_Orb, Luminous_Orb, Escape_Orb, Pounce_Orb, 
;	  Trawl_Orb, Cleanse_Orb,  Scanner_Orb, Radar_Orb, Drought_Orb, Trapbust_Orb, 
;	  Rollcall_Orb, Invisify_Orb, Identify_Orb, OneRoom_Orb, FillIn_Orb, 
;	  Trapper_Orb, Mobile_Orb, Stairs_Orb, Longtoss_Orb, Pierce_Orb.
;
; Notes:	  - Move Animations may be impacted by this ASM! Please test these!
;				 (I tried my best, but it's a lot to test...)
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel DoMoveHail, 0x232612C
.definelabel DoMoveSunnyDay, 0x232A220
.definelabel DoMoveRainDance, 0x23260D0
.definelabel DoMoveDoubleTeam, 0x2326E04
.definelabel DoMoveSandstorm, 0x23289F8
.definelabel DoMoveSnatch, 0x232BE34
.definelabel DoMoveSeeTrap, 0x232C300
.definelabel DoMoveRebound, 0x232C524
.definelabel DoMoveSearchlight, 0x232CA2C
.definelabel DoMovePounce, 0x232CA4C
.definelabel DoMoveTrawl, 0x232CA60
.definelabel DoMoveEscape, 0x232CA70
.definelabel DoMoveDrought, 0x232CB08
.definelabel DoMoveTrapBuster, 0x232CB18
.definelabel DoMoveWildCall, 0x232CCC4
.definelabel DoMoveInvisify, 0x232CD90
.definelabel DoMoveHpGauge, 0x232CE40
.definelabel DoMoveOneRoom, 0x232CF74
.definelabel DoMoveFillIn, 0x232CF84
.definelabel DoMoveTrapper, 0x232D0F0
.definelabel DoMoveMobile, 0x232D1EC 
.definelabel DoMoveSeeStairs, 0x232D1FC
.definelabel DoMoveLongToss, 0x232D20C
.definelabel DoMovePierce, 0x232D21C
.definelabel DoMoveCleanse, 0x232C578
.definelabel DoMoveScan, 0x232C82C
.definelabel DoMovePowerEars, 0x232C83C
.definelabel PlayEffectAnimationEntity, 0x22E35E4

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DoMoveHail, 0x2326B94 
;.definelabel DoMoveSunnyDay, 0x232AC8C
;.definelabel DoMoveRainDance, 0x2326B38
;.definelabel DoMoveDoubleTeam, 0x232786C
;.definelabel DoMoveSandstorm, 0x2329464
;.definelabel DoMoveSnatch, 0x232C8A4
;.definelabel DoMoveSeeTrap, 0x232CD70
;.definelabel DoMoveRebound, 0x232CF94
;.definelabel DoMoveSearchlight, 0x232D49C
;.definelabel DoMovePounce, 0x232D4BC
;.definelabel DoMoveTrawl, 0x232D4D0
;.definelabel DoMoveEscape, 0x232D4E0
;.definelabel DoMoveDrought, 0x232D578
;.definelabel DoMoveTrapBuster, 0x232D588
;.definelabel DoMoveWildCall, 0x232D734
;.definelabel DoMoveInvisify, 0x232D800
;.definelabel DoMoveHpGauge, 0x232D8B0
;.definelabel DoMoveOneRoom, 0x232D9E4
;.definelabel DoMoveFillIn, 0x232D9F4
;.definelabel DoMoveTrapper, 0x232DB60
;.definelabel DoMoveMobile, 0x232DC5C
;.definelabel DoMoveSeeStairs, 0x232DC6C
;.definelabel DoMoveLongToss, 0x232DC7C
;.definelabel DoMovePierce, 0x232DC8C
;.definelabel DoMoveCleanse, 0x232CFE8   
;.definelabel DoMoveScan, 0x232D29C        
;.definelabel DoMovePowerEars, 0x232D2AC      
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
	ldr r12,=#301;
	cmp r7, r12;
		beq Hail_Orb;
	ldr r12,=#302;
	cmp r7, r12;
		beq Sunny_Orb;
	ldr r12,=#303
	cmp r7, r12;
		beq Rainy_Orb;
	ldr r12,=#304
	cmp r7, r12;
		beq Evasion_Orb;
	ldr r12,=#305
	cmp r7, r12;
		beq Sandy_Orb;
	ldr r12,=#307
	cmp r7, r12;
		beq Snatch_Orb;
	ldr r12,=#308
	cmp r7, r12;
		beq SeeTrap_Orb;
	ldr r12,=#310
	cmp r7, r12;
		beq Rebound_Orb;
	ldr r12,=#318
	cmp r7, r12;
		beq Luminous_Orb;
	ldr r12,=#330
	cmp r7, r12;
		beq Escape_Orb;
	ldr r12,=#321
	cmp r7, r12;
		beq Pounce_Orb;
	ldr r12,=#322
	cmp r7, r12;
		beq Trawl_Orb;
	ldr r12,=#323
	cmp r7, r12;
		beq Cleanse_Orb;
	ldr r12,=#331
	cmp r7, r12;
		beq Scanner_Orb;
	ldr r12,=#332
	cmp r7, r12;
		beq Radar_Orb;
	ldr r12,=#333
	cmp r7, r12;
		beq Drought_Orb;
	ldr r12,=#334
	cmp r7, r12;
		beq Trapbust_Orb;
	ldr r12,=#335
	cmp r7, r12;
		beq Rollcall_Orb;
	ldr r12,=#336
	cmp r7, r12;
		beq Invisify_Orb;
	ldr r12,=#338
	cmp r7, r12;
		beq Identify_Orb;
	ldr r12,=#342
	cmp r7, r12;
		beq OneRoom_Orb;
	ldr r12,=#343
	cmp r7, r12;
		beq FillIn_Orb;
	ldr r12,=#344
	cmp r7, r12;
		beq Trapper_Orb;
	ldr r12,=#348
	cmp r7, r12;
		beq Mobile_Orb;
	ldr r12,=#350
	cmp r7, r12;
		beq Stairs_Orb;
	ldr r12,=#351
	cmp r7, r12;
		beq Longtoss_Orb;
	ldr r12,=#352
	cmp r7, r12;
		beq Pierce_Orb;
	b return;


	Hail_Orb: ; Works and animates perfectly!
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveHail;
		b return;
	Sunny_Orb: ; Works and animates perfectly!
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSunnyDay;
		b return;
	b return
	Rainy_Orb: ; Works and animates perfectly!
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveRainDance;
		b return;
	Evasion_Orb: ; Works and animates perfectly!
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveDoubleTeam;
		b return;
	Sandy_Orb: ; Works and animates perfectly!
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSandstorm;
		b return;
	Snatch_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #47
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		mov r1, #48
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSnatch;
		b return;
	SeeTrap_Orb: ; Seems to work?
		mov r0, r9
		ldr r1,=#356
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSeeTrap;
		b return;
	Rebound_Orb: ; works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		ldr r1,=#318
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveRebound;
		b return;
	Luminous_Orb: ; works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		ldr r1,=#351
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSearchlight;
		b return;
	Pounce_Orb: ; works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMovePounce;
		b return;
	Trawl_Orb: ; works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		ldr r1,=#360
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveTrawl;
		b return;
	Escape_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveEscape;
		b return;
	Cleanse_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		mov r1, #204
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveCleanse;
		b return;
	Scanner_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #80
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveScan;
		b return;
	Radar_Orb: ; Works and animates perfectly!
		mov r0, r9
		ldr r1,=#305
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMovePowerEars;
		b return;
	Drought_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		ldr r1,=#361
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveDrought;
		b return;
	Trapbust_Orb: ; Animation plays. Seems to work???
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		mov r1, #199
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveTrapBuster;
		b return;
	Rollcall_Orb: ; Works and animates perfectly!
		mov r0, r9
		ldr r1,=#362
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveWildCall;
		b return;
	Invisify_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		ldr r1,=#363
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveInvisify;
		b return;
	Identify_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #21
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveHpGauge;
		b return;
	OneRoom_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		ldr r1,=#351
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		mov r1, #230
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveOneRoom;
		b return;
	FillIn_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveFillIn;
		b return;
	Trapper_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		ldr r1,=#290
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveTrapper;
		b return;
	Mobile_Orb: ; Works, Animation looks "wrong"?
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r9
		ldr r1,=#363
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveMobile;
		b return;
	Stairs_Orb: ; Works!
		mov r0, r9
		mov r1, #80
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveSeeStairs;
		b return;
	Longtoss_Orb: ; Works!
		mov r0, r9
		mov r1, #235
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveLongToss;
		b return;
	Pierce_Orb: ; Works!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r9; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMovePierce;
		b return;

    return:
        add sp,sp,#0x8
        b MoveJumpAddress
        .pool
    .endarea
.close