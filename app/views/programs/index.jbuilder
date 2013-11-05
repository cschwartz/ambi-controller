json.programs @programs do |program|
  json.name program.name
  json.isCurrent program.isCurrent
  json.url program_path(program.name)
end
