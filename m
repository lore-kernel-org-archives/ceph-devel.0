From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: osdmap consistency during incremental applying in kernel client
Date: Mon, 12 Feb 2018 10:37:53 +0100
Message-ID: <CAOi1vP9j=hBeZ73oguLBuXp-YDE5tk3h=HU5_MDJgOxY300kFQ@mail.gmail.com>
References: <302D379F-727B-489C-B257-633CF16577C8@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:32792 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932480AbeBLJhy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 04:37:54 -0500
Received: by mail-io0-f177.google.com with SMTP id n7so16621375iob.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 01:37:54 -0800 (PST)
In-Reply-To: <302D379F-727B-489C-B257-633CF16577C8@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 12, 2018 at 5:05 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Hi All,
>
> In ceph kernel client, osdmap_apply_incremental() can fail by failing of
> allocation memory in many places, in this case, current osdmap can not
> keep consistency after applying failure.
>
> I=E2=80=99m not sure how much impact will be caused by this kind of incon=
sistency
> but for safety it=E2=80=99s better to keep osdmap consistency all the tim=
e even
> failing from incremental applying.

Hi Chengguang,

Well, in practice those are rather small allocations, so if you see any
of them failing, the system is likely in deep trouble.  In theory it is
a valid point though.

Thanks,

                Ilya
