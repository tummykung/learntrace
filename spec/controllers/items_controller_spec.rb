require 'spec_helper'

describe ItemsController do

  login_user

  def valid_attributes
    { 
      :name => "How to play starcraft 2",
      :description => "Pros only",
      :url => "http://www.youtube.com/watch?v=vzjC3rbzQVc"
    }
  end

  describe "GET index" do
    it "assigns all items as @items" do
      item = Item.create! valid_attributes
      get :index, {}
      assigns(:items).should eq([item])
    end
  end

  describe "GET show" do
    it "assigns the requested item as @item" do
      item = Item.create! valid_attributes
      get :show, {:id => item.to_param}
      assigns(:item).should eq(item)
    end
  end

  describe "GET new" do
    it "assigns a new item as @item" do
      get :new, {}
      assigns(:item).should be_a_new(Item)
    end
  end

  describe "GET edit" do
    it "assigns the requested item as @item" do
      item = Item.create! valid_attributes
      get :edit, {:id => item.to_param}
      assigns(:item).should eq(item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {:item => valid_attributes}
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {:item => valid_attributes}
        assigns(:item).should be_a(Item)
        assigns(:item).should be_persisted
      end

      it "redirects to the created item" do
        post :create, {:item => valid_attributes}
        response.should redirect_to(Item.last)
      end

      it "pins the created item to the current user" do
        post :create, {:item => valid_attributes}
        subject.current_user.pins.should_not be_empty
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item as @item" do
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        post :create, {:item => {}}
        assigns(:item).should be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        post :create, {:item => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item" do
        item = Item.create! valid_attributes
        # Assuming there are no other items in the database, this
        # specifies that the Item created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Item.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => item.to_param, :item => {'these' => 'params'}}
      end

      it "assigns the requested item as @item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => valid_attributes}
        assigns(:item).should eq(item)
      end

      it "redirects to the item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => valid_attributes}
        response.should redirect_to(item)
      end
    end

    describe "with invalid params" do
      it "assigns the item as @item" do
        item = Item.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        put :update, {:id => item.to_param, :item => {}}
        assigns(:item).should eq(item)
      end

      it "re-renders the 'edit' template" do
        item = Item.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        put :update, {:id => item.to_param, :item => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete :destroy, {:id => item.to_param}
      response.should redirect_to(items_url)
    end
  end

end