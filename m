From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Deep scrubbing
Date: Wed, 26 Oct 2016 12:13:22 +0200
Message-ID: <411e6078-bd48-4b01-36b6-146555cb1691@digiware.nl>
References: <CAOmo8DZHhJPD-uozsSk7djUxQBdfoBp6UDu7Ou1Bwc8vwHRtiQ@mail.gmail.com>
 <CAJE9aOO5svW_AZLzDkJ4hfh2Lc0co4e_Swe6g8pmscKrr_rbpQ@mail.gmail.com>
 <CAOmo8DY7XJ5dgQV7wZL2K7TkvSJ==+=Tk9yNFw3bO_nZ3Y5ERQ@mail.gmail.com>
 <CAOmo8DaC0A605-37WPYVd4nMpYJ+Pxg0oDqMFkEXQKwWgzGurQ@mail.gmail.com>
 <CABZ+qq=gr6jtJ0geyEA=K_Lrg=V6EZnQ10Ku3dyggsDEVstrtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25816 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753949AbcJZKN1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 26 Oct 2016 06:13:27 -0400
In-Reply-To: <CABZ+qq=gr6jtJ0geyEA=K_Lrg=V6EZnQ10Ku3dyggsDEVstrtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>, Andrzej Jakowski <andrzej.jakowski@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 26-10-2016 10:32, Dan van der Ster wrote:
> On Tue, Oct 25, 2016 at 5:20 AM, Andrzej Jakowski
> <andrzej.jakowski@gmail.com> wrote:
>> 2016-10-24 19:27 GMT-07:00 kefu chai <tchaikov@gmail.com>:
>>> posting this to ceph-users mailing list.
>>>
>>> On Tue, Oct 25, 2016 at 2:02 AM, Andrzej Jakowski
>>> <andrzej.jakowski@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> Wanted to learn more on what is the Ceph community take on the deep
>>>> scrubbing process.
>>>> It seems that deep scrubbing is expected to read data from physical
>>>> media: NAND dies or magnetic platters.
>>>> What in case if OSD is build on top of some kind of volume and the
>>>> logic in the volume manager prevents OSD scrubbing process to read the
>>>> data from physical media?
>>>
>>> so it's a read only media, and read-only only for scrubbing. so you
>>> have no choice but to disable the scrub, i guess?
>>>
>>> $ ceph osd set noscrub
>>> $ ceph osd set nodeep-scrub
>>
>> No, let me rephrase this. We can imagine following situation: Logical
>> volume manager
>> implements some kind of caching. OSD is built on top of the cache
>> volume. If deep scrubbing
>> is done, data may not be read from primary storage but from cache due
>> to cache hit.
>> In case if data is corrupted in the primary storage deep scrubbing may
>> not be detect it.
>> Is there a way for OSD to force reading data from primary storage device?
> 
> I've had this same concern in relation to bcache/dm-cache/iCAS
> accelerated OSDs. It seems that deep scrubbing would be useless if
> you're reading the cached data and not the HDD itself. And to make
> things worse, deep scrubbing will tend to thrash the cache and evict
> all the hot data, making the cache itself of less value.
> 
> So in general, for these things to be useful we need a way to identify
> and bypass the cache for deep scrub IOs. (and there are probably other
> types of IO that we don't want to cache, such as reads for
> backfilling).
> 
> I've worked a bit with iCAS, and it allows you to define a policy
> whereby reads above a particular size bypass the cache. And AFAIK
> bcache will bypass the cache for sequential IO. Maybe these help,
> maybe not...
> I've heard that RedHat is working on dm-cache tooling for OSDs --
> maybe they already realized this problem and have a good solution.

I think this is going to be the same once Ceph runs on top of ZFS.
ZFS itself is already a few layers of software before you get to the
platters.

So I think that deeps scrubbing is a convoluted business:
1) Get ZFS to scrub.
   Of which it does a rather nice job. I don't think I seen
   corrupt data that ZFS did not tell me about, and usually
   could repair. Check-summing on ZFS is rather strong.
2) Flush the Ceph cache and all other things that keep data.
3) Get Ceph to deep scrub.

But all in all is this going to be a long and painful undertaking,
because ZFS scrub can take quite some time.

Now if you are using middleware storage that can not check its own
consistency. But if you can also not puncture holes in the layers in
between then guaranteeing any consistency get hard real fast.

Not even considering things like crypto and/or compression that could be
stuck in there at just every level.

just my 2cts,
--WjW

