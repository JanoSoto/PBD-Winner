class NuevaCompetenciaController < ApplicationController
	@volver = false
	def paso1
		$nombre_competencia = params[:nombre_competencia]
		$desc_competencia = params[:desc_competencia]
		$tipo_competencia = params[:tipo]
		$ida_vuelta = params[:ida_vuelta]
		if $tipo_competencia == "torneo"
			$cant_participantes = params[:participantes_torneo]
		else
			if params[:cant_participantes]
				$cant_participantes = params[:cant_participantes]['participantes']
			end
		end

		if $tipo_competencia == "copa"
			if params[:cant_grupos]
				$cant_grupos = params[:cant_grupos]['grupos']
			end

			if params[:cant_clasificados]
				$cant_clasificados = params[:cant_clasificados]['clasificados']
			end
		else
			$cant_grupos = 0
		end

		if fecha1 = params[:fecha1]
			$fecha_inicio = Date.new fecha1["fecha_inicio(1i)"].to_i, fecha1["fecha_inicio(2i)"].to_i, fecha1["fecha_inicio(3i)"].to_i
		end

		if fecha2 = params[:fecha2]
			$fecha_fin = Date.new fecha2["fecha_fin(1i)"].to_i, fecha2["fecha_fin(2i)"].to_i, fecha2["fecha_fin(3i)"].to_i
		end

		$privacidad = params[:privacidad]

		if request.post?
			if $fecha_fin < $fecha_inicio
				@alert = 'La fecha de inicio es posterior a la fecha de fin. Por favor, ingrese un fecha valida'
			elsif $cant_grupos != 0 && $cant_participantes % $cant_grupos != 0
				@alert = 'La cantidad de grupos no coincide con la cantidad de participantes. Es estrictamente necesario que cada grupo tenga la misma cantidad de participantes.'
			elsif $cant_grupos != 0 && $cant_clasificados.to_i > $cant_participantes.to_i/$cant_grupos.to_i-1
				@alert = 'La cantidad de clasificados no puede ser mayor o igual que la cantidad de participantes por grupo'
			else
				redirect_to action: 'paso2'
			end
		end
	end

	def paso2
		if params[:arbitros]
			$cant_arbitros = params[:arbitros]['cant_arbitros']
		end
		if params[:jugadores]
			$cant_jugadores = params[:jugadores]['cant_jugadores']
		end
		if params[:titulares]
			$cant_titulares = params[:titulares]['jug_titulares']
		end
		if params[:cambios]
			$cant_cambios = params[:cambios]['cant_cambios']
		end
		if params[:banca]
			$cant_banca = params[:banca]['jug_banca']
		end

		if request.post?
			if $cant_jugadores.to_i < $cant_titulares.to_i + $cant_banca.to_i
				@alert = 'La cantidad máxima de jugadores es inferior a la cantidad de jugadores titulares más la cantidad de jugadores en banca'	
			elsif $cant_cambios.to_i > $cant_banca.to_i
				@alert = 'La cantidad máxima de cambios permitidos es mayor que la cantidad de jugadores en banca'
			elsif @volver
				redirect_to action: 'paso1'
			else
				redirect_to action: 'paso3'
			end
		end
	end

	def paso3
		$participantes = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				fila = row.to_hash
				$participantes.push(fila)
			end
		end

		nombre_repetido = false
		campo_vacio = false

		$participantes.each do |participante|
			if participante['Nombre'] == nil || participante['Pais'] == nil
				campo_vacio = true
			end
		end


		if $participantes != [] && $participantes != nil
			for i in (0..$participantes.length-1)
				for j in(i+1..$participantes.length)
					if i != j
						if $participantes[i] != nil && $participantes[j] != nil
							if $participantes[i]['Nombre'] == $participantes[j]['Nombre']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end
		$cant_participantes = $participantes.length
		$participantes.sort! {|x,y| x['Nombre'] <=> y['Nombre']}

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay nombres de participantes que están repetidos'
			else
				redirect_to action: 'paso4'
			end
		end
	end

	def paso4
		$jugadores = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$jugadores.push(row.to_hash)
			end
		end

		nombre_repetido = false
		campo_vacio = false

		$jugadores.each do |jugador|
			puts jugador
			if jugador['Institucion Deportiva'] == nil || jugador['Nombre'] == nil || jugador['Apellido Paterno'] == nil || jugador['Apellido Materno'] == nil || jugador['RUT'] == nil || jugador['Sexo'] == nil || jugador['Fecha nacimiento'] == nil || jugador['Email'] == nil
				campo_vacio = true
			end
		end


		if $jugadores != [] && $jugadores != nil
			for i in (0..$jugadores.length-1)
				for j in(i+1..$jugadores.length)
					if i != j
						if $jugadores[i] != nil && $jugadores[j] != nil
							if $jugadores[i]['Email'] == $jugadores[j]['Email'] || $jugadores[i]['RUT'] == $jugadores[j]['RUT']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		
		$jugadores.sort! {|x,y| x['Institucion Deportiva'] <=> y['Institucion Deportiva']}

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay jugadores que están inscritos dos veces'
			else
				redirect_to action: 'paso5'
			end
		end
	end

	def paso5
		$entrenadores = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$entrenadores.push(row.to_hash)
			end
		end

		nombre_repetido = false
		campo_vacio = false

		$entrenadores.each do |entrenador|
			puts entrenador
			if entrenador['Institucion Deportiva'] == nil || entrenador['Nombre'] == nil || entrenador['Apellido Paterno'] == nil || entrenador['Apellido Materno'] == nil || entrenador['RUT'] == nil || entrenador['Sexo'] == nil || entrenador['Fecha nacimiento'] == nil || entrenador['Email'] == nil
				campo_vacio = true
			end
		end


		if $entrenadores != [] && $entrenadores != nil
			for i in (0..$entrenadores.length-1)
				for j in(i+1..$entrenadores.length)
					if i != j
						if $entrenadores[i] != nil && $entrenadores[j] != nil
							if $entrenadores[i]['Email'] == $entrenadores[j]['Email'] || $entrenadores[i]['RUT'] == $entrenadores[j]['RUT']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay entrenadores que están inscritos dos veces'
			else
				redirect_to action: 'paso6'
			end
		end
	end
	
	def paso6
		$jueces = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$jueces.push(row.to_hash)
			end
		end

		nombre_repetido = false
		campo_vacio = false

		$jueces.each do |juez|
			puts juez
			if juez['Nombre'] == nil || juez['Apellido Paterno'] == nil || juez['Apellido Materno'] == nil || juez['RUT'] == nil || juez['Sexo'] == nil || juez['Fecha nacimiento'] == nil || juez['Email'] == nil
				campo_vacio = true
			end
		end


		if $jueces != [] && $jueces != nil
			for i in (0..$jueces.length-1)
				for j in(i+1..$jueces.length)
					if i != j
						if $jueces[i] != nil && $jueces[j] != nil
							if $jueces[i]['Email'] == $jueces[j]['Email'] || $jueces[i]['RUT'] == $jueces[j]['RUT']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay jueces que están inscritos dos veces'
			else
				redirect_to action: 'paso7'
			end
		end
	end
	
	def paso7
		$recintos = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$recintos.push(row.to_hash)
			end
		end
		
		nombre_repetido = false
		campo_vacio = false

		$recintos.each do |recinto|
			puts recinto
			if recinto['Nombre'] == nil || recinto['Ciudad'] == nil || recinto['Pais'] == nil || recinto['Capacidad'] == nil 
				campo_vacio = true
			end
		end


		if $recintos != [] && $recintos != nil
			for i in (0..$recintos.length-1)
				for j in(i+1..$recintos.length)
					if i != j
						if $recintos[i] != nil && $recintos[j] != nil
							if $recintos[i]['Nombre'] == $recintos[j]['Nombre'] && $recintos[i]['Pais'] == $recintos[j]['Pais'] && $recintos[i]['Ciudad'] == $recintos[j]['Ciudad']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay recintos deportivos que están registrados dos veces'
			else
				redirect_to action: 'paso8'
			end
		end
	end
	

	def paso8
		if request.post?
			#INSERT A LA TABLA COMPETENCIA
			competencia = Competencia.new
			competencia.nombre_comp = $nombre_competencia
			competencia.descripcion_comp = $desc_competencia
			competencia.tipo_comp = $tipo_competencia
			if $ida_vuelta == "ida"
				competencia.ida_vuelta_comp = true
			else
				competencia.ida_vuelta_comp = false
			end
			competencia.cant_part_comp = $cant_participantes.to_i
			competencia.fecha_inicio_comp = $fecha_inicio
			competencia.fecha_termino_comp = $fecha_fin
			competencia.cant_grupos_comp = $cant_grupos.to_i
			if $tipo_competencia == "liga"
				if $cant_participantes % 2 == 0
					$cant_fases = $cant_participantes.to_i-1
				else
					$cant_fases = $cant_participantes
				end
			elsif $tipo_competencia == "torneo"	
				$cant_fases = Math.log($cant_participantes.to_i)/Math.log(2)				
			else #COPA
				if $cant_grupos.to_i > 1
					cant_por_grupo = $cant_participantes.to_i/$cant_grupos.to_i-1
					cant_por_fase = $cant_clasificados.to_i*$cant_grupos.to_i
					for i in(0..6)
						if cant_por_fase == 2**i
							$cant_fases = cant_por_fase + cant_por_grupo
						elsif cant_por_fase > 2**i && cant_por_fase < 2**(i+1)
							$cant_fases = 2**(i+1) + cant_por_grupo
						end
					end
				end
			end
			if $ida_vuelta != "ida"
				$cant_fases= $cant_fases.to_i * 2
			end
			competencia.cant_fases_comp = $cant_fases
			competencia.cant_arbitros_comp = $cant_arbitros.to_i
			competencia.cant_jug_tit = $cant_titulares.to_i
			competencia.cant_jug_ban = $cant_banca.to_i
			competencia.cant_max_jug_comp = $cant_jugadores.to_i
			competencia.cant_mod_comp = $cant_cambios.to_i
			if $privacidad == "si"
				competencia.privacidad_comp = true
			else
				competencia.privacidad_comp = false
			end
			competencia.organizador_id = 0 #AGREGAAAAAAAAR!!!!
			competencia.save

			#INSERT A LA TABLA PARTICIPANTES
			$ids_participantes = Array.new
			$participantes.each do |participante|
				nuevo_participante = Participante.new
				nuevo_participante.nombre_par = participante['Nombre']
				nuevo_participante.pais_par = participante['Pais']
				#participante_aux = {"nombre_par"=>participante['Nombre'], "pais_par"=>participante['Pais']}
				#Participante.create! participante_aux
				nuevo_participante.save
				$ids_participantes.push({'id'=>nuevo_participante.id, 'nombre'=>participante['Nombre']})
			end

			#INSERT A LA TABLA JUGADOR
			$ids_jugadores = Array.new
			$jugadores.each do |jugador|
				nuevo_jugador = Jugador.new
				nuevo_jugador.nombre_jug = jugador['Nombre']
				nuevo_jugador.apellido_pat_jug = jugador['Apellido Paterno']
				nuevo_jugador.apellido_mat_jug = jugador['Apellido Materno']
				nuevo_jugador.rut_jug = jugador['RUT']
				nuevo_jugador.sexo_jug = jugador['Sexo']
				nuevo_jugador.fecha_nac_jug = jugador['Fecha nacimiento']
				nuevo_jugador.email_jug = jugador['Email']
				nuevo_jugador.save
				$ids_jugadores.push({'id'=>nuevo_jugador.id, 'Institucion Deportiva'=>jugador['Institucion Deportiva']})
			end

			#INSERT A LA TABLA CONVOCATORIA
			#RELACIONAMIENTO ENTRE JUGADOR E INSTITUCIÓN DEPORTIVA
			#ids_jugadores.each do |jugador|
			#	ids_participantes.each do |institucion|
			for i in(0..$ids_jugadores.length-1)
				for j in(0..$ids_participantes.length-1)
					puts $ids_jugadores[i]
					puts $ids_participantes[j]
					puts '---------------------------'
					if $ids_jugadores[i]['Institucion Deportiva'] == $ids_participantes[j]['nombre']
						nueva_convocatoria = Convocatoria.new
						nueva_convocatoria.jugador_id = $ids_jugadores[i]['id']
						nueva_convocatoria.participante_id = $ids_participantes[j]['id']
						nueva_convocatoria.save						
					end
				end
			end


			#GENERACIÓN DEL FIXTURE
			if $tipo_competencia == "liga"
				#CREACIÓN DE LAS ETAPAS CORRESPONDIENTES
				id_etapa_siguiente = nil
				num_fases = $cant_fases.to_i
				while num_fases > 0
					puts '-----------------------------------------'
					etapa = Etapa.new
					etapa.nombre_etp = "Fecha "+num_fases.to_s
					etapa.tipo_etp = 0
					etapa.competencia_id = competencia.id
					etapa.etapa_id = id_etapa_siguiente
					etapa.save
					id_etapa_siguiente = etapa.id
					num_fases -= 1
				end

				#GENERACIÓN DEL FIXTURE EN UNA MATRIZ
				$fixture = Array.new($cant_fases.to_i) {Array.new($cant_participantes.to_i/2){Array.new(2)}}

				equipo1 = $cant_participantes.to_i-2
				equipo2 = 0
				alterna = true
				iteracion1 = true
				$fixture.each do |fecha|
					fecha.each do |encuentro|
						if !iteracion1
							encuentro[0] = $participantes[equipo1]	
							equipo1 -= 1
							encuentro[1] = $participantes[equipo2]
							equipo2 += 1
						else
							if alterna							
								encuentro[0] = $participantes[equipo1]	
								equipo1 -= 1
								encuentro[1] = $participantes[$cant_participantes.to_i-1]
								alterna = false
							else
								encuentro[1] = $participantes[equipo1]	
								equipo1 -= 1
								encuentro[0] = $participantes[$cant_participantes.to_i-1]
								alterna = true
							end
						end

						if equipo1 < 0
							equipo1 = $cant_participantes.to_i-2
						end
						if equipo2 > $cant_participantes.to_i-2
							equipo2 = 0
						end
					end
					iteracion1 = false
					print fecha
				end
			

			elsif $tipo_competencia == "torneo"

			else

			end
					
			redirect_to action: 'paso9'
		end
	end

	def paso9

	end
end
