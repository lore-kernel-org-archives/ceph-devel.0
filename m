From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: write cache disabling recommendations for journal and storage disks ?
Date: Tue, 22 May 2012 17:01:09 +0200 (CEST)
Message-ID: <17391def-20b6-48fb-b55d-d29beaa680cf@mailpro>
References: <Pine.LNX.4.64.1205220736390.26515@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:35967 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822Ab2EVPBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 11:01:30 -0400
In-Reply-To: <Pine.LNX.4.64.1205220736390.26515@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks Sage,

yes newer kernel doesn't need barrier option since 2.6.37 if I remember=
=2E (support of  REQ_FLUSH/FUA)


Just to be sure:

If client do a fsync or fdatasync, does the write will go only to journ=
al  and after 30seconds is flushed to disk ?

or does it force the write to be committed to disk ?


Does the journal fake the fsync ? (with zfs, this is the nocacheflush=3D=
1 system variable)


----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 22 Mai 2012 16:41:50=20
Objet: Re: write cache disabling recommendations for journal and storag=
e disks ?=20

On Tue, 22 May 2012, Alexandre DERUMIER wrote:=20
> Hi, I have some questions about disabling write cache=20
> "=20
> http://ceph.com/docs/master/config-cluster/file-system-recommendation=
s/=20
>=20
> Ceph aims for data safety, which means that when the application rece=
ives notice that data was written to the disk, that data was actually w=
ritten to the disk. For old kernels (<2.6.33), disable the write cache =
if the journal is on a raw disk. Newer kernels should work fine.=20
>=20
> Use hdparm to disable write caching on the hard disk:=20
>=20
> hdparm -W 0 /dev/hda 0=20
> "=20

To clarify: on newer kernels, calling fsync() or fdatasync() flushes th=
e=20
disk's write cache, so this isn't something you need to worry about at=20
all.=20

> Cache on journal disk:=20
>=20
> what happen if we have a powerfailure, if data are in cache of journa=
l=20
> disk (ssd with/without supercapicitor) (so write is ack, but not real=
ly=20
> write on disk).=20

The ack is only sent if the client requests it, and normally the client=
=20
does not. Which means the client didn't get the ack, and will resend th=
e=20
request to the other replicas once the failed OSD is marked down.=20

> Cache on disks storage:=20
> what happen if we have a powerfailure,if write is commited to journal=
,=20
> but write are in cache of storage disks and not yet on the platters ?=
=20

On newer kernels, the file system is careful to flush the disk cache an=
y=20
time durability matters (e.g., during a journal commit); there is no ne=
ed=20
to disable it on that disk. If the write is durable in the journal, it=20
will be applied to the fs on ceph-osd restart.=20

> Maybe the best way is to disable write cache on both (journal and=20
> storage disks) ?=20

If you have an old kernel, disable it on the journal, and (if you're us=
ing=20
ext3) mount with -o discard. On newer kernels, I believe discard is=20
(finally) the default.=20

sage=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
