require 'grpc'
require_relative '../lib/notification_pb'
require_relative '../lib/notification_services_pb'

class NotificationGrpcClient
  def initialize
    @host = ENV.fetch('NOTIFICATION_GRPC_HOST', 'localhost:50051')
    @stub = Notification::NotificationService::Stub.new(@host, :this_channel_is_insecure)
  end

  def send_follow_notification(actor_id:, recipient_id:, responsible_id:, type:, content:, timestamp:)
    request = Notification::FollowCreatedRequest.new(
      actorId: actor_id,
      recipientId: recipient_id,
      responsibleId: responsible_id,
      type: type,
      content: content,
      timestamp: timestamp
    )
    response = @stub.follow_created(request)
    puts "[gRPC] Notification sent: #{response.message}"
    true
  rescue GRPC::BadStatus => e
    Rails.logger.error("[gRPC] Notification failed: #{e.message}")
    raise StandardError, "gRPC notification failed: #{e.message}"
  end
end
