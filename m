From: =?iso-8859-1?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Subject: Re: TOO SLOW data write speed and delete.. NEED HELP
Date: Wed, 14 Mar 2012 17:42:08 +0000
Message-ID: <492F51DD-2416-49AF-99D5-55495D548A32@gmail.com>
References: <loom.20120313T113524-750@post.gmane.org> <4F5FA114.7070806@gmail.com> <loom.20120314T052312-964@post.gmane.org> <5BBEBFD4-B55F-4B62-A6A9-03BD4652B07C@gmail.com> <loom.20120314T180310-823@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-20--895072705"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36109 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688Ab2CNRmV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 13:42:21 -0400
Received: by yenl12 with SMTP id l12so2063486yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 10:42:20 -0700 (PDT)
In-Reply-To: <loom.20120314T180310-823@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-20--895072705
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=iso-8859-1


On Mar 14, 2012, at 5:05 PM, madhusudhana wrote:

>> I am yet to fully understand Ceph's behavior, thus you should not =
take my word on it, but I believe Ceph will
>> automatically take snapshots as a checkpointing mechanism. So, until =
someone (*looks at Sage*)
>> declares I am completely and utterly wrong, I'm going with that =
assumption.
>>=20
>> Also, I am not sure if the slowdown you're suffering is =
Btrfs-related, but just in case...
>>=20
>>>=20
>>> One more concern is 'rm' command is also TOO slow. I am a newbie =
here and=20
>>> i don't know to much about ceph working. I configured it in a simple =
way.
>>> Install ceph and run mkcephfs and start ceph in all the servers in =
the=20
>>> cluster.
>>>=20
>>> I want to understand why basic operations like 'cp' and 'rm' are =
slow bcz=20
>>> my actual workload does a lot of copy and delete operation. If I =
find the
>>> reason for the slowness and get a fix, then I think i can better =
compare and=20
>>> complete my ceph evaluation.=20
>>=20
>> My follow up questions:=20
>>=20
>> - Are you copying into Ceph? =46rom within Ceph, into Ceph? Or are =
you simply copying from Ceph to somewhere else?
> Am copying data from a linux machine to ceph. Bot cp and rsync are =
really really slow

Although this could trigger a Btrfs-specific behavior we've noticed a =
while ago...

>>=20
>> - Under which conditions do these slowdowns happen? Are you =
performing *a lot* of cp's / rm's in a short
>> amount of time?
> Its doesn't matter whether i am doing cp/rm in a short. Whenever i run =
those=20
> commands they run really slow.

... I don't think this applies.=20

If it happens every time you perform a cp/rm, regardless what's =
happening on the file system, and specially if it happens even if it's =
just the occasional cp/rm, well... then I think this does not fulfill =
the requirements for my initial suspicion.

This may be Ceph-related, so I'll leave it to someone else who might be =
able to help you better than I am. :-)

Good luck.

Cheers,
Joao

---
Jo=E3o Eduardo Lu=EDs
gpg key: 477C26E5 from pool.keyserver.eu=20






--Apple-Mail-20--895072705
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.16 (Darwin)

iQEcBAEBAgAGBQJPYNh2AAoJEJ9vvxhHfCblvzwH/jMdP/mIXTi5hgwVJjGYcGUL
6ZX/X2ogpj3rH8ovPKmpAaNVRgfVxjFICwIH88v7vKMcjawBtkRgOmYC55uEZ4DG
WejrNmTjSvhOhAQsAbWh1ARDykisx8fenHFAZ5SFKj0dPphvY1dCTNjWpxnImwWU
DAcuKExUSy0TFXXlQQSOq8vU4KTUwmlbx1LfnaA+3AWw++f3lXlIrABC0g1EkpTu
f/FAxSjSMB0Y78jMyUfz4hZtY4tEh5qwXnij6Sey+ihVLdEfpxbz/Ym4Pu8xSLYg
+rnIWyA9sDGwbOuSWkQaMUznhPMtNL3OWqPcXgKtSSRDxudNNOGUppb4lXszGvM=
=H04n
-----END PGP SIGNATURE-----

--Apple-Mail-20--895072705--
