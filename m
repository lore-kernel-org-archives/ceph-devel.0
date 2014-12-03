From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: Performance variation across RBD clients on different pools in
 all SSD setup - tcmalloc issue
Date: Wed, 3 Dec 2014 13:53:42 +0100
Message-ID: <CABZ+qqm=eWfsON=r5H+digGqoDtdi6JerCeYz2M26b+EDPH6bg@mail.gmail.com>
References: <9E914F5BD7F48A4782456CEB550A42280A74C0F6@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:51967 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbaLCMy1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Dec 2014 07:54:27 -0500
Received: by mail-la0-f44.google.com with SMTP id ge10so12508443lab.17
        for <ceph-devel@vger.kernel.org>; Wed, 03 Dec 2014 04:54:22 -0800
 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A74C0F6@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 3, 2014 at 12:41 PM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> Hi All,
>
> We are seeing large read performance variations across RBD clients on different pools. Below is the summary of our findings
>
> - First client starting I/O after a cluster restart (ceph start/stop on all OSD nodes) gets the best performance
> - Clients started later exhibit 40% to 70% degraded performance, This is seen even in cases where first client I/O is stopped before starting the second client I/O
> -  Adding performance counters showed large increase in latency across the entire path and no specific point of increased latency - upto 3x increase in latency
> - On further investigation we have root caused this to degradation in tcmalloc performance inducing large latency across the entire path
> - Also the variation is more as we increase the number of op worker shards, with lower shards the variation is lesser but this results in more lock contention and is not a good option for SSD based clusters
> - Variation is observed even when the RBD images are not written at all thus indicating that this is not a filesystem issue
>
> Below is a snippet of perf top output for the two runs:
>
> (1)    TCmalloc  - Client-1
>    2.68%  ceph-osd                 [.] crush_hash32_3
>   2.65%  libtcmalloc.so.4.1.2     [.] operator new(unsigned long)
>   1.66%  [kernel]                 [k] _raw_spin_lock
>   1.56%  libstdc++.so.6.0.19      [.] std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string(std::string const&)
>   1.51%  libtcmalloc.so.4.1.2     [.] operator delete(void*)
>
> (2)    TCmalloc - Client -2 (note significant increase in TCmalloc internal free to central list code paths)
>
> 14.75%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::FetchFromSpans()
>   7.46%  libtcmalloc.so.4.1.2     [.] tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*, unsigned long, int)
>   6.71%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::ReleaseToSpans(void*)
>   1.68%  libtcmalloc.so.4.1.2     [.] operator new(unsigned long)
>   1.57%  ceph-osd                 [.] crush_hash32_3
>
> Tying it all together, It looks like the new client I/O on a different pool induces change in how the OSD shards are used, this would induce movement of memory to/from the thread local caches to the central free lists.
> Increasing the TCmalloc thread cache limit with 'TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES' alleviates the issues in our test setups. However this is a temporary resolution - this also bloats the OSD memory usage
>

I've noticed that tcmalloc is quite visible in perf top, but I never
looked closer because we don't even have debug symbols enabled in our
tcmalloc. Here's a production dumpling ceph-osd right now:

Samples: 35K of event 'cycles', Event count (approx.): 4040795974,
Thread: ceph-osd(13976)
 87.81%  libtcmalloc.so.4.1.0.#prelink#.P1wCcj  [.] 0x0000000000017e6f
  1.41%  libpthread-2.12.so                     [.] pthread_mutex_lock
  1.40%  libstdc++.so.6.0.13                    [.] 0x0000000000065b8c

What value did you use for TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES and
how well did it alleviate the problem? I assume env
TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=x ceph-osd ... is sufficient to
override this?

Cheers, Dan
