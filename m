From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: why cephfs kernel module does not support fallocate with default mode?
Date: Sun, 28 Jun 2020 06:23:53 +0200
Message-ID: <CAOi1vP8Ppr300Ag7FvRRg6mY1+4+dvXUkLsD4CYogv9aEsZbkQ@mail.gmail.com>
References: <CALZt5jy7G3e7+bibmNXeqxsRuoSwwE-U7G=cu5KvwAbsEiAmKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgF1EXq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Jun 2020 00:23:46 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFAAC061794
        for <ceph-devel@vger.kernel.org>; Sat, 27 Jun 2020 21:23:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so136569iob.4
        for <ceph-devel@vger.kernel.org>; Sat, 27 Jun 2020 21:23:46 -0700 (PDT)
In-Reply-To: <CALZt5jy7G3e7+bibmNXeqxsRuoSwwE-U7G=cu5KvwAbsEiAmKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: dev <dev@ceph.io>, "Yan, Zheng" <zyan@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Jun 27, 2020 at 6:02 PM Ning Yao <zay11022@gmail.com> wrote:
>
> Hi, all
>
> I find the in cephfs kernel module fs/ceph/file.c, the function ceph_fall=
ocate return -EOPNOTSUPP=EF=BC=8Cwhen mode !=3D (FALLOC_FL_KEEP_SIZE | FALL=
OC_FL_PUNCH_HOLE)=E3=80=82
>
> Recently=EF=BC=8Cwe try to use cephfs but need supporting fallocate sysca=
ll to generate the file writing not failed after reserved space. But we fin=
d the cephfs kernel module does not support this right now. Can anyone expl=
ain why we don't implement this now?

It used to be supported (as in it wasn't rejected with EOPNOTSUPP),
but never actually worked.  There is no easy way to preallocate/reserve
space in the cluster without explicitly zeroing it.  If the space isn't
actually reserved, subsequent writes could fail with ENOSPC which would
violate POSIX and break applications, so we chose to disable it.

>
> We also find out ceph-fuse can support the falllocate syscall but endwith=
 a pool writing performance vs cephfs kernel mount. There is a large perfor=
mance gap under fio.cfg below:

ceph-fuse is broken in the same way and it should be disabled there
as well.

Thanks,

                Ilya
