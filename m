From: Sage Weil <sage@inktank.com>
Subject: Re: write cache disabling recommendations for journal and storage
 disks ?
Date: Tue, 22 May 2012 08:17:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205220815540.26515@cobra.newdream.net>
References: <17391def-20b6-48fb-b55d-d29beaa680cf@mailpro>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1377468043-1337699876=:26515"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45692 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2EVPR7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 11:17:59 -0400
In-Reply-To: <17391def-20b6-48fb-b55d-d29beaa680cf@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1377468043-1337699876=:26515
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 22 May 2012, Alexandre DERUMIER wrote:
> Thanks Sage,
>=20
> yes newer kernel doesn't need barrier option since 2.6.37 if I remember.=
=20
> (support of REQ_FLUSH/FUA)
>=20
>=20
> Just to be sure:
>=20
> If client do a fsync or fdatasync, does the write will go only to=20
> journal and after 30seconds is flushed to disk ?
>=20
> or does it force the write to be committed to disk ?

Oh, are you talking about the *ceph* client doing an fsync?  In that case,=
=20
it waits for a COMMIT from the osd, which happens when all replicas have=20
written to the journal (or fs, whichever is durable first).

The OSD itself is calling fdatasync() on the journal file.

> Does the journal fake the fsync ? (with zfs, this is the nocacheflush=3D1=
=20
> system variable)

I'm not sure what you mean by "faking" the fsync...

sage


>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Sage Weil" <sage@inktank.com>=20
> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Envoy=E9: Mardi 22 Mai 2012 16:41:50=20
> Objet: Re: write cache disabling recommendations for journal and storage =
disks ?=20
>=20
> On Tue, 22 May 2012, Alexandre DERUMIER wrote:=20
> > Hi, I have some questions about disabling write cache=20
> > "=20
> > http://ceph.com/docs/master/config-cluster/file-system-recommendations/=
=20
> >=20
> > Ceph aims for data safety, which means that when the application receiv=
es notice that data was written to the disk, that data was actually written=
 to the disk. For old kernels (<2.6.33), disable the write cache if the jou=
rnal is on a raw disk. Newer kernels should work fine.=20
> >=20
> > Use hdparm to disable write caching on the hard disk:=20
> >=20
> > hdparm -W 0 /dev/hda 0=20
> > "=20
>=20
> To clarify: on newer kernels, calling fsync() or fdatasync() flushes the=
=20
> disk's write cache, so this isn't something you need to worry about at=20
> all.=20
>=20
> > Cache on journal disk:=20
> >=20
> > what happen if we have a powerfailure, if data are in cache of journal=
=20
> > disk (ssd with/without supercapicitor) (so write is ack, but not really=
=20
> > write on disk).=20
>=20
> The ack is only sent if the client requests it, and normally the client=
=20
> does not. Which means the client didn't get the ack, and will resend the=
=20
> request to the other replicas once the failed OSD is marked down.=20
>=20
> > Cache on disks storage:=20
> > what happen if we have a powerfailure,if write is commited to journal,=
=20
> > but write are in cache of storage disks and not yet on the platters ?=
=20
>=20
> On newer kernels, the file system is careful to flush the disk cache any=
=20
> time durability matters (e.g., during a journal commit); there is no need=
=20
> to disable it on that disk. If the write is durable in the journal, it=20
> will be applied to the fs on ceph-osd restart.=20
>=20
> > Maybe the best way is to disable write cache on both (journal and=20
> > storage disks) ?=20
>=20
> If you have an old kernel, disable it on the journal, and (if you're usin=
g=20
> ext3) mount with -o discard. On newer kernels, I believe discard is=20
> (finally) the default.=20
>=20
> sage=20
>=20
>=20
>=20
> --=20
>=20
> --=20
>=20
>=20
>=20
>=20
> =09Alexandre D erumier=20
> Ing=E9nieur Syst=E8me=20
> Fixe : 03 20 68 88 90=20
> Fax : 03 20 68 90 81=20
> 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix - France=20
> 12 rue Marivaux 75002 Paris - France=20
> =09
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1377468043-1337699876=:26515--
