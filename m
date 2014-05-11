From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: crash in rbd_img_request_create
Date: Sun, 11 May 2014 13:33:47 +0400
Message-ID: <CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>
	<536EEA5C.70503@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34296 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaEKJds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 May 2014 05:33:48 -0400
Received: by mail-qg0-f46.google.com with SMTP id q108so6261331qgd.5
        for <ceph-devel@vger.kernel.org>; Sun, 11 May 2014 02:33:47 -0700 (PDT)
In-Reply-To: <536EEA5C.70503@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Hannes Landeholm <hannes@jumpstarter.io>, Ceph Development <ceph-devel@vger.kernel.org>, Thorwald Lundqvist <thorwald@jumpstarter.io>

On Sun, May 11, 2014 at 7:11 AM, Alex Elder <elder@ieee.org> wrote:
> On 05/10/2014 05:18 PM, Hannes Landeholm wrote:
>> Hello,
>>
>> I have a development machine that I have been running stress tests on
>> for a week as I'm trying to reproduce some hard to reproduce failures.
>> I've mentioned the same machine previously in the thread "rbd unmap
>> deadlock". I just now noticed that some processes had completely
>> stalled. I looked in the system log and saw this crash about 9 hours
>> ago:
>
> Are you still running kernel rbd as a client of ceph
> services running on the same physical machine?
>
> I personally believe that scenario may be at risk of
> deadlock in any case--we haven't taken great care to
> avoid it in this case.
>
> Anyway...
>
> I can build v3.14.1 but I don't know what kernel configuration
> you are using.  Knowing that could be helpful.  I built it using
> a config I have though, and it's *possible* you crashed on
> this line, in rbd_segment_name():
>         ret = snprintf(name, CEPH_MAX_OID_NAME_LEN + 1, name_format,
>                         rbd_dev->header.object_prefix, segment);
> And if so, the only reason I can think that this failed is if
> rbd_dev->header.object_prefix were null (or an otherwise bad
> pointer value).  But at this point it's a lot of speculation.

More precisely, it crashed on

segment = offset >> rbd_dev->header.obj_order;

while loading obj_order.  rbd_dev is ffff87ff3fbcdc00, which suggests
a use after free of some sort.  (This is the first rbd_dev deref after
grabbing it from img_request at the top of rbd_img_request_fill(),
which got it from request_queue::queuedata in rbd_request_fn().)

Thanks,

                Ilya
