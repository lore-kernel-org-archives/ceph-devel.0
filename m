From: Andrzej Jakowski <andrzej.jakowski@gmail.com>
Subject: Re: Deep scrubbing
Date: Mon, 24 Oct 2016 20:20:38 -0700
Message-ID: <CAOmo8DaC0A605-37WPYVd4nMpYJ+Pxg0oDqMFkEXQKwWgzGurQ@mail.gmail.com>
References: <CAOmo8DZHhJPD-uozsSk7djUxQBdfoBp6UDu7Ou1Bwc8vwHRtiQ@mail.gmail.com>
 <CAJE9aOO5svW_AZLzDkJ4hfh2Lc0co4e_Swe6g8pmscKrr_rbpQ@mail.gmail.com> <CAOmo8DY7XJ5dgQV7wZL2K7TkvSJ==+=Tk9yNFw3bO_nZ3Y5ERQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33085 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbcJYDUj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 23:20:39 -0400
Received: by mail-ua0-f178.google.com with SMTP id 6so28391715uat.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 20:20:39 -0700 (PDT)
In-Reply-To: <CAOmo8DY7XJ5dgQV7wZL2K7TkvSJ==+=Tk9yNFw3bO_nZ3Y5ERQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

2016-10-24 19:27 GMT-07:00 kefu chai <tchaikov@gmail.com>:
> posting this to ceph-users mailing list.
>
> On Tue, Oct 25, 2016 at 2:02 AM, Andrzej Jakowski
> <andrzej.jakowski@gmail.com> wrote:
>> Hi,
>>
>> Wanted to learn more on what is the Ceph community take on the deep
>> scrubbing process.
>> It seems that deep scrubbing is expected to read data from physical
>> media: NAND dies or magnetic platters.
>> What in case if OSD is build on top of some kind of volume and the
>> logic in the volume manager prevents OSD scrubbing process to read the
>> data from physical media?
>
> so it's a read only media, and read-only only for scrubbing. so you
> have no choice but to disable the scrub, i guess?
>
> $ ceph osd set noscrub
> $ ceph osd set nodeep-scrub

No, let me rephrase this. We can imagine following situation: Logical
volume manager
implements some kind of caching. OSD is built on top of the cache
volume. If deep scrubbing
is done, data may not be read from primary storage but from cache due
to cache hit.
In case if data is corrupted in the primary storage deep scrubbing may
not be detect it.
Is there a way for OSD to force reading data from primary storage device?

>>
>> Thanks!
>> Andrzej Jakowski
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai
