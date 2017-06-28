From: Ning Yao <zay11022@gmail.com>
Subject: Re: cls_rbd copyup and write
Date: Wed, 28 Jun 2017 12:06:53 +0800
Message-ID: <CALZt5jx779G1QSOgSOXGN-OWhVO7ECV0mmYOk-d6J0WJ7mPNWw@mail.gmail.com>
References: <CALZt5jzk+8yS7SY6L+5BNvKuTGDZV+KOW5b=vDqO=R7t_o9Vfw@mail.gmail.com>
 <CA+aFP1AJRmsA57aEp-1jQkvLp=NW81hJqUHUM4+HRrpN=8ONHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34836 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdF1EGz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 00:06:55 -0400
Received: by mail-io0-f181.google.com with SMTP id h134so29186817iof.2
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 21:06:54 -0700 (PDT)
In-Reply-To: <CA+aFP1AJRmsA57aEp-1jQkvLp=NW81hJqUHUM4+HRrpN=8ONHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2017-06-27 21:40 GMT+08:00 Jason Dillaman <jdillama@redhat.com>:
> This is definitely an optimization we can test post-Luminous release
> once bluestore is the defacto OSD object store. Of course, even
> bluestore won't track holes down to 8KiB -- only 16KiB or 64KiB
> depending on your backing device and settings. I am pretty sure
> Luminous already has an optimization to not copy-up if the full parent
> object is zeroed.
you mean if the full parent object is zeroed, then it will not
copy-up?  But what about a 4M object only with several 16 KiB or 64KiB
holes in Bluestore, It seems those objects still read to rbd-client
side and send copy-up request to osd-side and I do not find bluestone
will treat the whole 64KiB allocated extents as holes if its data is
all zeros.


> I do remember a presentation about surprising results when
> implementing NFS v4.2 READ_PLUS sparse support where it actually
> degraded performance due to the need to seek the file holes. There
> might be a performance trade-off to consider when objects have lots of
> holes due to increased metadata plus decreased data locality.
Yeah, but I think if we can send a single MOSDOp containing several
OSDOps.  So it will be treat as a single transaction in osd-side and
deal with much more efficiently. If we send several MOSDOps, then it
will become bad since each transaction on osd-side will be queued and
processed serially  because the pg_lock and rw_lock for object.
Actually, we face the same issue when vm flush in-memory data on disk
and lots of adjacent but not continue writeOps will submit to osd-side
with Each MOSDOp simultaneously so that the single pg will process
each transaction one by one, which leads to a bad latency for those
ops at the end of the pg_wq queue.


> On Tue, Jun 27, 2017 at 4:22 AM, Ning Yao <zay11022@gmail.com> wrote:
>> Hi, all
>>
>> currently I find that when do copy on write for a clone image. librbd
>> call the cls copyup function to write the data, reading from its
>> parent, to the child.
>>
>> However, there is a issue here:  if an object in the parent image -->
>> [0, 8192] with data and [8192, end] without data, then after COW
>> operation, it will filling the whole object [0, end] to the children
>> object with [8192, end] all zeros. This phenomenon also occurs in
>> flatten images.
>>
>> Actually, we already have sparse_read to just read data without holes.
>> However, copyup function does not support to write serveral fragments
>> such as {[0, 8192], [16384,20480]}.
>>
>> So it that possible to direct send OSDOp {[cow write], [cow write],
>> [user write]} instead of  OSDOp {[copyup], [user write]} ?
>>
>>
>>
>> Regards
>> Ning Yao
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Jason
