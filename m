From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: rados read ordering
Date: Wed, 10 Dec 2014 10:26:05 +0800
Message-ID: <CACJqLyavLaAsF3tyqz+5MbWfYaTwPwjYiWZRhti5iD7V6seQvg@mail.gmail.com>
References: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>
	<CABBk=J9iA=iwAqOBrQ3zDpUvEDH2JA17+WJLRU2gLz_fFdF55w@mail.gmail.com>
	<88C3E003BB3649489ED4ECA6C80410476BCEF6@ORSMSX102.amr.corp.intel.com>
	<alpine.DEB.2.00.1412091640140.22847@cobra.newdream.net>
	<06E7D85B3BA36C4DB207FEDE871C5348968009@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42649 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbaLJC0H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Dec 2014 21:26:07 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so9824718wiv.5
        for <ceph-devel@vger.kernel.org>; Tue, 09 Dec 2014 18:26:05 -0800 (PST)
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348968009@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: Sage Weil <sweil@redhat.com>, "Cook, Nigel" <nigel.cook@intel.com>, Yehuda Sadeh <yehuda@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Samuel Just <sjust@redhat.com>, Jason Dillaman <dillaman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 10, 2014 at 9:10 AM, Wang, Zhiqiang <zhiqiang.wang@intel.com> wrote:
> For multiple clients accessing the same volume, same object, I guess the clients need to do some synchronization between them to guarantee what it reads is what it wrote. That is to say, if two clients, say A and B, A is doing write, B is doing read. If B wants to read what A writes, it needs to know A has completed the write before issuing the read. If A hasn't completed the write yet, it could be possible that the write fails, so you can't expect B reads what A writes. I think this makes sense from the client/application perspective.

I think each write for a object is a barrier. If receiving a write op,
previous read ops all are allowed to out of order and read ops after
write op also can out of order.

I think it's still SERIALIZABLE level for rados client.

>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Wednesday, December 10, 2014 8:43 AM
> To: Cook, Nigel
> Cc: Yehuda Sadeh; Josh Durgin; Samuel Just; Wang, Zhiqiang; Jason Dillaman; ceph-devel
> Subject: Re: rados read ordering
>
> On Wed, 10 Dec 2014, Cook, Nigel wrote:
>> Folks
>>
>> I'm wondering if this is related to the question I posed a few days
>> ago..
>>
>>  Can CEPH support 2 clients simultaneously accessing a single volume -
>> for example a database cluster - and honor read and write order of
>> blocks across the multiple clients?
>>
>> Can you comment?
>
> I don't think so.  This (non)change is about a single client submitting two reads to a single object (say, different blocks in the same disk) and whether the OSD is allowed to respond out of order (say, because some blocks are in cache and some aren't).
>
> In the shared volume case, it is generally not important what happens with requests that are submitted in parallel.. they can take different amounts of time on the wire and which happens first (i.e., which arrives at the OSD first) depends on happenstance.  What does matter is that any read that happens after a complete write reflects that read, which is why the concern is around caching.
>
> sage
>
>
>>
>> Regards,
>> Nigel Cook +1 720 319 7508
>>
>> Sent from a mobile device.
>> Please excuse both my brevity and sp3lling
>>
>> On Dec 8, 2014 10:12 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>> On Mon, Dec 8, 2014 at 9:03 AM, Sage Weil <sweil@redhat.com> wrote:
>> > The current RADOS behavior is that reads (on any given object) are always
>> > processed in the order they are submitted by the client.  This causes a
>> > few headaches for the cache tiering that it would be nice to avoid.  It
>> > also occurs to me that there are likely cases where we could go a lot
>> > faster by not strictly ordering things.  For example, a stat can respond
>> > more quickly than a large read, and some reads may hit cache while others
>> > go to disk.  This doesn't happen currently because of the (lame) way we do
>> > reads synchronously, but hope that can change too.
>> >
>> > I propose we drop this semantic.  If a client wants reads to have a strict
>> > ordering, they can set the existing RWORDERED flag (which also orders them
>> > with respect to writes).  That's not the most general thing ever, but I'm
>> > not sure we care about callers who want reads ordered with respect to each
>> > other but not writes.
>> >
>> > The real question is whether there are any users that want/need this
>> > currently.  I can't think of any offhand.  In several places we submit
>> > multiple *writes* and expect them to be strictly ordered (e.g., we
>> > set a completion on teh last write only).  I don't think we do this
>> > anywhere for reads though...
>> >
>> > Josh, Yehuda, Jason--can you think of any in RBD or RGW that would depend
>> > on this?
>> >
>>
>> None that I can think of. For objects data, we already stripe it
>> across multiple objects, and the underlying assumption is that we're
>> going to get responses out of order so we make sure we commit
>> in-order. Guards are used on the head object, and the read is
>> synchronous there anyway. I can't think of any other place where we'd
>> have an issue.
>>
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
