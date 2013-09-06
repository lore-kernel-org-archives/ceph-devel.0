From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: OSD crash during repair
Date: Fri, 6 Sep 2013 15:34:32 +1000
Message-ID: <20130906053432.GA18760@onthe.net.au>
References: <20130906000409.GA10181@onthe.net.au>
 <alpine.DEB.2.00.1309051937410.6929@cobra.newdream.net>
 <20130906025004.GA15642@onthe.net.au>
 <alpine.DEB.2.00.1309051952200.6929@cobra.newdream.net>
 <20130906031221.GA16201@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:38249 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab3IFFei (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Sep 2013 01:34:38 -0400
Content-Disposition: inline
In-Reply-To: <20130906031221.GA16201@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Sep 06, 2013 at 01:12:21PM +1000, Chris Dunlop wrote:
> On Thu, Sep 05, 2013 at 07:55:52PM -0700, Sage Weil wrote:
>> On Fri, 6 Sep 2013, Chris Dunlop wrote:
>>> Hi Sage,
>>> 
>>> Does this answer your question?
>>> 
>>> 2013-09-06 09:30:19.813811 7f0ae8cbc700  0 log [INF] : applying configuration change: internal_safe_to_start_threads = 'true'
>>> 2013-09-06 09:33:28.303658 7f0ae94bd700  0 log [ERR] : 2.12 osd.7: soid 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 extra attr _, extra attr snapset
>>> 2013-09-06 09:33:28.303685 7f0ae94bd700  0 log [ERR] : repair 2.12 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 no 'snapset' attr
>>> 2013-09-06 09:34:45.138468 7f0ae94bd700  0 log [ERR] : 2.12 repair stat mismatch, got 2722/2723 objects, 339/339 clones, 11307104768/11311299072 bytes.
>>> 2013-09-06 09:34:45.142215 7f0ae94bd700  0 log [ERR] : 2.12 repair 0 missing, 1 inconsistent objects
>>> 2013-09-06 09:34:45.206621 7f0ae94bd700 -1 *** Caught signal (Aborted) **
>>> 
>>> I've just attached the full 'debug_osd 0/10' log to the bug report.
>> 
>> This suggests to me that the object on osd.6 is missing those xattrs; can 
>> you confirm with getfattr -d on the in osd.6's data directory?
> 
> I haven't yet wrapped my head around how to translate an oid
> like those above into a underlying file system object. What 
> directory should I be looking at?

Found it:

b5# cd /var/lib/ceph/osd/ceph-6/current
b5# find 2.12* | grep -i 17d9b.2ae8944a.000000001e11
2.12_head/DIR_2/DIR_1/DIR_A/rb.0.17d9b.2ae8944a.000000001e11__head_56987A12__2
b5# getfattr -d 2.12_head/DIR_2/DIR_1/DIR_A/rb.0.17d9b.2ae8944a.000000001e11__head_56987A12__2
<<< ...crickets... >>>

vs.

b4# cd /var/lib/ceph/osd/ceph-7/current
b4# getfattr -d 2.12_head/DIR_2/DIR_1/DIR_A/rb.0.17d9b.2ae8944a.000000001e11__head_56987A12__2
# file: 2.12_head/DIR_2/DIR_1/DIR_A/rb.0.17d9b.2ae8944a.000000001e11__head_56987A12__2
user.ceph._=0sCgjhAAAABANBAAAAAAAAACAAAAByYi4wLjE3ZDliLjJhZTg5NDRhLjAwMDAwMDAwMWUxMf7/////////EnqYVgAAAAAAAgAAAAAAAAAEAxAAAAACAAAAAAAAAP////8AAAAAAAAAAEInCgAAAAAAuEsAAEEnCgAAAAAAuEsAAAICFQAAAAgTmwEAAAAAAHD1AgAAAAAAAAAAAAAAQAAAAAAAyY4dUpjCTSACAhUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABCJwoAAAAAALhLAAAA
user.ceph.snapset=0sAgIZAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==

>> If that is indeed the case, you should be able to move the object out of 
>> the way (don't delete it, just in case) and then do the repair.  The osd.6 
>> should recover by copying the object from osd.7 (which has the needed 
>> xattrs).  Bobtail is smart enough to recover missing objects but not to 
>> recover just missing xattrs.
> 
> Do you want me to hold off on any repairs to allow tracking down
> the crash, or is the current code sufficiently different that
> there's little point?

Repaired! ...but why does it take multiple rounds?

b5# mv 2.12_head/DIR_2/DIR_1/DIR_A/rb.0.17d9b.2ae8944a.000000001e11__head_56987A12__2 ..

b5# ceph pg repair 2.12
b5# while ceph -s | grep -q scrubbing; do sleep 60; done
b5# tail /var/log/ceph/ceph-osd.6.log
2013-09-06 15:02:13.751160 7f6ccc5ae700  0 log [ERR] : 2.12 osd.6 missing 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2
2013-09-06 15:04:15.286711 7f6ccc5ae700  0 log [ERR] : 2.12 repair stat mismatch, got 2723/2724 objects, 339/339 clones, 11311299072/11315493376 bytes.
2013-09-06 15:04:15.286766 7f6ccc5ae700  0 log [ERR] : 2.12 repair 1 missing, 0 inconsistent objects
2013-09-06 15:04:15.286823 7f6ccc5ae700  0 log [ERR] : 2.12 repair 2 errors, 2 fixed
2013-09-06 15:04:20.778377 7f6ccc5ae700  0 log [ERR] : 2.12 scrub stat mismatch, got 2724/2723 objects, 339/339 clones, 11315493376/11311299072 bytes.
2013-09-06 15:04:20.778383 7f6ccc5ae700  0 log [ERR] : 2.12 scrub 1 errors

b5# ceph pg dump | grep inconsistent
2.12    2723    0       0       0       11311299072     159103  159103  active+clean+inconsistent       2013-09-06 15:04:20.778413      20121'690883    20128'7941893   [6,7]   [6,7]   20121'690883    2013-09-06 15:04:20.778387      20121'690883    2013-09-06 15:04:15.286835

b5# ceph pg repair 2.12
b5# while ceph -s | grep -q scrubbing; do sleep 60; done
b5# tail /var/log/ceph/ceph-osd.6.log
2013-09-06 15:07:30.461959 7f6ccc5ae700  0 log [ERR] : 2.12 repair stat mismatch, got 2724/2723 objects, 339/339 clones, 11315493376/11311299072 bytes.
2013-09-06 15:07:30.461991 7f6ccc5ae700  0 log [ERR] : 2.12 repair 1 errors, 1 fixed

b5# ceph pg dump | grep inconsistent
2.12    2724    0       0       0       11315493376     159580  159580  active+clean+inconsistent       2013-09-06 15:07:30.462039      20129'690886    20128'7942171   [6,7]   [6,7]   20129'690886    2013-09-06 15:07:30.461995      20129'690886    2013-09-06 15:07:30.461995

b5# ceph pg repair 2.12
b5# while ceph -s | grep -q scrubbing; do sleep 60; done
b5# tail /var/log/ceph/ceph-osd.6.log
2013-09-06 15:09:36.993049 7f6ccc5ae700  0 log [INF] : 2.12 repair ok, 0 fixed

# ceph pg dump | grep inconsistent
<<< ...crickets... >>>


Chris
