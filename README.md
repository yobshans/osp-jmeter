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
It could be integrated with Jenkins with small customizations also.

Requirements:

Hardware
    Undercloud Machine (Baremetal or Virtual Machine)

Networking
    Access to Public API endpoints
    Access to Keystone Admin Endpoint

Ansible
    Should be installed version >= 2.4
    
Install "osp-jmeter"

[root@undercloud-0 ~]# cd /opt
[root@undercloud-0 opt]# git clone https://github.com/yobshans/osp-jmeter
[root@undercloud-0 opt]# cd osp-jmeter/
[root@undercloud-0 opt]# ansible-playbook -v install-jmeter-4.0.yaml
[root@undercloud-0 opt]# ansible-playbook -v config-openstack.yaml -e uc_node=10.0.0.44

(Optional) Install JMeter PerfMon Plugin 
It's useful when there is not any monitoring tools.

[root@undercloud-0 opt]# ansible-playbook -v install-jmeter-perfmon-agents.yaml -e uc_node=10.0.0.44

Usage

Run REST API Sanity Functional Test 

JMeter send REST API calls to Openstack Public API endpoints.
This test simulate a flow when user creates project, user, network, volume, image, instance.
Perform various operations on an instance and remove all entities in the end of test.

[root@undercloud-0 opt]# ansible-playbook \
-v run-restapi-functional-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e uc_node=10.0.0.44 \
-e image_name=rhel \
-e flavor_ref=2 \
-e ssl_mode=false

Run REST API Sanity Performance Tests

JMeter send REST API calls to Openstack Public API endpoints.
This test simulate a similar to Functional test flow, but with multi-threaded load in cycle manner.
To manage concurency need to set test parameters such as thread_count, thread_rampup, iteration_count.

[root@undercloud-0 opt]# ansible-playbook \
-v run-restapi-performance-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=10 \
-e thread_rampup=200 \
-e iteration_count=20 \
-e uc_node=10.0.0.44 \
-e image_name=rhel \
-e flavor_ref=2 \
-e perf_monitor=false \
-e ssl_mode=false

Run HTTP Horizon Sanity Functional Tests

JMeter send web HTTP requests Openstack Horizon Dashboard.
This test simulate a flow when user creates project, user, network, volume, image, instance.
Perform various operations on an instance and remove all entities in the end of test.

[root@undercloud-0 opt]# ansible-playbook \
-v run-horizon-functional-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e uc_node=10.0.0.44 \
-e image_name=rhel \
-e flavor_ref=2 \
-e ssl_mode=false

Run HTTP Horizon Sanity Performance Tests

JMeter send web HTTP requests Openstack Horizon Dashboard.
This test simulate a similar to Functional test flow, but with multi-threaded load in cycle manner.
To manage concurency need to set test parameters such as thread_count, thread_rampup, iteration_count.

[root@undercloud-0 opt]# ansible-playbook \
-v run-horizon-performance-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=10 \
-e thread_rampup=200 \
-e iteration_count=20 \
-e uc_node=10.0.0.44 \
-e image_name=rhel \
-e flavor_ref=2 \
-e perf_monitor=false \
-e ssl_mode=false

Run Stress Test on instances
JMeter send REST API calls to Openstack Public API endpoints.
This test create instances, install stress-ng and iperf tools on them 
and start stress test which can be set by using parameters such as
cpu_workers, cpu_percent, vm_workers, vm_mbytes, hdd_workers, hdd_gbytes, stress_time_sec.
Test remove all tenties in the end of test.

[root@undercloud-0 opt]# ansible-playbook \
-v run-stress-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e thread_count=10 \
-e thread_rampup=200 \
-e uc_node=10.0.0.44 \
-e image_name=rhel \
-e flavor_ref=2 \
-e cpu_workers=2 \
-e cpu_percent=50 \
-e vm_workers=2 \
-e vm_mbytes=512 \
-e hdd_workers=2 \
-e hdd_gbytes=2 \
-e stress_time_sec=3000 \
-e perf_monitor=false \
-e ssl_mode=false

Run System Test 
JMeter send REST API calls to Openstack Public API endpoints.
This test create instances, simulate Control and Data plane load
and execute specific test case (none, live-migrate-vm, reboot-controller, etc)
Test remove all tenties in the end of test.

[root@undercloud-0 opt]# ansible-playbook \
-v run-system-test.yaml \
-e test_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e sys_action=live-migrate-vm \
-e thread_count=1 \
-e thread_rampup=200 \
-e uc_node=10.0.0.44 \
-e image_name=rhel \
-e flavor_ref=2 \
-e hdd_workers=2 \
-e hdd_gbytes=2 \
-e stress_time_sec=3000 \
-e perf_monitor=false \
-e ssl_mode=false

Compare REST API Performance Tests

The playbook compares 2 REST API Performance tests results
and generate comparison report.

[root@undercloud-0 opt]# ansible-playbook \
-v compare-restapi-performance-test.yaml \
-e test_run_name=test1 \
-e baseline_run_name=test2 \
-e current_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e perf_monitor=false

Compare HTTP Horizon Performance Tests

The playbook compares 2 HTTP Horizon Performance tests results
and generate comparison report.

[root@undercloud-0 opt]# ansible-playbook \
-v compare-horizon-performance-test.yaml \
-e test_run_name=test1 \
-e baseline_run_name=test2 \
-e current_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e perf_monitor=false

Compare Stress Tests

The playbook compares 2 Stress tests results
and generate comparison report.

[root@undercloud-0 opt]# ansible-playbook \
-v compare-stress-test.yaml \
-e test_run_name=test2 \
-e baseline_run_name=test1 \
-e current_run_name=test2 \
-e build_num=rhos-12-p-2018-01-26.2 \
-e perf_monitor=false

Test results 

Will be created under directory: 
/opt/osp-jmeter/results/{{test_run_name}}

HTML report: /opt/osp-jmeter/results/{{test_run_name}}/index.html
Plain test report: /opt/osp-jmeter/results/{{test_run_name}}/log/report.txt
CSV REST API report: /opt/osp-jmeter/results/{{test_run_name}}/log/report-restapi.csv
CSV Transaction report: /opt/osp-jmeter/results/{{test_run_name}}/log/report-trx.csv
JMeter Test Result Dashboard: /opt/osp-jmeter/results/{{test_run_name}}/dashboard/index.html 

# osp-jmeter
