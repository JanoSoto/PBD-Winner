json.array!(@organizadors) do |organizador|
  json.extract! organizador, :id, :nombre_org, :apellido_pat_org, :apellido_mat_org, :rut_org, :sexo_org, :fecha_nac_org, :email_org, :foto_org
  json.url organizador_url(organizador, format: :json)
end
