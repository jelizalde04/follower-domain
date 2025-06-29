# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/followers', type: :request do
  path '/api/v1/followers' do
    delete('Remove follower') do
      tags 'Followers'
      consumes 'application/json'
      parameter name: :follower, in: :body, schema: {
        type: :object,
        properties: {
          followerId: { type: :string },
          petId: { type: :string }
        },
        required: %w[followerId petId]
      }

      response(200, 'Removed') do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end

      response(404, 'Not found') do
        run_test!
      end
    end
  end
end
