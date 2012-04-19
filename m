From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH 5/6] rbd: rename __rbd_update_snaps to __rbd_refresh_header
Date: Thu, 19 Apr 2012 11:06:23 -0700
Message-ID: <CAC-hyiF2mc=hX0q5SouQqHepzVKh3Jj2AZKpwcB0Mj_4sDax6w@mail.gmail.com>
References: <4F8ED154.6050500@dreamhost.com>
	<4F8ED288.9010807@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60439 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2DSSGY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 14:06:24 -0400
Received: by bkcik5 with SMTP id ik5so6603174bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 11:06:23 -0700 (PDT)
In-Reply-To: <4F8ED288.9010807@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 18, 2012 at 7:41 AM, Alex Elder <elder@dreamhost.com> wrote=
:
> This function rereads the entire header and handles any changes in
> it, not just changes in snapshots.
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Reviewed-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 12 ++++++------
> =A01 file changed, 6 insertions(+), 6 deletions(-)
>
> Index: b/drivers/block/rbd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -240,7 +240,7 @@
> =A0 =A0 =A0 =A0put_device(&rbd_dev->dev);
> =A0}
>
> -static int __rbd_update_snaps(struct rbd_device *rbd_dev);
> +static int __rbd_refresh_header(struct rbd_device *rbd_dev);
>
> =A0static int rbd_open(struct block_device *bdev, fmode_t mode)
> =A0{
> @@ -1223,7 +1223,7 @@
> =A0 =A0 =A0 =A0dout("rbd_watch_cb %s notify_id=3D%lld opcode=3D%d\n",=
 dev->obj_md_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_id, (int)opcode);
> =A0 =A0 =A0 =A0mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> - =A0 =A0 =A0 rc =3D __rbd_update_snaps(dev);
> + =A0 =A0 =A0 rc =3D __rbd_refresh_header(dev);
> =A0 =A0 =A0 =A0mutex_unlock(&ctl_mutex);
> =A0 =A0 =A0 =A0if (rc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning(RBD_DRV_NAME "%d got notifi=
cation but failed to "
> @@ -1690,7 +1690,7 @@
> =A0/*
> =A0* only read the first part of the ondisk header, without the snaps=
 info
> =A0*/
> -static int __rbd_update_snaps(struct rbd_device *rbd_dev)
> +static int __rbd_refresh_header(struct rbd_device *rbd_dev)
> =A0{
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0struct rbd_image_header h;
> @@ -1877,7 +1877,7 @@
>
> =A0 =A0 =A0 =A0mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>
> - =A0 =A0 =A0 rc =3D __rbd_update_snaps(rbd_dev);
> + =A0 =A0 =A0 rc =3D __rbd_refresh_header(rbd_dev);
> =A0 =A0 =A0 =A0if (rc < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D rc;
>
> @@ -2160,7 +2160,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 rbd_dev->header.obj_version);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret =3D=3D -ERANGE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock_nested(&ctl=
_mutex, SINGLE_DEPTH_NESTING);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D __rbd_update_sna=
ps(rbd_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D __rbd_refresh_he=
ader(rbd_dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&ctl_mute=
x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rc < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 rc;
> @@ -2545,7 +2545,7 @@
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_unlock;
>
> - =A0 =A0 =A0 ret =3D __rbd_update_snaps(rbd_dev);
> + =A0 =A0 =A0 ret =3D __rbd_refresh_header(rbd_dev);
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_unlock;
>

Reviewed-by: Yehuda Sadeh <yehuda@hq.newdream.net>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
