From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: filestore flusher = false  , correct my problem of constant write (need info on this parameter)
Date: Tue, 26 Jun 2012 09:29:12 +0200 (CEST)
Message-ID: <99aeb3f7-a312-4924-80e5-566069c6a13b@mailpro>
References: <2b6bdfdd-21ed-4984-a3f0-e3aed6f4f28b@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50298 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132Ab2FZH3h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 03:29:37 -0400
In-Reply-To: <2b6bdfdd-21ed-4984-a3f0-e3aed6f4f28b@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, Stefan Priebe <s.priebe@profihost.ag>

some tests today:

with filestore queue max ops =3D 50000

I can achieve 4000io/s BY kvm-guest.

So it seem to scale.=20

(tested with 3 kvm guest, each guest 4000io/s).



I have some spike because underlying storage is not able to handle writ=
e.
with iostat and seekwatcher I see a lot of random write and seeks on os=
d storage.

(I'll take alook to flush_min wip to see if it's helping).



----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Sage Weil" <sage@inktank.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org=
, "Stefan Priebe" <s.priebe@profihost.ag>=20
Envoy=C3=A9: Lundi 25 Juin 2012 16:34:03=20
Objet: Re: filestore flusher =3D false , correct my problem of constant=
 write (need info on this parameter)=20

Hi,=20
maybe this can help:=20

I have tunned=20
filestore queue max ops =3D 50000=20

now I'm able to achieve 4000io/s (with some spikes)=20

with 3 nodes with 1 x osd (1 x 15k drive by osd), journal on tmpfs=20
or=20
3 nodes with 5 osd (1 x 15k drive by osd), journal on tmpfs=20

same result for both conf.=20




----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Sage Weil" <sage@inktank.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org=
, "Stefan Priebe" <s.priebe@profihost.ag>=20
Envoy=C3=A9: Dimanche 24 Juin 2012 10:10:48=20
Objet: Re: filestore flusher =3D false , correct my problem of constant=
 write (need info on this parameter)=20

ok, I have done tests with more than 1 client.=20

3 kvm guest on 3 differents kvm host server and 3 kvm guest on same ser=
ver.=20

I have the same result , around 2000 io/s shared between clients. So it=
 doesn't scale.=20


I have also tried with 3 nodes x 5 osd 15k drive + 5 tmpfs journal=20
and 3 nodes x 1 osd (hardware raid0 with 5 x 15kdisk) + 1 tmpfs journal=
=20

the results are same, around 2000 io/s=20


But=20
if I try with 3 nodes x 1 osd with 1x15k drive,=20
I got around 500 io/s=20


I also known that stefan priebe has achieve around 12000io/s with ssds =
in osd.=20

So it's seem related to osd drive speed=20

So, are we sure that journal is acking to client before flushing to dis=
k ?=20



benchmark used is fio, with directio, write 100MB of 4K block. (so jour=
nal is big enough to handle all the write)=20

fio --filename=3D[disk] --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=3D=
100M --numjobs=3D50 --runtime=3D30 --group_reporting --name=3Dfile1=20


----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Sage Weil" <sage@inktank.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org=
, "Stefan Priebe" <s.priebe@profihost.ag>=20
Envoy=C3=A9: Samedi 23 Juin 2012 20:21:05=20
Objet: Re: filestore flusher =3D false , correct my problem of constant=
 write (need info on this parameter)=20

>>Is that 2000 ios from a single client? You might try multiple clients=
 and=20
>>see if the sum of the ios will scale any higher.=20

yes from a single client. (qemu-kvm guest).=20

Tomorrow,I'll retry with 3 qemu-kvm guest, on same host and 3 different=
s hosts.=20
I'll also try on bigger cpu machine to compra.(I see a lot of cpu on my=
 kvm guest process, more than with iscsi)=20

I'll keep you in touch.=20

Thanks=20

Alexandre=20

----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org=
, "Stefan Priebe" <s.priebe@profihost.ag>=20
Envoy=C3=A9: Samedi 23 Juin 2012 20:12:49=20
Objet: Re: filestore flusher =3D false , correct my problem of constant=
 write (need info on this parameter)=20

On Sat, 23 Jun 2012, Alexandre DERUMIER wrote:=20
> >>I was just talking with Elder on IRC yesterday about looking into h=
ow=20
> >>much small network transfers are hurting us in cases like these. Ev=
en=20
> >>with SSD based OSDs I haven't seen a very dramatic improvement in s=
mall=20
> >>request performance. How tough would it be to aggregate requests in=
to=20
> >>larger network transactions? There would be a latency penalty of=20
> >>course, but we could flush a client side dirty cache pretty quickly=
 and=20
> >>still benefit if we are getting bombarded with lots of tiny request=
s.=20
>=20
> Yes, I see no improvement with journal on tmpfs ...this is strange..=20
>=20
> Also, I have tried with rbd_cache=3Dtrue, so ios should be already ag=
gregate in bigger transaction.=20
> But I didnt't have see any improvement.=20
>=20
> I'm around 2000 ios.=20
>=20
> Do you know what is the bottleneck ? rbd protocol (some kind of overh=
ead=20
> for each io ?)=20

Is that 2000 ios from a single client? You might try multiple clients a=
nd=20
see if the sum of the ios will scale any higher. That will tell us=20
whether it is in the messenger or osd request pipeline. The latter=20
definitely needs some work, although there may be a quick fix to the ms=
gr=20
that will buy us some too.=20

sage=20


>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Mark Nelson" <mark.nelson@inktank.com>=20
> =C3=80: "Sage Weil" <sage@inktank.com>=20
> Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, ceph-devel@vger.kerne=
l.org, "Stefan Priebe" <s.priebe@profihost.ag>=20
> Envoy=C3=A9: Samedi 23 Juin 2012 18:40:28=20
> Objet: Re: filestore flusher =3D false , correct my problem of consta=
nt write (need info on this parameter)=20
>=20
> On 6/23/12 10:38 AM, Sage Weil wrote:=20
> > On Fri, 22 Jun 2012, Alexandre DERUMIER wrote:=20
> >> Hi Sage,=20
> >> thanks for your response.=20
> >>=20
> >>>> If you turn off the journal compeletely, you will see bursty wri=
te commits=20
> >>> >from the perspective of the client, because the OSD is periodica=
lly doing=20
> >>>> a sync or snapshot and only acking the writes then.=20
> >>>> If you enable the journal, the OSD will reply with a commit as s=
oon as the=20
> >>>> write is stable in the journal. That's one reason why it is ther=
e--file=20
> >>>> system commits of heavyweight and slow.=20
> >>=20
> >> Yes of course, I don't wan't to desactivate journal, using a journ=
al on a fast ssd or nvram is the right way.=20
> >>=20
> >>>> If we left the file system to its own devices and did a sync eve=
ry 10=20
> >>>> seconds, the disk would sit idle while a bunch of dirty data acc=
umulated=20
> >>>> in cache, and then the sync/snapshot would take a really long ti=
me. This=20
> >>>> is horribly inefficient (the disk is idle half the time), and us=
eless (the=20
> >>>> delayed write behavior makes sense for local workloads, but not =
servers=20
> >>>> where there is a client on the other end batching its writes). T=
o prevent=20
> >>>> this, 'filestore flusher' will prod the kernel to flush out any =
written=20
> >>>> data to the disk quickly. Then, when we get around to doing the=20
> >>>> sync/snapshot it is pretty quick, because only fs metadata and=20
> >>>> just-written data needs to be flushed.=20
> >>=20
> >> mmm, I disagree.=20
> >>=20
> >> If you flush quickly, it's works fine with sequential write worklo=
ad.=20
> >>=20
> >> But if you have a lot of random write with 4k block by exemple, yo=
u are=20
> >> going to have a lot of disk seeks. The way zfs works or netapp san=
=20
> >> storage works, they take random writes in a fast journal then flus=
h them=20
> >> sequentially each 20s to slow storage.=20
> >=20
> > Oh, I see what you're getting at. Yes, that is not ideal for small =
random=20
> > writes. There is a branch in ceph.git called wip-flushmin that just=
 sets=20
> > a minimum write size for the flush that will probably do a decent j=
ob of=20
> > dealing with this: small writes won't get flushed, large ones will.=
=20
> > Picking the right value will depend on how expensive seeks are for =
your=20
> > storage system.=20
> >=20
> > You'll want to cherry-pick just the top commit on top of whatever i=
t is=20
> > you're running...=20
>=20
> I was just talking with Elder on IRC yesterday about looking into how=
=20
> much small network transfers are hurting us in cases like these. Even=
=20
> with SSD based OSDs I haven't seen a very dramatic improvement in sma=
ll=20
> request performance. How tough would it be to aggregate requests into=
=20
> larger network transactions? There would be a latency penalty of=20
> course, but we could flush a client side dirty cache pretty quickly a=
nd=20
> still benefit if we are getting bombarded with lots of tiny requests.=
=20
>=20
> Mark=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
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
>=20
>=20
> Alexandre D e rumier=20
>=20
> Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20
>=20
>=20
> Fixe : 03 20 68 88 85=20
>=20
> Fax : 03 20 68 90 88=20
>=20
>=20
> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
> 12 rue Marivaux 75002 Paris=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20


--=20

--=20





Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20





Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20





Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



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
