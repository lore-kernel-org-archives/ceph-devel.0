From: Ridge Chen <ridge.chen@gmail.com>
Subject: Re: Sequential write performance on cloning images
Date: Tue, 16 Aug 2016 10:05:46 +0800
Message-ID: <CAOb-7EwU_sE_T5geNU6OHHO_x5XZG3E3ZqfOxOqbDi8Ss6p5fg@mail.gmail.com>
References: <CAOb-7EzSpjYp9dZB4j2UoTgB6H0WZM5SeC2rJ=EYMc9R9a6x3Q@mail.gmail.com>
 <CA+aFP1D+gBbTK=JiJSG=nevZoxxTAq=OgU6GGFQ=uO0smLsCKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36213 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbcHPCFr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 22:05:47 -0400
Received: by mail-io0-f171.google.com with SMTP id b62so95330814iod.3
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 19:05:47 -0700 (PDT)
In-Reply-To: <CA+aFP1D+gBbTK=JiJSG=nevZoxxTAq=OgU6GGFQ=uO0smLsCKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi

Thanks for your quick response.

Yes, the result is similar with object-map disabled. And in all my
tests the librbd cache is disabled.

Could you explain more about the additional "assert object exists"
operation? what it does in osd side?

And can we bypass the operation in this very common case based on the
object-map feature?

Regards,
Ridge

2016-08-15 20:16 GMT+08:00 Jason Dillaman <jdillama@redhat.com>:
> On Sun, Aug 14, 2016 at 10:41 PM, Ridge Chen <ridge.chen@gmail.com> wrote:
>> I have tested on hammer and jewel, the results are similar. Is it expected?
>
> In this case, there actually would not be an extra copy-up since you
> already performed the necessary copy-ups during the "dd" against
> "clone-vol1". The only difference, on the librbd side, is that the
> write operation would have an additional "assert object exists"
> operation before the write operation.
>
> Do you see similar differences with the librbd cache disabled and the
> object map disabled?
>
>
>
> --
> Jason
