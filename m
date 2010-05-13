From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 2/2] avoid overwriting the header
Date: Thu, 13 May 2010 12:01:35 -0700
Message-ID: <AANLkTilpggEt_EETk5cwoEWNUGjbDzuYEwocI1CdoBRI@mail.gmail.com>
References: <20100513151054.GB53373@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46053 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab0EMTBj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 May 2010 15:01:39 -0400
Received: by vws16 with SMTP id 16so265400vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 May 2010 12:01:38 -0700 (PDT)
In-Reply-To: <20100513151054.GB53373@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

Thanks. Pushed both patches.

Yehuda

On Thu, May 13, 2010 at 8:10 AM, Christian Brunner <chb@muc.de> wrote:
>
> avoid overwriting the rbd header when doing qemu-img create
> to resize a rbd image use rbdtool --resize instead
> ---
> =A0block/rbd.c | =A0 =A08 ++++++++
> =A01 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index a182d5e..11b7c10 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -163,6 +163,8 @@ static int rbd_create(const char *filename, QEMUO=
ptionParameter * options)
> =A0{
> =A0 =A0 int64_t bytes =3D 0;
> =A0 =A0 int64_t objsize;
> + =A0 =A0uint64_t size;
> + =A0 =A0time_t mtime;
> =A0 =A0 uint8_t obj_order =3D RBD_DEFAULT_OBJ_ORDER;
> =A0 =A0 char pool[RBD_MAX_SEG_NAME_SIZE];
> =A0 =A0 char n[RBD_MAX_SEG_NAME_SIZE];
> @@ -227,6 +229,12 @@ static int rbd_create(const char *filename, QEMU=
OptionParameter * options)
> =A0 =A0 =A0 =A0 return -EIO;
> =A0 =A0 }
>
> + =A0 =A0ret =3D rados_stat(p, n, &size, &mtime);
> + =A0 =A0if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0ret=3D-EEXIST;
> + =A0 =A0 =A0 =A0goto done;
> + =A0 =A0}
> +
> =A0 =A0 ret =3D rados_write(p, n, 0, (const char *)&header, sizeof(he=
ader));
> =A0 =A0 if (ret < 0) {
> =A0 =A0 =A0 =A0 goto done;
> --
> 1.7.0.4
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
