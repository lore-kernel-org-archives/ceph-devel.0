From: Sam Lang <sam.lang@inktank.com>
Subject: lockdeps
Date: Tue, 11 Dec 2012 16:25:43 -1000
Message-ID: <50C7EB27.2050704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38881 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab2LLDbw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 22:31:52 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so147309pbc.31
        for <ceph-devel@vger.kernel.org>; Tue, 11 Dec 2012 19:31:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>


I've been puzzling over a failure in teuthology where lockdeps were 
enabled and reported a lock cycle.  The output of the found cycle is 
below.  I think the issue is actually erroneous, as it reports a found 
cycle, but the two dependencies that cause the cycle occur in separate 
threads.  Its correctly detecting a possible deadlock due to out of 
order locking (thread1: a -> b, thread2: b -> a), but in this case I 
don't think the deadlock is possible, because the two threads never run 
at the same time.

My proposed fixes are in wip-lockdep-fixes.  It resolves the issue of 
stomping on thread ids by using gettid() instead of pthread_self(), and 
ensures that the cycle happens within the same thread.  It also allows 
the g_lockdep field to be set to 3, which will detect (and only warn) on 
possible deadlock cases across threads.

-sam

------------------------------------
existing dependency Client::client_lock (10) -> SimpleMessenger::lock 
(4) at:
  ceph version 0.55-217-g331c250 (331c25046ecd99ec10c5835e8e674ca819e6168a)
  1: (Client::init()+0xbbd) [0x7f0303a9d83d]
  2: (ceph_mount_info::mount(std::string const&)+0x191) [0x7f0303a772b1]
  3: (ceph_mount()+0x76) [0x7f0303a75bc6]
  4: (LibCephFS_Open_empty_component_Test::TestBody()+0x4e1) [0x432cc1]
  5: (testing::Test::Run()+0xaa) [0x46089a]
  6: (testing::internal::TestInfoImpl::Run()+0x100) [0x4609a0]
  7: (testing::TestCase::Run()+0xbd) [0x460a6d]
  8: (testing::internal::UnitTestImpl::RunAllTests()+0x217) [0x460cd7]
  9: (main()+0x35) [0x41c4d5]
  10: (__libc_start_main()+0xed) [0x7f030309176d]
  11: test_libcephfs() [0x41c531]

2012-12-10 19:31:30.231305 7f02c8ff9700  0 new dependency 
SimpleMessenger::lock (4) -> Client::client_lock (10) creates a cycle at
  ceph version 0.55-217-g331c250 (331c25046ecd99ec10c5835e8e674ca819e6168a)
  1: (ObjectCacher::FlusherThread::entry()+0x15) [0x7f0303d98005]
  2: (Thread::_entry_func(void*)+0x12) [0x7f0303c908d2]
  3: (()+0x7e9a) [0x7f0304a32e9a]
  4: (clone()+0x6d) [0x7f03031624bd]

2012-12-10 19:31:30.231332 7f02c8ff9700  0 btw, i am holding these locks:
2012-12-10 19:31:30.231334 7f02c8ff9700  0   SimpleMessenger::lock (4)
2012-12-10 19:31:30.231335 7f02c8ff9700  0


