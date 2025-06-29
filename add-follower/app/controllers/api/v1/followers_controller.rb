# frozen_string_literal: true

module Api
  module V1
    class FollowersController < ApplicationController
      before_action :authenticate_request

      def create
        follower_id = params[:followerId]
        pet_id = params[:petId]

        # Validamos que el follower exista en Pets y pertenezca al usuario autenticado
        follower_pet = Pet.find_by(id: follower_id)

        return render json: { error: 'Follower pet not found' }, status: :not_found unless follower_pet

        unless follower_pet.responsibleId == @current_user_id
          return render json: { error: 'Unauthorized for this pet' }, status: :unauthorized
        end

        # Evitar que se sigan a sí mismas
        if follower_id == pet_id
          return render json: { error: 'A pet cannot follow itself' }, status: :unprocessable_entity
        end

        # Revisar si ya existe relación
        existing = Follower.find_by(followerId: follower_id, petId: pet_id)
        return render json: { error: 'Already following this pet' }, status: :unprocessable_entity if existing

        # Crear follower
        new_follow = Follower.create!(
          id: SecureRandom.uuid,
          followerId: follower_id,
          petId: pet_id,
          createdAt: Time.now
        )

        NotificationGrpcClient.new.send_follow_notification(
          follower_id: follower_id,
          pet_id: pet_id
        )

        render json: {
          message: 'Follow created successfully',
          data: {
            id: new_follow.id,
            followerId: new_follow.followerId,
            petId: new_follow.petId,
            createdAt: new_follow.createdAt
          }
        }, status: :created
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
