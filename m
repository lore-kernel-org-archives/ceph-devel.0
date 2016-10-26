From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Deep scrubbing
Date: Wed, 26 Oct 2016 10:32:50 +0200
Message-ID: <CABZ+qq=gr6jtJ0geyEA=K_Lrg=V6EZnQ10Ku3dyggsDEVstrtw@mail.gmail.com>
References: <CAOmo8DZHhJPD-uozsSk7djUxQBdfoBp6UDu7Ou1Bwc8vwHRtiQ@mail.gmail.com>
 <CAJE9aOO5svW_AZLzDkJ4hfh2Lc0co4e_Swe6g8pmscKrr_rbpQ@mail.gmail.com>
 <CAOmo8DY7XJ5dgQV7wZL2K7TkvSJ==+=Tk9yNFw3bO_nZ3Y5ERQ@mail.gmail.com> <CAOmo8DaC0A605-37WPYVd4nMpYJ+Pxg0oDqMFkEXQKwWgzGurQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:38766 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcJZIde (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 04:33:34 -0400
Received: by mail-lf0-f41.google.com with SMTP id d20so2225428lfj.5
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 01:33:33 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id jq10sm1205215wjb.46.2016.10.26.01.33.31
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2016 01:33:31 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id b80so211069249wme.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 01:33:31 -0700 (PDT)
In-Reply-To: <CAOmo8DaC0A605-37WPYVd4nMpYJ+Pxg0oDqMFkEXQKwWgzGurQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrzej Jakowski <andrzej.jakowski@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Oct 25, 2016 at 5:20 AM, Andrzej Jakowski
<andrzej.jakowski@gmail.com> wrote:
> 2016-10-24 19:27 GMT-07:00 kefu chai <tchaikov@gmail.com>:
>> posting this to ceph-users mailing list.
>>
>> On Tue, Oct 25, 2016 at 2:02 AM, Andrzej Jakowski
>> <andrzej.jakowski@gmail.com> wrote:
>>> Hi,
>>>
>>> Wanted to learn more on what is the Ceph community take on the deep
>>> scrubbing process.
>>> It seems that deep scrubbing is expected to read data from physical
>>> media: NAND dies or magnetic platters.
>>> What in case if OSD is build on top of some kind of volume and the
>>> logic in the volume manager prevents OSD scrubbing process to read the
>>> data from physical media?
>>
>> so it's a read only media, and read-only only for scrubbing. so you
>> have no choice but to disable the scrub, i guess?
>>
>> $ ceph osd set noscrub
>> $ ceph osd set nodeep-scrub
>
> No, let me rephrase this. We can imagine following situation: Logical
> volume manager
> implements some kind of caching. OSD is built on top of the cache
> volume. If deep scrubbing
> is done, data may not be read from primary storage but from cache due
> to cache hit.
> In case if data is corrupted in the primary storage deep scrubbing may
> not be detect it.
> Is there a way for OSD to force reading data from primary storage device?

I've had this same concern in relation to bcache/dm-cache/iCAS
accelerated OSDs. It seems that deep scrubbing would be useless if
you're reading the cached data and not the HDD itself. And to make
things worse, deep scrubbing will tend to thrash the cache and evict
all the hot data, making the cache itself of less value.

So in general, for these things to be useful we need a way to identify
and bypass the cache for deep scrub IOs. (and there are probably other
types of IO that we don't want to cache, such as reads for
backfilling).

I've worked a bit with iCAS, and it allows you to define a policy
whereby reads above a particular size bypass the cache. And AFAIK
bcache will bypass the cache for sequential IO. Maybe these help,
maybe not...
I've heard that RedHat is working on dm-cache tooling for OSDs --
maybe they already realized this problem and have a good solution.

Cheers, dan
