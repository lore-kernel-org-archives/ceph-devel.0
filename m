From: Loic Dachary <loic@dachary.org>
Subject: Re: Merging hammer in master: conflict on gmock
Date: Tue, 10 Mar 2015 09:02:34 +0100
Message-ID: <54FEA51A.30003@dachary.org>
References: <54FDABC0.4080803@dachary.org> <54FDD8D8.6090709@bisect.de> <54FE2775.8010608@dachary.org> <54FE8836.6040308@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="A0p6LpW09XnA0AIKmBGCFhbRNHr7bm7pv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55652 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868AbbCJICh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 04:02:37 -0400
In-Reply-To: <54FE8836.6040308@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A0p6LpW09XnA0AIKmBGCFhbRNHr7bm7pv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Danny,

On 10/03/2015 06:59, Danny Al-Gaaf wrote:
> Am 10.03.2015 um 00:06 schrieb Loic Dachary:
>>
>>
>> On 09/03/2015 18:31, Danny Al-Gaaf wrote:
>>> Hi Loic,
>>>
>>> this one is a tricky one. I didn't find a smooth/automatic
>>> solution yet.
>>>
>>> This seems to work:
>>>
>>> git checkout master git merge --no-ff origin/hammer git
>>> mergetool -> for the conflict: select 'local' for src/gmock (this
>>> should keep the changes im master and ignore changes from
>>> hammer)
>>
>> Do you know what changes have been done in hammer in src/gmock ?
>=20
> It seems as if there was no change to src/gmock in hammer that is not
> already in master.

After the set of commands you suggest, how could we make sure nothing was=
 trashed or unintentionally included ? I can't think of a sure method fro=
m the top of my head.

Cheers

> Danny
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--A0p6LpW09XnA0AIKmBGCFhbRNHr7bm7pv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT+pRoACgkQ8dLMyEl6F21yKgCgoiQbt+RUYRHXBm7TmtyNrePr
cv0AoJ87qepgLBOEVc7IcnBILpcQdB8p
=Y2me
-----END PGP SIGNATURE-----

--A0p6LpW09XnA0AIKmBGCFhbRNHr7bm7pv--
