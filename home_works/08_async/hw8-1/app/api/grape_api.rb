class GrapeApi < Grape::API
  mount ReportsApi
  add_swagger_documentation
end
