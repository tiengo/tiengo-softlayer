require 'puppet/parameter/boolean'

Puppet::Type.newtype(:sl_compute) do
  @doc = 'Type representing a Softlayer compute instance.'

  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of the instance.'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:os_code) do
    desc 'The image id to use for the instance.'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newparam(:flavor_id) do
    desc 'The size of the instance compute.'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:datacenter) do
    desc 'The datacenter in which to launch the instance.'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newparam(:provision_script) do
    desc 'URL contain a script to execute after the installation is completed.'
  end

  newproperty(:domain) do
    desc 'The domain to set for the instance.'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:public_ip_address) do
    desc 'The instance public ip address.'
  end

  newproperty(:private_ip_address) do
    desc 'The instance private ip address.'
  end

  newproperty(:cpu) do
    desc 'Specify the CPU unit quantity for the instance.'
  end

  newproperty(:ram) do
    desc 'Specify the RAM quantity for the instance.'
  end

  newproperty(:disk) do
    desc 'Specify the disk size for the instance.'
  end

  newparam(:key_pairs, :array_matching => :all) do
    defaultto []
    desc 'Specify the SSH Keys names allowed to access the compute instance.'
    munge do |value|
      [*value]
    end
  end
end
