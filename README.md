# osp-jmeter

"osp-jmeter" is the simple and fast way to run various workloads on Openstack delpoyment.
Basically, it a collection of Ansible playbooks, JMeter scripts and xsl templates which 
- generate workload on Openstack deployment using REST APIs calls or Web HTTP requests to Horizon Dashboard
- stress a Openstack instances in various selectable ways using stress-ng and iperf tools
- execute specific test cases under Control and Data plane load
- measure various response times and collect other statistcs during the tests
- generate informative reports 
- compare test results and generate comparison report

Supported environments:

Operating systems - RHEL 7.*, CentOS 7.*

Openstack: RHOS 10/11/12/13, Newton/Ocata/Pike/Queens 

Openstack security: SSL / no SSL

Installation:

"osp-jmeter" is currently installed via an ansible playbook. 
In a Tripleo environment it can be installed directly on the Undercloud or a separate machine. 
It is ready to use as InfraRed plugin and could be integrated with Jenkins also.

Requirements:

Hardware
    Undercloud Machine (Baremetal or Virtual Machine)

Networking
    Access to Public API endpoints
    Access to Keystone Admin Endpoint

Ansible
    Should be installed version >= 2.4
    
Install "osp-jmeter"
 
 - Standalone
 
[root@undercloud-0 ~]# cd /opt
[root@undercloud-0 opt]# git clone https://github.com/yobshans/osp-jmeter
[root@undercloud-0 opt]# cd osp-jmeter/
[root@undercloud-0 opt]# ansible-playbook -v config-osp-jmeter.yaml
[root@undercloud-0 opt]# ansible-playbook -v config-osp-cloud.yaml

- InfraRed plugin

[root@hypervisor ~]# cd /root/infrared/plugins/
[root@hypervisor plugins]# git clone https://github.com/yobshans/osp-jmeter
[root@hypervisor ~]virtualenv .venv && source .venv/bin/activate
(.venv) [root@hypervisor infrared]# ir plugin add /root/infrared/plugins/osp-jmeter
(.venv) [root@hypervisor infrared]# ir osp-jmeter --config-osp-jmeter yes
(.venv) [root@hypervisor infrared]# ir osp-jmeter --config-osp-cloud yes

Optional can be installed JMeter PerfMon Plugin agents on nodes which collect CPU/Memory/Networ/Disk utilization
and finally generate charts. To do this need provide argument when install osp-jmeter and later when run tests 
(Standalone -> -e perf_monitor=true, InfraRed -> --perf-monitor true).Default: false. 

Usage

Run REST API Sanity Functional Test 

JMeter send REST API calls to Openstack Public API endpoints.
This test simulate a flow when user creates project, user, network, volume, image, instance.
Perform various operations on an instance and remove all entities in the end of test.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-restapi-functional-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e image_name=rhel \
-e flavor_ref=2 \
-e ssl_mode=false

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-restapi-functional-test yes \
--run-name restapi-func-test \
--build-num osp-13-2018-04-24.1 \
--image-name rhel \
--flavor-ref 2

Run REST API Sanity Performance Tests

JMeter send REST API calls to Openstack Public API endpoints.
This test simulate a similar to Functional test flow, but with multi-threaded load in cycle manner.
To manage concurency need to set test parameters such as thread_count, thread_rampup, iteration_count.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-restapi-performance-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=10 \
-e thread_rampup=200 \
-e iteration_count=20 \
-e image_name=rhel \
-e flavor_ref=2 \
-e ssl_mode=false

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-restapi-performance-test yes \
--run-name restapi-perf-test \
--build-num osp-13-2018-04-19.2 \
--image-name rhel \
--flavor-ref 2 \
--thread-count 2 \
--iteration-count 2

Run HTTP Horizon Sanity Functional Tests

JMeter send web HTTP requests Openstack Horizon Dashboard.
This test simulate a flow when user creates project, user, network, volume, image, instance.
Perform various operations on an instance and remove all entities in the end of test.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-horizon-functional-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e image_name=rhel \
-e flavor_ref=2 \
-e ssl_mode=false

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-horizon-functional-test yes \
--run-name http-func-test \
--build-num osp-13-2018-04-19.2 \
--image-name rhel \
--flavor-ref 2

Run HTTP Horizon Sanity Performance Tests

JMeter send web HTTP requests Openstack Horizon Dashboard.
This test simulate a similar to Functional test flow, but with multi-threaded load in cycle manner.
To manage concurency need to set test parameters such as thread_count, thread_rampup, iteration_count.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-horizon-performance-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=10 \
-e thread_rampup=200 \
-e iteration_count=20 \
-e image_name=rhel \
-e flavor_ref=2 \
-e ssl_mode=false

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-horizon-performance-test yes \
--run-name restapi-perf-test \
--build-num osp-13-2018-04-19.2 \
--image-name rhel \
--flavor-ref 2 \
--thread-count 2 \
--iteration-count 2

Run Stress Test on instances

JMeter send REST API calls to Openstack Public API endpoints.
This test create instances, install stress-ng and iperf tools on them 
and start stress test which can be set by using parameters such as
cpu_workers, cpu_percent, vm_workers, vm_mbytes, hdd_workers, hdd_gbytes, stress_time_sec.
Test remove all tenties in the end of test.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-stress-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=10 \
-e thread_rampup=200 \
-e image_name=rhel \
-e flavor_ref=2 \
-e iperf_host=10.0.0.1 \
-e cpu_workers=2 \
-e cpu_percent=50 \
-e vm_workers=2 \
-e vm_mbytes=512 \
-e hdd_workers=2 \
-e hdd_gbytes=2 \
-e stress_time_sec=3000 \
-e ssl_mode=false

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-stress-test yes \
--run-name stress-test \
--iperf-srv-host 10.0.0.1 \
--build-num osp-13-2018-04-24.1 \
--image-name rhel \
--flavor-ref 2 \
--thread-count 2 \
--cpu-workers 2 \
--cpu-percent 50 \
--vm-workers 2 \
--vm-mbytes 512 \
--hdd-workers 2 \
--hdd-gbytes 2 \
--stress-time-sec 600 \
--ssl-mode false

Run System Test 

JMeter send REST API calls to Openstack Public API endpoints.
This test create instances, simulate Control and Data plane load
and execute specific test case (none, live-migrate-vm, reboot-controller, etc)
Test remove all tenties in the end of test.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-system-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e sys_action=live-migrate-vm \
-e thread_count=1 \
-e thread_rampup=200 \
-e image_name=rhel \
-e flavor_ref=2 \
-e hdd_workers=2 \
-e hdd_gbytes=2 \
-e stress_time_sec=3000 \
-e ssl_mode=false

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-system-test yes \
--run-name stress-test \
--iperf-srv-host 10.0.0.1 \
--build-num osp-13-2018-04-24.1 \
--sys-action live-migrate-vm \
--image-name rhel \
--flavor-ref 2 \
--thread-count 2 \
--hdd-workers 2 \
--hdd-gbytes 2 \
--stress-time-sec 3000 \
--ssl-mode false

Populate Cloud in Openstack deployment

JMeter generate Cloud in Openstack deployment. It creates Projects, Users, Netwroks, Routers, Instances with FIP which is accessible from hypervisor server. To set the number of Projects use argument thread_count/thread-count and the number of Instances per Project use argument vm_amount/vm-amount.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v populate-cloud.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=2 \
-e vm_amount=2 \
-e image_name=rhel \
-e flavor_ref=2 \
-e ssl_mode=false

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--populate-cloud yes \
--run-name populate-cloud \
--build-num osp-13-2018-04-24.1 \
--thread-count 2 \
--vm-amount 2 \
--image-name rhel

Run Ping Load Test 

JMeter perform on existed Cloud environment Ping operations to instances in loop and generate finally report with Ping operation statistics. It contains 2 scripts where first will start Ping load test and second will stop running Ping load test and generate report. Both test run commands must to have identical test_run_name/test-run-name, thread_count/thread-count and vm_amount/vm-amount arguments.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-ping-load.yaml \
-e test_run_name=ping-test-1 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=2 \
-e vm_amount=2 

[root@undercloud-0 opt]# ansible-playbook \
-v stop-ping-load.yaml \
-e test_run_name=ping-test-1 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=2 \
-e vm_amount=2 

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-ping-load yes \
--run-name ping-test-2 \
--build-num osp-13-2018-04-24.1 \
--thread-count 2 \
--vm-amount 1

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--stop-ping-load yes \
--run-name ping-test-2 \
--build-num osp-13-2018-04-24.1 \
--thread-count 2 \
--vm-amount 1

Run Data Plane Load Test 

JMeter perform on existed Cloud environment Data Plane load test by runnning stress-ng and iperf tools on Instances. It could be run sync and async by setting an argument stress_time_sec/stress-time-sec to any desired number of seconds or to 0 to run forever. In case async test running (stress_time_sec/stress-time-sec=0) should run second test which will stop Data Plane Load test and both test run commands must to have identical test_run_name/test-run-name, thread_count/thread-count and vm_amount/vm-amount arguments.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v run-dataplane-load.yaml \
-e test_run_name=load-test-1 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=2 \
-e vm_amount=2 
-e iperf_host=10.0.0.1 \
-e cpu_workers=2 \
-e cpu_percent=50 \
-e vm_workers=2 \
-e vm_mbytes=512 \
-e hdd_workers=2 \
-e hdd_gbytes=2 \
-e stress_time_sec=3000 \
-e ssl_mode=false

(if stress_time_sec=0 -> run this)

[root@undercloud-0 opt]# ansible-playbook \
-v stop-dataplane-load.yaml \
-e test_run_name=load-test-1 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e iperf_host=10.0.0.1 \
-e thread_count=2 \
-e vm_amount=2 

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--run-dataplane-load yes \
--run-name load-test \
--iperf-srv-host 10.0.0.1 \
--build-num osp-13-2018-04-24.1 \
--perf-monitor true \
--thread-count 2 \
--vm-amount 1 \
--cpu-workers 2 \
--cpu-percent 50 \
--vm-workers 2 \
--vm-mbytes 512 \
--hdd-workers 2 \
--hdd-gbytes 2 \
--stress-time-sec 600

(if stress-time-sec 0 -> run this)

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--stop-dataplane-load yes \
--run-name load-test \
--iperf-srv-host 10.0.0.1 \
--build-num osp-13-2018-04-24.1 \
--perf-monitor true \
--thread-count 2 \
--vm-amount 1

Delete Cloud in Openstack deployment

JMeter remove Cloud in Openstack deployment populated early by using above script. You have to provide the same number of Projects and Instances per Project as did it when populates Cloud.

- Standalone 

[root@undercloud-0 opt]# ansible-playbook \
-v remove-cloud.yaml \
-e thread_count=2 \
-e vm_amount=2 

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--remove-cloud yes \
--thread-count 2 \
--vm-amount 1 

Compare REST API Performance Tests

The playbook compares 2 REST API Performance tests results
and generate comparison report.

[root@undercloud-0 opt]# ansible-playbook \
-v compare-restapi-performance-test.yaml \
-e test_run_name=test1 \
-e baseline_run_name=test2 \
-e current_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--compare-restapi-performance-test trtue \
--run-name compare-test \
--baseline-run-name test1 \
--current-run-name test2 \
--build-num osp-13-2018-04-24.1 

Compare HTTP Horizon Performance Tests

The playbook compares 2 HTTP Horizon Performance tests results
and generate comparison report.

[root@undercloud-0 opt]# ansible-playbook \
-v compare-horizon-performance-test.yaml \
-e test_run_name=test1 \
-e baseline_run_name=test2 \
-e current_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--compare-horizon-performance-test trtue \
--run-name compare-test \
--baseline-run-name test1 \
--current-run-name test2 \
--build-num osp-13-2018-04-24.1 

Compare Stress Tests

The playbook compares 2 Stress tests results
and generate comparison report.

[root@undercloud-0 opt]# ansible-playbook \
-v compare-stress-test.yaml \
-e test_run_name=test2 \
-e baseline_run_name=test1 \
-e current_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 

- InfraRed plugin

(.venv) [root@hypervisor infrared]# ir osp-jmeter \
--compare-stress-test trtue \
--run-name compare-test \
--baseline-run-name test1 \
--current-run-name test2 \
--build-num osp-13-2018-04-24.1 

Test results will be created under directory: 

/opt/osp-jmeter/results/{{test_run_name}}

HTML report: /opt/osp-jmeter/results/{{test_run_name}}/index.html

Plain test report: /opt/osp-jmeter/results/{{test_run_name}}/log/report.txt

CSV REST API report: /opt/osp-jmeter/results/{{test_run_name}}/log/report-restapi.csv

CSV Transaction report: /opt/osp-jmeter/results/{{test_run_name}}/log/report-trx.csv

JMeter Test Result Dashboard: /opt/osp-jmeter/results/{{test_run_name}}/dashboard/index.html 
