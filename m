From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [Ceph-qa] multiple BLK-MQ queues for Ceph's RADOS Block Device
 (RBD) and CephFS
Date: Wed, 15 Jul 2020 21:04:15 +0200
Message-ID: <CAOi1vP9yz7hLuSRWnDtj3wdKZD1qTiF+84_o5F91bw3wZam=0g@mail.gmail.com>
References: <CA+xD70OJhkhH=+5W7M8NM54VPh42FmbD3O0yqKe1p-+=yd9zXQ@mail.gmail.com>
 <CAOi1vP-hmzEkkUWGOwxksQn8ny1HzgNURtnf1D33KQq4-49xgQ@mail.gmail.com> <CA+xD70Neac2hpzu-Tg7s+1NCDegwzKs-zdTk8DYTWZPjNaexaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGOTEN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2020 15:04:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF099C061755
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2020 12:04:12 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s21so2945873ilk.5
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2020 12:04:12 -0700 (PDT)
In-Reply-To: <CA+xD70Neac2hpzu-Tg7s+1NCDegwzKs-zdTk8DYTWZPjNaexaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bobby <italienisch1987@gmail.com>
Cc: dev <dev@ceph.io>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jul 15, 2020 at 12:47 AM Bobby <italienisch1987@gmail.com> wrote:
>
>
>
> Hi Ilya,
>
> Thanks for the reply. It's basically both i.e. I have a specific project =
currently and also I am looking to make ceph-fuse faster.
>
> But for now, let me ask specifically the project based question. In the p=
roject I have to write a blk-mq kernel driver for the Ceph client machine. =
The Ceph client machine will transfer the data to HBA or lets say any embed=
ded device.

What is a "Ceph client machine"?

A Ceph client (or more specifically a RADOS client) speaks RADOS
protocol and transfers data to OSD daemons.  It can't transfer data
directly to a physical device because something has to take care of
replication, ensure consistency and self healing, etc.  This is the
job of the OSD.

>
> My hope is that there can be an alternative and that alternative is to no=
t implement a blk-mq kernel driver and instead do the stuff in userspace. I=
 am trying to avoid writing a blk-mq kernel driver and yet achieve the mult=
i-queue implementation through userspace. Is it possible?
>
> Also AFAIK, the Ceph=E2=80=99s block storage implementation uses a client=
 module and this client module has two implementations librbd (user-space) =
and krbd (kernel module). I have not gone deep into these client modules. b=
ut can librbd help me with this?

I guess I don't understand the goal of your project.  A multi-queue
implementation of what exactly?  A Ceph block device, a Ceph filesystem
or something else entirely?  It would help if you were more specific
because "a multi-queue driver for Ceph" is really vague.

Thanks,

                Ilya
