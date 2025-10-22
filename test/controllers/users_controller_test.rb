require "test_helper"

class UsersControllerTest < ActionController::TestCase
  context "#index" do 
    should "render the correct template" do 
      create(:customer)

      get :index 

      assert_template :index
    end
  end

  context "#list" do 
    should "render the correct template" do 
      create(:customer)

      get :list

      assert_template :list
    end

    should "assign customers" do 
      create(:customer)

      get :list 

      assert assigns(:customers)
    end
  end
  
  context "#show" do 
    should "render the correct template" do 
      customer = create(:customer)
      
      get :show, params: { id: customer.id, view: "customer" }
      assert_template :show
    end
  end

  context "#customer" do
    should "render the correct template" do
      customer = create(:customer)

      get :customer

      assert_template :customer
    end
  end
end
