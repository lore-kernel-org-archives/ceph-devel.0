From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: filestore flusher = false  , correct my problem of constant write
 (need info on this parameter)
Date: Sat, 23 Jun 2012 11:40:28 -0500
Message-ID: <4FE5F17C.5070708@inktank.com>
References: <1fa246cc-38d3-486d-bd55-1f809d229074@mailpro> <Pine.LNX.4.64.1206230834570.20561@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41919 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab2FWQkb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 12:40:31 -0400
Received: by ghrr11 with SMTP id r11so2187133ghr.19
        for <ceph-devel@vger.kernel.org>; Sat, 23 Jun 2012 09:40:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206230834570.20561@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org, Stefan Priebe <s.priebe@profihost.ag>

On 6/23/12 10:38 AM, Sage Weil wrote:
> On Fri, 22 Jun 2012, Alexandre DERUMIER wrote:
>> Hi Sage,
>> thanks for your response.
>>
>>>> If you turn off the journal compeletely, you will see bursty write commits
>>> >from the perspective of the client, because the OSD is periodically doing
>>>> a sync or snapshot and only acking the writes then.
>>>> If you enable the journal, the OSD will reply with a commit as soon as the
>>>> write is stable in the journal. That's one reason why it is there--file
>>>> system commits of heavyweight and slow.
>>
>> Yes of course, I don't wan't to desactivate journal, using a journal on a fast ssd or nvram is the right way.
>>
>>>> If we left the file system to its own devices and did a sync every 10
>>>> seconds, the disk would sit idle while a bunch of dirty data accumulated
>>>> in cache, and then the sync/snapshot would take a really long time. This
>>>> is horribly inefficient (the disk is idle half the time), and useless (the
>>>> delayed write behavior makes sense for local workloads, but not servers
>>>> where there is a client on the other end batching its writes). To prevent
>>>> this, 'filestore flusher' will prod the kernel to flush out any written
>>>> data to the disk quickly. Then, when we get around to doing the
>>>> sync/snapshot it is pretty quick, because only fs metadata and
>>>> just-written data needs to be flushed.
>>
>> mmm, I disagree.
>>
>> If you flush quickly, it's works fine with sequential write workload.
>>
>> But if you have a lot of random write with 4k block by exemple, you are
>> going to have a lot of disk seeks. The way zfs works or netapp san
>> storage works, they take random writes in a fast journal then flush them
>> sequentially each 20s to slow storage.
>
> Oh, I see what you're getting at.  Yes, that is not ideal for small random
> writes.  There is a branch in ceph.git called wip-flushmin that just sets
> a minimum write size for the flush that will probably do a decent job of
> dealing with this: small writes won't get flushed, large ones will.
> Picking the right value will depend on how expensive seeks are for your
> storage system.
>
> You'll want to cherry-pick just the top commit on top of whatever it is
> you're running...

I was just talking with Elder on IRC yesterday about looking into how 
much small network transfers are hurting us in cases like these.  Even 
with SSD based OSDs I haven't seen a very dramatic improvement in small 
request performance.  How tough would it be to aggregate requests into 
larger network transactions?  There would be a latency penalty of 
course, but we could flush a client side dirty cache pretty quickly and 
still benefit if we are getting bombarded with lots of tiny requests.

Mark
