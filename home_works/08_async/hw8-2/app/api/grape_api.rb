class GrapeApi < Grape::API
    mount VmsApi
    mount ProjectsApi
    mount OrdersApi
    add_swagger_documentation
end
