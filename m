From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Qemu-devel] qemu : rbd block driver internal snapshot and
 vm_stop is hanging forever
Date: Mon, 9 Nov 2015 15:02:50 +0100 (CET)
Message-ID: <899209401.8213791.1447077770365.JavaMail.zimbra@oxygem.tv>
References: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv> <5640490B.5030700@parallels.com> <564049BA.1090805@parallels.com> <253899541.6094258.1447066125770.JavaMail.zimbra@oxygem.tv> <1119051619.7201094.1447076562035.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38366 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbKIOCw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 09:02:52 -0500
In-Reply-To: <1119051619.7201094.1447076562035.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, jdurgin@redhat.com

>>Can you reproduce with Ceph debug logging enabled (i.e. debug rbd=3D2=
0 in your ceph.conf)?  If you could attach the log to the Ceph tracker =
ticket I opened [1], that would be very helpful.
>>
>>[1] http://tracker.ceph.com/issues/13726

yes,I'm able to reproduce it 100%, I have attached the log to the track=
er.

Alexandre

----- Mail original -----
De: "Jason Dillaman" <dillaman@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-devel=
@nongnu.org>, jdurgin@redhat.com
Envoy=C3=A9: Lundi 9 Novembre 2015 14:42:42
Objet: Re: [Qemu-devel] qemu : rbd block driver internal snapshot and v=
m_stop is hanging forever

Can you reproduce with Ceph debug logging enabled (i.e. debug rbd=3D20 =
in your ceph.conf)? If you could attach the log to the Ceph tracker tic=
ket I opened [1], that would be very helpful.=20

[1] http://tracker.ceph.com/issues/13726=20

Thanks,=20
Jason=20


----- Original Message -----=20
> From: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> To: "ceph-devel" <ceph-devel@vger.kernel.org>=20
> Cc: "qemu-devel" <qemu-devel@nongnu.org>, jdurgin@redhat.com=20
> Sent: Monday, November 9, 2015 5:48:45 AM=20
> Subject: Re: [Qemu-devel] qemu : rbd block driver internal snapshot a=
nd vm_stop is hanging forever=20
>=20
> adding to ceph.conf=20
>=20
> [client]=20
> rbd_non_blocking_aio =3D false=20
>=20
>=20
> fix the problem for me (with rbd_cache=3Dfalse)=20
>=20
>=20
> (@cc jdurgin@redhat.com)=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Denis V. Lunev" <den-lists@parallels.com>=20
> =C3=80: "aderumier" <aderumier@odiso.com>, "ceph-devel"=20
> <ceph-devel@vger.kernel.org>, "qemu-devel" <qemu-devel@nongnu.org>=20
> Envoy=C3=A9: Lundi 9 Novembre 2015 08:22:34=20
> Objet: Re: [Qemu-devel] qemu : rbd block driver internal snapshot and=
 vm_stop=20
> is hanging forever=20
>=20
> On 11/09/2015 10:19 AM, Denis V. Lunev wrote:=20
> > On 11/09/2015 06:10 AM, Alexandre DERUMIER wrote:=20
> >> Hi,=20
> >>=20
> >> with qemu (2.4.1), if I do an internal snapshot of an rbd device,=20
> >> then I pause the vm with vm_stop,=20
> >>=20
> >> the qemu process is hanging forever=20
> >>=20
> >>=20
> >> monitor commands to reproduce:=20
> >>=20
> >>=20
> >> # snapshot_blkdev_internal drive-virtio0 yoursnapname=20
> >> # stop=20
> >>=20
> >>=20
> >>=20
> >>=20
> >> I don't see this with qcow2 or sheepdog block driver for example.=20
> >>=20
> >>=20
> >> Regards,=20
> >>=20
> >> Alexandre=20
> >>=20
> > this could look like the problem I have recenty trying to=20
> > fix with dataplane enabled. Patch series is named as=20
> >=20
> > [PATCH for 2.5 v6 0/10] dataplane snapshot fixes=20
> >=20
> > Den=20
>=20
> anyway, even if above will not help, can you collect gdb=20
> traces from all threads in QEMU process. May be I'll be=20
> able to give a hit.=20
>=20
> Den=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
