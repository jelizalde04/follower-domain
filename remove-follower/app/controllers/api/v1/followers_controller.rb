# frozen_string_literal: true

module Api
  module V1
    class FollowersController < ApplicationController
      before_action :authenticate_request

      # DELETE /api/v1/followers
      def destroy
        follower_id = params[:followerId] || params.dig(:follower, :followerId)
        pet_id = params[:petId] || params.dig(:follower, :petId)

        # Validar parámetros
        if follower_id.blank? || pet_id.blank?
          return render json: { error: 'Missing followerId or petId' }, status: :bad_request
        end

        # Verificamos que la mascota que hace de follower sea propiedad del usuario autenticado
        follower_pet = Pet.find_by(id: follower_id)

        return render json: { error: 'Follower pet not found' }, status: :not_found unless follower_pet

        unless follower_pet.responsibleId == @current_user_id
          return render json: { error: 'Unauthorized for this pet' }, status: :unauthorized
        end

        # Buscamos la relación
        follow = Follower.find_by(followerId: follower_id, petId: pet_id)
        return render json: { error: 'Follow relationship not found' }, status: :not_found if follow.nil?

        # Eliminamos la relación
        follow.destroy!

        render json: {
          message: 'Follower removed successfully',
          data: {
            followerId: follower_id,
            petId: pet_id,
            removedAt: Time.current.iso8601
          }
        }, status: :ok
      end

      private

      def authenticate_request
        token = request.headers['Authorization']&.split(' ')&.last
        payload = JwtService.decode(token)

        unless payload && payload['userId'].present?
          render json: { error: 'Invalid or missing token' }, status: :unauthorized
          return
        end

        # Aquí asignamos el current_user_id para comparaciones
        @current_user_id = payload['userId']
      end
    end
  end
end
