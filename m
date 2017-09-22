From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: inconsistent file issue
Date: Fri, 22 Sep 2017 19:48:25 +0800
Message-ID: <CAAM7YAmVaGta8ZPsmeEs9w0xH_01kQf+cGZpEGTs974Yd2cjHw@mail.gmail.com>
References: <571AAE95-D681-4887-BBFA-86163B6DA800@gmail.com>
 <CAAM7YAntnQBNMz5DbZ2X8C6dDUeTnLNZ=O01bJZ8KcndWgthNQ@mail.gmail.com>
 <2169D938-C686-4B14-B612-0FEBFECBC777@gmail.com> <CAAM7YAnmMAKX4kv0qjNCSJmsvOGWaUd+EcfGhzRW4Ew4Mw3=Ng@mail.gmail.com>
 <25A9902F-640B-4581-B0D2-3D845807BF63@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:56499 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751928AbdIVLs1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Sep 2017 07:48:27 -0400
Received: by mail-io0-f178.google.com with SMTP id m103so2406678iod.13
        for <ceph-devel@vger.kernel.org>; Fri, 22 Sep 2017 04:48:26 -0700 (PDT)
In-Reply-To: <25A9902F-640B-4581-B0D2-3D845807BF63@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 21, 2017 at 11:00 PM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@=
gmail.com> wrote:
> sorry, i don=E2=80=99t have the detail log that could show if the mds has=
 revoked the cap successful
>
> i have done =E2=80=9Cecho 1 > /proc/sys/vm/drop_caches=E2=80=9D,  and aft=
er that the client can read the latest data.
>
> i have tried =E2=80=9Cceph +p > /sys/kernel/debug/dynamic_debug/control=
=E2=80=9D to enable the kernel log.
> but where can i find the ceph log ?
>
> could you please show me the code path that directly operate on page cach=
e without checking CEPH_CAP_FILE_CACHE   in kernel 3.10  ?
>

splice_read, splice_write and readahead

> Thanks,
> Dongdong
>
>> =E5=9C=A8 2017=E5=B9=B49=E6=9C=8821=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=881=
0:38=EF=BC=8CYan, Zheng <ukernel@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Thu, Sep 21, 2017 at 8:25 PM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd2115118=
6@gmail.com> wrote:
>>>
>>> thanks zheng,
>>>
>>> that issue happened again today.
>>> and from the log, client A write one file, but the mds didn=E2=80=99t r=
evoke the
>>> CEPH_CAP_FILE_CACHE of the file from client B.
>>> so that, when client B trying to read that file, client B just read it =
from
>>> its page cache which has the old data.
>>
>> Are you sure that mds didn't revoke CEPH_CAP_FILE_CACHE? could you
>> provide mds log. In old version kernel, there are code paths that
>> operate directly on page cache, without checking if
>> CEPH_CAP_FILE_CACHE is issued.
>>
>> Regards
>> Yan, Zheng
>>
>>
>>>
>>> Regards,
>>> Dongdong
>>>
>>> =E5=9C=A8 2017=E5=B9=B49=E6=9C=8821=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
8:00=EF=BC=8CYan, Zheng <ukernel@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> On Wed, Sep 20, 2017 at 11:42 AM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151=
186@gmail.com> wrote:
>>>
>>> Hi Zheng,
>>>
>>> we have been suffering from an inconsistent issue in cephfs :
>>>
>>> kernel version : 3.1.0
>>> ceph version: 10.2.5
>>>
>>> we are using the kernel client to mount cephfs
>>> we mount the ceph filesystem on two machines all with kernel 3.1.0,
>>> but the strange thing is that the content of one same file is different=
 from
>>> the two machines.
>>> and we are certain one machine has the correct content.
>>>
>>> we didn=E2=80=99t know the way to reproduce it , and we don=E2=80=99t h=
ave the log here.
>>> i=E2=80=99m wondering maybe it=E2=80=99s because  there is some bug wit=
hin kernel client, so
>>> that the client think
>>> it has enough capability to read it just from it=E2=80=99s buffer, no n=
eed to get
>>> the cap from mds, so it didn=E2=80=99t get the latest content.
>>>
>>> since the kernel is too old, may be you have fixed this kind inconsiste=
nt
>>> issues ?
>>>
>>>
>>> we fixed a splice issue about 1 year ago, it could cause inconsistent
>>> data when multiples client read/write a file at the same time. The
>>> issue the is the only bug I remember, that can cause inconsistent
>>> data. Please try recent kernel, check if the issue still happen.
>>>
>>> Regards
>>> Yan, Zheng
>>>
>>>
>>> Regards,
>>> Dongdong
>>>
>>>
>
