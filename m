From: huang jun <hjwsm1989@gmail.com>
Subject: Re: question about backfill on erasure pool
Date: Wed, 14 Dec 2016 09:01:24 +0800
Message-ID: <CABAwU-Y5mo_WefKozn6zLxBH3Vnb8OSaH2N30ExoHSm_fCEzSw@mail.gmail.com>
References: <CABAwU-b6m6xfLXvLwfR4DXMxW4kwzyvVYpKPm_NzRxzDWoROVA@mail.gmail.com>
 <alpine.DEB.2.11.1612131247350.32565@piezo.novalocal> <CAN=+7FWNccmp32oWy9sHhONBqdyf989Kq2ydSd_Ah3K_UydY6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33444 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754577AbcLNBB0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 20:01:26 -0500
Received: by mail-qt0-f171.google.com with SMTP id p16so4130973qta.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 17:01:26 -0800 (PST)
In-Reply-To: <CAN=+7FWNccmp32oWy9sHhONBqdyf989Kq2ydSd_Ah3K_UydY6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

2016-12-13 23:42 GMT+08:00 Samuel Just <sjust@redhat.com>:
> Actually, I'm not sure it wouldn't read the parity chunk from osd.3,
> I'd have to check.  However, the data would still go through the
> primary.
you reminder me, i will check the osd log,
it is expected if the osd1 read the parity chunk from osd.3(shard 2)
and then push it to osd.4?
> -Sam
>
> On Tue, Dec 13, 2016 at 4:48 AM, Sage Weil <sage@newdream.net> wrote:
>> On Tue, 13 Dec 2016, huang jun wrote:
>>> hi,all
>>> i have a question about pg backfill on erasure pool.
>>> pg0 in erasure pool, which k:m=2:1,
>>> at first, pg0 on osd [1,2,3], after osd.4 added,
>>> the pg0 is now distribute to osd [1,2,4],
>>> for replicated pool, it will do backfill from primary(osd.1) to osd.4,
>>> for erasure code pool, the primary osd.1 needs to read the data chunks
>>> from osd.1 and osd.2,
>>> then decode and push the parity chunk to osd.4,
>>> in the above case, the osd.3 is up and contain the parity chunk,
>>> why dont let osd.3 push the parity chunk to osd.4?
>>
>> I don't think there is any reason why we couldn't... it just hasn't been
>> implemented.  Sam?
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thank you!
HuangJun
