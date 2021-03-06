require_relative '../spec_helper'

describe 'homebrew::cask' do
  context 'default user' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.10').converge(described_recipe)
    end

    before(:each) do
      allow_any_instance_of(Chef::Resource).to receive(:homebrew_owner).and_return('vagrant')
    end

    it 'manages the Cask Cache directory' do
      allow(Dir).to receive(:exist?).with('/Library/Caches/Homebrew').and_return(true)
      expect(chef_run).to create_directory('/Library/Caches/Homebrew/Casks').with(
        user: 'vagrant',
        mode: 00775
      )
    end
  end
end
