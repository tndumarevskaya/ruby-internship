class GrapeApi
  class ProjectsApi < Grape::API
    format :json

    namespace :projects do
      post do
        error!({ massage: "Нет нужных параметров" }, 404) unless params[:name]&&params[:state]
        Project.create(name: params[:name], state: params[:state])
      end
      params do 
        optional :detail, type: Boolean
      end
      get do
        proj=Project.all
        proj=proj.where(state: params[:state]) if params[:state]
        present proj, with: GrapeApi::Entities::Project, detail: params[:detail]
      end
      route_param :id, type: Integer do
        params do 
          optional :detail, type: Boolean
        end
        get do
          proj = Project.find_by_id(params[:id])
          error!({ massage: "Проект не найден" }, 404) unless proj
          present proj, with: GrapeApi::Entities::Project, detail: params[:detail]
        end
        delete do
          proj = Project.find_by_id(params[:id])
          error!({ massage: "Проект не найден" }, 404) unless proj
          proj.destroy
          status 204
        end   
      end
    end
  end
end
