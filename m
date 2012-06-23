From: Sage Weil <sage@inktank.com>
Subject: Re: filestore flusher = false  , correct my problem of constant
 write (need info on this parameter)
Date: Sat, 23 Jun 2012 08:38:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206230834570.20561@cobra.newdream.net>
References: <1fa246cc-38d3-486d-bd55-1f809d229074@mailpro>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-438579241-1340465902=:20561"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50712 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab2FWPiZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 11:38:25 -0400
In-Reply-To: <1fa246cc-38d3-486d-bd55-1f809d229074@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-438579241-1340465902=:20561
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Jun 2012, Alexandre DERUMIER wrote:
> Hi Sage,
> thanks for your response.
>=20
> >>If you turn off the journal compeletely, you will see bursty write comm=
its=20
> >>from the perspective of the client, because the OSD is periodically doi=
ng=20
> >>a sync or snapshot and only acking the writes then.=20
> >>If you enable the journal, the OSD will reply with a commit as soon as =
the=20
> >>write is stable in the journal. That's one reason why it is there--file=
=20
> >>system commits of heavyweight and slow.=20
>=20
> Yes of course, I don't wan't to desactivate journal, using a journal on a=
 fast ssd or nvram is the right way.
>=20
> >>If we left the file system to its own devices and did a sync every 10=
=20
> >>seconds, the disk would sit idle while a bunch of dirty data accumulate=
d=20
> >>in cache, and then the sync/snapshot would take a really long time. Thi=
s=20
> >>is horribly inefficient (the disk is idle half the time), and useless (=
the=20
> >>delayed write behavior makes sense for local workloads, but not servers=
=20
> >>where there is a client on the other end batching its writes). To preve=
nt=20
> >>this, 'filestore flusher' will prod the kernel to flush out any written=
=20
> >>data to the disk quickly. Then, when we get around to doing the=20
> >>sync/snapshot it is pretty quick, because only fs metadata and=20
> >>just-written data needs to be flushed.=20
>=20
> mmm, I disagree.
>=20
> If you flush quickly, it's works fine with sequential write workload.
>=20
> But if you have a lot of random write with 4k block by exemple, you are=
=20
> going to have a lot of disk seeks. The way zfs works or netapp san=20
> storage works, they take random writes in a fast journal then flush them=
=20
> sequentially each 20s to slow storage.

Oh, I see what you're getting at.  Yes, that is not ideal for small random=
=20
writes.  There is a branch in ceph.git called wip-flushmin that just sets=
=20
a minimum write size for the flush that will probably do a decent job of=20
dealing with this: small writes won't get flushed, large ones will. =20
Picking the right value will depend on how expensive seeks are for your=20
storage system.

You'll want to cherry-pick just the top commit on top of whatever it is=20
you're running...

sage

>=20
> To compare with zfs or netapp, I can achieve around 20000io/s on random=
=20
> write 4K with 4GB nvram and 10 x 7200 disk.
>=20
> with ceph, i'm around 2000io/s with same config. (3 nodes with=20
> 10x7200disk, 2x replication), so around real disk io limit without any=20
> write cache.
>=20
>=20
> So for now, i'm think i'm going to use ssd for my osds,I have 80% random=
=20
> write workload. (no seeks, so no problem to constant random write)
>=20
>=20
>=20
> NTW: maybe wiki is wrong
> http://ceph.com/wiki/OSD_journal
> section Motivation
> "Enterprise products like NetApp filers "cheat" by journaling all writes =
to NVRAM and then taking their time to flush things out to disk efficiently=
=2E This gives you very low-latency writes _and_ efficient disk IO at the e=
xpense of hardware."
>=20
> This why I thinked ceph worked like this.
>=20
>=20
> Thanks again,
>=20
> -Alexandre
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Sage Weil" <sage@inktank.com>=20
> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org, "Mark Nelson" <mark.nelson@inktank.com>, =
"Stefan Priebe" <s.priebe@profihost.ag>=20
> Envoy=E9: Jeudi 21 Juin 2012 18:03:45=20
> Objet: Re: filestore flusher =3D false , correct my problem of constant w=
rite (need info on this parameter)=20
>=20
> Hi Alexandre,=20
>=20
> [Sorry I didn't follow up earlier; I didn't understand your question.]=20
>=20
> If you turn off the journal compeletely, you will see bursty write commit=
s=20
> from the perspective of the client, because the OSD is periodically doing=
=20
> a sync or snapshot and only acking the writes then.=20
>=20
> If you enable the journal, the OSD will reply with a commit as soon as th=
e=20
> write is stable in the journal. That's one reason why it is there--file=
=20
> system commits of heavyweight and slow.=20
>=20
> If we left the file system to its own devices and did a sync every 10=20
> seconds, the disk would sit idle while a bunch of dirty data accumulated=
=20
> in cache, and then the sync/snapshot would take a really long time. This=
=20
> is horribly inefficient (the disk is idle half the time), and useless (th=
e=20
> delayed write behavior makes sense for local workloads, but not servers=
=20
> where there is a client on the other end batching its writes). To prevent=
=20
> this, 'filestore flusher' will prod the kernel to flush out any written=
=20
> data to the disk quickly. Then, when we get around to doing the=20
> sync/snapshot it is pretty quick, because only fs metadata and=20
> just-written data needs to be flushed.=20
>=20
> So: the behavior you're seeing is normal, and good.=20
>=20
> Did I understand your confusion correctly?=20
>=20
> Thanks!=20
> sage=20
>=20
>=20
> On Wed, 20 Jun 2012, Alexandre DERUMIER wrote:=20
>=20
> > Hi,=20
> > I have tried to disabe filestore flusher=20
> >=20
> > filestore flusher =3D false=20
> > filestore max sync interval =3D 30=20
> > filestore min sync interval =3D 29=20
> >=20
> >=20
> > in osd config.=20
> >=20
> >=20
> > now, I see correct sync each 30s when doing rados bench=20
> >=20
> > rados -p pool3 bench 60 write -t 16=20
> >=20
> >=20
> > seekwatcher movie:=20
> >=20
> >=20
> > before=20
> > ------=20
> > http://odisoweb1.odiso.net/seqwrite-radosbench-flusherenable.mpg=20
> >=20
> > after=20
> > -----=20
> > http://odisoweb1.odiso.net/seqwrite-radosbench-flusherdisable.mpg=20
> >=20
> >=20
> > Shouldn't it be the normal behaviour ? What's exactly is filestore flus=
her vs syncfs ?=20
> >=20
> >=20
> >=20
> > This seem to works fine with rados bench,=20
> > But when I launch benchmark with fio from my guest vm, I see again cons=
tant write.=20
> > (I'll try to debug that today)=20
> >=20
> >=20
> > My target is to be able to handle small random write and write them eac=
h 30s.=20
> >=20
> > Regards,=20
> >=20
> > Alexandre=20
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
> > the body of a message to majordomo@vger.kernel.org=20
> > More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> >=20
> >=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=
=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
>=20
> --=20
>=20
> --=20
>=20
>=20
>=20
> =09
>=20
> Alexandre D e rumier=20
>=20
> Ing=E9nieur Syst=E8mes et R=E9seaux=20
>=20
>=20
> Fixe : 03 20 68 88 85=20
>=20
> Fax : 03 20 68 90 88=20
>=20
>=20
> 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix=20
> 12 rue Marivaux 75002 Paris=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-438579241-1340465902=:20561--
