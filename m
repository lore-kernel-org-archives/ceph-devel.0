From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: OSD crash during repair
Date: Fri, 6 Sep 2013 13:12:21 +1000
Message-ID: <20130906031221.GA16201@onthe.net.au>
References: <20130906000409.GA10181@onthe.net.au>
 <alpine.DEB.2.00.1309051937410.6929@cobra.newdream.net>
 <20130906025004.GA15642@onthe.net.au>
 <alpine.DEB.2.00.1309051952200.6929@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:50995 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab3IFDMn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Sep 2013 23:12:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1309051952200.6929@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Sep 05, 2013 at 07:55:52PM -0700, Sage Weil wrote:
> On Fri, 6 Sep 2013, Chris Dunlop wrote:
>> Hi Sage,
>> 
>> Does this answer your question?
>> 
>> 2013-09-06 09:30:19.813811 7f0ae8cbc700  0 log [INF] : applying configuration change: internal_safe_to_start_threads = 'true'
>> 2013-09-06 09:33:28.303658 7f0ae94bd700  0 log [ERR] : 2.12 osd.7: soid 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 extra attr _, extra attr snapset
>> 2013-09-06 09:33:28.303685 7f0ae94bd700  0 log [ERR] : repair 2.12 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 no 'snapset' attr
>> 2013-09-06 09:34:45.138468 7f0ae94bd700  0 log [ERR] : 2.12 repair stat mismatch, got 2722/2723 objects, 339/339 clones, 11307104768/11311299072 bytes.
>> 2013-09-06 09:34:45.142215 7f0ae94bd700  0 log [ERR] : 2.12 repair 0 missing, 1 inconsistent objects
>> 2013-09-06 09:34:45.206621 7f0ae94bd700 -1 *** Caught signal (Aborted) **
>> 
>> I've just attached the full 'debug_osd 0/10' log to the bug report.
> 
> This suggests to me that the object on osd.6 is missing those xattrs; can 
> you confirm with getfattr -d on the in osd.6's data directory?

I haven't yet wrapped my head around how to translate an oid
like those above into a underlying file system object. What 
directory should I be looking at?

> If that is indeed the case, you should be able to move the object out of 
> the way (don't delete it, just in case) and then do the repair.  The osd.6 
> should recover by copying the object from osd.7 (which has the needed 
> xattrs).  Bobtail is smart enough to recover missing objects but not to 
> recover just missing xattrs.

Do you want me to hold off on any repairs to allow tracking down
the crash, or is the current code sufficiently different that
there's little point?

> Also, you should upgrade to dumpling.  :)

I've been considering it. It was initially a little scary with
the various issues that were cropping up but that all seems to
have quietened down.

Of course I'd like my cluster to be clean before attempting an upgrade!

Chris
