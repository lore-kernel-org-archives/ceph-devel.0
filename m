From: bernhard glomm <bernhard.glomm@ecologic.eu>
Subject: Re: HSM
Date: Mon, 11 Nov 2013 17:05:06 +0100
Message-ID: <1A353CF1-73F8-430D-8291-B3343F760B9C@ecologic.eu>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: multipart/signed; boundary="Apple-Mail=_FE930C2F-07A3-4893-8CFA-8D33FE46B846"; protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.ecologic.eu ([85.214.42.230]:58619 "EHLO mx01.ecologic.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689Ab3KKQEp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Nov 2013 11:04:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx01.ecologic.eu (Postfix) with ESMTP id B185B740AA
	for <ceph-devel@vger.kernel.org>; Mon, 11 Nov 2013 17:04:44 +0100 (CET)
Received: from mx01.ecologic.eu ([127.0.0.1])
	by localhost (mx01.ecologic.eu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6UA0btOXfQ8O for <ceph-devel@vger.kernel.org>;
	Mon, 11 Nov 2013 17:04:44 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_FE930C2F-07A3-4893-8CFA-8D33FE46B846
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


Sorry for a maybe dumm idea,
but since this seems to be the beginnig of the discussion=20
about integrating HSM Systems it might still be the right place for it.

Integrating an HSM is surely interesting but the prize of a commercial=20=

System (like SAMFS) exceeds the capacity of a wide range of customers,
maybe the GRAU - HSM is meanwhile available as a potential affordable =
solution
but still it needs it's own maintenance.=20

If you are working on integrating a policy management and a copytool,
(not ME, I'm op not dev ;-) why not take a look at LTFS which comes
for free since LTO5 (at least the single drive version is free AFAIK).
It offers a filesystem structure that can be written/read directly =
to/from
tape without any further software than the kernel module.

I tend to believe that it can't be such a big extra effort to not just =
through
the files into an existing HSM for archiving=20
but feed them to LTFS formated tapes
that reside in an autochanger.

That would decrease archiving costs for small business by ... A LOT?

Might that b worth a thought?

best regards

Bernhard

--Apple-Mail=_FE930C2F-07A3-4893-8CFA-8D33FE46B846
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJSgQAyAAoJEHt+VBZXpX4EG9wH/3LljWt69Fp3B06JWFrkPN9U
FHDyh9e1zIRUq6IyW767eW+mHknHxAljXa4NBaIgcu3UgMwwGQy9vMj2w/ublpM5
EXy1dVmBIKB4xJr2UlNrwGPj165e6Z5qnK7mCN1Skajfzw3W4cPnPkhDRhQS1Wo/
v1TktoWo5kJNlZTFAnOdz44zAleAjLNIdkwx35mGyJFPxq0L2SbhA9sAVzAY3ZLv
mQULrJ3/ECejd/jrpgCwodQS4/Ir5SBsvJXQCUeKHVInNP90lD9nuyrbOvXYEUev
a75fWziqoZK37PR2gXdQmRaEwR80OJb71hHAGzMqTUElFKTcjf6Q8adWANboJYU=
=d4Fz
-----END PGP SIGNATURE-----

--Apple-Mail=_FE930C2F-07A3-4893-8CFA-8D33FE46B846--
