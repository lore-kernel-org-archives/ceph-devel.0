From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu-rbd : savevm monitor command don't save vmstate, is it normal ?
Date: Wed, 29 Aug 2012 18:29:40 +0200 (CEST)
Message-ID: <ef974784-d0db-4920-8277-d581a658af4f@mailpro>
References: <503E4015.7050707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56680 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab2H2QaG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 12:30:06 -0400
In-Reply-To: <503E4015.7050707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks Josh,

that's exactly what I want to know.

(BTW: I think that sheepdog block driver also support the save of the v=
mstate
http://lists.wpkg.org/pipermail/sheepdog/2010-April/000368.html
)

Regards,

Alexandre
----- Mail original -----=20

De: "Josh Durgin" <josh.durgin@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 29 Ao=C3=BBt 2012 18:15:17=20
Objet: Re: qemu-rbd : savevm monitor command don't save vmstate, is it =
normal ?=20

On 08/29/2012 06:40 AM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I'm trying to take a full vm state snapshot with savevm monitor comma=
nd (qemu 0.12rc1 + rbd 0.48.1)=20
>=20
> it seem that vmstate is not saved in the snapshot. (I also don't noti=
ce any vm hang during snapshot)=20
> Snapshot of disk is correctly made.=20

AFAIK the only block backend that supports saving the vmstate is qcow2.=
=20
=46or rbd, the savevm/loadvm monitor commands are equivalent to=20
'rbd snap create' and 'rbd snap rollback'. They just save/rollback the=20
disk.=20

> using loadvm monitor command, rollback correctly to disk snapshot but=
 vm hang.=20

If you don't quiesce i/o i.e. via xfsfreeze (it works on the vfs level=20
now, so it's not xfs-specific anymore) before snapshotting a running=20
vm, the fs might require a fsck to be usable. This is only rolling back=
=20
the disk, and not the memory state, so doing it while the vm is running=
=20
is likely to cause problems.=20

> starting qemu with -loadvm snapshotname give=20
> kvm: Error -22 while loading VM state=20
>=20
>=20
> Is it normal ? Not implemented ?=20

bdrv_{save|load}_vmstate are not implemented.=20

>=20
> Regards,=20
>=20
> Alexandre=20




--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
