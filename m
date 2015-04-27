From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Hitting tcmalloc bug even with patch applied
Date: Mon, 27 Apr 2015 14:06:22 +0200 (CEST)
Message-ID: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:54705 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbbD0MGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 08:06:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Somnath Roy <somnath.roy@sandisk.com>

Hi,

I'm hitting the tcmalloc even with patch apply.
It's mainly occur when I try to bench fio with a lot jobs (20 - 40 jobs)

Does It need to tuned something in osd environnement variable ?


I double check it with

#g++ -o gperftest gperftest.c -ltcmalloc
# export TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=67108864
# ./gperftest 
Tcmalloc OK! Internal and Env cache size are same:67108864


perf top
-------
  10.04%  libtcmalloc.so.4.1.2  [.] tcmalloc::ThreadCache::ReleaseToCentralCache
   8.19%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::FetchFromSpans
   3.89%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::ReleaseToSpans
   2.04%  libtcmalloc.so.4.1.2  [.] tcmalloc::CentralFreeList::ReleaseListToSpans
   1.79%  libtcmalloc.so.4.1.2  [.] operator new
   1.25%  ceph-osd              [.] ConfFile::load_from_buffer
   1.21%  libtcmalloc.so.4.1.2  [.] operator delete
   1.14%  [kernel]              [k] _raw_spin_lock
   1.08%  libstdc++.so.6.0.19   [.] std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string
   1.04%  [kernel]              [k] __schedule
   1.00%  libpthread-2.17.so    [.] pthread_mutex_trylock
   0.90%  [kernel]              [k] native_write_msr_safe
   0.89%  [kernel]              [k] __switch_to
   0.79%  [kernel]              [k] _raw_spin_lock_irqsave
   0.73%  [kernel]              [k] copy_user_enhanced_fast_string



Regards,

Alexandre
