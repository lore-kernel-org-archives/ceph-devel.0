From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [PATCH v4 4/4] rbd: Add bdrv_truncate implementation
Date: Wed, 25 May 2011 21:22:04 +0200
Message-ID: <BANLkTinBv5OG5obL8V89aahR85-8s8KnsQ@mail.gmail.com>
References: <1306263078-18089-1-git-send-email-josh.durgin@dreamhost.com>
	<1306263078-18089-5-git-send-email-josh.durgin@dreamhost.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1306263078-18089-5-git-send-email-josh.durgin@dreamhost.com>
Sender: kvm-owner@vger.kernel.org
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Looks good to me:

Reviewed-by: Christian Brunner <chb@muc.de>


2011/5/24 Josh Durgin <josh.durgin@dreamhost.com>:
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
> =A0block/rbd.c | =A0 15 +++++++++++++++
> =A01 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index c9f32e4..015ae8e 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -687,6 +687,20 @@ static int64_t qemu_rbd_getlength(BlockDriverSta=
te *bs)
> =A0 =A0 return info.size;
> =A0}
>
> +static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> + =A0 =A0int r;
> +
> + =A0 =A0r =3D rbd_resize(s->image, offset);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("failed to resize rbd image");
> + =A0 =A0 =A0 =A0return -EIO;
> + =A0 =A0}
> +
> + =A0 =A0return 0;
> +}
> +
> =A0static int qemu_rbd_snap_create(BlockDriverState *bs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 QEMUS=
napshotInfo *sn_info)
> =A0{
> @@ -785,6 +799,7 @@ static BlockDriver bdrv_rbd =3D {
> =A0 =A0 .bdrv_get_info =A0 =A0 =A0=3D qemu_rbd_getinfo,
> =A0 =A0 .create_options =A0 =A0 =3D qemu_rbd_create_options,
> =A0 =A0 .bdrv_getlength =A0 =A0 =3D qemu_rbd_getlength,
> + =A0 =A0.bdrv_truncate =A0 =A0 =A0=3D qemu_rbd_truncate,
> =A0 =A0 .protocol_name =A0 =A0 =A0=3D "rbd",
>
> =A0 =A0 .bdrv_aio_readv =A0 =A0 =3D qemu_rbd_aio_readv,
> --
> 1.7.2.3
>
>
>
