---
config:
    plugin_type: test
subparsers:
    osp-jmeter:
        description:  Run Various Workloads on Openstack using JMeter tool
        include_groups: ["Ansible options", "Inventory", "Common options"]
        groups:
            - title: JMeter installation and Openstack Overcloud configuration
              options:
                  config-osp-jmeter:
                      type: Bool
                      help: |
                          Install JMeter and Plugins on Hypervisor machine
                      default: false
                  config-osp-cloud:
                      type: Bool
                      help: |
                          Create Images, Flavors and update Default Quotas in Openstack Overcloud
                      default: false
                  config-osp-monitor:
                      type: Bool
                      help: |
                          Install cAdvisor, Node-exporter and Blackbox containers on Openstack Overcloud nodes and instances. Install Prometheus and Grafana on Hypervisor machine.
                      default: false
            - title: General agruments for test execution
              options:
                  run-name:
                      type: Value
                      help: |
                          Name of results directory will be created during the test running.
                      default: osp-jmeter-test
                  build-num:
                      type: Value
                      help: |
                          Openstack Build or Puddle number.
                      default: osp-13
                  image-name:
                      type: Value
                      help: |
                          Openstack Overcloud image name for launching an Instance.
                          Allowed Values: cirros, rhel or centos 
                      default: cirros
                  flavor-ref:
                      type: Value
                      help: |
                          Openstack Overcloud Flavor Reff ID for launching an Instance.
                          Allowed Values: 1, 2, 3, 4, 5 and 6
                      default: 2
                  thread-count:
                      type: Value
                      help: |
                          Number of JMeter concurent threads.
                      default: 1
                  thread-rampup:
                      type: Value
                      help: |
                          Time required to start all JMeter threads (sec).
                      default: 100
                  iteration-count:
                      type: Value
                      help: |
                          Number of JMeter script's logical loop iterations.
                      default: 1
                  ssl-mode:
                      type: Bool
                      help: |
                          Specifies whether the Openstack Overcloud use SSL. 
                      default: false
                  perf-monitor:
                      type: Bool
                      help: |
                          Specifies whether the JMeter use PerfMon Plugin. 
                      default: false
                  cpu-workers:
                      type: Value
                      help: |
                          Spawn N workers spinning on sqrt().
                      default: 2
                  cpu-percent:
                      type: Value
                      help: |
                          Load CPU by percent: 0=sleep, 100=full load.
                      default: 50
                  vm-workers:
                      type: Value
                      help: |
                          Spawn N workers spinning on malloc()/free().
                      default: 2
                  vm-mbytes:
                      type: Value
                      help: |
                          Malloc B bytes per vm worker (default is 512 MB).
                      default: 512
                  hdd-workers:
                      type: Value
                      help: |
                          Spawn N workers spinning on write()/unlink().
                      default: 2
                  hdd-gbytes:
                      type: Value
                      help: |
                          Write B bytes per hdd worker (default is 2GB).
                      default: 2
                  stress-time-sec:
                      type: Value
                      help: |
                          Timeout after N seconds. Forever is 0.
                      default: 600
                  iperf-srv-host:
                      type: Value
                      help: |
                          IPERF server host IP
                      default: 127.0.0.1
                  iperf-srv-user:
                      type: Value
                      help: |
                          IPERF server user name
                      default: root
                  iperf-srv-pass:
                      type: Value
                      help: |
                          IPERF server password
                      default: qum5net
                  sys-action:
                      type: Value
                      help: |
                          Predefined name of Action to be executed during the Control and Data plane load.
                      choices:
                        - "none"
                        - "live-migrate-vm"
                        - "reboot-controller"
                      required_when: "run-system-test == True"
                  vm-amount:
                      type: Value
                      help: |
                          Number of Instances per Project when run Populate Clouod.
                      required_when: [ "populate-cloud == True", "remove-cloud == True" ]
                  baseline-run-name:
                      type: Value
                      help: |
                          Name of Previous (Baseline) Test run name.
                      required_when: [ "compare-restapi-performance-test == True", "compare-horizon-performance-test == True", "compare-stress-test == True" ]
                  current-run-name:
                      type: Value
                      help: |
                          Name of Current Test run name to be compared vs Baseline.
                      required_when: [ "compare-restapi-performance-test == True", "compare-horizon-performance-test == True", "compare-stress-test == True" ]
                  remote_server:
                      type: Value
                      help: |
                          server for store test results
                      default: 127.0.0.1
                  remote_dir:
                      type: Value
                      help: |
                          directory on server for store test results
                      default: /var/www/html/osp-jmeter/result/
            - title: REST API based tests
              options:
                  run-restapi-functional-test:
                      type: Bool
                      help: |
                          Run REST API Functional Test on Openstack Ovecloud
                      default: false
                  run-restapi-performance-test:
                      type: Bool
                      help: |
                          Run REST API Performance Test on Openstack Ovecloud
                      default: false
                  run-stress-test:
                      type: Bool
                      help: |
                          Run Stress Test on Openstack Ovecloud Instances using stress-ng and iperf3 tools
                      default: false
                  run-system-test:
                      type: Bool
                      help: |
                          Run System Test on Openstack Ovecloud: create Cloud, run Control and Data plane load
                          and excute an action such as - live-migrate-vm reboot-controller
                      default: false
                  populate-cloud:
                      type: Bool
                      help: |
                          Populate Cloud in Openstack Ovecloud where
                          thread-count - set number of Project in Cloud
                          vm-amount - set number of Instances per Project.
                      default: false
                  remove-cloud:
                      type: Bool
                      help: |
                          Clean up populate Cloud in Openstack Ovecloud.
                          thread-count - number of Project in Cloud
                          vm-amount - number of Instances per Project.
                      default: false
                  run-dataplane-load:
                      type: Bool
                      help: |
                          Async Start to run Data Plane load on existed Openstack Cloud
                          To stop need to execute stop-dataplane-load scenario.
                      default: false
                  stop-dataplane-load:
                      type: Bool
                      help: |
                          Stop to run Data Plane load on existed Openstack Cloud
                          started by run-dataplane-load scenario before.
                      default: false
                  run-ping-load:
                      type: Bool
                      help: |
                          Async Start to run Ping commands to instances on existed Openstack Cloud
                          To stop need to execute stop-ping-load scenario.
                      default: false
                  stop-ping-load:
                      type: Bool
                      help: |
                          Stop to run Ping commands to instances on existed Openstack Cloud
                          started by run-ping-load scenario before.
                      default: false
            - title: Horizon HTTP based tests
              options:
                  run-horizon-functional-test:
                      type: Bool
                      help: |
                          Run Horizon HTTP Functional Test on Openstack Ovecloud
                      default: false
                  run-horizon-performance-test:
                      type: Bool
                      help: |
                          Run Horizon HTTP Performance Test on Openstack Ovecloud
                      default: false
            - title: Comparison tests
              options:
                  compare-restapi-performance-test:
                      type: Bool
                      help: |
                          Compare 2 REST API Performance Tests.
                      default: false
                  compare-horizon-performance-test:
                      type: Bool
                      help: |
                          Compare 2 Horizon HTTP Performance Tests.
                      default: false
                  compare-stress-test:
                      type: Bool
                      help: |
                          Compare 2 Stress Tests.
                      default: false
