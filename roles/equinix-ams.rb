name "equinix-ams"
description "Role applied to all servers at Equinix Amsterdam"

default_attributes(
  :networking => {
    :roles => {
      :internal => {
        :inet => {
          :prefix => "20",
          :gateway => "10.0.48.10",
          :routes => {
            "10.0.0.0/8" => { :via => "10.0.48.10" }
          }
        }
      },
      :external => {
        :zone => "ams",
        :inet => {
          :prefix => "27",
          :gateway => "130.117.76.1"
        },
        :inet6 => {
          :prefix => "64",
          :gateway => "2001:978:2:2C::172:1",
          :routes => {
            "2001:470:1:b3b::/64" => { :type => "unreachable" },
            "2001:978:2:2c::/64" => { :type => "unreachable" },
            "2001:4860::/32" => { :type => "unreachable" },
            "2a00:1450:4000::/37" => { :type => "unreachable" }
          }
        }
      }
    }
  },
  :web => {
    :fileserver => "ironbelly",
    :readonly_database_host => "snap-01.ams.openstreetmap.org",
    :primary_cluster => true
  }
)

override_attributes(
  :networking => {
    :nameservers => ["10.0.48.10", "1.1.1.1", "1.0.0.1"],
    :search => ["ams.openstreetmap.org", "openstreetmap.org"]
  },
  :ntp => {
    :servers => ["0.nl.pool.ntp.org", "1.nl.pool.ntp.org", "europe.pool.ntp.org"]
  }
)

run_list(
  "role[nl]"
)
