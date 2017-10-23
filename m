From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Re: multiple client read/write in cephfs
Date: Mon, 23 Oct 2017 16:25:45 +0800
Message-ID: <2DB06C59-5D80-45B3-9847-E926FE60A823@gmail.com>
References: <F6B9A347-CD3E-42BF-B65A-3BAF61C1C284@gmail.com>
 <CAAM7YAnHFiEq6qiL9_+S7ZWEpZN-0pnom2-TCiztzQdM6QbVaw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47982 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdJWIZt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 04:25:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id z11so16549711pfk.4
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 01:25:48 -0700 (PDT)
In-Reply-To: <CAAM7YAnHFiEq6qiL9_+S7ZWEpZN-0pnom2-TCiztzQdM6QbVaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>


Thanks Zheng,  so, do you mean client B can have =A1=B0Fs" cap and thle =
same time client A can have =A1=B0Fw=A1=B1 for the same file ?
so that, client A and client B can write and read the same file at same =
time (different object) ?

also another extended question, does that mean client A and client B can =
both have the =A1=B0Fw=A1=B1 for the same file same time, and also they =
can write the same file at same time (different object)  ?=20

Dongdong



> =D4=DA 2017=C4=EA10=D4=C223=C8=D5=A3=AC=CF=C2=CE=E73:55=A3=ACYan, =
Zheng <ukernel@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Mon, Oct 23, 2017 at 12:50 PM, =CC=D5=B6=AC=B6=AC =
<tdd21151186@gmail.com> wrote:
>> Dear Cephers,
>>=20
>> I have one issue about cephfs, suppose we got below scenario:
>> client A write one file with interval1 (offset1, length1)
>> then client B read the same file with interval2 (offset2, length2).
>> but due to capability system controlled by mds,  client B have to =
wait until client A finish its write operation (including flushing its =
buffer to osd)
>=20
> Client B only need to wait until Client A finishes flush buffer to
> osd. If Client B keeps the file descriptor open, writing to page cache
> gets disabled on client A, reading from client B does not need to wait
> for writing on client A (different object).
>=20
>> Even if interval1 and interval2 belongs to two different object of =
that file,  client B still  have to wait client A.
>>=20
>> I=A1=AFm wondering why mds doesn=A1=AFt try to control the caps based =
on object rather than whole file?
>=20
> because mds can't foresee which offset client want to read/write. the
> overhead for issuing caps for each read/write syscall is too high.
>=20
>>=20
>> Thanks,
>> Dongdong

