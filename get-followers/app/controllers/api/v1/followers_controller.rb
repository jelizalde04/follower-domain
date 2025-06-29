module Api
  module V1
    class FollowersController < ApplicationController
      before_action :authenticate_request


      def index
        pet_id = params[:petId]


        pet = Pet.find_by(id: pet_id)
        return render json: { error: 'Pet not found' }, status: :not_found unless pet

        followers_relations = Follower.where(petId: pet_id)

        follower_pets = Pet.where(id: followers_relations.pluck(:followerId))

        render json: {
          petId: pet_id,
          followers_count: follower_pets.count,
          followers: follower_pets.as_json(only: %i[id name created_at])
        }
      end

      private

      def authenticate_request
        token = request.headers['Authorization']&.split(' ')&.last
        payload = JwtService.decode(token)

        unless payload
          render json: { error: 'Invalid token' }, status: :unauthorized
          return
        end

        @current_user_id = payload['userId']
      end
    end
  end
end
