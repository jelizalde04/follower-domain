require 'swagger_helper'

RSpec.describe 'api/v1/followers', type: :request do
  path '/api/v1/followers' do
    get('list followers for a pet') do
      tags 'Followers'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :petId, in: :query, type: :string, format: :uuid, description: 'ID of the pet', required: true

      response(200, 'followers found') do
        let(:Authorization) { 'Bearer <token>' }
        let(:petId) { 'some-pet-uuid' }

        schema type: :object,
               properties: {
                 petId: { type: :string, format: :uuid },
                 followers_count: { type: :integer },
                 followers: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string, format: :uuid },
                       name: { type: :string },
                       created_at: { type: :string, format: 'date-time' }
                     },
                     required: %w[id name created_at]
                   }
                 }
               },
               required: %w[petId followers_count followers]

        run_test!
      end

      response(400, 'bad request') do
        let(:petId) { '' }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }
        let(:petId) { 'some-pet-uuid' }
        run_test!
      end

      response(404, 'pet not found') do
        let(:Authorization) { 'Bearer <token>' }
        let(:petId) { 'non-existent-uuid' }
        run_test!
      end
    end
  end
end
