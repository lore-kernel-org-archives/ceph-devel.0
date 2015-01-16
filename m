From: Loic Dachary <loic@dachary.org>
Subject: Re: upcoming release giant v0.87.1 : leads feedback needed
Date: Fri, 16 Jan 2015 21:34:38 +0100
Message-ID: <54B975DE.3020504@dachary.org>
References: <54B7E6DC.8010905@dachary.org> <54B7F2DF.9060003@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q2eOpFDwnW5WMget6mIdmRPDWogQbQG9c"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42047 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752484AbbAPUek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 15:34:40 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id C40B342B4C
	for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 21:34:38 +0100 (CET)
In-Reply-To: <54B7F2DF.9060003@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q2eOpFDwnW5WMget6mIdmRPDWogQbQG9c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Again,

As it turns out we're going to have giant point releases after all. In a =
nutshell there is going to be one or two point release for giant, until H=
ammer is out. The backporting activity for giant will be lower than for f=
irefly or hammer, because the idea is to focus on backporting every other=
 release (i.e. dumpling, firefly, hammer, etc. ).=20

My initial request is therefore resumed and the ticket open again.

Thanks for your patience and sorry for the confusion :-)

On 15/01/2015 18:03, Loic Dachary wrote:
> Hi Again,
>=20
> Well, this is a little embarassing but here it is : there won't be a po=
int release for giant. I'll update the redmine tickets to remove the "gia=
nt" backport targets as well as the github milestone list accordingly.
>=20
> Sorry for the noise.
>=20
> On 15/01/2015 17:12, Loic Dachary wrote:
>> Hi Ceph,
>>
>> The https://github.com/ceph/ceph/tree/giant-backports branch was teste=
d with the rgw, rados and rbd suites. The results of each suite have been=
 analyzed and summarized in http://tracker.ceph.com/issues/10501. The nex=
t steps are either:
>>
>> a) Yehuda for rgw, Josh for rbd and Sam for rados all agree that the e=
rrors are unrelated to the backports
>> b) The https://github.com/ceph/ceph/tree/giant-backports branch is giv=
en to QE for final tests and merge into giant
>>
>> OR
>>
>> a) At least of the lead thinks more work is needed to stabilize the gi=
ant branch
>> b) A new set of tests will be run and analyzed after adding/removing o=
ne or more backports to/from the https://github.com/ceph/ceph/tree/giant-=
backports branch
>>
>> The description of http://tracker.ceph.com/issues/10501 shows a detail=
ed list of all commits / issues that are in the giant backport branch. To=
 get a global view of what the next giant point release will be, the desc=
ription also includes the commits that have already been merged in the gi=
ant branch. The list of pull requests that are candidate for inclusion in=
 the giant release but have not been included in the integration branch a=
re also listed: maybe one of them could contribute to resolve a problem f=
ound during the tests. And finally all redmine issues that have been mark=
ed to be backported to giant but do not yet have a candidate pull request=
 are listed: this is the backport backlog so to speak ;-)
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Q2eOpFDwnW5WMget6mIdmRPDWogQbQG9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS5dd4ACgkQ8dLMyEl6F20qRwCfUE/GeHcb8RCScEa1A/lGwBG+
exsAoKPpSzbjS18nb+WBZaIMKQLdaKpf
=1oEj
-----END PGP SIGNATURE-----

--Q2eOpFDwnW5WMget6mIdmRPDWogQbQG9c--
