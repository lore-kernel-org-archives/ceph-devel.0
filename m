From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: multiple client read/write in cephfs
Date: Mon, 23 Oct 2017 17:38:19 +0800
Message-ID: <CAAM7YAkBHrmgiqErUXPhc84prFW8S-WVwdHgA7htim_UDO+76g@mail.gmail.com>
References: <F6B9A347-CD3E-42BF-B65A-3BAF61C1C284@gmail.com>
 <CAAM7YAnHFiEq6qiL9_+S7ZWEpZN-0pnom2-TCiztzQdM6QbVaw@mail.gmail.com> <2DB06C59-5D80-45B3-9847-E926FE60A823@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:48819 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdJWJiU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 05:38:20 -0400
Received: by mail-oi0-f45.google.com with SMTP id m198so29607392oig.5
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 02:38:20 -0700 (PDT)
In-Reply-To: <2DB06C59-5D80-45B3-9847-E926FE60A823@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>

On Mon, Oct 23, 2017 at 4:25 PM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@g=
mail.com> wrote:
>
> Thanks Zheng,  so, do you mean client B can have =E2=80=9CFs" cap and thl=
e same time client A can have =E2=80=9CFw=E2=80=9D for the same file ?
> so that, client A and client B can write and read the same file at same t=
ime (different object) ?
>

Reading within file size only requires "Fr" cap.  If read reaches file
size and there is no "Fs", checking EOF requires an extra getattr
request.


> also another extended question, does that mean client A and client B can =
both have the =E2=80=9CFw=E2=80=9D for the same file same time, and also th=
ey can write the same file at same time (different object)  ?
>
> Dongdong
>
>
>
>> =E5=9C=A8 2017=E5=B9=B410=E6=9C=8823=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
3:55=EF=BC=8CYan, Zheng <ukernel@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Mon, Oct 23, 2017 at 12:50 PM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd211511=
86@gmail.com> wrote:
>>> Dear Cephers,
>>>
>>> I have one issue about cephfs, suppose we got below scenario:
>>> client A write one file with interval1 (offset1, length1)
>>> then client B read the same file with interval2 (offset2, length2).
>>> but due to capability system controlled by mds,  client B have to wait =
until client A finish its write operation (including flushing its buffer to=
 osd)
>>
>> Client B only need to wait until Client A finishes flush buffer to
>> osd. If Client B keeps the file descriptor open, writing to page cache
>> gets disabled on client A, reading from client B does not need to wait
>> for writing on client A (different object).
>>
>>> Even if interval1 and interval2 belongs to two different object of that=
 file,  client B still  have to wait client A.
>>>
>>> I=E2=80=99m wondering why mds doesn=E2=80=99t try to control the caps b=
ased on object rather than whole file?
>>
>> because mds can't foresee which offset client want to read/write. the
>> overhead for issuing caps for each read/write syscall is too high.
>>
>>>
>>> Thanks,
>>> Dongdong
>
