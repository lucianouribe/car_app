require 'rails_helper'

RSpec.describe DealershipsController, type: :controller do

  # let(:dealership) { Dealership.create(name: 'Larry H Miller', amount_of_cars: 4000, second_hand: true) }
  let(:dealership) { FactoryGirl.create(:dealership) }


  # INDEX
  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the dealerships instance variable' do
      get :index
      expect(assigns(:dealerships)).to eq([])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has dealerships in the dealerships instance variable' do
      3.times { |index| Dealership.create(name: "Dealer_#{index}", amount_of_cars: 4000, second_hand: true) }
      get :index
      expect(assigns(:dealerships).length).to eq(3)
      expect(assigns(:dealerships).last.name).to eq('Dealer_2')
    end

  end


  # NEW
  describe "GET #new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "sets the new instance variable" do
      get :new
      expect(assigns(:dealership)).to_not eq(nil)
      expect(assigns(:dealership).id).to eq(nil)
    end

  end


  # CREATE
  describe "POST #create" do

    before(:each) do
      @dealership_params = { dealership: { name: "Dealer_test", amount_of_cars: 4300, second_hand: false }}
    end

    it "sets the dealership instance variable" do
      post :create, @dealership_params
      expect(assigns(:dealership)).to_not eq(nil)
      expect(assigns(:dealership).name).to eq(@dealership_params[:dealership][:name])
    end

    #fails it doesnt create anithing, expects 1 but gets 0
    it "creates a new dealership" do
      expect(Dealership.count).to eq(0)
      post :create, @dealership_params
      expect(Dealership.count).to eq(1) # it doesnt create anithing, expects 1 but gets 0
      expect(Dealership.first.name).to eq(@dealership_params[:dealership][:name])
    end

    it "sets a flash message on success" do
      post :create, @dealership_params # gets nil
      expect(flash[:success]).to eq('Dealership Created Succesfully!')
    end

    it "sets a flash message on error" do
      post :create, { id: dealership.id, dealership: { name: "Dealer_name", amount_of_cars: 4300, second_hand: false } }
      expect(flash[:error]).to eq('Fix errors and try again')
    end

    it "renders new on fail" do
      post :create, { id: dealership.id, dealership: { name: "Dealer_name", amount_of_cars: 4300, second_hand: false } }
      expect(response).to render_template(:new)
    end

  end

  # EDIT
  describe "GET #edit" do

    it "returns http success" do
      get :edit, id: dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, id: dealership.id
      expect(response). to render_template(:edit)
    end

    it "sets dealership instance variable" do
      get :edit, id: dealership.id
      expect(assigns(:dealership).id).to eq(dealership.id)
    end

  end


  # UPDATE
  describe 'PUT #update' do

    it "sets the dealership instance variable" do
      put :update, { id: dealership.id, dealership: { name: 'New Name', amount_of_cars: 4300, second_hand: false}}
      expect(assigns(:dealership).id).to eq(dealership.id)
    end

    it "updates the dealership" do
      put :update, { id: dealership.id, dealership: { name: 'New Name'}}
      expect(dealership.reload.name).to eq('New Name')
    end

    it "sets a flash message on success" do
      put :update, { id: dealership.id, dealership: { name: 'New Name'}}
      expect(flash[:success]).to eq('Dealership Updated!')
    end

    it "redirect to show on success" do
      put :update, { id: dealership.id, dealership: { name: 'New Name'}}
      expect(response).to redirect_to(dealership_path(dealership.id))
    end

    describe 'update failures' do
      before (:each) do # if it validates_uniqueness_of :name
        @dealership2 = Dealership.create(name: "Dealer_name", amount_of_cars: 4300, second_hand: false)
      end

      it "renders edit on fail" do
        put :update, { id: dealership.id, dealership: { name: 'Dealer_name', amount_of_cars: 4300, second_hand: false } }
        expect(response).to render_template(:edit)
      end

      it "sets a flash message on error" do
        put :update, { id: dealership.id, dealership: { name: "Dealer_name", amount_of_cars: 4300, second_hand: false } }
        expect(flash[:error]).to eq('Dealership failed to update!')
      end

    end
  end


  # SHOW
  describe "GET #show" do

    it "returns http success" do
      get :show, id: dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, id: dealership.id
      expect(response).to render_template(:show)
    end

    it "set the dealership instance variable" do
      get :show, id: dealership.id
      expect(assigns(:dealership).name).to eq(dealership.name)
    end

  end


  # DESTROY
  describe "DELETE #destroy" do

    it "sets the dealership instance variable" do
      delete :destroy, id: dealership.id
      expect(assigns(:dealership)).to eq(dealership)
    end

    it "destroys the dealership" do
      dealership # this is the let dealership way above
      expect(Dealership.count).to eq(1)
      delete :destroy, id: dealership.id
      expect(Dealership.count).to eq(0)
    end

    it "sets the flash message" do
      delete :destroy, id: dealership.id
      expect(flash[:success]).to eq('Dealership Deleted!')
    end

    it "redirect to index path after destroy" do
      delete :destroy, id: dealership.id
      expect(response).to redirect_to(dealerships_path)
    end

  end

end
