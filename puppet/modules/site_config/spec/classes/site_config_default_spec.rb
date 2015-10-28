require 'spec_helper'

describe 'site_config::default' do
  let(:facts) do
    {
      :osfamily                  => 'Debian',
      :operatingsystem           => 'Debian',
      :operatingsystemmajrelease => '7',
      :lsbdistcodename           => 'wheezy',
      :concat_basedir            => '/var/lib/puppet/concat',
      :lsbmajdistrelease         => '7',
    }
  end

  it { should compile }
end

