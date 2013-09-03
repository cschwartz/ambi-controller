json.name @component.name
@component.properties.each do |name, value|
  json.set! name, value
end
