json.name @program.name
json.activations @program.activations do |activation|
  json.name activation
  json.url component_path(activation)
end

