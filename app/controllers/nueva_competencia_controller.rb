class NuevaCompetenciaController < ApplicationController
	
	def paso1
		$nombre_competencia = params[:nombre_competencia]
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
			redirect_to action: 'paso2'
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
		if params[:banca]
			$cant_banca = params[:banca]['jug_banca']
		end

		if request.post?
			redirect_to action: 'paso3'
		end
	end

	def paso3
		$participantes = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$participantes.push(row.to_hash)
			end
		end

		if request.post?
			redirect_to action: 'paso4'
		end
	end

	def paso4
		$jugadores = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$jugadores.push(row.to_hash)
			end
		end
		if request.post?
			redirect_to action: 'paso5'
		end
	end

	def paso5
		$entrenadores = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$entrenadores.push(row.to_hash)
			end
		end
		if request.post?
			redirect_to action: 'paso6'
		end
	end
	
	def paso6
		$jueces = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$jueces.push(row.to_hash)
			end
		end
		if request.post?
			redirect_to action: 'paso7'
		end
	end
	
	def paso7
		$recintos = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$recintos.push(row.to_hash)
			end
		end
		if request.post?
			redirect_to action: 'paso8'
		end
	end
	
	def paso8
		if request.post?
			redirect_to action: 'paso9'
		end
	end
end
