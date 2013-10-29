-multichilds-nested-form-add-remove
===================================

I've multiple childs to be added and removed in certain nested-form.

0. Add these methods in ApplicationHelper

module ApplicationHelper

    def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
    end
  
    def link_to_remove_fields(name, f)
      f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
    end
end



2. Add these methods in .js file

  function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
  }
  
  function add_fields(link, association, content) {
    var new_id = new Date().getTime() + getRandomInt(1, 5000);
    var regexp = new RegExp("new_" + association, "g")
    // $(link).parent().before(content.replace(regexp, new_id));
  
    $(".all_nested_fields").append(content.replace(regexp, new_id));
  }
  
  //this method assures unique id of fields in add_fields_method
  function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
 

3. In Parent model -> dish.rb

  #assosiation for nested model
  has_many :dishes_icons
  # Must add "allow_destroy: true" in the line below to provide remove functionality
  accepts_nested_attributes_for :dishes_icons, allow_destroy: true

  # add :assosiation_attributes to attr_accessible to acces nested model attributes
  attr_accessible :name, :dishes_icons_attributes
  
  
4. In Nested model -> dishes_icon.rb

  belongs_to :dish
  belongs_to :icon
  attr_accessible :dish_id, :icon_id
  
5. In parent controller -> dishes_controller.rb


  def new
    @dish = Dish.find(params[:id])
    @dish = Dish.new
    @dish_icons = @dish.dishes_icons.build
  end

  def edit
    @dish = Dish.find(params[:id])
    @dish_icons = @dish.dishes_icons
    @dish_icons ||= @dish.dishes_icons.build
  end
  
  
  
6. In Parent view -> dishes/_form.html.erb  

  <!-- Multi Fields generation in nested form Start  -->
  <!-- Link to add Nested attributes -->
  <p><%= link_to_add_fields "Add Dish Icon", f, :dishes_icons %></p>
  <div class="dishes-icons">
    <!-- All nested fields Loop and partial,  the div below with class named "all_nested_fields" will be used in js method add_fields -->
    <div class="all_nested_fields" > 
      <%= f.fields_for :dishes_icons do |dishes_icon|%>
       <%= render "dishes_icon_fields", :f => dishes_icon, formats: [:html] %>
      <%end%>
    </div>
  </div>
  <!-- Multi Fields generation in nested form End  --> 


where dishes.icon_fields.html.erb -> nested attributes file contains attributes like below

  <div class="fields">
    <%= f.select :icon_id, Icon.all.collect {|icon| [icon.name, icon.id]} %>
    <%= link_to_remove_fields "remove", f %>
  </div>
 

 
  





 

