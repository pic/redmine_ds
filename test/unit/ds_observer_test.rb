require File.join(File.dirname(__FILE__), '..', 'test_helper')

class DsObserverTest < ActiveSupport::TestCase

  #fixtures :issues, :custom_fields, :custom_values, :users

  def setup
    #@cccf = CustomField.new :name => 'Cc', :is_for_all => true, :field_format => 'text'
    #@cccf.save!
  end

  test 'split line' do
    o = DsObserver.instance
    assert_equal ['ciao bello'], o.split_line('ciao bello')

    assert_equal ['ciao bello, come', 
                  'te la passi oggi?'],
                  o.split('ciao bello, come te la passi oggi?', 12)

    assert_equal ['ciao bello, come',
                  'te la passi oggi?',
                  "Spero molto bene"],
                  o.split_line('ciao bello, come te la passi oggi? Spero molto bene', 12)

    assert_equal ['ciao bello, come',
                  'te la passi oggi?',
                  "Spero molto bene"],
                  o.split_line('ciao bello, come te la passi oggi? Spero molto bene', 12)
  end

  test 'split' do
    o = DsObserver.instance
    assert_equal ['ciao bello, come',
                  'te la passi oggi?',
                  'mah',
                  'potrebbe andare',
                  'meglio'],
                  o.split("ciao bello, come te la passi oggi?\nmah\npotrebbe andare meglio", 12)
    assert_equal ['ciao bello, come',
                  'te la passi oggi?',
                  'mah',
                  'potrebbe andare',
                  'meglio'],
                  o.split("ciao bello, come te la passi oggi?\r\nmah\r\npotrebbe andare meglio", 12)
  end


end
