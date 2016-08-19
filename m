From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: helgrind fincorrectly reports lock order violated
Date: Fri, 19 Aug 2016 14:30:25 -0400
Message-ID: <CA+aFP1AOstQ-bgGN=KaNir05g3-yxRZRPsGQL0_rKji5hJpqiQ@mail.gmail.com>
References: <57B56FA5.6060108@dachary.org>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34118 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbcHSSa1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 14:30:27 -0400
Received: by mail-pa0-f45.google.com with SMTP id fi15so18361424pac.1
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2016 11:30:27 -0700 (PDT)
In-Reply-To: <57B56FA5.6060108@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sounds good to me -- the helgrind problems have always been low
priority for me since they change with each OS so its next to
impossible to keep up with new false positives being added to the code
base well below librbd.

On Thu, Aug 18, 2016 at 4:19 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Jason,
>
> The jewel rbd job
>
> rbd/valgrind/{base/install.yaml clusters/{fixed-1.yaml openstack.yaml} fs/xfs.yaml validator/helgrind.yaml workloads/c_api_tests_with_journaling.yaml}
>
> at
>
> http://pulpito.ceph.com/loic-2016-08-17_22:11:27-rbd-jewel-backports-loic-distro-basic-smithi/371732/
>
> for the sake of validating a series of backports found at https://github.com/ceph/ceph/pull/10684 failed with:
>
> 2016-08-18T03:38:43.412 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== Helgrind, a thread error detector
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== Copyright (C) 2007-2013, and GNU GPL'd, by OpenWorks LLP et al.
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== Using Valgrind-3.10.0.SVN and LibVEX; rerun with -h for copyright info
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== Command: ceph_test_librbd
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== ---Thread-Announcement------------------------------------------
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== Thread #26 was created
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    at 0xC92943E: clone (clone.S:74)
> 2016-08-18T03:38:43.413 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0xAC3F199: do_clone.constprop.3 (createthread.c:75)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0xAC408BA: pthread_create@@GLIBC_2.2.5 (createthread.c:245)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0xAA2BC90: ??? (in /usr/lib/valgrind/vgpreload_helgrind-amd64-linux.so)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x715508: Thread::try_create(unsigned long) (Thread.cc:139)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x7155D7: Thread::create(char const*, unsigned long) (Thread.cc:154)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x6FF67E: Finisher::start() (Finisher.cc:15)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x669743: librados::RadosClient::connect() (RadosClient.cc:298)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x638FAF: rados_connect (librados.cc:2611)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x98DD6B: connect_cluster(void**) (test.cc:368)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x45A826: TestLibRBD::SetUpTestCase() (test_librbd.cc:159)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x948DA2: void testing::internal::HandleExceptionsInMethodIfSupported<testing::TestCase, void>(testing::TestCase*, void (testing::TestCase::*)(), char const*) (gtest.cc:2078)
> 2016-08-18T03:38:43.414 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==
> 2016-08-18T03:38:43.415 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== ----------------------------------------------------------------
> 2016-08-18T03:38:43.415 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==
> 2016-08-18T03:38:43.415 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== Thread #26: lock order "0xD822EC8 before 0xD8FFB10" violated
> 2016-08-18T03:38:43.415 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==
> 2016-08-18T03:38:43.415 INFO:tasks.workunit.client.0.smithi036.stderr:==21351== Observed (incorrect) order is: acquisition of lock at 0xD8FFB10
> 2016-08-18T03:38:43.415 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    at 0xAA2D145: pthread_mutex_lock (in /usr/lib/valgrind/vgpreload_helgrind-amd64-linux.so)
> 2016-08-18T03:38:43.415 INFO:tasks.workunit.client.0.smithi036.stderr:==21351==    by 0x6E2497: Mutex::Lock(bool) (Mutex.cc:110)
> ...
>
> And it looks like your commits:
>
> https://github.com/ceph/ceph/commit/7d64f0ea62545d2ac4a4b399e9566d80b41d3068
> https://github.com/ceph/ceph/commit/d4c76649902b74c37da4f7d448bcb0b7ffa04084
> https://github.com/ceph/ceph/commit/b12cf70fe415cc872c33223bb6574ce47bea0623
>
> are trying to address the problem. However, none of them were merged. A quick search in the tracker found
>
> http://tracker.ceph.com/issues/15424 Many helgrind lock warnings within Objecter
> http://tracker.ceph.com/issues/15352 TestJournalEntries.AioWrite: failed assert(m_watch_in_progress)
>
> I'm tempted to add the failed job to the issue you created to collect helgrind issues: http://tracker.ceph.com/issues/14846 although none of the logs it contains seem to exactly match the failure. I could then set it to be backported to jewel and wait until https://github.com/ceph/ceph/pull/9436 is merged in master.
>
> What do you think ?
>
> --
> Loïc Dachary, Artisan Logiciel Libre



-- 
Jason
