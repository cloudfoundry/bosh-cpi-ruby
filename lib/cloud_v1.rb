# Copyright (c) 2009-2012 VMware, Inc.

module Bosh; module Clouds; end; end

require "forwardable"

require "cloud/config"
require "cloud/errors"

module Bosh

  ##
  # CPI - Cloud Provider Interface, used for interfacing with various IaaS APIs.
  #
  # Key terms:
  # Stemcell: template used for creating VMs (shouldn't be powered on)
  # VM:       VM created from a stemcell with custom settings (networking and resources)
  # Disk:     volume that can be attached and detached from the VMs,
  #           never attached to more than a single VM at one time
  module CloudV1
    ## Information about cpi
    #
    # Sample info response:
    #  {
    #   "stemcell_formats" => ["aws-raw", "aws-light"],
    #   "api_version" => <highest supported version>,
    #  }
    #  @return [Hash] information about cpi, currently supported stemcell formats; CPI api_version this cpi supports
    def info
      not_implemented(:info)
    end

    ##
    # Get the vm_id of this host
    #
    # @return [String] opaque id later used by other methods of the CPI
    def current_vm_id
      not_implemented(:current_vm_id)
    end

    ##
    # Creates a stemcell
    #
    # @param [String] image_path path to an opaque blob containing the stemcell image
    # @param [Hash] cloud_properties properties required for creating this template
    #               specific to a CPI
    # @return [String] opaque id later used by {#create_vm} and {#delete_stemcell}
    def create_stemcell(image_path, cloud_properties)
      not_implemented(:create_stemcell)
    end

    ##
    # Deletes a stemcell
    #
    # @param [String] stemcell stemcell id that was once returned by {#create_stemcell}
    # @return [void]
    def delete_stemcell(stemcell_id)
      not_implemented(:delete_stemcell)
    end

    ##
    # Creates a VM - creates (and powers on) a VM from a stemcell with the proper resources
    # and on the specified network. When disk locality is present the VM will be placed near
    # the provided disk so it won't have to move when the disk is attached later.
    #
    # Sample networking config:
    #  {"network_a" =>
    #    {
    #      "netmask"          => "255.255.248.0",
    #      "ip"               => "172.30.41.40",
    #      "gateway"          => "172.30.40.1",
    #      "dns"              => ["172.30.22.153", "172.30.22.154"],
    #      "cloud_properties" => {"name" => "VLAN444"}
    #    }
    #  }
    #
    # Sample resource pool config (CPI specific):
    #  {
    #    "ram"  => 512,
    #    "disk" => 512,
    #    "cpu"  => 1
    #  }
    # or similar for EC2:
    #  {"name" => "m1.small"}
    #
    # @param [String] agent_id UUID for the agent that will be used later on by the director
    #                 to locate and talk to the agent
    # @param [String] stemcell_id stemcell id that was once returned by {#create_stemcell}
    # @param [Hash] resource_pool cloud specific properties describing the resources needed
    #               for this VM
    # @param [Hash] networks list of networks and their settings needed for this VM
    # @param [String, Array] disk_locality disk id(s) if known of the disk(s) that will be
    #                                    attached to this vm
    # @param [Hash] env environment that will be passed to this vm
    # @return [String] opaque id later used by {#attach_disk}, {#detach_disk} and {#delete_vm}
    def create_vm(agent_id, stemcell_id, resource_pool, networks, disk_locality, env)
      not_implemented(:create_vm)
    end

    ##
    # Deletes a VM. If the VM has already been deleted, this call returns normally and has no effect.
    #
    # @param [String] vm vm id that was once returned by {#create_vm}
    # @return [void]
    def delete_vm(vm_id)
      not_implemented(:delete_vm)
    end

    ##
    # Checks if a VM exists
    #
    # @param [String] vm vm id that was once returned by {#create_vm}
    # @return [Boolean] True if the vm exists
    def has_vm?(vm_id)
      not_implemented(:has_vm?)
    end

    ##
    # Checks if a disk exists
    #
    # @param [String] disk disk_id that was once returned by {#create_disk}
    # @return [Boolean] True if the disk exists
    def has_disk?(disk_id)
      not_implemented(:has_disk?)
    end

    ##
    # Reboots a VM
    #
    # @param [String] vm vm id that was once returned by {#create_vm}
    # @param [Optional, Hash] CPI specific options (e.g hard/soft reboot)
    # @return [void]
    def reboot_vm(vm_id)
      not_implemented(:reboot_vm)
    end

    ##
    # Set metadata for a VM
    #
    # Optional. Implement to provide more information for the IaaS.
    #
    # @param [String] vm vm id that was once returned by {#create_vm}
    # @param [Hash] metadata metadata key/value pairs
    # @return [void]
    def set_vm_metadata(vm, metadata)
      not_implemented(:set_vm_metadata)
    end

    ##
    # Set metadata for a disk
    #
    # Optional. Implement to provide more information for the IaaS.
    #
    # @param [String] disk_id disk id that was once returned by {#create_disk}
    # @param [Hash] metadata metadata key/value pairs
    # @return [void]
    def set_disk_metadata(disk_id, metadata)
      not_implemented(:set_disk_metadata)
    end

    ##
    # Creates a disk (possibly lazily) that will be attached later to a VM. When
    # VM locality is specified the disk will be placed near the VM so it won't have to move
    # when it's attached later.
    #
    # @param [Integer] size disk size in MB
    # @param [Hash] cloud_properties properties required for creating this disk
    #               specific to a CPI
    # @param [String] vm_locality vm id if known of the VM that this disk will
    #                           be attached to
    # @return [String] opaque id later used by {#attach_disk}, {#detach_disk}, and {#delete_disk}
    def create_disk(size, cloud_properties, vm_locality)
      not_implemented(:create_disk)
    end

    ##
    # Deletes a disk
    # Will raise an exception if the disk is attached to a VM
    #
    # @param [String] disk disk id that was once returned by {#create_disk}
    # @return [void]
    def delete_disk(disk_id)
      not_implemented(:delete_disk)
    end

    # Attaches a disk
    # @param [String] vm vm id that was once returned by {#create_vm}
    # @param [String] disk disk id that was once returned by {#create_disk}
    # @return [void]
    def attach_disk(vm_id, disk_id)
      not_implemented(:attach_disk)
    end

    # Take snapshot of disk
    # @param [String] disk_id disk id of the disk to take the snapshot of
    # @param [Hash] metadata metadata key/value pairs
    # @return [String] snapshot id
    def snapshot_disk(disk_id, metadata)
      not_implemented(:snapshot_disk)
    end

    # Delete a disk snapshot
    # @param [String] snapshot_id snapshot id to delete
    # @return [void]
    def delete_snapshot(snapshot_id)
      not_implemented(:delete_snapshot)
    end

    # Detaches a disk
    # @param [String] vm vm id that was once returned by {#create_vm}
    # @param [String] disk disk id that was once returned by {#create_disk}
    # @return [void]
    def detach_disk(vm_id, disk_id)
      not_implemented(:detach_disk)
    end

    # List the attached disks of the VM.
    # @param [String] vm_id is the CPI-standard vm_id (eg, returned from current_vm_id)
    # @return [array[String]] list of opaque disk_ids that can be used with the
    # other disk-related methods on the CPI
    def get_disks(vm_id)
      not_implemented(:get_disks)
    end

    ##
    # Resizes an existing disk
    #
    # @param [String] disk_id disk id
    # @param [Integer] new_size disk size in MiB
    # @return [void]
    def resize_disk(disk_id, new_size)
      not_implemented(:resize_disk)
    end

    ##
    # Updates an existing disk via the IaaS API
    #
    # @param [String] disk_id disk id
    # @param [Integer] new_size disk size in MiB
    # @param [Hash] cloud_properties properties required for updating this disk
    #               specific to a CPI
    # @return [void]
    def update_disk(disk_id, new_size, cloud_properties)
      not_implemented(:update_disk)
    end

    # Specify VM's hardware resources
    # @param [Hash] vm_properties (typically cpu, ram, ephemeral_disk_size)
    # @return [Hash] opaque description of the VM's configuration that
    # can be used with {#create_vm}
    def calculate_vm_cloud_properties(vm_properties)
      not_implemented(:calculate_vm_cloud_properties)
    end

    ##
    # Creates a network that will be used to place VMs on.
    #
    # @param [Hash] network_definition properties required for creating network.
    #               may contain range and gateway keys. Has to have cloud_properties - properties required for creating
    #               this network  specific to a CPI
    # @return [Hash] network_cid key has unique id of network, cloud_properties are properties required for placing VMs
    def create_network(network_definition)
      not_implemented(:create_network)
    end

    ##
    # Deletes network by given network_id
    # @param [String] network_id of network to delete
    # @return [void]
    def delete_network(network_id)
      not_implemented(:delete_network)
    end

    private

    def not_implemented(method)
      raise Bosh::Clouds::NotImplemented,
            "'#{method}' is not implemented by #{self.class}"
    end
  end
end
