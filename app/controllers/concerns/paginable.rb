module Paginable
  extend ActiveSupport::Concern

  def paginate(collection, page, per_page = 10)
    collection.page(page).per(per_page)
  end
end
