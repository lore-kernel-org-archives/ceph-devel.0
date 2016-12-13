From: Samuel Just <sjust@redhat.com>
Subject: Re: question about backfill on erasure pool
Date: Tue, 13 Dec 2016 07:42:17 -0800
Message-ID: <CAN=+7FWNccmp32oWy9sHhONBqdyf989Kq2ydSd_Ah3K_UydY6w@mail.gmail.com>
References: <CABAwU-b6m6xfLXvLwfR4DXMxW4kwzyvVYpKPm_NzRxzDWoROVA@mail.gmail.com>
 <alpine.DEB.2.11.1612131247350.32565@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33586 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbcLMPmT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 10:42:19 -0500
Received: by mail-qk0-f173.google.com with SMTP id x190so120128013qkb.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 07:42:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612131247350.32565@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: huang jun <hjwsm1989@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Actually, I'm not sure it wouldn't read the parity chunk from osd.3,
I'd have to check.  However, the data would still go through the
primary.
-Sam

On Tue, Dec 13, 2016 at 4:48 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 13 Dec 2016, huang jun wrote:
>> hi,all
>> i have a question about pg backfill on erasure pool.
>> pg0 in erasure pool, which k:m=2:1,
>> at first, pg0 on osd [1,2,3], after osd.4 added,
>> the pg0 is now distribute to osd [1,2,4],
>> for replicated pool, it will do backfill from primary(osd.1) to osd.4,
>> for erasure code pool, the primary osd.1 needs to read the data chunks
>> from osd.1 and osd.2,
>> then decode and push the parity chunk to osd.4,
>> in the above case, the osd.3 is up and contain the parity chunk,
>> why dont let osd.3 push the parity chunk to osd.4?
>
> I don't think there is any reason why we couldn't... it just hasn't been
> implemented.  Sam?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
