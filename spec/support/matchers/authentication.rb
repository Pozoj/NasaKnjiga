module Authentication
 def self.included(base)
   base.extend(ClassMethods)
 end

 module ClassMethods
   def it_should_require_admin_for_actions(*actions)
     actions.each do |action|
       it "#{action} action should require admin" do
         get action, :id => 1
         response.should redirect_to(new_session_url)
         flash[:error].should == "Prosimo prijavite se s svojim administratorskim računom."
       end
     end
   end
   
   def it_should_require_editor_for_actions(*actions)
     actions.each do |action|
       it "#{action} action should require admin" do
         get action, :id => 1
         response.should redirect_to(new_session_url)
         flash[:error].should == "Prosimo prijavite se s svojim uredniškim računom."
       end
     end
   end
   
   def it_should_require_reviewer_for_actions(*actions)
     actions.each do |action|
       it "#{action} action should require admin" do
         get action, :id => 1
         response.should redirect_to(new_session_url)
         flash[:error].should == "Prosimo prijavite se s svojim lektorskim računom."
       end
     end
   end
   
   def it_should_not_require_login_for_actions(*actions)
      actions.each do |action|
        it "#{action} action should not require login" do
          begin
            get action, :id => 1
            response.should_not redirect_to(new_session_url)
            flash.should be_empty
          rescue ActiveRecord::RecordNotFound
          end
        end
      end
    end
 end

 def login_as_admin
   user_kind = UserKind.new(:name => "Admin", :kind => "admin")
   user = User.new(:name => "admin", :surname => "administrator", :email => "admin@example.com", :password => "secret", :kind => user_kind)
   user.save!
   session[:user] = user.id
 end
end
