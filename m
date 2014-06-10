From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Feature]Proposal for adding a new flag named shared to support
 performance and statistic purpose
Date: Tue, 10 Jun 2014 14:52:54 +0800
Message-ID: <CACJqLybz-aATGRKJ0_iSqEfHzRBaSWJRO_kyB9ic-yt2SGqYUg@mail.gmail.com>
References: <CACJqLyZoxqN69NarVLsWZan7aULwbULUAFwmGC5D_jiVTc=uqg@mail.gmail.com>
	<20140609181625.401b76d5@sietchtabr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:57594 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030AbaFJGw4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jun 2014 02:52:56 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so3246336wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jun 2014 23:52:55 -0700 (PDT)
In-Reply-To: <20140609181625.401b76d5@sietchtabr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks, Josh!

Your points are really helpful. Maybe we can schedule this bp to the
near CDS? The implementation I hope can has great performance effects
on librbd.



On Tue, Jun 10, 2014 at 9:16 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 06/05/2014 12:01 AM, Haomai Wang wrote:
>> Hi,
>> Previously I sent a mail about the difficult of rbd snapshot size
>> statistic. The main solution is using object map to store the changes.
>> The problem is we can't handle with multi client concurrent modify.
>>
>> Lack of object map(like pointer map in qcow2), it cause many problems
>> in librbd. Such as clone depth, the deep clone depth will cause
>> remarkable latency. Usually each clone wrap will increase two times of
>> latency.
>>
>> I consider to make a tradeoff between multi-client support and
>> single-client support for librbd. In practice, most of the
>> volumes/images are used by VM, there only exist one client will
>> access/modify image. We can't only want to make shared image possible
>> but make most of use cases bad. So we can add a new flag called
>> "shared" when creating image. If "shared" is false, librbd will
>> maintain a object map for each image. The object map is considered to
>> durable, each image_close call will store the map into rados. If the
>> client  is crashed and failed to dump the object map, the next client
>> open the image will think the object map as out of date and reset the
>> objectmap.
>>
>> We can easily find the advantage of this feature:
>> 1. Avoid clone performance problem
>> 2. Make snapshot statistic possible
>> 3. Improve librbd operation performance including read, copy-on-write
>> operation.
>>
>> What do you think above? More feedbacks are appreciate!
>
> I think it's a great idea! We discussed this a little at the last cds
> [1]. I like the idea of the shared flag on an image. Since the vastly
> more common case is single-client, I'd go further and suggest that
> we treat images as if shared is false by default if the flag is not
> present (perhaps with a config option to change this default behavior).
>
> That way existing images can benefit from the feature without extra
> configuration. There can be an rbd command to toggle the shared flag as
> well, so users of ocfs2 or gfs2 or other multi-client-writing systems
> can upgrade and set shared to true before restarting their clients.
>
> Another thing to consider is the granularity of the object map. The
> coarse granularity of a bitmap of object existence would be simplest,
> and most useful for in-memory comparison for clones. For statistics
> it might be desirable in the future to have a finer-grained index of
> data existence in the image. To make that easy to handle, the on-disk
> format could be a list of extents (byte ranges).
>
> Another potential use case would be a mode in which the index is
> treated as authoritative. This could make discard very fast, for
> example. I'm not sure it could be done safely with only binary
> 'exists/does not exist' information though - a third 'unknown' state
> might be needed for some cases. If this kind of index is actually useful
> (I'm not sure there are cases where the performance penalty would be
> worth it), we could add a new index format if we need it.
>
> Back to the currently proposed design, to be safe with live migration
> we'd need to make sure the index is consistent in the destination
> process. Using rados_notify() after we set the clean flag on the index
> can make the destination vm re-read the index before any I/O
> happens. This might be a good time to introduce a data payload to the
> notify as well, so we can only re-read the index, instead of all the
> header metadata. Rereading the index after cache invalidation and wiring
> that up through qemu's bdrv_invalidate() would be even better.
>
> There's more to consider in implementing this wrt snapshots, but this
> email has gone on long enough.
>
> Josh
>
> [1] http://pad.ceph.com/p/cdsgiant-rbd-copy-on-read-for-clones



-- 
Best Regards,

Wheat
