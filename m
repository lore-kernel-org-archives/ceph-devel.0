From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: Re: rocked crash in 12.1.0 release when ran fio+libfio_objectstore.so
Date: Thu, 13 Jul 2017 11:15:38 +0800
Message-ID: <CAMwhyqXX7RPC8M54t7brOqrTRDNmMoA7BrGYUVDyrHu7X=jLEA@mail.gmail.com>
References: <CAMwhyqW3vhQRrwRkoxGsbDp8NQZcqA3tVm9eO_E-pb1T3sFANA@mail.gmail.com>
 <alpine.DEB.2.11.1707121356090.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36558 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdGMDPk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 23:15:40 -0400
Received: by mail-ua0-f176.google.com with SMTP id g40so26059486uaa.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 20:15:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707121356090.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, 20702390@qq.com

Hi Sage=EF=BC=8C

I ran again for half an hour, this time this crash not be reproduced,
but yes, there is issue about memory=EF=BC=9A

At the beginning, only small amount of memory were used:
   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAN=
D
 32801 root      20   0 1282300 453480 269344 S 196.0  0.3   0:17.99 fio

But after 30 mins, RES went up to 20G, and VIRT went up to 22G ...

Seems memory leak? I will use valgrind to san it.

Thanks
Pan

2017-07-12 21:56 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>> Hi Cephers,
>>
>> When I ran fio_libfio_objectstore.so, I met a crash below after ran 10 m=
ins:
>>
>> https://drive.google.com/open?id=3D0B1m1ON51YNOSTFRHRng3YksxRkk
>>
>> I made three disk partitions=EF=BC=9A
>> 1) db part, 50GB
>> 2) wal part, 50GB
>> 3) data part, others.
>>
>> I used all default options of RocksDB.
>
> I haven't seen this one.  Did you exhaust memory?  (Can you reproduce and
> see what the memory utilization looks like?)
>
> sage
>
>>
>> Could anybody have some opinion?
>>
>> Thanks
>> Pan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
