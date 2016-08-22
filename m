From: Casey Bodley <cbodley@redhat.com>
Subject: memory leaks related to CephContext and global_init_daemonize()
Date: Mon, 22 Aug 2016 17:12:44 -0400
Message-ID: <c152a162-43ba-0db2-1fd4-2debdaac4163@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f173.google.com ([209.85.213.173]:35157 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbcHVWHt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 18:07:49 -0400
Received: by mail-yb0-f173.google.com with SMTP id z10so44528402ybh.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 15:07:48 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id i84sm9520118ywi.7.2016.08.22.14.12.44
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 14:12:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi devs,

We've been seeing valgrind failures in radosgw from all of our recent 
teuthology runs, and it's been a difficult one to track down. An example 
of the valgrind output [1] points to a std::string in the md_config_t 
coming from CephContext.

I've been able to reproduce the failures locally as well, and narrowed 
it down to a trivial test case [2] that calls global_init(), 
common_init_finish(), global_init_daemonize(), and g_ceph_context->put().

Running this test with the -f flag (to set daemonize=false), no leaks 
are detected:

$ valgrind --tool=memcheck --leak-check=full bin/cephcontext_test -c 
ceph.conf -f
==18331== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

Without the -f, valgrind complains about the CephContext leaks, but the 
test doesn't terminate like I'd expect.

$ valgrind --tool=memcheck --leak-check=full bin/cephcontext_test -c 
ceph.conf
...
==18335== ERROR SUMMARY: 105 errors from 105 contexts (suppressed: 0 from 0)

$ ps ax | grep valgrind
18339 ?        Ssl    0:00 valgrind --tool=memcheck --leak-check=full 
bin/cephcontext_test -c ceph.conf
18354 pts/1    S+     0:00 grep --color=auto valgrind

Killing the process prints the following message, followed by all of the 
same leaks:

$ kill 18339
==18339==
==18339== Process terminating with default action of signal 15 (SIGTERM)
==18339==    at 0x9B109E8: pthread_cond_destroy@@GLIBC_2.3.2 
(pthread_cond_destroy.c:77)
==18339==    by 0x66DC23: Cond::~Cond() (Cond.h:45)
==18339==    by 0x66E22D: 
CephContextServiceThread::~CephContextServiceThread() (ceph_context.cc:90)
==18339==    by 0x66E279: 
CephContextServiceThread::~CephContextServiceThread() (ceph_context.cc:90)
==18339==    by 0x66CF5D: CephContext::join_service_thread() 
(ceph_context.cc:652)
==18339==    by 0x66C1A1: CephContext::~CephContext() (ceph_context.cc:522)
==18339==    by 0x66CC59: CephContext::put() (ceph_context.cc:594)
==18339==    by 0x64ACC6: main (test_main.cc:25)
...
==18339== ERROR SUMMARY: 104 errors from 104 contexts (suppressed: 0 from 0)

So we see the CephContext destructor being called, but it hangs on 
pthread_cond_destroy(). Looking to helgrind for help:

$ valgrind --tool=helgrind bin/cephcontext_test -c ceph.conf
==18362== ---Thread-Announcement------------------------------------------
==18362==
==18362== Thread #1 is the program's root thread
==18362==
==18362== ----------------------------------------------------------------
==18362==
==18362== Thread #1: pthread_cond_destroy: destruction of condition 
variable being waited upon
==18362==    at 0x98FC915: pthread_cond_destroy_WRK (hg_intercepts.c:1586)
==18362==    by 0x98FFB93: pthread_cond_destroy@* (hg_intercepts.c:1604)
==18362==    by 0x66DC23: Cond::~Cond() (Cond.h:45)
==18362==    by 0x66E22D: 
CephContextServiceThread::~CephContextServiceThread() (ceph_context.cc:90)
==18362==    by 0x66E279: 
CephContextServiceThread::~CephContextServiceThread() (ceph_context.cc:90)
==18362==    by 0x66CF5D: CephContext::join_service_thread() 
(ceph_context.cc:652)
==18362==    by 0x66C1A1: CephContext::~CephContext() (ceph_context.cc:522)
==18362==    by 0x66CC59: CephContext::put() (ceph_context.cc:594)
==18362==    by 0x64ACC6: main (test_main.cc:25)

At the point when CephContext's destructor fires, only two threads 
remain: the main thread, and the log thread - and the log thread is 
waiting on its own condition variable. So it appears that the 
conflicting waiter is actually the CephContextServiceThread from the 
parent process. I see that we don't stop and restart this 
CephContextServiceThread when we daemonize, unlike the Log thread (it 
stops in global_init_prefork() and restarts in 
global_init_postfork_start()).

Does anyone know what changed here recently to cause these leaks? Should 
we be restarting this CephContextServiceThread on daemonize?

Thanks,
Casey

[1] 
http://qa-proxy.ceph.com/teuthology/teuthology-2016-08-20_17:05:04-rgw-master---basic-smithi/376190/remote/smithi046/log/valgrind/client.0.log.gz
[2] https://gist.github.com/cbodley/4551b29c50718c230683a6c1d65b326a
