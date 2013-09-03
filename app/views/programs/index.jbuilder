json.programs @programs do |program|
  json.name program.name
  json.url program_path(program.name)
end
