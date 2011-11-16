From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 4/4] qemu/rbd: improve rbd device specification
Date: Wed, 16 Nov 2011 08:40:14 -0700
Message-ID: <4EC3D95E.50903@redhat.com>
References: <4EAEFED2.70808@redhat.com> <3bd8191e8040b4ebe95d31200373539be7ba6e95.1320110364.git.josh.durgin@dreamhost.com> <4EC2FE47.60501@redhat.com> <4EC313D8.6040507@dreamhost.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig2FD966C2EB6ACCDE218B705F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab1KPPkU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Nov 2011 10:40:20 -0500
In-Reply-To: <4EC313D8.6040507@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FD966C2EB6ACCDE218B705F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/15/2011 06:37 PM, Josh Durgin wrote:
>> The command line that we pass to qemu gets logged.  But what happens i=
f
>> the secret was marked as ephemeral - could we be violating the premise=

>> of not exposing passwords to too broad an audience?  Or are we already=

>> safe in that the log entries created by virCommand can only be exposed=

>> to users that already can get at the secret information by other means=
?
>=20
> The secret can be read from the command line of the running process,
> which is even less secure than the log. I'm working on passing the
> secret via the qemu monitor instead of the command line, which will
> avoid both issues.
>=20
>> Maybe this means we should we be adding capabilities into virCommand t=
o
>> prevent the logging of the actual secret (whether base64-encoded or
>> otherwise), and instead log an alternate string?  That is, should
>> virCommand be tracking parallel argv arrays; the real array passed to
>> exec() but never logged, and the alternate array (normally matching th=
e
>> real one, but which can differ in this particular case of passing an
>> argument that contains a password)?

Given your arguments (that ps can read argv of qemu, even if we hid it
from libvirt logs, and that we will be moving to a monitor command as
soon as qemu supports one), I see no reason to hack up virCommand to
support alternate log output.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig2FD966C2EB6ACCDE218B705F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOw9leAAoJEKeha0olJ0Nq3gYH/jxXJk55r/QvanI5Ki/y33jG
V5XlthRaiQNosFVACxFUahVM7gptPG69iItFl0vh50t+GnwrHoM5VqJmdPXKkQjZ
9sRErcwLMVjUzFiTbWa7/obdAaZKAcGs9EiQkqOfZOjpeDsXPGDQ3g7uYHPixywQ
ETCircvmGa4twA7z6Jcn6DXdhYIA37nAhP2RCOKxIHqxiQYykqR3ybpTW73Jn38c
K/cyWsqWW1cvQyyPJ8TftU4nIKIv1WDosQRZRZjolNlEWEVNde84XT7FSeZH1VmX
NX/8sYsjM0t9xupdr/AJ7ac9IH7AiF4PWIDicl+zcqXmOrT6U8XbsbfK327T0xY=
=uEp6
-----END PGP SIGNATURE-----

--------------enig2FD966C2EB6ACCDE218B705F--
