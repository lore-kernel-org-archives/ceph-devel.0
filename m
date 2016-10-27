From: David Zafman <dzafman@redhat.com>
Subject: master baseline
Date: Thu, 27 Oct 2016 12:17:09 -0700
Message-ID: <3bd8dfa1-0dc5-0c91-bf62-90fb0d062613@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935449AbcJ0TRL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 27 Oct 2016 15:17:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2CB3C0023C4
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 19:17:10 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: 'ceph-devel' <ceph-devel@vger.kernel.org>


I tried to figure out what was going on with these failures, but ended 
up filing 5 new trackers (1 already existed).

master baseline

http://pulpito.ceph.com/yuriw-2016-10-25_16:08:46-rados-master-distro-basic-smithi/

   yuriw@teuthology ~ [22:16:52]> aaa 
/a/yuriw-2016-10-25_16:08:46-rados-master-distro-basic-smithi
Found 280 jobs
Found 7 distinct failure reasons

-------
Assertion: 2016-10-25T18:58:44.899 
INFO:tasks.workunit.client.0.smithi092.stdout: api_list: 
/srv/autobuild-ceph/gitbuilder.git/build/rpmbuild/BUILD/ceph-11.0.2/src/log/SubsystemMap.h: 
62: FAILED assert(sub < m_subsys.size())
1 jobs: ['494555']
suites: ['1thrash/none.yaml', 'clusters/{fixed-2.yaml', 'fs/btrfs.yaml', 
'mon_kv_backend/rocksdb.yaml', 'msgr-failures/few.yaml', 
'msgr/simple.yaml', 'openstack.yaml}', 'rados/verify/{rados.yaml', 
'tasks/rados_api_tests.yaml', 'validater/valgrind.yaml}’]

There may be 2 problems.  First why did set_pg_num() fail. Because of 
the failure we went to RadosTestNS::TearDown().  The set_snap_read()  
does ldout() that calls should_gather() which hit the assert.

2016-10-25T18:58:44.892 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list: 
/srv/autobuild-ceph/gitbuilder.git/build/rpmbuild/BUILD/ceph-11.0.2/src/test/librados/list.cc:689: 
Failure
2016-10-25T18:58:44.892 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list: Value of: err_str.empty()
2016-10-25T18:58:44.892 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:   Actual: false
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list: Expected: true
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list: 
/srv/autobuild-ceph/gitbuilder.git/build/rpmbuild/BUILD/ceph-11.0.2/src/log/SubsystemMap.h: 
In function 'bool ceph::log::SubsystemMap::should_gather(unsigned int, 
int)' thread 7fc8b4da1300 time 2016-10-25 18:58:44.875361
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list: 
/srv/autobuild-ceph/gitbuilder.git/build/rpmbuild/BUILD/ceph-11.0.2/src/log/SubsystemMap.h: 
62: FAILED assert(sub < m_subsys.size())
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  ceph version v11.0.2-682-gbbdfd13 
(bbdfd1375e8d2d0b8db59fd805aeb2a5c8ea2563)
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  1: (ceph::__ceph_assert_fail(char const*, char const*, int, 
char const*)+0x85) [0x7fc8b50d8ae5]
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  2: (()+0x1c08ac) [0x7fc8b4f808ac]
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  3: (librados::IoCtxImpl::set_snap_read(snapid_t)+0x2ee) 
[0x7fc8b4fdae4e]
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  4: (rados_ioctx_snap_set_read()+0x26) [0x7fc8b4fadb66]
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  5: (RadosTestNS::cleanup_all_objects(void*)+0x33) 
[0x7fc8b5047e83]
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  6: (RadosTestNS::TearDown()+0xd) [0x7fc8b504832d]
2016-10-25T18:58:44.893 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  7: (void 
testing::internal::HandleExceptionsInMethodIfSupported<testing::Test, 
void>(testing::Test*, void (testing::Test::*)(), char const*)+0x43) 
[0x7fc8b5036e43]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  8: (testing::Test::Run()+0x80) [0x7fc8b5029870]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  9: (testing::TestInfo::Run()+0x9e) [0x7fc8b502994e]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  10: (testing::TestCase::Run()+0xa5) [0x7fc8b5029a55]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  11: (testing::internal::UnitTestImpl::RunAllTests()+0x278) 
[0x7fc8b5029d38]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  12: (testing::UnitTest::Run()+0x68) [0x7fc8b502a008]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  13: (main()+0x156) [0x7fc8b4f84456]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  14: (__libc_start_main()+0xf5) [0x7fc8b159bb15]
2016-10-25T18:58:44.894 INFO:tasks.workunit.client.0.smithi092.stdout: 
api_list:  15: (()+0x1c8349) [0x7fc8b4f88349]
Tracker: bug#17724

-------
Failure: Command failed on smithi016 with status 22: 'sudo 
adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage 
timeout 120 ceph --cluster ceph mon remove a'
1 jobs: ['494653']
suites: ['all/mon-seesaw.yaml', 'fs/xfs.yaml', 
'msgr-failures/many.yaml}', 'msgr/async.yaml', 
'rados/singleton/{rados.yaml’]

2016-10-25T18:34:25.948 INFO:teuthology.orchestra.run.smithi016:Running: 
'sudo adjust-ulimits ceph-coverage 
/home/ubuntu/cephtest/archive/coverage timeout 120 ceph --cluster ceph 
mon remove a'
2016-10-25T18:34:26.256 
INFO:teuthology.orchestra.run.smithi016.stderr:Error EINVAL: removing 
mon.a at 172.21.15.16:6789/0, there will be 1 monitors
CommandFailedError: Command failed on smithi016 with status 22: 'sudo 
adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage 
timeout 120 ceph --cluster ceph mon remove a’
Tracker: bug#17725

-------
Dead: 2016-10-25T19:52:38.402 
INFO:tasks.workunit.client.0.smithi086.stderr:2016-10-25 19:52:38.404611 
7f7568a97700  0 monclient: hunting for new mon
1 jobs: ['494716']
suites: ['all/radostool.yaml', 'fs/xfs.yaml', 'msgr-failures/few.yaml}', 
'msgr/random.yaml', 'rados/singleton/{rados.yaml’]

2016-10-25T19:52:38.402 
INFO:tasks.workunit.client.0.smithi086.stderr:2016-10-25 19:52:38.404611 
7f7568a97700  0 monclient: hunting for new mon
NOTHING HAPPENING HERE
2016-10-25T22:23:21.261 
INFO:tasks.workunit.client.0.smithi086.stderr:Terminated
test_rados_tool.sh
Status 124 from timeout
Tracker: bug#17726

----------
Failure: failed to recover before timeout expired
1 jobs: ['494745']
suites: ['all/resolve_stuck_peering.yaml', 'fs/xfs.yaml', 
'msgr-failures/many.yaml}', 'msgr/random.yaml', 
'rados/singleton/{rados.yaml’]

2016-10-25T20:22:28.251 INFO:teuthology.orchestra.run.smithi041:Running: 
'sudo adjust-ulimits ceph-coverage 
/home/ubuntu/cephtest/archive/coverage timeout 120 ceph --cluster ceph 
osd lost 1 --yes-i-really-mean-it’
osd 0 and 2 should be running but osd.2 never became part pg 1.0 so that 
it pg could go clean
********
Tracker: bug#17727

-----------
Assertion: 
/srv/autobuild-ceph/gitbuilder.git/build/rpmbuild/BUILD/ceph-11.0.2/src/msg/Message.cc: 
193: FAILED assert(middle.length() == 0)
ceph version v11.0.2-682-gbbdfd13 (bbdfd1375e8d2d0b8db59fd805aeb2a5c8ea2563)
  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x85) [0x7f78dbb94085]
  2: (()+0x1e7056) [0x7f78dbb99056]
  3: (AsyncConnection::prepare_send_message(unsigned long, Message*, 
ceph::buffer::list&)+0x25c) [0x7f78dbdb0b7c]
  4: (AsyncConnection::send_message(Message*)+0x42f) [0x7f78dbdb686f]
  5: 
(SyntheticDispatcher::send_message_wrap(boost::intrusive_ptr<Connection>, 
Message*)+0x31b) [0x7f78dbb53b5b]
  6: (SyntheticWorkload::send_message()+0x554) [0x7f78dbb57024]
  7: (MessengerTest_SyntheticStressTest_Test::TestBody()+0x3da) 
[0x7f78dbb4485a]
  8: (void 
testing::internal::HandleExceptionsInMethodIfSupported<testing::Test, 
void>(testing::Test*, void (testing::Test::*)(), char const*)+0x43) 
[0x7f78dbb88363]
  9: (testing::Test::Run()+0xb7) [0x7f78dbb7ac97]
  10: (testing::TestInfo::Run()+0x9e) [0x7f78dbb7ad3e]
  11: (testing::TestCase::Run()+0xa5) [0x7f78dbb7ae45]
  12: (testing::internal::UnitTestImpl::RunAllTests()+0x278) 
[0x7f78dbb7b128]
  13: (testing::UnitTest::Run()+0x68) [0x7f78dbb7b3f8]
  14: (main()+0x199) [0x7f78dbb36c99]
  15: (__libc_start_main()+0xf5) [0x7f78d74cfb15]
  16: (()+0x187c15) [0x7f78dbb39c15]
1 jobs: ['494756']
suites: ['all/msgr.yaml}', 'rados/singleton-nomsgr/{rados.yaml’]
Tracker: bug#17728

-------
Failure: Command failed (workunit test 
rados/test_envlibrados_for_rocksdb.sh) on smithi020 with status 2: 
'mkdir -p -- /home/ubuntu/cephtest/mnt.0/client.0/tmp && cd -- 
/home/ubuntu/cephtest/mnt.0/client.0/tmp && CEPH_CLI_TEST_DUP_COMMAND=1 
CEPH_REF=bbdfd1375e8d2d0b8db59fd805aeb2a5c8ea2563 
TESTDIR="/home/ubuntu/cephtest" CEPH_ARGS="--cluster ceph" CEPH_ID="0" 
PATH=$PATH:/usr/sbin adjust-ulimits ceph-coverage 
/home/ubuntu/cephtest/archive/coverage timeout 3h 
/home/ubuntu/cephtest/workunit.client.0/rados/test_envlibrados_for_rocksdb.sh'
1 jobs: ['494766']
suites: ['all/test_envlibrados_for_rocksdb.yaml', 'fs/xfs.yaml', 
'msgr-failures/many.yaml}', 'msgr/async.yaml', 
'rados/singleton/{rados.yaml']
Tracker: bug#17654



