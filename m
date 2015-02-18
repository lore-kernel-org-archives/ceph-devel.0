From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Wed, 18 Feb 2015 18:56:14 +0100
Message-ID: <54E4D23E.8050702@dachary.org>
References: <54DA3A5B.5050509@dachary.org> <1520027977.15929683.1423693473209.JavaMail.zimbra@redhat.com> <1586599856.17187011.1423778777774.JavaMail.zimbra@redhat.com> <54DD268D.7050904@dachary.org> <2134758899.22244800.1424281099141.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HcmMMvP4auR7nW3SQacL9Ala41H6t0fmt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45902 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753067AbbBRR4U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 12:56:20 -0500
In-Reply-To: <2134758899.22244800.1424281099141.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Tamil Muthamizhan <tmuthami@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HcmMMvP4auR7nW3SQacL9Ala41H6t0fmt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18/02/2015 18:38, Yuri Weinstein wrote:
> Hi all
>=20
> I updated all issues in http://tracker.ceph.com/issues/10560
>=20
> Based on what is listed there, we have=20
> http://tracker.ceph.com/issues/10801 - Yehuda pls comment
> http://tracker.ceph.com/issues/10694 - Sam pls re-confirm
>=20
> rbd - Josh, I understood that we are good to go, pls re-confirm.
>=20
> I can re-run some suites if you'd like and we can make a call on this r=
elease.
>=20
> Loic - back to you, let me know what you think.

As long as you're satisfied with the test results, I have no further comm=
ent :-)

Cheers

> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Sage Weil" <sage@=
redhat.com>, "Tamil Muthamizhan" <tmuthami@redhat.com>, "Zack Cerza" <zac=
k@redhat.com>, "Sandon Van Ness" <svanness@redhat.com>
> Sent: Thursday, February 12, 2015 2:17:49 PM
> Subject: Re: dumpling integration branch for v0.67.12 ready for QE
>=20
>=20
>=20
> On 12/02/2015 23:06, Yuri Weinstein wrote:
>> I linked all issues related to this release testing to the ticket http=
://tracker.ceph.com/issues/10560
>>
>> After the team leads make a call of those, including environment issue=
s, I suggest re-running suites the failed again.
>>
>> Loic, I'd re-run them in the Octo, since we already started there, if =
you agree ?
>=20
> Sure :-)
>=20
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Yuri Weinstein" <yweinste@redhat.com>
>> To: "Loic Dachary" <loic@dachary.org>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Sage Weil" <sage=
@redhat.com>, "Tamil Muthamizhan" <tmuthami@redhat.com>
>> Sent: Wednesday, February 11, 2015 2:24:33 PM
>> Subject: Re: dumpling integration branch for v0.67.12 ready for QE
>>
>> I replied to individual suites runs, but just wanted to summarize QE v=
alidation status.
>>
>> The following suites were executed in the Octo lab (we will use Sepia =
in the future if nobody objects).
>>
>> upgrade:dumpling
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ['45493']
>> http://tracker.ceph.com/issues/10694 - Known "Won't fix"
>> "Assertion: osd/Watch.cc: 290: FAILED assert(!cb)"
>>
>> *** Sam - pls confirm the "Won't fix" status.
>>
>> ['45495', '45496', '45498', '45499', '45500']
>> http://tracker.ceph.com/issues/10838
>> "s3tests failed"
>>
>> *** Yehuda - need your verdict on s3tests.
>>
>> fs
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> All green !
>>
>> rados
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ['45054']
>> http://tracker.ceph.com/issues/10841
>> "Issued certificate has expired"=20
>> *** Sandon pls comment.
>>
>> ['45168', '45169']
>> http://tracker.ceph.com/issues/10840
>> coredump "ceph_test_filestore_idempotent_sequence"
>> *** Sam - pls comment
>>
>> ['45215']
>> Missing packages - no ticket FYI
>> "Failed to fetch http://apt-mirror.front.sepia.ceph.com/archive.ubuntu=
=2Ecom/ubuntu/dists/trusty-updates/universe/binary-i386/Packages  Hash Su=
m mismatch"
>>
>> *** Zack, Sandon ?
>>
>> ceph-deploy
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Travis - pls suggest
>> In general I am not sure if we needed to test this - Sage?
>>
>> rbd
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ['45365', '45366', '45367']
>> http://tracker.ceph.com/issues/10842
>> "unable to connect to apt-mirror.front.sepia.ceph.com"
>>
>> ['45349', '45350', '45351', '45355', '45356', '45357', '45363']
>> http://tracker.ceph.com/issues/10802
>> "error: image still has watchers"=20
>> (duplicate of 10680)
>>
>> *** Zack, Sandon, Josh - all environment noise, pls comment.=20
>>
>> rgw
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ['45382', '45390']
>> http://tracker.ceph.com/issues/10843
>> "s3tests failed" - could be related or duplicate of 10838
>>
>> *** Yehuda - same as issues in upgrades?
>>
>> I am standing by for you analysis/replies and recommendations for next=
 steps.
>>
>> Loic - let me know is you want to follow specific items in our backpor=
t testing process that I missed here.
>> PS:  I would think that you could've wanted to assign the release tick=
et to QE (me) for validation and at this point I could've re-assigned it =
back to devel (you), a?
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yuri Weinstein" <yweinste@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Tuesday, February 10, 2015 9:05:31 AM
>> Subject: dumpling integration branch for v0.67.12 ready for QE
>>
>> Hi Yuri,
>>
>> The dumpling integration branch for v0.67.12 as found at https://githu=
b.com/ceph/ceph/commits/dumpling-backports has been approved by Yehuda, J=
osh and Sam and is ready for QE.=20
>>
>> For the record, the head is https://github.com/ceph/ceph/commit/3944c7=
7c404c4a05886fe8276d5d0dd7e4f20410
>>
>> I think it would be best for the QE tests to use the dumpling-backport=
s. The alternative would be to merge dumpling-backports into dumpling. Ho=
wever, since testing may take a long time and require more patches, it pr=
obably is better to not do that iterative process on the dumpling branch =
itself. As it is now, there already are a number of commits in the dumpli=
ng branch that should really be in the dumpling-backports: they do not be=
long to v0.67.11 and are going to be released in v0.67.12. In the future =
though, the dumpling branch will only receive commits that have been care=
fully tested and all the integration work will be on the dumpling-backpor=
ts branch exclusively. So that third parties do not have to worry that th=
e dumpling branch contains commits that have not been tested yet.
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--HcmMMvP4auR7nW3SQacL9Ala41H6t0fmt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTk0j4ACgkQ8dLMyEl6F23U1QCgh0BUQofSrGsTRISeqSI39j8g
nfEAn3aoZm59SjVBwvQKnK6TKaWhqEo/
=M3zO
-----END PGP SIGNATURE-----

--HcmMMvP4auR7nW3SQacL9Ala41H6t0fmt--
