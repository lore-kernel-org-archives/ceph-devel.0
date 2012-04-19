From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH 3/6] rbd: remove conditional snapid parameters
Date: Thu, 19 Apr 2012 10:58:03 -0700
Message-ID: <CAC-hyiHuiCG0cmngGY5EcU00N14L_X+dv5uBpi5nNi+PiMWnoQ@mail.gmail.com>
References: <4F8ED154.6050500@dreamhost.com>
	<4F8ED281.3040009@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44416 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab2DSR6E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 13:58:04 -0400
Received: by bkcik5 with SMTP id ik5so6597741bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 10:58:03 -0700 (PDT)
In-Reply-To: <4F8ED281.3040009@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 18, 2012 at 7:41 AM, Alex Elder <elder@dreamhost.com> wrote=
:
> The snapid parameters passed to rbd_do_op() and rbd_req_sync_op()
> are now always either a valid snapid or an explicit CEPH_NOSNAP.
>
> [elder@dreamhost.com: Rephrased the description]
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Reviewed-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 =A04 ++--
> =A01 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: b/drivers/block/rbd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1153,7 +1153,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int coll_index)
> =A0{
> =A0 =A0 =A0 =A0return rbd_do_op(rq, rbd_dev, NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(snapid ? snapid : C=
EPH_NOSNAP),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapid,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEPH_OSD_OP_READ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEPH_OSD_FLAG_READ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2,
> @@ -1172,7 +1172,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u64 *ver)
> =A0{
> =A0 =A0 =A0 =A0return rbd_req_sync_op(dev, NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(snapid =
? snapid : CEPH_NOSNAP),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapid,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEPH_OSD_=
OP_READ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEPH_OSD_=
=46LAG_READ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL,
Reviewed-by: Yehuda Sadeh <yehuda@hq.newdream.net>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
