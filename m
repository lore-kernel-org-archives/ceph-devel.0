From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: Teuthology error 'exception on parallel execution'
Date: Wed, 3 Jun 2015 07:38:04 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489EE05D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:15140 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbbFCHi3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 03:38:29 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

Several teuthology jobs fail with the error 'exception on parallel execution' in my testing. I don't see any failures/errors/assertions in the mon/osd logs. And these failed jobs always have 'sentry event' log. However, I'm not able to open the sentry link.

Here is an example:
http://pulpito.ceph.com/yuan-2015-06-02_20:18:44-rados-wip-proxy-write---basic-multi/918584/
Log: http://qa-proxy.ceph.com/teuthology/yuan-2015-06-02_20:18:44-rados-wip-proxy-write---basic-multi/918584/teuthology.log
Sentry event: http://sentry.ceph.com/sepia/teuthology/search?q=38a00a22270748e79e8f0dd69a624ab4

2015-06-02T20:27:18.149 ERROR:teuthology.parallel:Exception in parallel execution
Traceback (most recent call last):
  File "/home/teuthworker/src/teuthology_master/teuthology/parallel.py", line 82, in __exit__
    for result in self:
  File "/home/teuthworker/src/teuthology_master/teuthology/parallel.py", line 101, in next
    resurrect_traceback(result)
  File "/home/teuthworker/src/teuthology_master/teuthology/parallel.py", line 19, in capture_traceback
    return func(*args, **kwargs)
  File "/var/lib/teuthworker/src/ceph-qa-suite_master/tasks/workunit.py", line 361, in _run_tests
    label="workunit test {workunit}".format(workunit=workunit)
  File "/home/teuthworker/src/teuthology_master/teuthology/orchestra/remote.py", line 156, in run
    r = self._runner(client=self.ssh, name=self.shortname, **kwargs)
  File "/home/teuthworker/src/teuthology_master/teuthology/orchestra/run.py", line 378, in run
    r.wait()
  File "/home/teuthworker/src/teuthology_master/teuthology/orchestra/run.py", line 114, in wait
    label=self.label)
CommandFailedError: Command failed (workunit test cephtool/test.sh) on plana52 with status 1: 'mkdir -p -- /home/ubuntu/cephtest/mnt.0/client.0/tmp && cd -- /home/ubuntu/cephtest/mnt.0/client.0/tmp && CEPH_CLI_TEST_DUP_COMMAND=1 CEPH_REF=d5a52869dd23ae1fbdf3e80d54e855560e467ff6 TESTDIR="/home/ubuntu/cephtest" CEPH_ID="0" PATH=$PATH:/usr/sbin adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage timeout 3h /home/ubuntu/cephtest/workunit.client.0/cephtool/test.sh'
2015-06-02T20:27:18.150 ERROR:teuthology.run_tasks:Saw exception from tasks.

Is this something wrong with the teuthology itself? Anyone has experience with this? Any hints are welcomed~
