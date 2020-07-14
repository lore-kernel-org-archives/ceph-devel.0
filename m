From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [Ceph-qa] multiple BLK-MQ queues for Ceph's RADOS Block Device
 (RBD) and CephFS
Date: Tue, 14 Jul 2020 23:16:28 +0200
Message-ID: <CAOi1vP-hmzEkkUWGOwxksQn8ny1HzgNURtnf1D33KQq4-49xgQ@mail.gmail.com>
References: <CA+xD70OJhkhH=+5W7M8NM54VPh42FmbD3O0yqKe1p-+=yd9zXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGNVQZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2020 17:16:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F2C061755
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2020 14:16:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c16so18863170ioi.9
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2020 14:16:25 -0700 (PDT)
In-Reply-To: <CA+xD70OJhkhH=+5W7M8NM54VPh42FmbD3O0yqKe1p-+=yd9zXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bobby <italienisch1987@gmail.com>
Cc: dev <dev@ceph.io>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 13, 2020 at 8:40 PM Bobby <italienisch1987@gmail.com> wrote:
>
>
> Hi,
>
> I have a question regarding support for multiple BLK-MQ queues for Ceph's=
 RADOS Block Device (RBD). The below given link says that the driver has be=
en using the BLK-MQ interface for a while but not actually multiple queues =
until now with having a queue per-CPU. A change to not hold onto caps that =
aren't actually needed.  These improvements and more can be found as part o=
f the Ceph changes for Linux 5.7, which should be released as stable in ear=
ly June.
>
> https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DLinux-5.7-Ceph-Pe=
rformance
>
> My question is: Is it possible that through Ceph FS (Filesystem in User S=
pace) I can develop a multi-queue driver for Ceph? Asking because this way =
I can avoid kernel space. (https://docs.ceph.com/docs/nautilus/start/quick-=
cephfs/)

[ trimming CCs to dev and ceph-devel ]

Hi Bobby,

I'm not sure what you mean by a "multi-queue driver for Ceph".
blk-mq is the block layer framework, it has nothing to do with
filesystems, whether local sitting on top of a block device (such
as ext4 or XFS) or distributed sitting on top of a network stack
(such as CephFS).

Do you have a specific project in mind or are you just looking to
make ceph-fuse faster?

Thanks,

                Ilya
