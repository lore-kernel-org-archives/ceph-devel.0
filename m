From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: multiple client read/write in cephfs
Date: Mon, 23 Oct 2017 15:55:13 +0800
Message-ID: <CAAM7YAnHFiEq6qiL9_+S7ZWEpZN-0pnom2-TCiztzQdM6QbVaw@mail.gmail.com>
References: <F6B9A347-CD3E-42BF-B65A-3BAF61C1C284@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:49679 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdJWHzO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 03:55:14 -0400
Received: by mail-oi0-f41.google.com with SMTP id w197so29273271oif.6
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 00:55:14 -0700 (PDT)
In-Reply-To: <F6B9A347-CD3E-42BF-B65A-3BAF61C1C284@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>

On Mon, Oct 23, 2017 at 12:50 PM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@=
gmail.com> wrote:
> Dear Cephers,
>
> I have one issue about cephfs, suppose we got below scenario:
> client A write one file with interval1 (offset1, length1)
> then client B read the same file with interval2 (offset2, length2).
> but due to capability system controlled by mds,  client B have to wait un=
til client A finish its write operation (including flushing its buffer to o=
sd)

Client B only need to wait until Client A finishes flush buffer to
osd. If Client B keeps the file descriptor open, writing to page cache
gets disabled on client A, reading from client B does not need to wait
for writing on client A (different object).

> Even if interval1 and interval2 belongs to two different object of that f=
ile,  client B still  have to wait client A.
>
> I=E2=80=99m wondering why mds doesn=E2=80=99t try to control the caps bas=
ed on object rather than whole file?

because mds can't foresee which offset client want to read/write. the
overhead for issuing caps for each read/write syscall is too high.

>
> Thanks,
> Dongdong
