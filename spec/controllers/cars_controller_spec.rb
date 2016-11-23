require 'rails_helper'

RSpec.describe CarsController, type: :controller do


  let(:car) { Car.create(make: 'Subaru', model: 'STI', year: '2004', price: '1000', engine: 2000, c_type: 'sedan') }
  let(:car) { FactoryGirl.create(:car) }


  # INDEX
  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the cars instance variable' do
      get :index
      expect(assigns(:car)).to eq([])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has cars in the cars instance variable' do
      3.times { |index| Car.create(make: "Car_#{index}", model: 'STI', year: '2004', price: '1000', engine: 2000, c_type: 'sedan') }
      get :index
      expect(assigns(:cars).length).to eq(3)
      expect(assigns(:cars).last.make).to eq('Car_2')
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
    # @car = Car.new
    it "sets the new instance variable" do
      get :new
      expect(assigns(:car)).to_not eq(nil)
      expect(assigns(:car).id).to eq(nil)
    end

  end


  # CREATE
  describe "POST #create" do
    before(:all) do
      @car_params = { car: { make: 'Subaru', model: 'STI', year: '2004', price: '1000', engine: 2000, c_type: 'sedan' }}
    end

    it "sets the car instance variable" do
      post :create, @car_params
      expect(assigns(:car)).to_not eq(nil)
      expect(assigns(:car).make).to eq(@car_params[:car][:make])
    end

    it "creates a new car" do
      expect(Car.count).to eq(0)
      post :create, @car_params
      expect(Car.count).to eq(1)
      expect(Car.first.make).to eq(@car_params[:car][:make])
    end

    it "sets a flash message on success" do
      post :create, @car_params
      expect(flash[:success]).to eq('Car Created Succesfully!')
    end

    it "sets a flash message on error" do
      post :create, { id: car.id, car: { make: 'Subaru', model: 'STI', year: '2004', price: '1000', engine: 2000, c_type: 'sedan' } }
      expect(flash[:error]).to eq('Fix errors and try again')
    end
  end

  # EDIT
  describe "GET #edit" do

    it "returns http success" do
      get :edit, id: car.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, id: car.id
      expect(response). to render_template(:edit)
    end

    it "sets car instance variable" do
      get :edit, id: car.id
      expect(assigns(:car).id).to eq(car.id)
    end

  end


  # UPDATE
  describe 'PUT #update' do

    it "sets the car instance variable" do
      put :update, { id: car.id, car: { make: 'New car'}}
      expect(assigns(:car).id).to eq(car.id)
    end

    it "updates the car" do
      put :update, { id: car.id, car: { make: 'New car'}}
      expect(car.reload.name).to eq('New car')
    end

    it "sets a flash message on success" do
      put :update, { id: car.id, car: { make: 'New car'}}
      expect(flash[:success]).to eq('car Updated!')
    end

    it "redirect to show on success" do
      put :update, { id: car.id, car: { make: 'New car'}}
      expect(response).to redirect_to(car_path(car.id))
    end

    describe 'update failures' do

      it "renders edit on fail" do
        put :update, { id: car.id, car: { make: nil, model: 'STI', year: '2004', price: '1000', engine: 2000, c_type: 'sedan'e } }
        expect(response).to render_template(:edit)
      end

      it "sets a flash message on error" do
        put :update, { id: car.id, car: { make: nil, model: 'STI', year: '2004', price: '1000', engine: 2000, c_type: 'sedan' } }
        expect(flash[:error]).to eq('car failed to update!')
      end

    end
  end


  # SHOW
  describe "GET #show" do

    it "returns http success" do
      get :show, id: car.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, id: car.id
      expect(response).to render_template(:show)
    end

    it "set the car instance variable" do
      get :show, id: car.id
      expect(assigns(:car).make).to eq(car.make)
    end

  end


  # DESTROY
  describe "DELETE #destroy" do

    it "sets the car instance variable" do
      delete :destroy, id: car.id
      expect(assigns(:car)).to eq(car)
    end

    it "destroys the car" do
      car # this is the let car way above
      expect(Car.count).to eq(1)
      delete :destroy, id: car.id
      expect(Car.count).to eq(0)
    end

    it "sets the flash message" do
      delete :destroy, id: car.id
      expect(flash[:success]).to eq('Car Deleted!')
    end

    it "redirect to index path after destroy" do
      delete :destroy, id: car.id
      expect(response).to redirect_to(cars_path)
    end

  end


end
