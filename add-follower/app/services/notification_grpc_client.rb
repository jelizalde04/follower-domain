# frozen_string_literal: true

class NotificationGrpcClient
  def send_follow_notification(follower_id:, pet_id:)
    puts "[gRPC] Notificación: follower_id=#{follower_id} sigue a pet_id=#{pet_id}"
  end
end
