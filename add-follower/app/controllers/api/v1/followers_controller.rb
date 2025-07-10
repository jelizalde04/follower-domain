# frozen_string_literal: true

module Api
  module V1
    class FollowersController < ApplicationController
      before_action :authenticate_request

def create
  follower_id = params[:followerId]
  pet_id = params[:petId]

  follower_pet = Pet.find_by(id: follower_id)
  return render json: { error: 'Follower pet not found' }, status: :not_found unless follower_pet

  unless follower_pet.responsibleId == @current_user_id
    return render json: { error: 'Unauthorized for this pet' }, status: :unauthorized
  end

  if follower_id == pet_id
    return render json: { error: 'A pet cannot follow itself' }, status: :unprocessable_entity
  end

  existing = Follower.find_by(followerId: follower_id, petId: pet_id)
  return render json: { error: 'Already following this pet' }, status: :unprocessable_entity if existing

  target_pet = Pet.find_by(id: pet_id)
  return render json: { error: 'Target pet not found' }, status: :not_found unless target_pet
  
  responsible_id = target_pet.responsibleId
  content_text = "#{follower_pet.name} ha empezado a seguir a #{target_pet.name}"

  begin
    # Primero intentamos enviar la notificación
    notification_sent = NotificationGrpcClient.new.send_follow_notification(
      actor_id: follower_id,
      recipient_id: pet_id, 
      responsible_id: responsible_id,
      type: "Follower",
      content: content_text,    
      timestamp: Time.now.utc.iso8601
    )
    
    unless notification_sent
      return render json: { error: "Failed to send notification" }, status: :internal_server_error
    end
  rescue StandardError => e
    return render json: { error: "Failed to send notification: #{e.message}" }, status: :internal_server_error
  end

  # Solo si la notificación fue exitosa, creamos el follower
  new_follow = Follower.create!(
    id: SecureRandom.uuid,
    followerId: follower_id,
    petId: pet_id,
    createdAt: Time.now
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
