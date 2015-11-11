From: Ning Yao <zay11022@gmail.com>
Subject: Re: disabling buffer::raw crc cache
Date: Wed, 11 Nov 2015 21:50:49 +0800
Message-ID: <CALZt5jwhKieOh=usLOGvQ0UzZijB_3AbB_T3Q6i3cuO3dgxZNQ@mail.gmail.com>
References: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com>
	<CANE=7sWCUw5PiKwQqqq__6XpyF89jk1v_rsNgnfX10UtkRxXpQ@mail.gmail.com>
	<D2683AC6.8AB2%evgeniy.firsov@sandisk.com>
	<CALZt5jyuAH_aYYyzSEmn03QXaJQsfLiF=HMB6FJ5xEq6LMhFag@mail.gmail.com>
	<CALZt5jwOOp1gnBqO1vbmj2Kyborebz_Os79YcE1zeTMwumfp8A@mail.gmail.com>
	<CALZt5jyirEnrsStRknq9HcX5JqkoMcg+-=0KFoSGrzWCV2m=hw@mail.gmail.com>
	<alpine.DEB.2.00.1511110510440.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37930 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbKKNuv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 08:50:51 -0500
Received: by wmec201 with SMTP id c201so47428008wme.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 05:50:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511110510440.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

2015-11-11 21:13 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 11 Nov 2015, Ning Yao wrote:
>> >>>the code logic would touch crc cache is bufferlist::crc32c and invalidate_crc.
>> >>Also for pg_log::_write_log(), but seems it is always miss and use at
>> >>once, no need to cache crc actually?
>> > Oh, no, it will be hit in FileJournal writing
>> Still miss as buffer::ptr length diff with ::encode(crc, bl), right?
>> So the previous ebl.crc32c(0) calculation would be also no need to
>> cache.
>
> How about just skipping the cache logic if the raw length is less than
> some threshold?  Say, 16KB or something?  That would cover the _write_log
> case (small buffer) and more generally avoid the fixed overhead of caching
> when recalculating is cheap.
>
> This was originally added with large writes in mind to avoid the crc
> recalculation during journaling on armv7l.  It is presumably also helping
> now that we have the opportunistic whole-object checksums for full or
> sequential writes.

Reasonable,  and we may also reconsider whether
map<pair<size_t,size_t>, <int, int> > is really needed. The common
case seems always use the same offset and length. Is it better for us
to just cache the last crc result (only one item is enough efficient)?

Regards
Ning Yao
