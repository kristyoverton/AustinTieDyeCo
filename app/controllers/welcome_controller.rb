class WelcomeController < ApplicationController
	layout "users"
  require 'EasyPost'

  EasyPost.api_key = 'aSjNYTfjMa08e7MFji6tCw'

  def index
    insta = Instagram.user_recent_media("420821382", {count:1})
    @instagram = insta[0].images
    @location = Location.new
    if signed_in? && admin?
      redirect_to admins_dash_path
    elsif signed_in?
      redirect_to users_dash_path
    end
  end

  def foundblanket
    @location = Location.new
  	@blanket = Blanket.new
    @contact_form = ContactForm.new
  end

def makeMailingLabel
  redirect_to generate_label(params)
end

  private
  def blanket_params
  	params.require(:blanket).permit(:id)
  end

  def generate_label(address)
    shipment = EasyPost::Shipment.create(
    {
      to_address: {
        name: 'Chief Blanket Reuniter',
        company: 'Austin Tie Dye Co',
        street1: '8222 N. Lamar Ste F60',
        city: 'Austin',
        state: 'TX',
        zip: '78753'
      },
      from_address: {
        name: address[:name],
        street1: address[:street1],
        street2: address[:street2],
        city: address[:city],
        state: address[:state],
        zip: address[:zip],
        phone: address[:phone]
      },
      parcel: {
        predefined_package: 'MediumFlatRateBox',
        weight: 10
      }
    }
    )
      shipment.buy(
        :rate => shipment.lowest_rate
        )

    return shipment.postage_label.label_url
  end
end
