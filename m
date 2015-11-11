From: Sage Weil <sage@newdream.net>
Subject: Re: disabling buffer::raw crc cache
Date: Wed, 11 Nov 2015 05:13:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511110510440.7964@cobra.newdream.net>
References: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com> <CANE=7sWCUw5PiKwQqqq__6XpyF89jk1v_rsNgnfX10UtkRxXpQ@mail.gmail.com> <D2683AC6.8AB2%evgeniy.firsov@sandisk.com> <CALZt5jyuAH_aYYyzSEmn03QXaJQsfLiF=HMB6FJ5xEq6LMhFag@mail.gmail.com>
 <CALZt5jwOOp1gnBqO1vbmj2Kyborebz_Os79YcE1zeTMwumfp8A@mail.gmail.com> <CALZt5jyirEnrsStRknq9HcX5JqkoMcg+-=0KFoSGrzWCV2m=hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58290 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbKKNNy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 08:13:54 -0500
In-Reply-To: <CALZt5jyirEnrsStRknq9HcX5JqkoMcg+-=0KFoSGrzWCV2m=hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 11 Nov 2015, Ning Yao wrote:
> >>>the code logic would touch crc cache is bufferlist::crc32c and invalidate_crc.
> >>Also for pg_log::_write_log(), but seems it is always miss and use at
> >>once, no need to cache crc actually?
> > Oh, no, it will be hit in FileJournal writing
> Still miss as buffer::ptr length diff with ::encode(crc, bl), right?
> So the previous ebl.crc32c(0) calculation would be also no need to
> cache.

How about just skipping the cache logic if the raw length is less than 
some threshold?  Say, 16KB or something?  That would cover the _write_log 
case (small buffer) and more generally avoid the fixed overhead of caching 
when recalculating is cheap.

This was originally added with large writes in mind to avoid the crc 
recalculation during journaling on armv7l.  It is presumably also helping 
now that we have the opportunistic whole-object checksums for full or 
sequential writes.

sage
