From: Loic Dachary <loic@dachary.org>
Subject: Re: Proposal for a Backport tracker
Date: Thu, 21 May 2015 17:27:37 +0200
Message-ID: <555DF969.4020405@dachary.org>
References: <555DC080.8050508@dachary.org> <555DD285.3050204@suse.cz> <87r3qa6of7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6udt6F88OhRgkKRU3axmCo0WvgQTv377R"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48458 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964874AbbEUP1j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 11:27:39 -0400
In-Reply-To: <87r3qa6of7.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6udt6F88OhRgkKRU3axmCo0WvgQTv377R
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 21/05/2015 15:38, Abhishek L wrote:
> Hi
>=20
> Nathan Cutler writes:
>=20
>>> * a backport issue is created in the "Backport" tracker and is=20
>>> "Related" to the original issue
>>
>> Hi Loic:
>>
>> I like the idea of having backport tickets in a separate Redmine
>> subproject/issue tracker. In fact, I would go even a step further and
>> have separate subprojects for each target version (hammer backports,
>> firefly backports).
>=20
> Agree with the idea of seperate subproject.=20

Another (I mean in addition to what I wrote in reply to Nathan) against s=
ubprojects is that existing custom queries would no longer display the ba=
ckport issues. For instance http://tracker.ceph.com/projects/ceph/issues?=
query_id=3D47 is frequently used and does *not* display subprojects becau=
se Ceph is the parent project of all other projects and it would display =
all their issues. If there was a subproject for backports, it would not s=
how. And if I'm not mistaken there is no way to say : "display issues fro=
m these subprojects and ignore the others".=20

> Though I'm not having a
> strong opinion on whether subprojects are needed for each version;
> probably for issues which have multiple backports ie. backports to both=

> firefly & hammer for instance it might be a little bit more bookkeeping=
,
> though from a maintainer standpoint; it is easier having a seperate
> subproject, so either way is okay.=20
>=20
>> Having all, e.g. hammer, backports in one place is advantageous in
>> pretty much every way I can think of: easier to see what has been
>> done, what needs to be done, easier to search, easier to automate,
>> less risk of munging something not related to backports...
>>
>=20
> Agree, from a scripting standpoint, we could develop some tools to ease=

> out the process better, which should it make it easier in backports dow=
n
> the line.
>=20

I think we can do that by creating a tracker. It would be in addition to =
the Bug, Fix, Documentation etc. trackers that are already in place.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--6udt6F88OhRgkKRU3axmCo0WvgQTv377R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVd+WkACgkQ8dLMyEl6F218lQCfTQRpO3urcmcqUO/QrvigzgJL
yk0AniNkCYs3eZiP1gbqgAhFQ2IcPxd8
=WP4b
-----END PGP SIGNATURE-----

--6udt6F88OhRgkKRU3axmCo0WvgQTv377R--
