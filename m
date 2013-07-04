From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Thu, 04 Jul 2013 15:07:52 +0200
Message-ID: <51D573A8.4050901@dachary.org>
References: <CAGhffvws=OabwJHi+7n=SOg+YNxAnU=Zt8WLVZtvf1neHZQYhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig045910B3622A6CCA4ADE376D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:37270 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3GDNH7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jul 2013 09:07:59 -0400
In-Reply-To: <CAGhffvws=OabwJHi+7n=SOg+YNxAnU=Zt8WLVZtvf1neHZQYhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig045910B3622A6CCA4ADE376D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 03/07/2013 18:55, Andreas-Joachim Peters wrote:> Dear Loic et. al.,=20
>=20
> I have/had some questions about the idea's of Erasure Encoding plans an=
d OSD scalability.=20
> Please forgive me that I didnt' study too much any source code or detai=
ls of the current CEPH implementation (yet).
>=20
> Some of my questions I found now already answered here,
>=20
> ( https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/e=
rasure-code.rst )
>=20
> but they also created some more ;-)
>=20
> *ERASUE ENCODING*
>=20
> 1.) I understand that you will cover only OSD outages with the implemen=
tation and will delegate block corruption to be discovered by the file sy=
stem implementation (like BTRFS would do) Is that correct?=20

Ceph also does scrubbing to detect block ( I assume you mean chunk ) corr=
uption. The idea is to adapt the logic which is currently assuming replic=
as so that it detects corruption ( for instance more than K missing chunk=
s if M+K is used ).

> 2.) Blocks would be assembled always on the OSDs (?)

Yes.=20

> 3.) I understood that the (3,2) RS sketched in the Blog is the easiest =
to implement since it can be done with simple parity(XOR) operations but =
do you intend to have a generic (M,K) implementation?

Yes. The idea is to use the jerasure library which provides reed-solomon =
and can be configured in various ways.
=20
> 4.) Would you split a 4M object into M x(4/M) objects? Would this not (=
even more) degrade single disk performance to random IO performance when =
many clients retrieve objects at random disk positions? Is 4M just a defa=
ult or a hard coded parameter of CEPHFS/S3 ?

It is just a default. I hope the updated (look for "Partials" ) https://g=
ithub.com/dachary/ceph/blob/5efcac8fa6e08119f0deaaf1ae9919080e90cf0a/doc/=
dev/osd_internals/erasure-code.rst answers the rest of the question .

> 5.) Local Parity like in Xorbas makes sense for large M, but would a la=
rge M not hit scalability limits given by a single OSD in terms of object=
 bookkeeping/scrubbing/synchronization, Network packet limitations (atlea=
st in 1GBit networks) etc ... 1 TB =3D 250k objects =3D> M=3D10 =3D> 2.5 =
Mio objects ( a 100 TB disk server would have 250 Mio object fragments ?!=
?!)=20

We are looking at M+K < 2^8 at the moment which significantly reduces the=
 problem you mention as well as the CPU consumption issues.

> 6.) Does a CEPH object know something like a parent object so it could =
understand if it is still a 'connected' object (like part of a block coll=
ection implementing a block, a file or container?)

At the level where erasure coding is implemented ( librados ) there is no=
 nothing of relationships between objects.

> *OSD SCALABILITY*

Please take my answers there with a grain of salt because there are many =
people with much more knowledge than I have :-)

> 1.) Are there some deployment numbers about the largest number of OSDs =
per placement group and the number of objects you can handle well in a pl=
acement group?

The acceptable range seems to be ( number of OSDs ) * 100 up to ( number =
of OSDs ) * 1000

> 2.) What is the largest number of OSDs people have ever tried out? Many=
 presentations say 10-10k nodes, but probably it should be more OSDs?

The largest deployment I'm aware of is Dream{Object,Compute} but I don't =
know the actual numbers.

> 3.) In our CC we operate disk server with up to 100 TB (25 disks) , nex=
t year 200 TB (50 disks) and in the future even bigger.=20
> If I remember right the recommendation is to have 2GB of memory per OSD=
=2E=20
> Can the memory footprint be lowered or is it a 'feature' of the OSD arc=
hitecture?
> Is there in-memory information limiting scalability?

The OSD memory usage varies from from a few hundred mega bytes when runni=
ng normal operations to about 2GB when recovering, which can be a problem=
 if you have a large number of OSDs running on the same hardware. You can=
 control this by grouping the disks together. For instance if your machin=
e has 50 disks you could group them in 10 RAID0 including 5 physical disk=
s each and run 10 OSD instead of 50. Of course it means that you'll lose =
5 disks at once if one fails but when grouping 50 disks on a single hardw=
are you already made a decision that leans in this direction.

> 4.) Today we run disk-only storage with 20k disks and 24 to 33 disk per=
 node. There is a weekly activity of repair & replacement and reboots.

I assume that's of 1,000 machines, right ? How many disk / machines do yo=
u need to replace on a weekly basis ?=20

> A typical scenario is that after a reboot filesystem contents was not s=
ynced and information is lost. Does CEPH OSD sync every block or if not u=
se a quorum on block contents when reading or it would just return the bl=
ock as is and only scrubbing would mark a block as corrupted?

I don't think Ceph can ever return a corrupted object as if it was not. T=
hat would either require a manual intervention from the operator to tampe=
r with the file without notifying Ceph ( which would be the equivalent of=
 shotting himself in the foot ;-) or a bug in XFS ( or the underlying fil=
e system on which objects are stored ) that similarly corrupts the file. =
And all this would have to happen before deep scrubbing discovers the pro=
blem. =20

> 5.) When rebalancing is needed is there some time slice or scheduling m=
echanism which regulates the block relocation with respect to the 'normal=
' IO activity on the source and target OSD? Is there an overload protecti=
on in particular on the block target OSD?

There is a reservation mechanism to avoid creating too many communication=
 paths during recovery ( see http://ceph.com/docs/master/dev/osd_internal=
s/backfill_reservation/ for instance ) and throttling to regulate the ban=
dwidth usage ( not 100% sure how that works though ). In addition it is r=
ecommended when operating a large cluster to dedicate an interface to int=
ernal communications ( check http://ceph.com/docs/master/rados/configurat=
ion/network-config-ref/ for more information ).

Cheers

>=20
> Thanks.
>=20
> Andreas.
>=20
>=20
>=20
>=20
>=20
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig045910B3622A6CCA4ADE376D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHVc6kACgkQ8dLMyEl6F23oYgCcC4paISSyXNZ7X0vCHnyPwUN8
xGQAn2P+wcvge1T5OiyuCpf2hdGH1JYZ
=iFNj
-----END PGP SIGNATURE-----

--------------enig045910B3622A6CCA4ADE376D--
