From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 4/4] rbd: use a single value of snap_name to mean no snap
Date: Tue, 28 Feb 2012 20:53:18 -0800
Message-ID: <CAC-hyiGGAnKM92YyfUsbW17pW4a2_E0gO5Z_x5B+fNqZjDWtgA@mail.gmail.com>
References: <4F4D9BF6.5070102@dreamhost.com>
	<4F4D9CF1.1020101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35233 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2B2ExU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:53:20 -0500
Received: by bkcik5 with SMTP id ik5so1932622bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:53:19 -0800 (PST)
In-Reply-To: <4F4D9CF1.1020101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 7:35 PM, Alex Elder <elder@dreamhost.com> wrote=
:
> From Josh Durgin <josh.durgin@dreamhost.com>
>
> There's already a constant for this anyway.
>
> (I changed Josh's code to use memcmp() and memcpy() instead. -Alex)
>
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 =A08 +++-----
> =A01 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3d0f8cf..25ed3c0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -563,10 +563,7 @@ static int rbd_header_set_snap(struct rbd_device=
 *dev,
>
> =A0 =A0 =A0 =A0down_write(&header->snap_rwsem);
>
> - =A0 =A0 =A0 if (!snap_name ||
> - =A0 =A0 =A0 =A0 =A0 !*snap_name ||
> - =A0 =A0 =A0 =A0 =A0 strcmp(snap_name, "-") =3D=3D 0 ||
> - =A0 =A0 =A0 =A0 =A0 strcmp(snap_name, RBD_SNAP_HEAD_NAME) =3D=3D 0)=
 {
> + =A0 =A0 =A0 if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME, sizeof

The original code checked for snap_name, we don't do it here. Also, do
we know that snap_name is pointing to at least
sizeof(RBD_SNAP_HEAD_NAME)? if not (or in any case) we should use
strcmp instead of memcmp. Also, sizeof(x) instead of sizeof x.

> RBD_SNAP_HEAD_NAME)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (header->total_snaps)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapc->seq =3D header-=
>snap_seq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> @@ -2213,7 +2210,8 @@ static ssize_t rbd_add(struct bus_type *bus,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (rbd_dev->snap_name[0] =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rbd_dev->snap_name[0] =3D '-';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(rbd_dev->snap_name, RBD_SNAP_HEA=
D_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof RBD_SNAP_HEAD_NA=
ME);
>
> =A0 =A0 =A0 =A0rbd_dev->obj_len =3D strlen(rbd_dev->obj);
> =A0 =A0 =A0 =A0snprintf(rbd_dev->obj_md_name, sizeof(rbd_dev->obj_md_=
name), "%s%s",
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
