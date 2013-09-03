json.components @components do |component|
  json.name component.name
  json.url component_path(component.name)
end
