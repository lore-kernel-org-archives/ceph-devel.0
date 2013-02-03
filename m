From: Loic Dachary <loic@dachary.org>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Sun, 03 Feb 2013 19:17:05 +0100
Message-ID: <510EA9A1.6070505@dachary.org>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com> <CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com> <CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com> <CAOLwVUm-LOStdMRNJeuA8qSzy2x3twMssBFA43J0MYVrFPNcbA@mail.gmail.com> <CAOLwVUmMCX_jHBc5Fqs_emT5E4ThoHd3nhUxmwhEJAZN4H3t9g@mail.gmail.com> <CAF6-1L7HJMwqDPWwpkbqyTNbGbVhm_5pCbR73nTtnk0eD8xB4g@mail.gmail.com> <CAF6-1L4SfogRx0=46A8YR4dW1f-qOLNSh-7mT9HS_NKz9CjCZQ@mail.gmail.com> <alpine.DEB.2.00.1301270946190.16117@cobra.newdream.net> <CAF6-1L76dwdxGp2MGJTWFF4VwmzMT3a62tSTZhE8P1b-OOSBuw@mail.gmail.com> <alpine.DEB.2.00.1301300116210.4449@cobra.newdream.net> <CAF6-1L61H28xXDPZBC5Um0tyJLs2uGX8S7G2UjpL64fnt7oRcA@mail.gmail.com> <alpine.DEB.2.00.1301301139490.18801@cobra.newdream.ne
 t> <CAF6-1L5z39ZsPwBz5yJWDvQoX7UaUZ5PVpUwfVhoBne56Z018Q@mail.gmail.com> <alpine.DEB.2.00.1301311141240.807@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig75F77DC6BB7A593D351C3C04"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47235 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab3BCSRI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Feb 2013 13:17:08 -0500
In-Reply-To: <alpine.DEB.2.00.1301311141240.807@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75F77DC6BB7A593D351C3C04
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

As discussed during FOSDEM, the script you wrote to kill the OSD when it =
grows too much could be amended to core dump instead of just being killed=
 & restarted. The binary + core could probably be used to figure out wher=
e the leak is.

You should make sure the OSD current working directory is in a file syste=
m with enough free disk space to accomodate for the dump and set

ulimit -c unlimited

before running it ( your system default is probably ulimit -c 0 which inh=
ibits core dumps ). When you detect that OSD grows too much kill it with

kill -SEGV $pid

and upload the core found in the working directory, together with the bin=
ary in a public place. If the osd binary is compiled with -g but without =
changing the -O settings, you should have a larger binary file but no neg=
ative impact on performances. Forensics analysis will be made a lot easie=
r with the debugging symbols.=20

My 2cts

On 01/31/2013 08:57 PM, Sage Weil wrote:
> On Thu, 31 Jan 2013, Sylvain Munaut wrote:
>> Hi,
>>
>> I disabled scrubbing using
>>
>>> ceph osd tell \* injectargs '--osd-scrub-min-interval 1000000'
>>> ceph osd tell \* injectargs '--osd-scrub-max-interval 10000000'
>>
>> and the leak seems to be gone.
>>
>> See the graph at  http://i.imgur.com/A0KmVot.png  with the OSD memory
>> for the 12 osd processes over the last 3.5 days.
>> Memory was rising every 24h. I did the change yesterday around 13h00
>> and OSDs stopped growing. OSD memory even seems to go down slowly by
>> small blocks.
>>
>> Of course I assume disabling scrubbing is not a long term solution and=

>> I should re-enable it ... (how do I do that btw ? what were the
>> default values for those parameters)
>=20
> It depends on the exact commit you're on.  You can see the defaults if =
you=20
> do
>=20
>  ceph-osd --show-config | grep osd_scrub
>=20
> Thanks for testing this... I have a few other ideas to try to reproduce=
=2E =20
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig75F77DC6BB7A593D351C3C04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAlEOqaEACgkQ8dLMyEl6F21nTACgnPIA2p/P9Q6z64tlsvMJQWFQ
hTwAkQFKMEbSswabqyBXxBdpIUd3T5I=
=BQdR
-----END PGP SIGNATURE-----

--------------enig75F77DC6BB7A593D351C3C04--
