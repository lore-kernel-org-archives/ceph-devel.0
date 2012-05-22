From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: write cache disabling recommendations for journal and storage disks ?
Date: Tue, 22 May 2012 17:26:51 +0200 (CEST)
Message-ID: <6cf65d55-fb96-4bd9-af1c-811082708583@mailpro>
References: <Pine.LNX.4.64.1205220815540.26515@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:42654 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759496Ab2EVP1N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 11:27:13 -0400
In-Reply-To: <Pine.LNX.4.64.1205220815540.26515@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Yes, I was talking about client fsync. (Sorry, I was not clear in my ma=
il)

But thanks for the informations about fsync in ceph osd,I'm understand =
now how things works.

About faking: I just want to say that if the client do a fsync, the fsy=
nc doesn't force the flush the disk platter but only to journal.
With zfs, I didn't have activated nocacheflush, and write was always co=
mmit to journal AND disk platter before ack to the client.(so latency w=
as bad ....)

Thanks again !



----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Sage Weil" <sage@inktank.com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 22 Mai 2012 17:17:56=20
Objet: Re: write cache disabling recommendations for journal and storag=
e disks ?=20

On Tue, 22 May 2012, Alexandre DERUMIER wrote:=20
> Thanks Sage,=20
>=20
> yes newer kernel doesn't need barrier option since 2.6.37 if I rememb=
er.=20
> (support of REQ_FLUSH/FUA)=20
>=20
>=20
> Just to be sure:=20
>=20
> If client do a fsync or fdatasync, does the write will go only to=20
> journal and after 30seconds is flushed to disk ?=20
>=20
> or does it force the write to be committed to disk ?=20

Oh, are you talking about the *ceph* client doing an fsync? In that cas=
e,=20
it waits for a COMMIT from the osd, which happens when all replicas hav=
e=20
written to the journal (or fs, whichever is durable first).=20

The OSD itself is calling fdatasync() on the journal file.=20

> Does the journal fake the fsync ? (with zfs, this is the nocacheflush=
=3D1=20
> system variable)=20

I'm not sure what you mean by "faking" the fsync...=20

sage=20


>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Sage Weil" <sage@inktank.com>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Mardi 22 Mai 2012 16:41:50=20
> Objet: Re: write cache disabling recommendations for journal and stor=
age disks ?=20
>=20
> On Tue, 22 May 2012, Alexandre DERUMIER wrote:=20
> > Hi, I have some questions about disabling write cache=20
> > "=20
> > http://ceph.com/docs/master/config-cluster/file-system-recommendati=
ons/=20
> >=20
> > Ceph aims for data safety, which means that when the application re=
ceives notice that data was written to the disk, that data was actually=
 written to the disk. For old kernels (<2.6.33), disable the write cach=
e if the journal is on a raw disk. Newer kernels should work fine.=20
> >=20
> > Use hdparm to disable write caching on the hard disk:=20
> >=20
> > hdparm -W 0 /dev/hda 0=20
> > "=20
>=20
> To clarify: on newer kernels, calling fsync() or fdatasync() flushes =
the=20
> disk's write cache, so this isn't something you need to worry about a=
t=20
> all.=20
>=20
> > Cache on journal disk:=20
> >=20
> > what happen if we have a powerfailure, if data are in cache of jour=
nal=20
> > disk (ssd with/without supercapicitor) (so write is ack, but not re=
ally=20
> > write on disk).=20
>=20
> The ack is only sent if the client requests it, and normally the clie=
nt=20
> does not. Which means the client didn't get the ack, and will resend =
the=20
> request to the other replicas once the failed OSD is marked down.=20
>=20
> > Cache on disks storage:=20
> > what happen if we have a powerfailure,if write is commited to journ=
al,=20
> > but write are in cache of storage disks and not yet on the platters=
 ?=20
>=20
> On newer kernels, the file system is careful to flush the disk cache =
any=20
> time durability matters (e.g., during a journal commit); there is no =
need=20
> to disable it on that disk. If the write is durable in the journal, i=
t=20
> will be applied to the fs on ceph-osd restart.=20
>=20
> > Maybe the best way is to disable write cache on both (journal and=20
> > storage disks) ?=20
>=20
> If you have an old kernel, disable it on the journal, and (if you're =
using=20
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
> Alexandre D erumier=20
> Ing=C3=A9nieur Syst=C3=A8me=20
> Fixe : 03 20 68 88 90=20
> Fax : 03 20 68 90 81=20
> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
> 12 rue Marivaux 75002 Paris - France=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20


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
