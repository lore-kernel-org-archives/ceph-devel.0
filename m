From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH 1/6] rbd: protect read of snapshot sequence number
Date: Thu, 19 Apr 2012 10:35:53 -0700
Message-ID: <CAC-hyiGsSF3JVgFvHbZ2DNyZrbVTug8EiswP_vme_8iuPpMjxA@mail.gmail.com>
References: <4F8ED154.6050500@dreamhost.com>
	<4F8ED27B.7050105@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65473 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab2DSRfy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 13:35:54 -0400
Received: by bkcik5 with SMTP id ik5so6581957bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 10:35:53 -0700 (PDT)
In-Reply-To: <4F8ED27B.7050105@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 18, 2012 at 7:40 AM, Alex Elder <elder@dreamhost.com> wrote=
:
> This is updated whenever a snapshot is added or deleted, and the
> snapc pointer is changed with every refresh of the header.
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Reviewed-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 =A04 +++-
> =A01 file changed, 3 insertions(+), 1 deletion(-)
>
> Index: b/drivers/block/rbd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1685,7 +1685,9 @@
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> - =A0 =A0 =A0 dev->header.snapc->seq =3D =A0new_snapid;
> + =A0 =A0 =A0 down_write(&dev->header_rwsem);
> + =A0 =A0 =A0 dev->header.snapc->seq =3D new_snapid;
> + =A0 =A0 =A0 up_write(&dev->header_rwsem);
>
> =A0 =A0 =A0 =A0return 0;
> =A0bad:

Reviewed-by: Yehuda Sadeh <yehuda@hq.newdream.net>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
