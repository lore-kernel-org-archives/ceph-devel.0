From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: inconsistent file issue
Date: Thu, 21 Sep 2017 20:00:16 +0800
Message-ID: <CAAM7YAntnQBNMz5DbZ2X8C6dDUeTnLNZ=O01bJZ8KcndWgthNQ@mail.gmail.com>
References: <571AAE95-D681-4887-BBFA-86163B6DA800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:46502 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdIUMAR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Sep 2017 08:00:17 -0400
Received: by mail-io0-f178.google.com with SMTP id d16so10213654ioj.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 Sep 2017 05:00:17 -0700 (PDT)
In-Reply-To: <571AAE95-D681-4887-BBFA-86163B6DA800@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 20, 2017 at 11:42 AM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@=
gmail.com> wrote:
> Hi Zheng,
>
> we have been suffering from an inconsistent issue in cephfs :
>
> kernel version : 3.1.0
> ceph version: 10.2.5
>
> we are using the kernel client to mount cephfs
> we mount the ceph filesystem on two machines all with kernel 3.1.0,
> but the strange thing is that the content of one same file is different f=
rom the two machines.
> and we are certain one machine has the correct content.
>
>  we didn=E2=80=99t know the way to reproduce it , and we don=E2=80=99t ha=
ve the log here.
>  i=E2=80=99m wondering maybe it=E2=80=99s because  there is some bug with=
in kernel client, so that the client think
>  it has enough capability to read it just from it=E2=80=99s buffer, no ne=
ed to get the cap from mds, so it didn=E2=80=99t get the latest content.
>
>  since the kernel is too old, may be you have fixed this kind inconsisten=
t issues ?

we fixed a splice issue about 1 year ago, it could cause inconsistent
data when multiples client read/write a file at the same time. The
issue the is the only bug I remember, that can cause inconsistent
data. Please try recent kernel, check if the issue still happen.

Regards
Yan, Zheng

>
> Regards,
> Dongdong
>
