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
   #  pp =Refinery::Projects::Project.find(params[:id])
   #  pp.case_current_money = pp.case_current_money + pp.case_price*(params[:quantity]).to_i
   #  pp.case_support_people_num = pp.case_support_people_num + 1
   #  pp.save
    
    session = GoogleSpreadsheet.login("jackmodo2012@gmail.com", "asdfggfdsa2012")
    @ws = session.spreadsheet_by_key("0AhrnVMnQbzuxdENaVENUaW9wOTAzTGd3SFR4Y2dKX2c").worksheets[0]
    row = @ws.num_rows + 1
    @ws[row, 1] = params[:name]
    @ws[row, 2] = params[:email]
    @ws[row, 3] = params[:phone]
    @ws[row, 4] = params[:address]
    @ws[row, 5] = params[:quantity]    
    @ws.save()
    
    
    name = params[:item_name]
    name = URI.encode(name)
    url = "https://www.paypal.com/cgi-bin/webscr?charset=utf-8&country=TW&business=jackmodo2012@gmail.com&item_name=#{name}&cmd=_xclick&currency_code=TWD&return=http://www.jackmodo.com/home&amount=#{params[:amount]}&notify_url=http://www.jackmodo.com/staticpages/create_payments&quantity=#{params[:quantity]}&invoice=#{params[:id]}"
    redirect_to url
   else
     redirect_to '/home'
   end
   
  end
  
  def create_payments
     
     if params[:payment_status]=="Completed" && !Payment.exists?(:trans_id=>params[:txn_id])
      change_goods_status
      Payment.create(:trans_id=>params[:txn_id])
     end     
 
     session = GoogleSpreadsheet.login("jackmodo2012@gmail.com", "asdfggfdsa2012")
     @ws = session.spreadsheet_by_key("0AhrnVMnQbzuxdDk4UmpSVHNvVTU4MFlrNy1yYzN4RVE").worksheets[0]
     row = @ws.num_rows + 1
     @ws[row, 1] = "#{params[:first_name]} #{params[:last_name]}"
     @ws[row, 2] = params[:payment_status]
     @ws[row, 3] = params[:txn_id]
     @ws[row, 4] = params[:payment_date]
     @ws[row, 5] = "#{params[:address_country]} #{params[:address_city]} #{params[:address_street]}"
     @ws[row, 6] = params[:payer_email]
     #@ws[row, 7] = params
     @ws.save()
  end
    
  
  def change_goods_status
    pp = Refinery::Projects::Project.find(params[:invoice])
    pp.case_current_money = pp.case_current_money + (params[:mc_gross]).to_i
    pp.case_support_people_num = pp.case_support_people_num + 1
    
    pp.save
  end

end
