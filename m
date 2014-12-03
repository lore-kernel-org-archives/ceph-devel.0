From: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Subject: RE: Performance variation across RBD clients on different pools in
 all SSD setup - tcmalloc issue
Date: Wed, 3 Dec 2014 15:31:25 +0000
Message-ID: <9E914F5BD7F48A4782456CEB550A42280A74C1DF@SACMBXIP01.sdcorp.global.sandisk.com>
References: <9E914F5BD7F48A4782456CEB550A42280A74C0F6@SACMBXIP01.sdcorp.global.sandisk.com>
 <547F1C65.1060102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0071.outbound.protection.outlook.com ([157.56.111.71]:12224
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751405AbaLCQDj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 11:03:39 -0500
In-Reply-To: <547F1C65.1060102@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "mnelson@redhat.com" <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Mark, I have added this item in the agenda for today's meeting

Regards,
Chaitanya

-----Original Message-----
From: Mark Nelson [mailto:mark.nelson@inktank.com] 
Sent: Wednesday, December 03, 2014 7:51 PM
To: Chaitanya Huilgol; ceph-devel@vger.kernel.org
Subject: Re: Performance variation across RBD clients on different pools in all SSD setup - tcmalloc issue



On 12/03/2014 05:41 AM, Chaitanya Huilgol wrote:
> Hi All,
>
> We are seeing large read performance variations across RBD clients on 
> different pools. Below is the summary of our findings
>
> - First client starting I/O after a cluster restart (ceph start/stop 
> on all OSD nodes) gets the best performance
> - Clients started later exhibit 40% to 70% degraded performance, This 
> is seen even in cases where first client I/O is stopped before 
> starting the second client I/O
> -  Adding performance counters showed large increase in latency across 
> the entire path and no specific point of increased latency - upto 3x 
> increase in latency
> - On further investigation we have root caused this to degradation in 
> tcmalloc performance inducing large latency across the entire path
> - Also the variation is more as we increase the number of op worker 
> shards, with lower shards the variation is lesser but this results in 
> more lock contention and is not a good option for SSD based clusters
> - Variation is observed even when the RBD images are not written at 
> all thus indicating that this is not a filesystem issue
>
> Below is a snippet of perf top output for the two runs:
>
> (1)    TCmalloc  - Client-1
>     2.68%  ceph-osd                 [.] crush_hash32_3
>    2.65%  libtcmalloc.so.4.1.2     [.] operator new(unsigned long)
>    1.66%  [kernel]                 [k] _raw_spin_lock
>    1.56%  libstdc++.so.6.0.19      [.] std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string(std::string const&)
>    1.51%  libtcmalloc.so.4.1.2     [.] operator delete(void*)
>
> (2)    TCmalloc - Client -2 (note significant increase in TCmalloc internal free to central list code paths)
>
> 14.75%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::FetchFromSpans()
>    7.46%  libtcmalloc.so.4.1.2     [.] tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*, unsigned long, int)
>    6.71%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::ReleaseToSpans(void*)
>    1.68%  libtcmalloc.so.4.1.2     [.] operator new(unsigned long)
>    1.57%  ceph-osd                 [.] crush_hash32_3
>
> Tying it all together, It looks like the new client I/O on a different pool induces change in how the OSD shards are used, this would induce movement of memory to/from the thread local caches to the central free lists.
> Increasing the TCmalloc thread cache limit with 
> 'TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES' alleviates the issues in our 
> test setups. However this is a temporary resolution - this also bloats 
> the OSD memory usage
>
> We have also tested with glibc malloc and jemalloc based builds where 
> this issue is not seen, both hold up well, below is the perf output 
> from the tests
>
> (3)    Glibc - malloc : Any client - no significant change
>
>    3.00%  libc-2.19.so         [.] _int_malloc
>    2.65%  libc-2.19.so         [.] malloc
>    2.47%  libc-2.19.so         [.] _int_free
>    2.33%  ceph-osd             [.] crush_hash32_3
>    1.63%  [kernel]             [k] _raw_spin_lock
>    1.38%  libstdc++.so.6.0.19  [.] std::basic_string<char, 
> std::char_traits<char>, std::allocator<char> 
> >::basic_string(std::string const&)
>
> (4)    Jemalloc  - Any client - no significant changes
>
>    2.47%  ceph-osd                 [.] crush_hash32_3
>    2.25%  libjemalloc.so.1         [.] free
>    2.07%  libc-2.19.so             [.] 0x0000000000081070
>    1.95%  libjemalloc.so.1         [.] malloc
>    1.65%  [kernel]                 [k] _raw_spin_lock
>    1.60%  libstdc++.so.6.0.19      [.] std::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string(std::string const&)
>
> IMHO, we should probably look at the following in general for better 
> performance with less variation
>
> - Add jemalloc option for ceph builds
> - Look at ways to evenly distribute PGs across the shards  - with 
> larger number of shards some shards do not get exercised at all while 
> some are overloaded
> - Look at decreasing heap activity in the I/O path (index Manager, 
> Hash Index, LFN index etc.)
>
> We can discuss this further in todays performance meeting

This is a fantastic writup Chaitanya.  Please add to the performance meeting agenda.

fwiw there are some interesting benchmarks and discussion of different allocators here:

http://www.percona.com/blog/2012/07/05/impact-of-memory-allocators-on-mysql-performance/
http://www.reddit.com/r/programming/comments/18zija/github_got_30_better_performance_using_tcmalloc/

I would definitely be in favor of at least exploring options other than tcmalloc.

Mark

>
> Thanks,
> Chaitanya
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>
