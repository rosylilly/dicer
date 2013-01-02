require File.expand_path('../entity', __FILE__)
require File.expand_path('../cleaner', __FILE__)

class CleaningContext < Dicer::Context
  describe Entity do
    it_behaves_like Cleaner
  end
end
