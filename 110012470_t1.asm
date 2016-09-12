#Aluno: Guilherme David Branco		mat: 11/0012470
#Professor: Ricardo Jacobi
#Curso: OAC - CiC UnB
#Obs: Lembre-se de colocar o valor para a memoria inicial do bitmap display para heap(0x10040000)
.data
	Red: 			.word 	0x00FF0000
	Green: 			.word 	0x0000FF00
	Blue: 			.word 	0x000000FF
	Branco: 		.word 	0x00FFFFFF
	Laranja:		.word 	0x00FF9900
	Amarelo:		.word   0x00FFFF00
	Wood_m:			.word   0x00A68064
	Magenta:		.word 	0x00FF00FF
	msg_erro_var_bounds:	.asciiz "\n***********Numero inserido fora dos limites***********\n"
	msg_erro_optfail:	.asciiz "\nOpcao selecionada nao existe\n"
	msg_erro_r_largura: 	.asciiz	"\nLargura do rect e 0\n"
	msg_erro_r_altura: 	.asciiz	"\nAltura do rect e 0\n"
	msg_erro_p_fora: 	.asciiz "\nPixel fora da tela\n"
	msg_menu_principal:	.asciiz "\n-------------------Primitivas graficas MIPS-------------------\n 1 - Seta Cor\n 2 - Desenha Ponto(x,y)\n 3 - Desenha Linha(x0,y0,x1,y1)\n 4 - Desenha Retangulo(x0,y0,l,a)\n 5 - Desenha Retangulo Solido(x0,y0,l,a)\n 6 - Desenha Circulo(x0,y0,r)\n 7 - Sair\n--------------------------------------------------------------\n Escolha sua opcao: "
	msg_menu_cor: 		.asciiz "\n1 - Branca\n2 - Azul\n3 - Vermelho\n4 - Verde\n5 - Laranja\n6 - Wood Medio\n7 - Magenta\n Escolha sua cor: "
	msg_menu_lcor:		.asciiz "\n***********Cor carrregada***********"
	msg_menu_p_x:		.asciiz "\nInsira o x: "
	msg_menu_p_y:		.asciiz "\nInsira o y: "
	msg_menu_pl_x0: 	.asciiz "\nInsira o x0 da linha: "
	msg_menu_pl_y0: 	.asciiz "\nInsira o y0 da linha: "
	msg_menu_pl_x1: 	.asciiz "\nInsira o x1 da linha: "
	msg_menu_pl_y1: 	.asciiz "\nInsira o y1 da linha: "
	msg_menu_f_r_x0:  	.asciiz "\nInsira o x0 do rect: "
	msg_menu_f_r_y0:  	.asciiz "\nInsira o y0 do rect: "
	msg_menu_f_r_l:		.asciiz "\nInsira a largura do rect: "
	msg_menu_f_r_a:		.asciiz "\nInsira a altura do rect: "
	msg_menu_c_cx:		.asciiz	"\nInsira o x0 do circulo: "
	msg_menu_c_cy:		.asciiz "\nInsira o y0 do circulo: "
	msg_menu_c_r:		.asciiz "\nInsira o raio do circulo: "
	msg_lembrete:		.asciiz "\n***********Abra o bitmap display!***********\n"
.text
main:
	lw $t9, Branco
	jal menu
	#######CODIGO DE PLOT LINE
		#	$a0 = x0
		#	$a1 = y0
		#	$a2 = y1
		#	$a3 = y2
		#	$t9 = cor
	#lw	$t9, Laranja
	#li	$a0, 50
	#li	$a1, 50
	#li	$a2, 2
	#li	$a3, 128
	#jal	plotLine
	#nop
	###############################
	##########CODIGO TEMP DE FILL RECT
	#lw	$t9, Laranja		# Cor branca
	#li	$a0, 256		# Ponto inicial x0($a0)
	#li	$a1, 128		# Ponto inicial y0($a1)
	#li	$s5, 200		# Largura do rect ($s5)
	#li	$s6, 100		# Altura do rect ($s6)
	#li	$s7, 0			# Contador de quantas linhas ja foram feitas ($s7), iniciado em 0	
	#addiu	$sp, $sp, -16		#	Salva os valores		
	#sw	$a0, 12($sp)		
	#sw	$a1, 8($sp)
	#sw	$s5, 4($sp)
	#sw	$s6, ($sp)
	#jal	rect			# Aceita numeros negativos para traçar altura e largura para lados contrarios
	#nop
	
	
	#li 	$s7, 0
	#lw	$s6, ($sp)
	#lw	$s5, 4($sp)
	#lw	$a1, 8($sp)
	#lw	$a0, 12($sp)
	#addiu	$sp, $sp, 16 
	
	#addiu 	$a0,$a0,1
	#addiu	$a1,$a1,1
	#addiu	$s5,$s5,-1
	#addiu 	$s6,$s6,-1	
	#jal	fillRect
	#nop
	################################
	##########################
	####FILL RECT FINAL
	#lw	$t9, Laranja		# Cor branca
	#li	$a0, 256		# Ponto inicial x0($a0)
	#li	$a1, 128		# Ponto inicial y0($a1)
	#li	$s5, 200		# Largura do rect ($s5)
	#li	$s6, 100		# Altura do rect ($s6)
	#li	$s7, 0			# Contador de quantas linhas ja foram feitas ($s7), iniciado em 0
	#jal 	fillRect
	#nop
	####################################
	###DESENHA CIRCULO TESTE
	#lw $t9, Magenta
	#li $a0, 256	#cx
	#li $a1, 128	#cy
	#li $a2, 50	#raio
	#jal plotCircle
	#nop
		
	j	sair
	nop
#Codigo de interface nao foi comentado pois é muito simples de ser entendido
menu:
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
.menu_iniciar:
	li	$v0, 4
	la	$a0, msg_menu_principal
	syscall
	li	$v0, 5
	syscall
	beq 	$v0, 1, .menu_cor
	nop
	beq	$v0, 2, .menu_point
	nop
	beq	$v0, 3, .menu_pl
	nop
	beq	$v0, 4, .menu_r
	nop
	beq	$v0, 5, .menu_fr
	nop
	beq	$v0, 6, .menu_c
	nop
	beq	$v0, 7, .menu_sair
	nop
	li	$v0, 4
	la	$a0, msg_erro_optfail
	syscall
	j menu
.menu_sair:
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr $ra
	nop
.menu_cor:
	li $v0, 4
	la $a0, msg_menu_cor
	syscall
	li $v0, 5
	syscall
	#1 - Branca
	#2 - Azul
	#3 - Vermelho
	#4 - Verde
	#5 - Laranja
	#6 - Wood Medio
	#7 - Magenta
	beq	$v0, 1, .menu_sw
	nop
	beq 	$v0, 2, .menu_sb
	nop
	beq	$v0, 3, .menu_sr
	nop
	beq	$v0, 4, .menu_sg
	nop
	beq	$v0, 5, .menu_so
	nop
	beq	$v0, 6, .menu_swm
	nop
	beq	$v0, 7, .menu_sm
	nop
	li	$v0, 4
	la	$a0, msg_erro_optfail
	syscall
	j .menu_cor
.menu_cor_sair:
	j 	.menu_iniciar
	nop
.menu_sw:
	lw $t9, Branco
	li $v0, 4
	la $a0, msg_menu_lcor
	syscall
	j .menu_cor_sair
	nop
.menu_sb:
	lw $t9, Blue
	li $v0, 4
	la $a0, msg_menu_lcor
	syscall
	j .menu_cor_sair
	nop
.menu_sr:
	lw $t9, Red
	li $v0, 4
	la $a0, msg_menu_lcor
	syscall
	j .menu_cor_sair
.menu_sg:
	lw $t9, Green
	li $v0, 4
	la $a0, msg_menu_lcor
	syscall
	j .menu_cor_sair
	nop
.menu_so:
	lw $t9, Laranja
	li $v0, 4
	la $a0, msg_menu_lcor
	syscall
	j .menu_cor_sair
	nop
.menu_swm:
	lw $t9, Wood_m
	li $v0, 4
	la $a0, msg_menu_lcor
	syscall
	j .menu_cor_sair
	nop
.menu_sm:
	lw $t9, Magenta
	li $v0, 4
	la $a0, msg_menu_lcor
	syscall
	j .menu_cor_sair
	nop
.menu_point:
	li $v0, 4
	la $a0, msg_menu_p_x
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 4
	la $a0, msg_menu_p_y
	syscall
	li $v0, 5
	syscall
	move 	$a0, $t0
	move 	$a1, $v0
	
	addiu 	$sp, $sp, -4
	sw 	$ra, ($sp)
	
	move 	$a2, $t9
	jal	point
	
	lw 	$ra, ($sp)
	addiu 	$sp, $sp, 4
.menu_p_sair:
	j 	.menu_iniciar
	nop
.menu_pl:
	li 	$v0, 4
	la 	$a0, msg_menu_pl_x0
	syscall
	li 	$v0, 5
	syscall
	move 	$t0,$v0
	li	 $v0, 4
	la 	$a0, msg_menu_pl_y0
	syscall
	li 	$v0, 5
	syscall
	move 	$a1,$v0
	li 	$v0, 4
	la 	$a0, msg_menu_pl_x1
	syscall
	li 	$v0, 5
	syscall
	move 	$a2, $v0
	li 	$v0, 4
	la 	$a0, msg_menu_pl_y1
	syscall
	li 	$v0, 5
	syscall
	move 	$a3, $v0
	move 	$a0, $t0
	
	addiu 	$sp, $sp, -4
	sw	$ra, ($sp)
	
	jal	plotLine
	
	lw 	$ra, ($sp)
	addiu	$sp, $sp, 4
.menu_pl_sair:
	j 	.menu_iniciar
	nop
.menu_r:
	li 	$v0, 4
	la 	$a0, msg_menu_f_r_x0
	syscall
	li 	$v0, 5
	syscall
	move	$t0,$v0
	li 	$v0, 4
	la 	$a0, msg_menu_f_r_y0
	syscall
	li 	$v0, 5
	syscall
	move 	$a1,$v0
	li 	$v0, 4
	la 	$a0, msg_menu_f_r_l
	syscall
	li 	$v0, 5
	syscall
	move 	$s5, $v0
	li 	$v0, 4
	la 	$a0, msg_menu_f_r_a
	syscall
	li 	$v0, 5
	syscall
	move 	$s6, $v0
	move 	$a0, $t0
	li 	$s7, 0
	
	addiu 	$sp, $sp, -4
	sw	$ra, ($sp)
	
	jal	rect
	
	lw 	$ra, ($sp)
	addiu	$sp, $sp, 4
.menu_r_sair:
	j 	.menu_iniciar
	nop
.menu_fr:
	li $v0, 4
	la $a0, msg_menu_f_r_x0
	syscall
	li $v0, 5
	syscall
	move $t0,$v0
	li $v0, 4
	la $a0, msg_menu_f_r_y0
	syscall
	li $v0, 5
	syscall
	move $a1,$v0
	li $v0, 4
	la $a0, msg_menu_f_r_l
	syscall
	li $v0, 5
	syscall
	move $s5, $v0
	li $v0, 4
	la $a0, msg_menu_f_r_a
	syscall
	li $v0, 5
	syscall
	move $s6, $v0
	move $a0, $t0
	li $s7, 0
	
	addiu 	$sp, $sp, -4
	sw	$ra, ($sp)
	
	jal	fillRect
	
	lw 	$ra, ($sp)
	addiu	$sp, $sp, 4
	
.menu_fr_sair:
	j 	.menu_iniciar
	nop
.menu_c:
	li $v0, 4
	la $a0, msg_menu_c_cx
	syscall
	li $v0, 5
	syscall
	move $t0,$v0
	li $v0, 4
	la $a0, msg_menu_c_cy
	syscall
	li $v0, 5
	syscall
	move $a1,$v0
	li $v0, 4
	la $a0, msg_menu_c_r
	syscall
	li $v0, 5
	syscall
	move	$a0,$t0
	move	$a2,$v0
	
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	
	jal 	circle
	
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
.menu_c_sair:
	j 	.menu_iniciar
	nop
#	Funcao que colore o pixel na coodenada (x,y) na cor pedida
	#	$a0 = x
	#	$a1 = y
	#	$a2 = cor
point:	
li 	$t3, 0x10040000		#Carregando o primeiro pixel num registrador temp
.p_plot:
	# pixel address = 4(x+(y*largura_tela))+end original
	sll 	$t0, $a1, 9		#	Multiplica a coordenada y por 512(largura da tela) para cair na linha necessaria
	addu 	$t1, $t0, $a0		#	Soma X+Y
	sll 	$t1, $t1, 2		#	Nultiplica X+Y por 4
	addu 	$t2, $t3, $t1		#	Adiciona ao endereço do primeiro pixel
	
	sw 	$a2, ($t2)		# 	Escreve o pixel na cor pedida
	
	j .p_sair
	nop
.p_sair:
	jr $ra
	nop
	
#	Desenha linha entre dois pontos, algoritmo baseado em http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm#Simplification
	#	$a0 = x0
	#	$a1 = y0
	#	$a2 = y1
	#	$a3 = y2
	#	$t9 = cor
plotLine:
	addiu	$sp, $sp, -24		#	Salva os valores de s para caso alguma outra funcao os esteja utilizando
	sw	$s0, 20($sp)		
	sw	$s1, 16($sp)		
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, ($sp)

	subu 	$s0, $a2, $a0		#	Calcula dx, ($s0)dx = x1-x0
	abs	$s0, $s0		#	pega valor absoluto de dx
	
	subu 	$s1, $a3, $a1		#	Calcula dy, ($s1)dy = y1-y0
	abs 	$s1, $s1		#	pega valora absoluto de dy
	
	sub 	$s4, $s0, $s1		#	D(erro)
	
	slt	$s2, $a0, $a2		#	X0<X1 ? SX = 1 : SX = -1
	sll	$s2,$s2,1		#	multiplica por 2
	addiu	$s2,$s2,-1		#	retira 1
	
	slt	$s3, $a1, $a3		# 	Y0<Y1 ? SY = 1 : SY = -1
	sll	$s3, $s3, 1		# 	Multiplica por 2
	addiu	$s3, $s3, -1		# 	Subtrai 1
	
	j	.pl_loop
	nop
.pl_loop:
	addiu	$sp, $sp, -16 
	sw	$a0, 12($sp)
	sw	$a1, 8($sp)
	sw	$a2, 4($sp)
	sw	$a3, ($sp)
	
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$a3, ($sp)
	lw	$a2, 4($sp)
	lw	$a1, 8($sp)
	lw	$a0, 12($sp)
	addiu	$sp, $sp, 16 
	
	bne	$a0, $a2, .pl_continuar	# 	Continua o loop enquanto x0 != x1
	nop
	bne	$a1, $a3, .pl_continuar	# 	Continua o loop enquanto y0 != y1
	nop
#	Se bne de continuar nao funcionar ele vem pra ca e termina pois x0==x1 e y0==y1
.pl_fim:
	lw	$ra, ($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addiu	$sp, $sp, 24
	
	jr	$ra			# Volta a main
	nop
	
.pl_continuar:
	sll	$t0, $s4, 2		#	multiplica por 2 e guarda em $t0
	
	subu 	$s1, $zero, $s1		#	Deixa dy negativo
	
	bgt 	$t0, $s1, .pl_ajuste_x	# 	se D*2 > -dy , deve-se avançar o x
	nop
	blt 	$t0, $s0, .pl_ajuste_y	# 	se D*2 < dx , deve-se avançar o y
	nop
	
					#	nao precisa de ajuste volta pro loop para fazer proxima iteracao
	
	j	.pl_loop		#	volta pro loop
	nop
		
.pl_ajuste_x:
	addu	$s4, $s4, $s1		# 	err = err - dy
	addu	$a0, $a0, $s2		# 	x0 = x0 + sx
	j	.pl_loop		# 	volta pro loop
	nop
.pl_ajuste_y:
	addu	$s4, $s4, $s0		# 	err = err + dx
	addu	$a1, $a1, $s3		# 	y0 = y0 + sy
	j	.pl_loop		# 	volta pro loop
	nop

#	Funcao que desenha um rect
	#	$a0 = x0
	#	$a1 = y0
	#	$s5 = largura
	#	$s6 = altura
	#	$s7 = quantidade de linhas desenhadas
	#	$t9 = cor
rect:
	addiu	$sp, $sp, -4 		# Abre espaço na stack
	sw	$ra, ($sp)		# Guarda RA na stack
	
	#como nao deu alguma instrucao ele vai para a proxima que esta em rectLoop mesmo que "j rectLoop"
	
.r_loop:
	
	addu	$s7, $s7, 1		# Adiciona um ao contador de lados
	
	beq	$s7, 1, .r_ladoSuperior	# Se contador for 1 estamos desenhando o lado superior
	nop
	
	beq	$s7, 2, .r_ladoDireito	# Se 2 desenhando o lado direito
	nop

	beq	$s7, 3, .r_ladoInferior	# Se 3 desenhando o lado inferior
	nop

	beq	$s7, 4, .r_ladoEsquerdo 	# Se 4 desenhando o lado esquerdo
	nop
	#como nada é chamado ele vai para .r_sair
.r_sair:
	lw	$ra, ($sp)		# Carregar ra para voltar a chamadora
	addiu	$sp, $sp, 4

	jr	$ra			# Todos os lados foram desenhados, voltar para a chamadora
	nop
	
.r_ladoSuperior:
	addu	$t0, $a0, $s5		# Coord. x
	la	$t1, ($a1)		# Coord. y
	j 	.r_plot
	nop
		 
.r_ladoDireito:
	la	$t0, ($a0)		# Coord. x
	addu	$t1, $a1, $s6		# Coord. y
	j 	.r_plot
	nop
	
.r_ladoInferior:
	subu	$t0, $a0, $s5		# Coord. x
	la	$t1, ($a1)		# Coord. y
	j 	.r_plot
	nop

.r_ladoEsquerdo:
	la	$t0, ($a0)		# Coord. x
	subu	$t1, $a1, $s6		# Coord. y
	j 	.r_plot
	nop

.r_plot:	 	 
	move	$a2, $t0		# Movendo variavel temp para o endereço que representa x1
	move	$a3, $t1		# Movendo variavel temp para o endereço que representa y1
	 
	addiu	$sp, $sp, -16 
	sw	$a0, 12($sp)
	sw	$a1, 8($sp)		#Guarda estes valores na stack pois plotline os modifica
	sw	$a2, 4($sp)
	sw	$a3, ($sp)
	
	jal	plotLine		#Desenha linha nas coordenadas pedidas
	nop
	
	lw	$a3, ($sp)
	lw	$a2, 4($sp)
	lw	$a1, 8($sp)		#Retorna os valores anteriores e retira o espaço da stack
	lw	$a0, 12($sp)
	addiu	$sp, $sp, 16
	
	move	$a0, $a2		# Move x1 para x0, pois o lado atual foi feito e deixa preparado para o proximo lado
	move	$a1, $a3		# Move y1 para y0
	
	j	.r_loop			# volta para o loop
	nop
	
#	Desenha um retangulo solido
	#	$a0 = x0
	#	$a1 = y0
	#	$s5 = largura
	#	$s6 = altura
	#	$s7 = quantidade de linhas desenhadas
	#	$t9 = cor
fillRect:	
	addiu	$sp, $sp, -20		#	Salva os valores		
	sw	$a0, 12($sp)		
	sw	$a1, 8($sp)
	sw	$s5, 4($sp)
	sw	$s6, ($sp)
	sw	$ra, 16($sp)
	jal	rect			# Aceita numeros negativos para traçar altura e largura para lados contrarios
	nop
	
	
	li 	$s7, 0
	lw	$s6, ($sp)
	lw	$s5, 4($sp)
	lw	$a1, 8($sp)
	lw	$a0, 12($sp)
	lw	$ra, 16($sp)
	addiu	$sp, $sp, 20
	
	addiu 	$a0,$a0,1
	addiu	$a1,$a1,1
	addiu	$s5,$s5,-1
	addiu 	$s6,$s6,-1	
.fr_iniciar:
	
	addiu	$sp, $sp, -4 		# Guarda RA na stack
	sw	$ra, ($sp)
	
	addu	$t0, $a0, $s5		# Criar x1 como x0+largura do rect
	la	$t1, ($a1)		# Criar y1 como y0, para manter a linha reta
	
	move	$a2, $t0		# utilizando argumentos
	move	$a3, $t1		# removendo os temps
	
.fr_controle:	 	 
	 
	addiu	$sp, $sp, -16 
	sw	$a0, 12($sp)
	sw	$a1, 8($sp)		#Guarda os antigos
	sw	$a2, 4($sp)
	sw	$a3, ($sp)
	
	jal	plotLine		#Desenha a linha nas coord
	nop
	
	lw	$a3, ($sp)
	lw	$a2, 4($sp)
	lw	$a1, 8($sp)
	lw	$a0, 12($sp)
	addiu	$sp, $sp, 16
	
	j	.fr_loop		# Volta ao loop de fr
	nop	

.fr_loop:		
	addu	$s7, $s7, 1		# Contador de quantas linhas foram feitas
	
	beq	$s7, $s6, .fr_sair	# Quando o contador acima chegar na altura do rect termina a funcao
	nop
	
	add	$a1, $a1, 1		#Adiciona 1 a y0 e y1 para descer uma linha
	add	$a3, $a3, 1		
	
	j	.fr_controle		#Coloca a proxima linha nos argumentos para preencher
	nop

.fr_sair:	
	lw	$ra, ($sp)		# Recupera o RA da chamadora
	addiu	$sp, $sp, 4

	jr	$ra			# Voltar a chamadora
	nop
#	Desenha um circulo, baseado em http://fr.wikipedia.org/wiki/Algorithme_de_trac%C3%A9_d%27arc_de_cercle_de_Bresenham
	#	$a0 = x0	Centro X
	#	$a1 = y0	Centro Y
	#	$a2 = r		Raio
	#	$t9 = c		Cor
circle:
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
.c_iniciar:
	add	$s1, $a2, $zero	#x = radius
	li	$s0, 0		#y = 0
	mul	$t0, $a2, 5
	sub	$t0, $zero, $t0
	li 	$t1, 5
	sub	$s2, $t1, $t0
.c_loop:
	bge	$s0, $s1, .c_end
	nop 
	#primeiro ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	add	$a0, $s0, $a0		#	x + x0
	add	$a1, $s1, $a1		#	y + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#segundo ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	add	$a0, $s1, $a0		#	y + x0
	add	$a1, $s0, $a1		#	x + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#terceiro ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	sub	$t0, $zero, $s0		#	t_x = -x
	add	$a0, $t0, $a0		#	-x + x0
	add	$a1, $s1, $a1		#	y  + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#quarto ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	sub	$t0, $zero, $s1		#	t_y = -y
	add	$a0, $t0, $a0		#	-y + x0
	add	$a1, $s0, $a1		#	x  + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#quinto ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	add	$a0, $s0, $a0		#	x + x0
	sub	$t0, $zero, $s1		#	t_y = -y
	add	$a1, $t0, $a1		#	-y + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#sexto ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	add	$a0, $s1, $a0		#	y + x0
	sub	$t0, $zero, $s0		#	t_x = -x
	add	$a1, $t0, $a1		#	-x + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#setimo ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	sub	$t0, $zero, $s0		#	t_x = -x
	add	$a0, $t0, $a0		#	-x + x0
	sub	$t0, $zero, $s1		#	t_y = -y
	add	$a1, $t0, $a1		#	-y + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#oitavo ponto
	addiu	$sp, $sp, -24
	sw	$a0, 20($sp)
	sw	$a1, 16($sp)
	sw	$a2, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, ($sp)
	
	sub	$t0, $zero, $s1		#	t_y = -y
	add	$a0, $t0, $a0		#	-y + x0
	sub 	$t0, $zero, $s0		#	t_x = -x
	add	$a1, $t0, $a1		#	-x + y0
	move 	$a2, $t9		# 	Move a cor da variavel temp para a2, que sera usado no pixel
	
	jal	point
	nop
	
	lw	$s2, ($sp)
	lw	$s1, 4($sp)
	lw	$s0, 8($sp)
	lw	$a2, 12($sp)
	lw	$a1, 16($sp)
	lw	$a0, 20($sp)
	addiu	$sp, $sp, 24 
	
	#continuacao
	bgtz	$s2, .c_erroajuste
	nop
.c_continua:
	addi 	$s0, $s0, 1	# 	x++
	sll	$t0, $s0, 3	#	t_x = 8*x
	addi	$t0, $t0, 4	#	t_x + 4
	add	$s2, $s2, $t0
	j	.c_loop
	nop
.c_erroajuste:
	addi 	$s1, $s1, -1	#	y--
	sll	$t0, $s1, 3	#	t_y*8
	sub	$s2, $s2, $t0	#	t_y+4
	j .c_continua
	nop
.c_end:
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr $ra
	nop
#	Funcao para finalizar o programa
sair:
      	li   	$v0, 10         	#  Fecha o programa(syscall com v0 = 10)
      	syscall
