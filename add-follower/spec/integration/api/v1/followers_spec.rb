# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/followers', type: :request do
  path '/api/v1/followers' do
    post('create follower') do
      tags 'Followers'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: []]

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          followerId: { type: :string, format: :uuid },
          petId: { type: :string, format: :uuid }
        },
        required: %w[followerId petId]
      }

      response(201, 'created') do
        let(:Authorization) { 'Bearer <token>' }
        let(:body) do
          {
            followerId: 'some-follower-uuid',
            petId: 'some-pet-uuid'
          }
        end

        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end

      response(422, 'unprocessable entity') do
        run_test!
      end
    end
  end
end
