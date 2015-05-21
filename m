From: Loic Dachary <loic@dachary.org>
Subject: Re: Proposal for a Backport tracker
Date: Thu, 21 May 2015 21:05:09 +0200
Message-ID: <555E2C65.1040503@dachary.org>
References: <555DC080.8050508@dachary.org> <555DD285.3050204@suse.cz> <555DF7E7.9000501@dachary.org> <alpine.DEB.2.00.1505210844580.23818@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3REUwHqBnWpoecHNji9r7b83ThTX2uXQW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48579 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751924AbbEUTFM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 15:05:12 -0400
In-Reply-To: <alpine.DEB.2.00.1505210844580.23818@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3REUwHqBnWpoecHNji9r7b83ThTX2uXQW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 21/05/2015 17:46, Sage Weil wrote:
> On Thu, 21 May 2015, Loic Dachary wrote:
>>
>> On 21/05/2015 14:41, Nathan Cutler wrote:
>>>> * a backport issue is created in the "Backport" tracker and is=20
>>>> "Related" to the original issue
>>>
>>> Hi Loic:
>>>
>>> I like the idea of having backport tickets in a separate Redmine
>>> subproject/issue tracker.=20
>>
>> It would just be in a separate tracker, in the same project.=20
>>
>>> In fact, I would go even a step further and
>>> have separate subprojects for each target version (hammer backports,
>>> firefly backports).
>>
>> Separating them in a different project / subproject would create=20
>> problems because redmine has ways to partition the subprojects that ma=
ke=20
>> some things difficult. For instance not all issues can be "Related" to=
=20
>> issues in other projects which is kind of annoying. My general=20
>> impression with redmine subprojects is that they tend to complexify an=
d=20
>> obscure the process rather than help. Or maybe it's just that my redmi=
ne=20
>> skills are not what they should be. Do you have a different experience=
 ?
>=20
> I agree.  Adding subprojects clutters up the project list, and a separa=
te=20
> tracker captures this perfectly.  It also means you can rank by priorit=
y=20
> issues and see both bugs and backprots together (if you like).  And I=20
> think (?) the related issue only works within the same project (that is=
=20
> at least true with the 'duplicate' relationship).
>=20
> Loic, I think this is a great idea (provided the bot does all the issue=
=20
> creation).  +1!

I created the Backport tracker and we will migrate the pending issues & H=
OWTO accordingly.

Cheers

>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--3REUwHqBnWpoecHNji9r7b83ThTX2uXQW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVeLGYACgkQ8dLMyEl6F21jxwCfRBKu1sL4k1cW2twKh0RDef0X
eBwAnib07/wkiuJSOpB6cjnjZFvwe8Y4
=zvfW
-----END PGP SIGNATURE-----

--3REUwHqBnWpoecHNji9r7b83ThTX2uXQW--
