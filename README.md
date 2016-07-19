#tiengo-softlayer

[![Puppet Forge](https://img.shields.io/puppetforge/v/tiengo/softlayer.svg)](https://forge.puppetlabs.com/tiengo/softlayer)
[![Build Status](https://travis-ci.org/tiengo/tiengo-softlayer.svg?branch=master)](https://travis-ci.org/tiengo/tiengo-softlayer)

##Table of Contents
1. [Overview](#overview)
2. [Description](#description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [TODO](#todo)

##Overview

Puppet module for managing SoftLayer resources to build out your cloud infrastructure.

##Description

This modules uses [fog-softlayer][https://github.com/fog/fog-softlayer],
and will help you to build your cloud infrastructure on Softlayer.

##Setup

```bash
gem install fog-softlayer  
export SOFTLAYER_USERNAME='SLXXXXXX'  
export SOFTLAYER_API_KEY='aa0aaa000aaa000'
```

##Usage

Creating a cloud instance:

```puppet
sl_compute { 'puppet.example.com':
  ensure           => present,
  os_code          => 'DEBIAN_7_64',
  flavor_id        => 'm1.tiny',
  datacenter       => 'wdc01',
  domain           => 'example.com',
  key_pairs        => [ 'key_name' ],
  provision_script => 'https://example.com/postinstall.sh',
}
```
##TODO

[] DNS  
[] Create a bare metal  
[] Global IP  
