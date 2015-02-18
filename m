From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Wed, 18 Feb 2015 12:38:19 -0500 (EST)
Message-ID: <2134758899.22244800.1424281099141.JavaMail.zimbra@redhat.com>
References: <54DA3A5B.5050509@dachary.org> <1520027977.15929683.1423693473209.JavaMail.zimbra@redhat.com> <1586599856.17187011.1423778777774.JavaMail.zimbra@redhat.com> <54DD268D.7050904@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:51789 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbBRRjV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 12:39:21 -0500
In-Reply-To: <54DD268D.7050904@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Tamil Muthamizhan <tmuthami@redhat.com>, Zack Cerza <zack@redhat.com>, Sandon Van Ness <svanness@redhat.com>

Hi all

I updated all issues in http://tracker.ceph.com/issues/10560

Based on what is listed there, we have=20
http://tracker.ceph.com/issues/10801 - Yehuda pls comment
http://tracker.ceph.com/issues/10694 - Sam pls re-confirm

rbd - Josh, I understood that we are good to go, pls re-confirm.

I can re-run some suites if you'd like and we can make a call on this r=
elease.

Loic - back to you, let me know what you think.

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Sage Weil" <sage@=
redhat.com>, "Tamil Muthamizhan" <tmuthami@redhat.com>, "Zack Cerza" <z=
ack@redhat.com>, "Sandon Van Ness" <svanness@redhat.com>
Sent: Thursday, February 12, 2015 2:17:49 PM
Subject: Re: dumpling integration branch for v0.67.12 ready for QE



On 12/02/2015 23:06, Yuri Weinstein wrote:
> I linked all issues related to this release testing to the ticket htt=
p://tracker.ceph.com/issues/10560
>=20
> After the team leads make a call of those, including environment issu=
es, I suggest re-running suites the failed again.
>=20
> Loic, I'd re-run them in the Octo, since we already started there, if=
 you agree ?

Sure :-)

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Yuri Weinstein" <yweinste@redhat.com>
> To: "Loic Dachary" <loic@dachary.org>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Sage Weil" <sag=
e@redhat.com>, "Tamil Muthamizhan" <tmuthami@redhat.com>
> Sent: Wednesday, February 11, 2015 2:24:33 PM
> Subject: Re: dumpling integration branch for v0.67.12 ready for QE
>=20
> I replied to individual suites runs, but just wanted to summarize QE =
validation status.
>=20
> The following suites were executed in the Octo lab (we will use Sepia=
 in the future if nobody objects).
>=20
> upgrade:dumpling
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45493']
> http://tracker.ceph.com/issues/10694 - Known "Won't fix"
> "Assertion: osd/Watch.cc: 290: FAILED assert(!cb)"
>=20
> *** Sam - pls confirm the "Won't fix" status.
>=20
> ['45495', '45496', '45498', '45499', '45500']
> http://tracker.ceph.com/issues/10838
> "s3tests failed"
>=20
> *** Yehuda - need your verdict on s3tests.
>=20
> fs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> All green !
>=20
> rados
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45054']
> http://tracker.ceph.com/issues/10841
> "Issued certificate has expired"=20
> *** Sandon pls comment.
>=20
> ['45168', '45169']
> http://tracker.ceph.com/issues/10840
> coredump "ceph_test_filestore_idempotent_sequence"
> *** Sam - pls comment
>=20
> ['45215']
> Missing packages - no ticket FYI
> "Failed to fetch http://apt-mirror.front.sepia.ceph.com/archive.ubunt=
u.com/ubuntu/dists/trusty-updates/universe/binary-i386/Packages  Hash S=
um mismatch"
>=20
> *** Zack, Sandon ?
>=20
> ceph-deploy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Travis - pls suggest
> In general I am not sure if we needed to test this - Sage?
>=20
> rbd
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45365', '45366', '45367']
> http://tracker.ceph.com/issues/10842
> "unable to connect to apt-mirror.front.sepia.ceph.com"
>=20
> ['45349', '45350', '45351', '45355', '45356', '45357', '45363']
> http://tracker.ceph.com/issues/10802
> "error: image still has watchers"=20
> (duplicate of 10680)
>=20
> *** Zack, Sandon, Josh - all environment noise, pls comment.=20
>=20
> rgw
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45382', '45390']
> http://tracker.ceph.com/issues/10843
> "s3tests failed" - could be related or duplicate of 10838
>=20
> *** Yehuda - same as issues in upgrades?
>=20
> I am standing by for you analysis/replies and recommendations for nex=
t steps.
>=20
> Loic - let me know is you want to follow specific items in our backpo=
rt testing process that I missed here.
> PS:  I would think that you could've wanted to assign the release tic=
ket to QE (me) for validation and at this point I could've re-assigned =
it back to devel (you), a?
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 9:05:31 AM
> Subject: dumpling integration branch for v0.67.12 ready for QE
>=20
> Hi Yuri,
>=20
> The dumpling integration branch for v0.67.12 as found at https://gith=
ub.com/ceph/ceph/commits/dumpling-backports has been approved by Yehuda=
, Josh and Sam and is ready for QE.=20
>=20
> For the record, the head is https://github.com/ceph/ceph/commit/3944c=
77c404c4a05886fe8276d5d0dd7e4f20410
>=20
> I think it would be best for the QE tests to use the dumpling-backpor=
ts. The alternative would be to merge dumpling-backports into dumpling.=
 However, since testing may take a long time and require more patches, =
it probably is better to not do that iterative process on the dumpling =
branch itself. As it is now, there already are a number of commits in t=
he dumpling branch that should really be in the dumpling-backports: the=
y do not belong to v0.67.11 and are going to be released in v0.67.12. I=
n the future though, the dumpling branch will only receive commits that=
 have been carefully tested and all the integration work will be on the=
 dumpling-backports branch exclusively. So that third parties do not ha=
ve to worry that the dumpling branch contains commits that have not bee=
n tested yet.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
