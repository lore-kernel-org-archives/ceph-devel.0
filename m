From: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>
Subject: RE: Performance variation across RBD clients on different pools in
 all SSD setup - tcmalloc issue
Date: Wed, 3 Dec 2014 17:41:04 +0000
Message-ID: <085BC98701B92B4C86AE7696562D284D0B9B24E4@SACMBXIP03.sdcorp.global.sandisk.com>
References: <9E914F5BD7F48A4782456CEB550A42280A74C0F6@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1412030755410.25778@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0073.outbound.protection.outlook.com ([207.46.100.73]:5824
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750798AbaLCRlP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 12:41:15 -0500
In-Reply-To: <alpine.DEB.2.00.1412030755410.25778@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,

We did test with latest version of tcmalloc as well. It exhibited the same behavior.

Viju


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Wednesday, December 03, 2014 9:30 PM
To: Chaitanya Huilgol
Cc: ceph-devel@vger.kernel.org
Subject: Re: Performance variation across RBD clients on different pools in all SSD setup - tcmalloc issue

On Wed, 3 Dec 2014, Chaitanya Huilgol wrote:
> (2)    TCmalloc - Client -2 (note significant increase in TCmalloc internal free to central list code paths)
>
> 14.75%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::FetchFromSpans()
>   7.46%  libtcmalloc.so.4.1.2     [.] tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*, unsigned long, int)
>   6.71%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::ReleaseToSpans(void*)
>   1.68%  libtcmalloc.so.4.1.2     [.] operator new(unsigned long)
>   1.57%  ceph-osd                 [.] crush_hash32_3

Yikes!

> IMHO, we should probably look at the following in general for better
> performance with less variation
>
> - Add jemalloc option for ceph builds

Definitely.

Several years ago we saw serious heap fragmetnation issues with glibc.  I suspect newer versions are less problematics.  It may also be that newer version of tcmalloc behave better (not sure if we're linking against the latest version?).  In any case, we should have build support for all options.  We'll need to be careful when making a change, though.  The best choice may also vary on a per-distro basis.

> - Look at ways to evenly distribute PGs across the shards - with
> larger number of shards some shards do not get exercised at all while
> some are overloaded

Ok

> - Look at decreasing heap activity in the I/O path (index Manager,
> Hash Index, LFN index etc.)

Yes.  Unfortunately I think this is a long tail... lots of small changes needed before we'll see much impact.

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

