From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v6)
Date: Wed, 13 Oct 2010 09:41:01 +0100
Message-ID: <AANLkTi=7oYpBRs6ZmpHm-KpsQFrH1ELNFgWRnPEYCQju@mail.gmail.com>
References: <20101012231854.GA4535@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63524 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0JMIlC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Oct 2010 04:41:02 -0400
In-Reply-To: <20101012231854.GA4535@dell.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com

On Wed, Oct 13, 2010 at 12:18 AM, Christian Brunner <chb@muc.de> wrote:
> +static int rbd_set_snapc(rados_pool_t pool, const char *snap, RbdHea=
der1 *header)
> +{
> + =A0 =A0uint32_t snap_count =3D header->snap_count;
> + =A0 =A0rados_snap_t *snaps =3D NULL;
> + =A0 =A0rados_snap_t seq;
> + =A0 =A0uint32_t i;
> + =A0 =A0uint64_t snap_names_len =3D header->snap_names_len;
> + =A0 =A0int r;
> + =A0 =A0rados_snap_t snapid =3D 0;
> +
> + =A0 =A0cpu_to_le32s(&snap_count);
> + =A0 =A0cpu_to_le64s(&snap_names_len);

It is clearer to do byteswapping immediately, rather than having the
variable take on different endianness at different times:
uint32_t snap_count =3D cpu_to_le32(header->snap_count);
uint64_t snap_names_len =3D cpu_to_le64(header->snap_names_len);

> + =A0 =A0if (snap_count) {
> + =A0 =A0 =A0 =A0const char *header_snap =3D (const char *)&header->s=
naps[snap_count];
> + =A0 =A0 =A0 =A0const char *end =3D header_snap + snap_names_len;

snap_names_len is little-endian.  This won't work on big-endian hosts.
 Did you mean le64_to_cpu() instead of cpu_to_le64()?

> + =A0 =A0 =A0 =A0snaps =3D qemu_malloc(sizeof(rados_snap_t) * header-=
>snap_count);

snaps is allocated here...

> +
> + =A0 =A0 =A0 =A0for (i=3D0; i < snap_count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0snaps[i] =3D (uint64_t)header->snaps[i].id;
> + =A0 =A0 =A0 =A0 =A0 =A0cpu_to_le64s(&snaps[i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0if (snap && strcmp(snap, header_snap) =3D=3D=
 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapid =3D snaps[i];
> + =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0header_snap +=3D strlen(header_snap) + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0if (header_snap > end) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("bad header, snapshot l=
ist broken");
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0}
> + =A0 =A0}
> +
> + =A0 =A0if (snap && !snapid) {
> + =A0 =A0 =A0 =A0error_report("snapshot not found");
> + =A0 =A0 =A0 =A0return -ENOENT;

=2E..but never freed here.

> + =A0 =A0}
> + =A0 =A0seq =3D header->snap_seq;
> + =A0 =A0cpu_to_le32s((uint32_t *)&seq);
> +
> + =A0 =A0r =3D rados_set_snap_context(pool, seq, snaps, snap_count);
> +
> + =A0 =A0rados_set_snap(pool, snapid);
> +
> + =A0 =A0qemu_free(snaps);
> +
> + =A0 =A0return r;
> +}

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
