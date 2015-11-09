From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: [Qemu-devel] qemu : rbd block driver internal snapshot and
 vm_stop is hanging forever
Date: Mon, 9 Nov 2015 08:42:42 -0500 (EST)
Message-ID: <1119051619.7201094.1447076562035.JavaMail.zimbra@redhat.com>
References: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv> <5640490B.5030700@parallels.com> <564049BA.1090805@parallels.com> <253899541.6094258.1447066125770.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:35202 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbKINmt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 08:42:49 -0500
In-Reply-To: <253899541.6094258.1447066125770.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, jdurgin@redhat.com

Can you reproduce with Ceph debug logging enabled (i.e. debug rbd=3D20 =
in your ceph.conf)?  If you could attach the log to the Ceph tracker ti=
cket I opened [1], that would be very helpful.

[1] http://tracker.ceph.com/issues/13726

Thanks,
Jason=20


----- Original Message -----
> From: "Alexandre DERUMIER" <aderumier@odiso.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Cc: "qemu-devel" <qemu-devel@nongnu.org>, jdurgin@redhat.com
> Sent: Monday, November 9, 2015 5:48:45 AM
> Subject: Re: [Qemu-devel] qemu : rbd block driver internal snapshot a=
nd vm_stop is hanging forever
>=20
> adding to ceph.conf
>=20
> [client]
>         rbd_non_blocking_aio =3D false
>=20
>=20
> fix the problem for me (with rbd_cache=3Dfalse)
>=20
>=20
> (@cc jdurgin@redhat.com)
>=20
>=20
>=20
> ----- Mail original -----
> De: "Denis V. Lunev" <den-lists@parallels.com>
> =C3=80: "aderumier" <aderumier@odiso.com>, "ceph-devel"
> <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-devel@nongnu.org>
> Envoy=C3=A9: Lundi 9 Novembre 2015 08:22:34
> Objet: Re: [Qemu-devel] qemu : rbd block driver internal snapshot and=
 vm_stop
> is hanging forever
>=20
> On 11/09/2015 10:19 AM, Denis V. Lunev wrote:
> > On 11/09/2015 06:10 AM, Alexandre DERUMIER wrote:
> >> Hi,
> >>=20
> >> with qemu (2.4.1), if I do an internal snapshot of an rbd device,
> >> then I pause the vm with vm_stop,
> >>=20
> >> the qemu process is hanging forever
> >>=20
> >>=20
> >> monitor commands to reproduce:
> >>=20
> >>=20
> >> # snapshot_blkdev_internal drive-virtio0 yoursnapname
> >> # stop
> >>=20
> >>=20
> >>=20
> >>=20
> >> I don't see this with qcow2 or sheepdog block driver for example.
> >>=20
> >>=20
> >> Regards,
> >>=20
> >> Alexandre
> >>=20
> > this could look like the problem I have recenty trying to
> > fix with dataplane enabled. Patch series is named as
> >=20
> > [PATCH for 2.5 v6 0/10] dataplane snapshot fixes
> >=20
> > Den
>=20
> anyway, even if above will not help, can you collect gdb
> traces from all threads in QEMU process. May be I'll be
> able to give a hit.
>=20
> Den
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
