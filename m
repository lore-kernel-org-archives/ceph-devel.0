From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Fri, 18 Mar 2016 18:53:50 +0300
Message-ID: <56EC248E.3060502@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <56EACAAD.90002@mirantis.com>
 <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36500 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbcCRPxq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2016 11:53:46 -0400
Received: by mail-lb0-f181.google.com with SMTP id qe11so36983003lbc.3
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2016 08:53:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 17.03.2016 18:33, Sage Weil wrote:
> I'd say "maybe". It's easy to say we should focus on read performance 
> now, but as soon as we have "support for compression" everybody is 
> going to want to turn it on on all of their clusters to spend less 
> money on hard disks. That will definitely include RBD users, where 
> write latency is very important. I'm hesitant to take an architectural 
> direction that locks us in. With something layered over BlueStore I 
> think we're forced to do it all in the initial phase; with the 
> monolithic approach that integrates it into BlueStore's write path we 
> have the option to do either one--perhaps based on the particular 
> request or hints or whatever.
>>>>> What do you think?
>>>>>
>>>>> It would be nice to choose a simpler strategy for the first pass that
>>>>> handles a subset of write patterns (i.e., sequential writes, possibly
>>>>> unaligned) that is still a step in the direction of the more robust
>>>>> strategy we expect to implement after that.
>>>>>
>>>> I'd probably agree but.... I don't see a good way how one can implement
>>>> compression for specific write patterns only.
>>>> We need to either ensure that these patterns are used exclusively ( append
>>>> only / sequential only flags? ) or provide some means to fall back to
>>>> regular
>>>> mode when inappropriate write occurs.
>>>> Don't think both are good and/or easy enough.
>>> Well, if we simply don't implement a garbage collector, then for
>>> sequential+aligned writes we don't end up with stuff that needs garbage
>>> collection.  Even the sequential case might be doable if we make it
>>> possible to fill the extent with a sequence of compressed strings (as long
>>> as we haven't reached the compressed length, try to restart the
>>> decompression stream).
>> It's still unclear to me if such specific patterns should be exclusively
>> applied to the object. E.g. by using specific object creation mode mode.
>> Or we should detect them automatically and be able to fall back to regular
>> write ( i.e. disable compression )  when write doesn't conform to the
>> supported pattern.
> I think initially supporting only the append workload is a simple check
> for whether the offset == the object size (and maybe whether it is
> aligned).  No persistent flags or hints needed there.
Well, but issues appear immediately after some overwrite request takes 
place.
How to handle overwrites? To do compression for the overwritten or not? 
If not - we need some way to be able to merge compressed and 
uncompressed blocks. And so on and so forth
IMO it's hard (or even impossible) to apply compression for specific 
write patterns only unless you prohibit other ones.
We can support a subset of compression policies ( i.e. ways how we 
resolve compression issues: RMW at init phase, lazy overwrite, WAL use, 
etc ) but not a subset of write patterns.

>> And I'm not following the idea about "a sequence of compressed strings". Could
>> you please elaborate?
> Let's say we have 32KB compressed_blocks, and the client is doing 1000
> byte appends.  We will allocate a 32 chunk on disk, and only fill it with
> say ~500 bytes of compressed data.  When the next write comes around, we
> could compress it too and append it to the block without decompressing the
> previous string.
>
> By string I mean that each compression cycle looks something like
>
>   start(...)
>   while (more data)
>     compress_some_stuff(...)
>   finish(...)
>
> i.e., there's a header and maybe a footer in the compressed string.  If we
> are decompressing and the decompressor says "done" but there is more data
> in our compressed block, we could repeat the process until we get to the
> end of the compressed data.
Got it, thanks for clarification
> But it might not matter or be worth it.  If the compressed blocks are
> smallish then decompressing, appending, and recompressing isn't going to
> be that expensive anyway.  I'm mostly worried about small appends, e.g. by
> rbd mirroring (imaging 4 KB writes + some metadata) or the MDS journal.
That's mainly about small appends not small writes, right?

At this point I agree with Allen that we need variable policies to 
handle compression. Most probably we wouldn't be able to create single 
one that fits perfect for any write pattern.
The only concern about that is the complexity of such a task...
> sage
Thanks,
Igor
