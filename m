From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v6)
Date: Thu, 14 Oct 2010 17:34:41 -0700
Message-ID: <AANLkTi=EhA=dT9ufuv10PgDLBX1hdDbD__tNGKnCtAW1@mail.gmail.com>
References: <20101012231854.GA4535@dell.home>
	<AANLkTi=7oYpBRs6ZmpHm-KpsQFrH1ELNFgWRnPEYCQju@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39393 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab0JOAem convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Oct 2010 20:34:42 -0400
In-Reply-To: <AANLkTi=7oYpBRs6ZmpHm-KpsQFrH1ELNFgWRnPEYCQju@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com

See my comments:

On Wed, Oct 13, 2010 at 1:41 AM, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
>> +
>> + =A0 =A0cpu_to_le32s(&snap_count);
>> + =A0 =A0cpu_to_le64s(&snap_names_len);

Redone all endianity conversions, made it so that it keeps the header
as little endian, and whenever reading the header, do the endianity
conversion.

>
> It is clearer to do byteswapping immediately, rather than having the
> variable take on different endianness at different times:
> uint32_t snap_count =3D cpu_to_le32(header->snap_count);
> uint64_t snap_names_len =3D cpu_to_le64(header->snap_names_len);

Right.

>
>> + =A0 =A0if (snap_count) {
>> + =A0 =A0 =A0 =A0const char *header_snap =3D (const char *)&header->=
snaps[snap_count];
>> + =A0 =A0 =A0 =A0const char *end =3D header_snap + snap_names_len;
>
> snap_names_len is little-endian. =A0This won't work on big-endian hos=
ts.
> =A0Did you mean le64_to_cpu() instead of cpu_to_le64()?
Yes, fixed that.

>
>> + =A0 =A0 =A0 =A0snaps =3D qemu_malloc(sizeof(rados_snap_t) * header=
->snap_count);
>
> snaps is allocated here...
>
>> +
>> + =A0 =A0 =A0 =A0for (i=3D0; i < snap_count; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0snaps[i] =3D (uint64_t)header->snaps[i].id;
>> + =A0 =A0 =A0 =A0 =A0 =A0cpu_to_le64s(&snaps[i]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0if (snap && strcmp(snap, header_snap) =3D=3D=
 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapid =3D snaps[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0header_snap +=3D strlen(header_snap) + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0if (header_snap > end) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("bad header, snapshot =
list broken");
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0}
>> +
>> + =A0 =A0if (snap && !snapid) {
>> + =A0 =A0 =A0 =A0error_report("snapshot not found");
>> + =A0 =A0 =A0 =A0return -ENOENT;
>
> ...but never freed here.

=46reed now.



Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
