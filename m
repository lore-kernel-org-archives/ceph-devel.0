From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: rados io hints
Date: Sat, 18 Jan 2014 13:52:13 +0800
Message-ID: <CACJqLyYEatEF04w17+qYUVVw3bOySt0AmXrU_cjxHAbX=eHSDQ@mail.gmail.com>
References: <alpine.DEB.2.00.1401171022030.6273@cobra.newdream.net>
	<alpine.DEB.2.00.1401171115060.6273@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35372 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaARFwO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Jan 2014 00:52:14 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so4832308pdi.7
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 21:52:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1401171115060.6273@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's great to performance, more advice from client is welcomed for ObjectStore
implementation.

Maybe the new operation can be just like fadvise, accept flags as argument and
ObjectStore will try to do it but not certainly.

KeyValueStore will also enjoy it and get much benefit from it.


On Sat, Jan 18, 2014 at 3:16 AM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 17 Jan 2014, Sage Weil wrote:
>> I think we need to add rados operations that provide hints to rados about
>> what the expected object sizes, alignment, and cacheability is.  In
>> particularly, I see two main wins:
>>
>>  - knowing that rbd images have a 4m size, librbd can pass a hint that
>> will let the osd do the xfs allocation size ioctl on new files so that
>> they are allocated in 1m or 4m chunks.  We've seen cases where users with
>> rbd workloads have very high levels of fragmentation in xfs and this would
>> mitigate that and probably have a pretty nice performance benefit.
>>
>>  - If the rbd (or other client) cache is enabled, we can pass a hint that
>> indicates that the OSD shouldn't keep the object pages around in cache.
>> This would just translate into an fadvise DONTNEED or similar.
>>
>> I think the challenge is to keep this as generic as possible from the
>> client's perspetive, but make sure that there is enough information to
>> translate it into a good set of low-level hints to the underlying backend
>> (like alignment size and fadvise).  For example, intuitively the 1m
>> allocation unit sounds about right to me, but rbd would probably
>> communicate to rados that the objects are expected to be 4m each (or
>> whatever the striping strategy is).  I'm thinking the "we shouldn't do an
>> allocation unit more than 1m" logic should live in the FileStore, tunable
>> via a config option?
>
> BTW, my initial thought is this should just be new rados operations, and
> the client should set the FAILOK flag so that older osds will ignore the
> fact that they don't understand the op.
>
> s
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
