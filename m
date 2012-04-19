From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH 2/6] rbd: store snapshot id instead of index
Date: Thu, 19 Apr 2012 10:41:49 -0700
Message-ID: <CAC-hyiF-bbPKQzmyUgOzb=fWRNwmQNGYyRW8iMQQo+Wps8Q9=g@mail.gmail.com>
References: <4F8ED154.6050500@dreamhost.com>
	<4F8ED27E.8020901@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62359 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab2DSRlv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 13:41:51 -0400
Received: by bkcik5 with SMTP id ik5so6586266bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 10:41:49 -0700 (PDT)
In-Reply-To: <4F8ED27E.8020901@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 18, 2012 at 7:41 AM, Alex Elder <elder@dreamhost.com> wrote=
:
> When a device was open at a snapshot, and snapshots were deleted or
> added, data from the wrong snapshot could be read. Instead of
> assuming the snap context is constant, store the actual snap id when
> the device is initialized, and rely on the OSDs to signal an error
> if we try reading from a snapshot that was deleted.
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Reviewed-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 27 +++++----------------------
> =A01 file changed, 5 insertions(+), 22 deletions(-)
>
> Index: b/drivers/block/rbd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -175,8 +175,7 @@
> =A0 =A0 =A0 =A0/* protects updating the header */
> =A0 =A0 =A0 =A0struct rw_semaphore =A0 =A0 header_rwsem;
> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snap_name[=
RBD_MAX_SNAP_NAME_LEN];
> - =A0 =A0 =A0 u32 cur_snap; =A0 /* index+1 of current snapshot within=
 snap context
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 - for the head=
 */
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snap_id; =A0=
 =A0 =A0 =A0/* current snapshot id */
> =A0 =A0 =A0 =A0int read_only;
>
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0node;
> @@ -554,21 +553,6 @@
> =A0 =A0 =A0 =A0return -ENOMEM;
> =A0}
>
> -static int snap_index(struct rbd_image_header *header, int snap_num)
> -{
> - =A0 =A0 =A0 return header->total_snaps - snap_num;
> -}
> -
> -static u64 cur_snap_id(struct rbd_device *rbd_dev)
> -{
> - =A0 =A0 =A0 struct rbd_image_header *header =3D &rbd_dev->header;
> -
> - =A0 =A0 =A0 if (!rbd_dev->cur_snap)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 return header->snapc->snaps[snap_index(header, rbd_dev-=
>cur_snap)];
> -}
> -
> =A0static int snap_by_name(struct rbd_image_header *header, const cha=
r
> *snap_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u64 *seq, u64 *size)
> =A0{
> @@ -607,7 +591,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapc->seq =3D header-=
>snap_seq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapc->seq =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cur_snap =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->snap_id =3D CEPH_NOSNAP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->read_only =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (size)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*size =3D header->imag=
e_size;
> @@ -615,8 +599,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D snap_by_name(header, dev->snap=
_name, &snapc->seq,
> size);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto done;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cur_snap =3D header->total_snaps -=
 ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->snap_id =3D snapc->seq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->read_only =3D 1;
> =A0 =A0 =A0 =A0}
>
> @@ -1523,7 +1506,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0coll, cur_seg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rbd_re=
q_read(rq, rbd_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0cur_snap_id(rbd_dev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0rbd_dev->snap_id,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ofs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 op_size, bio,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 coll, cur_seg);
> @@ -1658,7 +1641,7 @@
> =A0 =A0 =A0 =A0struct ceph_mon_client *monc;
>
> =A0 =A0 =A0 =A0/* we should create a snapshot only if we're pointing =
at the head */
> - =A0 =A0 =A0 if (dev->cur_snap)
> + =A0 =A0 =A0 if (dev->snap_id !=3D CEPH_NOSNAP)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0monc =3D &dev->rbd_client->client->monc;

Reviewed-by: Yehuda Sadeh <yehuda@hq.newdream.net>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
