From: Sage Weil <sage@inktank.com>
Subject: Re: filestore flusher = false  , correct my problem of constant
 write (need info on this parameter)
Date: Sat, 23 Jun 2012 11:12:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206231110520.29045@cobra.newdream.net>
References: <ba1bddc4-aaed-4ba9-8119-fdf954ec347d@mailpro>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-77117844-1340475169=:29045"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38865 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab2FWSMu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 14:12:50 -0400
In-Reply-To: <ba1bddc4-aaed-4ba9-8119-fdf954ec347d@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, Stefan Priebe <s.priebe@profihost.ag>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-77117844-1340475169=:29045
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 23 Jun 2012, Alexandre DERUMIER wrote:
> >>I was just talking with Elder on IRC yesterday about looking into how=
=20
> >>much small network transfers are hurting us in cases like these. Even=
=20
> >>with SSD based OSDs I haven't seen a very dramatic improvement in small=
=20
> >>request performance. How tough would it be to aggregate requests into=
=20
> >>larger network transactions? There would be a latency penalty of=20
> >>course, but we could flush a client side dirty cache pretty quickly and=
=20
> >>still benefit if we are getting bombarded with lots of tiny requests.=
=20
>=20
> Yes, I see no improvement with journal on tmpfs ...this is strange..
>=20
> Also, I have tried with rbd_cache=3Dtrue, so ios should be already aggreg=
ate in bigger transaction.
> But I didnt't have see any improvement.
>=20
> I'm around 2000 ios.
>=20
> Do you know what is the bottleneck ? rbd protocol (some kind of overhead=
=20
> for each io ?)

Is that 2000 ios from a single client?  You might try multiple clients and=
=20
see if the sum of the ios will scale any higher.  That will tell us=20
whether it is in the messenger or osd request pipeline.  The latter=20
definitely needs some work, although there may be a quick fix to the msgr=
=20
that will buy us some too.

sage


>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Mark Nelson" <mark.nelson@inktank.com>=20
> =C0: "Sage Weil" <sage@inktank.com>=20
> Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, ceph-devel@vger.kernel.or=
g, "Stefan Priebe" <s.priebe@profihost.ag>=20
> Envoy=E9: Samedi 23 Juin 2012 18:40:28=20
> Objet: Re: filestore flusher =3D false , correct my problem of constant w=
rite (need info on this parameter)=20
>=20
> On 6/23/12 10:38 AM, Sage Weil wrote:=20
> > On Fri, 22 Jun 2012, Alexandre DERUMIER wrote:=20
> >> Hi Sage,=20
> >> thanks for your response.=20
> >>=20
> >>>> If you turn off the journal compeletely, you will see bursty write c=
ommits=20
> >>> >from the perspective of the client, because the OSD is periodically =
doing=20
> >>>> a sync or snapshot and only acking the writes then.=20
> >>>> If you enable the journal, the OSD will reply with a commit as soon =
as the=20
> >>>> write is stable in the journal. That's one reason why it is there--f=
ile=20
> >>>> system commits of heavyweight and slow.=20
> >>=20
> >> Yes of course, I don't wan't to desactivate journal, using a journal o=
n a fast ssd or nvram is the right way.=20
> >>=20
> >>>> If we left the file system to its own devices and did a sync every 1=
0=20
> >>>> seconds, the disk would sit idle while a bunch of dirty data accumul=
ated=20
> >>>> in cache, and then the sync/snapshot would take a really long time. =
This=20
> >>>> is horribly inefficient (the disk is idle half the time), and useles=
s (the=20
> >>>> delayed write behavior makes sense for local workloads, but not serv=
ers=20
> >>>> where there is a client on the other end batching its writes). To pr=
event=20
> >>>> this, 'filestore flusher' will prod the kernel to flush out any writ=
ten=20
> >>>> data to the disk quickly. Then, when we get around to doing the=20
> >>>> sync/snapshot it is pretty quick, because only fs metadata and=20
> >>>> just-written data needs to be flushed.=20
> >>=20
> >> mmm, I disagree.=20
> >>=20
> >> If you flush quickly, it's works fine with sequential write workload.=
=20
> >>=20
> >> But if you have a lot of random write with 4k block by exemple, you ar=
e=20
> >> going to have a lot of disk seeks. The way zfs works or netapp san=20
> >> storage works, they take random writes in a fast journal then flush th=
em=20
> >> sequentially each 20s to slow storage.=20
> >=20
> > Oh, I see what you're getting at. Yes, that is not ideal for small rand=
om=20
> > writes. There is a branch in ceph.git called wip-flushmin that just set=
s=20
> > a minimum write size for the flush that will probably do a decent job o=
f=20
> > dealing with this: small writes won't get flushed, large ones will.=20
> > Picking the right value will depend on how expensive seeks are for your=
=20
> > storage system.=20
> >=20
> > You'll want to cherry-pick just the top commit on top of whatever it is=
=20
> > you're running...=20
>=20
> I was just talking with Elder on IRC yesterday about looking into how=20
> much small network transfers are hurting us in cases like these. Even=20
> with SSD based OSDs I haven't seen a very dramatic improvement in small=
=20
> request performance. How tough would it be to aggregate requests into=20
> larger network transactions? There would be a latency penalty of=20
> course, but we could flush a client side dirty cache pretty quickly and=
=20
> still benefit if we are getting bombarded with lots of tiny requests.=20
>=20
> Mark=20
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
--557981400-77117844-1340475169=:29045--
