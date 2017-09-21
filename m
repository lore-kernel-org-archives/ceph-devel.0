From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Re: inconsistent file issue
Date: Thu, 21 Sep 2017 23:00:51 +0800
Message-ID: <25A9902F-640B-4581-B0D2-3D845807BF63@gmail.com>
References: <571AAE95-D681-4887-BBFA-86163B6DA800@gmail.com>
 <CAAM7YAntnQBNMz5DbZ2X8C6dDUeTnLNZ=O01bJZ8KcndWgthNQ@mail.gmail.com>
 <2169D938-C686-4B14-B612-0FEBFECBC777@gmail.com>
 <CAAM7YAnmMAKX4kv0qjNCSJmsvOGWaUd+EcfGhzRW4Ew4Mw3=Ng@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36845 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdIUPBE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Sep 2017 11:01:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id f84so2594838pfj.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 Sep 2017 08:01:04 -0700 (PDT)
In-Reply-To: <CAAM7YAnmMAKX4kv0qjNCSJmsvOGWaUd+EcfGhzRW4Ew4Mw3=Ng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

sorry, i don=A1=AFt have the detail log that could show if the mds has =
revoked the cap successful

i have done =A1=B0echo 1 > /proc/sys/vm/drop_caches=A1=B1,  and after =
that the client can read the latest data.

i have tried =A1=B0ceph +p > /sys/kernel/debug/dynamic_debug/control=A1=B1=
 to enable the kernel log.=20
but where can i find the ceph log ?

could you please show me the code path that directly operate on page =
cache without checking CEPH_CAP_FILE_CACHE   in kernel 3.10  ?=20

Thanks,
Dongdong

> =D4=DA 2017=C4=EA9=D4=C221=C8=D5=A3=AC=CF=C2=CE=E710:38=A3=ACYan, =
Zheng <ukernel@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Thu, Sep 21, 2017 at 8:25 PM, =CC=D5=B6=AC=B6=AC =
<tdd21151186@gmail.com> wrote:
>>=20
>> thanks zheng,
>>=20
>> that issue happened again today.
>> and from the log, client A write one file, but the mds didn=A1=AFt =
revoke the
>> CEPH_CAP_FILE_CACHE of the file from client B.
>> so that, when client B trying to read that file, client B just read =
it from
>> its page cache which has the old data.
>=20
> Are you sure that mds didn't revoke CEPH_CAP_FILE_CACHE? could you
> provide mds log. In old version kernel, there are code paths that
> operate directly on page cache, without checking if
> CEPH_CAP_FILE_CACHE is issued.
>=20
> Regards
> Yan, Zheng
>=20
>=20
>>=20
>> Regards,
>> Dongdong
>>=20
>> =D4=DA 2017=C4=EA9=D4=C221=C8=D5=A3=AC=CF=C2=CE=E78:00=A3=ACYan, =
Zheng <ukernel@gmail.com> =D0=B4=B5=C0=A3=BA
>>=20
>> On Wed, Sep 20, 2017 at 11:42 AM, =CC=D5=B6=AC=B6=AC =
<tdd21151186@gmail.com> wrote:
>>=20
>> Hi Zheng,
>>=20
>> we have been suffering from an inconsistent issue in cephfs :
>>=20
>> kernel version : 3.1.0
>> ceph version: 10.2.5
>>=20
>> we are using the kernel client to mount cephfs
>> we mount the ceph filesystem on two machines all with kernel 3.1.0,
>> but the strange thing is that the content of one same file is =
different from
>> the two machines.
>> and we are certain one machine has the correct content.
>>=20
>> we didn=A1=AFt know the way to reproduce it , and we don=A1=AFt have =
the log here.
>> i=A1=AFm wondering maybe it=A1=AFs because  there is some bug within =
kernel client, so
>> that the client think
>> it has enough capability to read it just from it=A1=AFs buffer, no =
need to get
>> the cap from mds, so it didn=A1=AFt get the latest content.
>>=20
>> since the kernel is too old, may be you have fixed this kind =
inconsistent
>> issues ?
>>=20
>>=20
>> we fixed a splice issue about 1 year ago, it could cause inconsistent
>> data when multiples client read/write a file at the same time. The
>> issue the is the only bug I remember, that can cause inconsistent
>> data. Please try recent kernel, check if the issue still happen.
>>=20
>> Regards
>> Yan, Zheng
>>=20
>>=20
>> Regards,
>> Dongdong
>>=20
>>=20

