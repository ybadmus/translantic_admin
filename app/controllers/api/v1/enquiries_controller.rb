class EnquiriesController < ApiController
   # POST : /api/v1/{enquiries}
   def create
    enquiry = Enquiry.new(enquiry_params)
    if enquiry.save
      render_success('success', enquiry, EnquirySerializer)
    else
      render_error(enquiry.errors.full_messages)
    end
  end


  private

  def enquiry_params
    params.permit(:name, :email, :subject, :message)
  end
end
