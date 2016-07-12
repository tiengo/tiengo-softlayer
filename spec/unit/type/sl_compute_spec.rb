sl_compute = Puppet::Type.type(:sl_compute)

describe sl_compute do
  let :params do
    [
      :name,
      :flavor_id,
      :provision_script,
      :key_pairs,
    ]
  end

  let :properties do
    [
      :ensure,
      :os_code,
      :datacenter,
      :domain,
      :public_ip_address,
      :private_ip_address,
      :cpu,
      :ram,
      :disk,
    ]
  end

  it 'should have expected properties' do
    properties.each do |property|
      expect(sl_compute.properties.map(&:name)).to be_include(property)
    end
  end

  it 'should have expected parameters' do
    params.each do |param|
      expect(sl_compute.parameters).to be_include(param)
    end
  end

  it 'should require a name' do
    expect {
      sl_compute.new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'should require an os_code' do
    expect {
      sl_compute.new({ :name => 'puppet', :os_code => '' })
    }.to raise_error(Puppet::Error, /Empty values are not allowed/)
  end

  it 'should require a domain' do
    expect {
      sl_compute.new({ :name => 'puppet', :domain => '' })
    }.to raise_error(Puppet::Error, /Empty values are not allowed/)
  end

  it 'should require a flavor_id' do
    expect {
      sl_compute.new({ :name => 'puppet', :flavor_id => '' })
    }.to raise_error(Puppet::Error, /Empty values are not allowed/)
  end

  it 'should require a datacenter' do
    expect {
      sl_compute.new({ :name => 'puppet', :datacenter => '' })
    }.to raise_error(Puppet::Error, /Empty values are not allowed/)
  end

  it 'key_pairs should be an array' do
    expect {
      sl_compute.new({ :name => 'puppet', :key_pairs => 'tiengo' })
    }.to raise_error(Puppet::Error, /key_pairs should be an Array/)
  end

end
