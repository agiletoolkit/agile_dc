require "#{File.dirname(__FILE__)}/../../vendor/plugins/moonshine/lib/moonshine.rb"
class ApplicationManifest < Moonshine::Manifest::Rails
  # The majority of your configuration should be in <tt>config/moonshine.yml</tt>
  # If necessary, you may provide extra configuration directly in this class 
  # using the configure method. The hash passed to the configure method is deep 
  # merged with what is in <tt>config/moonshine.yml</tt>. This could be used, 
  # for example, to store passwords and/or private keys outside of your SCM, or 
  # to query a web service for configuration data.
  #
  # In the example below, the value configuration[:custom][:random] can be used in 
  # your moonshine settings or templates.
  #
  # require 'net/http'
  # require 'json'
  # random = JSON::load(Net::HTTP.get(URI.parse('http://twitter.com/statuses/public_timeline.json'))).last['id']
  # configure({
  #   :custom => { :random => random  }
  # })

  # The default_stack recipe install Rails, Apache, Passenger, the database from 
  # database.yml, Postfix, Cron, logrotate and NTP. See lib/moonshine/manifest/rails.rb
  # for details. To customize, remove this recipe and specify the components you want.
  recipe :default_stack

  # Add your application's custom requirements here
  def application_packages
    # If you've already told Moonshine about a package required by a gem with
    # :apt_gems in <tt>moonshine.yml</tt> you do not need to include it here.
    # package 'some_native_package', :ensure => :installed
    
    # some_rake_task = "/usr/bin/rake -f #{configuration[:deploy_to]}/current/Rakefile custom:task RAILS_ENV=#{ENV['RAILS_ENV']}"
    # cron 'custom:task', :command => some_rake_task, :user => configuration[:user], :minute => 0, :hour => 0
    
    # %w( root rails ).each do |user|
    #   mailalias user, :recipient => 'you@domain.com'
    # end
    
    # farm_config = <<-CONFIG
    #   MOOCOWS = 3
    #   HORSIES = 10
    # CONFIG
    # file '/etc/farm.conf', :ensure => :present, :content => farm_config
    
    # Logs for Rails, MySQL, and Apache are rotated by default
    # logrotate '/var/log/some_service.log', :options => %w(weekly missingok compress), :postrotate => '/etc/init.d/some_service restart'
    
    # Only run the following on the 'testing' stage using capistrano-ext's multistage functionality.
    # on_stage 'testing' do
    #   file '/etc/motd', :ensure => :file, :content => "Welcome to the TEST server!"
    # end
  end
  configure(
        :wordpress => {
          :domain          => 'blog.agiledc.org',
          :auth_key        => ':mmq+&JiiLnz3|v`#B%dGy{.JN:w.Q&);.1wkrs,*nn!cWDWvabFk_zMpXpKcT f',
          :secure_auth_key => ')x+YL+p,&mFDtj1-,S9oc2Iw;;$A=>S3%Ho~3 :^~^K7(}{?U8[C|RGsi. EG?~@',
          :logged_in_key   => '~}quWs+Mn7YL[pjxhb-)P,a[VvS,Lu4bMtW1`CvG,U/`D6O=PZ.d_zD 8|NQl7h{',
          :nonce_key       => 'gkZ?}N{QT@XU59MvyJyS_E/W6$^^A-TFWV:rM|Hl)P|*9?AYoT<(0j_0kx!&]7a-',
          :db => {:password => ''}
        }
      )
  # The following line includes the 'application_packages' recipe defined above
  recipe :application_packages
  plugin :wordpress
  recipe :wordpress
end