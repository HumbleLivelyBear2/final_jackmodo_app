# coding: utf-8

class StaticpagesController < ApplicationController

  require "rubygems"
  require 'nokogiri'
  require "google_spreadsheet"

  def contact
  end

  def service
  end

  def privacy
  end

  def whybuy
  end

  def launch
  end

  def about
  end

  def howlaunch
  end

  def howbuy
  end
  
  def home
    if !Refinery::Projects::Project.all.empty?
      @projects = Refinery::Projects::Project.all
    end
  end
  
  def create_lauch_data
    session = GoogleSpreadsheet.login("jackmodo2012@gmail.com", "asdfggfdsa2012")
    @ws = session.spreadsheet_by_key("0AhrnVMnQbzuxdHNVVTVuVjd2bEhtbVpDM1lDU0Z2dHc").worksheets[0]
    row = @ws.num_rows + 1
    @ws[row, 1] = params[:comment1]
    @ws[row, 2] = params[:comment2]
    @ws[row, 3] = params[:howkonw]
    @ws[row, 4] = params[:money]
    @ws.save()
    redirect_to '/' 
  end
  
  def creat_contact_data
    session = GoogleSpreadsheet.login("jackmodo2012@gmail.com", "asdfggfdsa2012")
    @ws = session.spreadsheet_by_key("0AhrnVMnQbzuxdHBMd3dIcXZyNDZmdldHanVMVDZRaUE").worksheets[0]
    row = @ws.num_rows + 1
    @ws[row, 1] = params[:name]
    @ws[row, 2] = params[:email]
    @ws[row, 3] = params[:comment]
    @ws.save()
    redirect_to '/'
  end
  
  def redirect_to_paypal
    
    if params[:name] != ''
    pp =Refinery::Projects::Project.find(params[:id])
    pp.case_current_money = pp.case_current_money + pp.case_price*(params[:id]).to_i
    pp.case_support_people_num = pp.case_support_people_num +1
    pp.save
    
    session = GoogleSpreadsheet.login("jackmodo2012@gmail.com", "asdfggfdsa2012")
    @ws = session.spreadsheet_by_key("0AhrnVMnQbzuxdENaVENUaW9wOTAzTGd3SFR4Y2dKX2c").worksheets[0]
    row = @ws.num_rows + 1
    @ws[row, 1] = params[:name]
    @ws[row, 2] = params[:email]
    @ws[row, 3] = params[:phone]
    @ws[row, 4] = params[:quantity]
    @ws.save()
    
    
    name = params[:item_name]
    name = URI.encode(name)
    url = "https://www.paypal.com/cgi-bin/webscr?charset=utf-8&country=TW&business=jackmodo2012@gmail.com&item_name=#{name}&cmd=_xclick&currency_code=TWD&return=http://www.jackmodo.com&amount=#{params[:amount]}&notify_url=http://localhost:3000/payments&quantity=#{params[:quantity]}"
    redirect_to url
   else
     redirect_to '/home'
   end
   
  end
    
  
end
