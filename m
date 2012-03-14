From: =?iso-8859-1?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Subject: Re: TOO SLOW data write speed and delete.. NEED HELP
Date: Wed, 14 Mar 2012 11:42:40 +0000
Message-ID: <5BBEBFD4-B55F-4B62-A6A9-03BD4652B07C@gmail.com>
References: <loom.20120313T113524-750@post.gmane.org> <4F5FA114.7070806@gmail.com> <loom.20120314T052312-964@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-18--916641162"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39882 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab2CNLmu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 07:42:50 -0400
Received: by wibhq7 with SMTP id hq7so2431296wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Mar 2012 04:42:49 -0700 (PDT)
In-Reply-To: <loom.20120314T052312-964@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-18--916641162
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=iso-8859-1

On Mar 14, 2012, at 4:28 AM, madhusudhana wrote:

> Jo=E3o Eduardo Lu=EDs <jecluis <at> gmail.com> writes:
>=20
>>=20
>> On 03/13/2012 10:39 AM, madhusudhana wrote:
>>> Hi all,
>>> Can someone PLEASE help me to understand why data copying (simple cp
>>> or rsync) is SO slow in CEPH ? And delete command (\rm -rf) for =
removing
>>> a small (175M) directory is taking so much of time. Because of this,
>>> i am not able to complete evaluation of ceph using my actual =
workload.=20
>>>=20
>>> I am hereby requesting all to help me in finding out the reason for=20=

>>> slow write/delete in my ceph cluster. I am really trying hard to=20
>>> complete the evaluation with actual workload but not able to copy =
the
>>> data whats required for evaluation to ceph cluster bcz of slow copy.
>>>=20
>>> I really appreciate any help on this.
>>>=20
>>> Thanks in advance
>>> Madhusudhan
>>>=20
>>=20
>> Hi Madhusudhan,
>>=20
>> Are you using Btrfs? And are you taking snapshots while you're
>> performing those operations?
>>=20
> Joao,
> Yes. all my OSD's are running on btrfs. I am not doing anything =
special
> except running 'cp' or 'rsync' command. can you please let me know how
> i can find if am taking snapshots while I do 'cp' or 'rsync' commands =
?

I am yet to fully understand Ceph's behavior, thus you should not take =
my word on it, but I believe Ceph will automatically take snapshots as a =
checkpointing mechanism. So, until someone (*looks at Sage*) declares I =
am completely and utterly wrong, I'm going with that assumption.

Also, I am not sure if the slowdown you're suffering is Btrfs-related, =
but just in case...

>=20
> One more concern is 'rm' command is also TOO slow. I am a newbie here =
and=20
> i don't know to much about ceph working. I configured it in a simple =
way.
> Install ceph and run mkcephfs and start ceph in all the servers in the=20=

> cluster.
>=20
> I want to understand why basic operations like 'cp' and 'rm' are slow =
bcz=20
> my actual workload does a lot of copy and delete operation. If I find =
the
> reason for the slowness and get a fix, then I think i can better =
compare and=20
> complete my ceph evaluation.=20

My follow up questions:=20

- Are you copying into Ceph? =46rom within Ceph, into Ceph? Or are you =
simply copying from Ceph to somewhere else?

- Under which conditions do these slowdowns happen? Are you performing =
*a lot* of cp's / rm's in a short amount of time?


Cheers,
Joao

---
Jo=E3o Eduardo Lu=EDs
gpg key: 477C26E5 from pool.keyserver.eu=20






--Apple-Mail-18--916641162
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.16 (Darwin)

iQEcBAEBAgAGBQJPYIQ0AAoJEJ9vvxhHfCbl0YcIAJYQZ/yGhrHjYCKXLzxMzhs8
lZtUvia0LTPvhgMtHC09LCbXb0oaHdbmzhyrYdYuTfK2HK+VpS21ZeYHh47+GWTR
Z9070tD9SWdGqdCJWE4BG+/gHeFx1SbeFAywSPRKtjuGKv8ivtDtSQreSUWTMTPr
lETECu7OHGt7G/MxdE7pPVVnTIkuNFwF1xcou0FRbzujDvdTr+toZJFfbmUKE1xI
XId1ZnvuhG/XaroX4CeixtvNNNSVvK5f68Yy1R1+oCh/4iA/NHoO4KXkJxzRH6re
Oly2R6AR/smHtB/eSRlFi79RE5mdEU4aAalx+sFmBwsu/FU0juO3Vd9fjBM2LW8=
=9Qfv
-----END PGP SIGNATURE-----

--Apple-Mail-18--916641162--
