require 'fog/softlayer'

Puppet::Type.type(:sl_compute).provide :v1 do

  confine feature: :fog_softlayer

  mk_resource_methods

  def initialize(*args)
    @client = self.class.client
    super(*args)
  end

  def self.client
    Fog::Compute.new({ :provider => "softlayer",
                       :softlayer_username => ENV['SOFTLAYER_USERNAME'],
                       :softlayer_api_key => ENV['SOFTLAYER_API_KEY'], })
  end

  def self.instances
    client.servers.to_a.collect do |instance|
      new(sl_compute_to_hash(instance))
    end
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
  end

  def self.sl_compute_to_hash(sl_compute)
    opts = {
      name: sl_compute.name,
      flavor_id: sl_compute.flavor_id,
      os_code: sl_compute.os_code,
      datacenter: sl_compute.datacenter,
      domain: sl_compute.domain,
      key_pairs: sl_compute.key_pairs,
      public_ip_address: sl_compute.public_ip_address,
      private_ip_address: sl_compute.private_ip_address,
      cpu: sl_compute.cpu,
      ram: sl_compute.ram,
      ensure: :present,
    }
    opts
  end

  def exists?
    Puppet.info("Checking if compute instance #{resource[:name]} exists")
    @property_hash[:ensure] == :present
  end

  def create
    key_pairs = []
    resource[:key_pairs].map { |x| key_pairs << @client.key_pairs.by_label(x).id }
    fail "sl_compute require os_code parameter" unless resource[:os_code]
    fail "sl_compute require flavor_id parameter" unless resource[:flavor_id]
    fail "sl_compute require datacenter parameter" unless resource[:datacenter]
    fail "sl_compute require domain parameter" unless resource[:domain]
    response = @client.servers.create(
      name: name,
      flavor_id: resource[:flavor_id],
      os_code: resource[:os_code],
      datacenter: resource[:datacenter],
      domain: resource[:domain],
      provision_script: resource[:provision_script],
      key_pairs: key_pairs,
    )
    response.wait_for { ready? }
    if response.ready?
      Puppet.info("Created new instance called #{name}")
    else
      fail('Failed to create sl_compute instance.')
    end
  end

  def destroy
    Puppet.info("Destroying instance #{resource[:name]}")
    vm = @client.servers.find { |z| z.fqdn == "#{resource[:name]}.#{resource[:domain]}" && z.datacenter == resource[:datacenter] }
    if vm
      vm.destroy
      @property_hash[:ensure] = :absent
    end
  end
  private
end
