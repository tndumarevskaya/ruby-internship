require 'rails_helper'
require 'webmock/rspec'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #check' do
    let(:good_params) { { check: { cpu: '1', ram: '1', hdd_type: 'sata', hdd_capacity: '100', os: 'linux' } } }
    let(:bad_params) { { check: { cpu: '1', ram: '1', hdd_type: 'sata', hdd_capacity: '100', os: 'lux' } } }
    let(:authorized_session) { { login: "Tanya" } }
    let(:sufficient_balance_session) { authorized_session.merge(balance: 200000) }
    let(:insufficient_balance_session) { authorized_session.merge(balance: 20000) }

    context 'when external system is available' do
      before do
        WebMock.allow_net_connect!(:allow => "http://possible_orders.srv.w55.ru")
      end

      context 'when not authorized' do
        it "returns unauthorized status code" do
          get :check
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when authorized' do
        it "returns bad request status code because of missing params" do
          get :check, session: authorized_session
          expect(response).to have_http_status(:bad_request)
        end

        context 'with valid params' do
          it "returns not acceptable status code because of invalid configuration" do
            get :check, session: authorized_session, params: bad_params
            expect(response).to have_http_status(:not_acceptable)
          end

          context 'with sufficient funds' do
            it "returns ok status code" do
              get :check, session: sufficient_balance_session, params: good_params
              expect(response).to have_http_status(:ok)
            end
          end

          context 'with insufficient funds' do
            it "returns not acceptable status code because not enough money" do
              get :check, session: insufficient_balance_session, params: good_params
              expect(response).to have_http_status(:not_acceptable)
            end
          end
        end
      end
    end

    context 'when external system is unavailable' do
      before do
        stub_request(:get, "http://possible_orders.srv.w55.ru").to_return(:status => [500, "Internal Server Error"])
      end

      it 'returns service unavailable status code' do
        get :check, session: authorized_session, params: good_params
        expect(response).to have_http_status(:service_unavailable)
      end
    end
  end
end