From: =?ISO-8859-1?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Subject: Re: Ceph on btrfs 3.4rc
Date: Wed, 25 Apr 2012 13:16:19 +0100
Message-ID: <4F97EB13.1050700@gmail.com>
References: <CAJafhzSVZ3+1ApgJU=sQu6gM62BeWVGG4mqFPNYRHx79czYJtQ@mail.gmail.com> <20120424152141.GB3326@localhost.localdomain> <Pine.LNX.4.64.1204240922040.29159@cobra.newdream.net> <CAJafhzQ0BtNsUSr4cPYLg1MfMoKQhvYE3eS6VskRBeyJOF58iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1BD6AFF92A8B5A430F0F2BE0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55867 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206Ab2DYMQZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Apr 2012 08:16:25 -0400
Received: by bkuw12 with SMTP id w12so8811bku.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 05:16:24 -0700 (PDT)
In-Reply-To: <CAJafhzQ0BtNsUSr4cPYLg1MfMoKQhvYE3eS6VskRBeyJOF58iw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <christian@brunner-muc.de>
Cc: Sage Weil <sage@newdream.net>, Josef Bacik <josef@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BD6AFF92A8B5A430F0F2BE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/25/2012 12:28 PM, Christian Brunner wrote:
> I've tried test_filestore_workloadgen, but it didn't work very well.
> After 5 Minutes it terminated with the following messages:
>=20
> 2012-04-25 11:28:57.768709 7fcac3f69760  0 Destroying collection
> '0.1_head' (358 objects)
> 2012-04-25 11:29:07.478747 7fcac3f69760  0 Destroying collection
> '0.22_head' (477 objects)
> 2012-04-25 11:29:07.479035 7fcac3f69760  0 We ran out of collections!
> 2012-04-25 11:29:07.916149 7fcac3f69760  1 journal close
> /dev/mapper/vg01-lv_osd_journal_0
>=20
> I guess this is not btrfs related .-)
>=20

Oh yeah... the "solution" for that is to set '--test-num-colls' to a
greater value (the test creates 30 by default, and destroys them every
'X' transactions). Increase the number of collections and it will have a
longer run.

But since that's sounding like a workaround over something that could
easily be avoided, I'll make a patch for the test to avoid that from
happening.

--=20
Jo=E3o Eduardo Lu=EDs
gpg key: 477C26E5 from pool.keyserver.eu


--------------enig1BD6AFF92A8B5A430F0F2BE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPl+sTAAoJEJ9vvxhHfCblK1YH/AvS29bN5BLGHgyblz9eSwle
guppZDARtghhaKiCHpVmOTScPLZtpXlzjgTZXpiT9UZPDJzK+JWpusiBoku9TYIv
w9CjfsazyAj/S7N6GQGei8FzlsWD+aYTwIgz/oCIO+zdWju+STRPnFgUaBInH07w
FD08qD5cbZsEtoiw/YPGV3mXpkQN7P6eoTnRDJc2QDtQJqNLTyPqRxpZhpg6FSUB
p6pi1t179A8R7f3xJFQycjtozDRGQXh1kEOtG8Ozr+maJkId+UGNj5ZKCuTWQe83
tRKL6Lo5dEzVRzAN7RlcL6DbgCgZqSWO4xkn3a7hMp9RqGFsygcVNpNPBP1EdUQ=
=HhTd
-----END PGP SIGNATURE-----

--------------enig1BD6AFF92A8B5A430F0F2BE0--
