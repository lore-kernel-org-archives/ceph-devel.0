From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Thu, 17 Mar 2016 18:18:05 +0300
Message-ID: <56EACAAD.90002@mirantis.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35027 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030849AbcCQPSB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2016 11:18:01 -0400
Received: by mail-lb0-f180.google.com with SMTP id bc4so70700400lbc.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2016 08:18:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,

On 16.03.2016 22:27, Sage Weil wrote:
>> A potential issue with using WAL for compressed block overwrites is
>> significant WAL data volume increase. IIUC currently WAL record can have up to
>> 2*bluestore_min_alloc_size (i.e. 128K) client data per single write request -
>> overlapped head and tail.
>> In case of compressed blocks this will be up to
>> 2*bluestore_max_compressed_block ( i.e. 8Mb ) as you can't simply overwrite
>> fully overlapped extents - one should operate compression blocks now...
>>
>> Seems attractive otherwise...
> I think the way to address this is to make bluestore_max_compressed_block
> *much* smaller.  Like, 4x or 8x min_alloc_size, but no more.  That gives
> us a smallish rounding error of "lost" efficiency, but keeps the size of
> extents we have to read+decompress in the overwrite or small read cases
> reasonable.
>
> The tradeoff is the onode_t's block_map gets bigger... but for a ~4MB it's
> still only 5-10 records, which sounds fine to me.
Sounds good.
>>> b) we could just leave the overwritten extents alone and structure the
>>> block_map so that they are occluded.  This will 'leak' space for some
>>> write patterns, but that might be okay given that we can come back later
>>> and clean it up, or refine our strategy to be smarter.
>> Just to clarify I understand the idea properly. Are you suggesting to simply
>> write out new block to a new extent and update block map (and read procedure)
>> to use that new extent or remains of the overwritten extents depending on the
>> read offset? And overwritten extents are preserved intact until they are fully
>> hidden or some background cleanup procedure merge them.
>> If so I can see following pros and cons:
>> + write is faster
>> - compressed data read is potentially slower as you might need to decompress
>> more compressed blocks.
>> - space usage is higher
>> - need for garbage collector i.e. additional complexity
>>
>> Thus the question is what use patterns are at foreground and should be the
>> most effective.
>> IMO read performance and space saving are more important for the cases where
>> compression is needed.
Any feedback on the above please!

>>> What do you think?
>>>
>>> It would be nice to choose a simpler strategy for the first pass that
>>> handles a subset of write patterns (i.e., sequential writes, possibly
>>> unaligned) that is still a step in the direction of the more robust
>>> strategy we expect to implement after that.
>>>
>> I'd probably agree but.... I don't see a good way how one can implement
>> compression for specific write patterns only.
>> We need to either ensure that these patterns are used exclusively ( append
>> only / sequential only flags? ) or provide some means to fall back to regular
>> mode when inappropriate write occurs.
>> Don't think both are good and/or easy enough.
> Well, if we simply don't implement a garbage collector, then for
> sequential+aligned writes we don't end up with stuff that needs garbage
> collection.  Even the sequential case might be doable if we make it
> possible to fill the extent with a sequence of compressed strings (as long
> as we haven't reached the compressed length, try to restart the
> decompression stream).
It's still unclear to me if such specific patterns should be exclusively 
applied to the object. E.g. by using specific object creation mode mode.
Or we should detect them automatically and be able to fall back to 
regular write ( i.e. disable compression )  when write doesn't conform 
to the supported pattern.
And I'm not following the idea about "a sequence of compressed strings". 
Could you please elaborate?
>
>> In this aspect my original proposal to have compression engine more or less
>> segregated from the bluestore seems more attractive - there is no need to
>> refactor bluestore internals in this case. One can easily start using
>> compression or drop it and fall back to the current code state. No significant
>> modifications in run-time data structures and algorithms....
> It sounds like in theory, but when I try to sort out how it would actually
> work, it seems like you have to either expose all of the block_map
> metadata up to this layer, at which point you may as well do it down in
> BlueStore and have the option of deferred WAL work, or you do something
> really simple with fixed compression block sizes and get a weak final
> result.  Not to mention the EC problems (although some of that will go
> away when EC overwrites come along)...
I would agree with the comment about additional metadata handling 
complexity. I probably missed this one initially. But as I wrote to 
Allen before I don't understand EC problems... Never mind though..
> sage
Thanks,
Igor
