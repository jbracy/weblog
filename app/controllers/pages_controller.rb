class PagesController < ApplicationController
  skip_before_filter :authorize  
end