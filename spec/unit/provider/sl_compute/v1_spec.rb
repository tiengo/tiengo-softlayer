require 'spec_helper'

provider_class = Puppet::Type.type(:sl_compute).provider(:v1)

ENV['SOFTLAYER_USERNAME'] = 'SLXXXXXX'
ENV['SOFTLAYER_API_KEY'] = 'aa0aaa000aaa000'

describe provider_class do
  context 'with the minimum params' do
    before(:all) do
      @resource = Puppet::Type.type(:sl_compute).new(
        name: 'puppet0',
        os_code: 'DEBIAN_7_64',
        flavor_id: 'm1.tiny',
        datacenter: 'wdc01',
        domain: 'example.com'
      )
      @provider = provider_class.new(@resource)
    end

    it 'should be an instance of the ProviderV1' do
      expect(@provider).to be_an_instance_of Puppet::Type::Sl_compute::ProviderV1
    end

    it 'should expose key_pairs as []' do
      expect(@resource['key_pairs']).to eq []
    end
  end
end
