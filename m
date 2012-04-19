From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 4/6] rbd: fix snapshot size type
Date: Thu, 19 Apr 2012 11:04:57 -0700
Message-ID: <CAC-hyiGzsK27Eqnp7gEZiz2k6oRjOt0B3SKm155mPtZv73hH5w@mail.gmail.com>
References: <4F8ED154.6050500@dreamhost.com>
	<4F8ED285.7060005@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59084 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2DSSE6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 14:04:58 -0400
Received: by bkcik5 with SMTP id ik5so6602194bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 11:04:57 -0700 (PDT)
In-Reply-To: <4F8ED285.7060005@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 18, 2012 at 7:41 AM, Alex Elder <elder@dreamhost.com> wrote=
:
> Snapshot sizes should be the same type as regular image sizes. This
> only affects their displayed size in sysfs, not the reported size of
> an actual block device sizes.
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Reviewed-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 =A06 +++---
> =A01 file changed, 3 insertions(+), 3 deletions(-)
>
> Index: b/drivers/block/rbd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -141,7 +141,7 @@
> =A0struct rbd_snap {
> =A0 =A0 =A0 =A0struct =A0device =A0 =A0 =A0 =A0 =A0dev;
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
> - =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size;
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size;
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0node;
> =A0 =A0 =A0 =A0u64 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id;
> =A0};
> @@ -1936,7 +1936,7 @@
> =A0{
> =A0 =A0 =A0 =A0struct rbd_snap *snap =3D container_of(dev, struct rbd=
_snap, dev);
>
> - =A0 =A0 =A0 return sprintf(buf, "%zd\n", snap->size);
> + =A0 =A0 =A0 return sprintf(buf, "%llu\n", (unsigned long long)snap-=
>size);
> =A0}
>
> =A0static ssize_t rbd_snap_id_show(struct device *dev,
> @@ -1945,7 +1945,7 @@
> =A0{
> =A0 =A0 =A0 =A0struct rbd_snap *snap =3D container_of(dev, struct rbd=
_snap, dev);
>
> - =A0 =A0 =A0 return sprintf(buf, "%llu\n", (unsigned long long) snap=
->id);
> + =A0 =A0 =A0 return sprintf(buf, "%llu\n", (unsigned long long)snap-=
>id);
> =A0}
>
> =A0static DEVICE_ATTR(snap_size, S_IRUGO, rbd_snap_size_show, NULL);

Reviewed-by: Yehuda Sadeh <yehuda@hq.newdream.net>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
