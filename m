From: =?UTF-8?B?Sm/Do28gRWR1YXJkbyBMdcOtcw==?= <jecluis@gmail.com>
Subject: Re: Integration work
Date: Thu, 30 Aug 2012 15:00:45 +0100
Message-ID: <503F720D.5060303@gmail.com>
References: <503D0A00.2080905@inktank.com> <20120828203235.45f1e3a5@dieter-t420s> <503D3214.4000503@hastexo.com> <CADvuQRHs_t0WT_eERPP_1Eb3wTM0yX5_v+WW3rRnY3JqWw2-3A@mail.gmail.com> <503D3636.40609@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF64AE6B17239FA8E7F63AC2D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63824 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab2H3OBn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 10:01:43 -0400
Received: by eekc1 with SMTP id c1so742220eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 07:01:42 -0700 (PDT)
In-Reply-To: <503D3636.40609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Plaetinck, Dieter" <dieter@vimeo.com>, Ross Turk <ross@inktank.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF64AE6B17239FA8E7F63AC2D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2012 10:20 PM, Josh Durgin wrote:
> On 08/28/2012 02:15 PM, Tommi Virtanen wrote:
>> On Tue, Aug 28, 2012 at 5:03 PM, Florian Haas <florian@hastexo.com>
>> wrote:
>>> I for my part, in the documentation space, would love for the admin
>>> tools to become self-documenting. For example, I would love a "help"
>>> subcommand at any level of the ceph shell, listing the supported
>>> subcommands in that level. As in "ceph help", "ceph mon help", "ceph =
osd
>>> getmap help".
>>>
>>> Even better, the ceph shell could support a general-purpose hook that=

>>> bash-completion can use (kind of like "hg" does in Mercurial), and th=
is
>>> and the above-conjectured help facility could arguably share quite a =
bit
>>> of code.
>>
>> I would love to see all of that. But, a lot of the "ceph" tool
>> functionality is implemented by shoveling strings in and out of the
>> monitors. It largely doesn't understand what's happening.
>=20
> It doesn't need to understand what's happening to give basic usage info=

> though - the monitors can provide that themselves in the short term
> while we don't have an admin api like you describe below.
>=20
> I added a feature request for this a little while back:
>=20
> http://www.tracker.newdream.net/issues/2894

I believe this is pretty straightforward to get done.


--=20
Jo=C3=A3o Eduardo Lu=C3=ADs
gpg key: 477C26E5 from pool.keyserver.eu


--------------enigF64AE6B17239FA8E7F63AC2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJQP3ITAAoJEJ9vvxhHfCbl0o4H/2uGkh+P7SdmrrvlkYGvaqYh
4on+JeFj7hGkP4kk0wtRo05EVvS3ENjJObc70KyBr/pKVqPlUOf3rsMdZ82dPN7S
HzzBuqwcWYQUHZL6+A79xW0vgX5xKCE1arUO1AYTowRq4XY3yRh6ef1HvGWhN9lS
pzvhC6jmkw4FUZV0nslDSxw9NXF/jPWvQB1+YsgtnzLJcWDDC4oYy+aDJsrFvl0c
uLuCIJWO1nRgA3bNsNacpkNP9FqpBUU8N1pnzFiavmnk7SCFdCvoI/jM8Sdjwfwa
x1ZSJjPVk1N+KFTR6b73rn2w1Zp7VoUdKs4tIP2349RDp+xgL0laIZpCq/d8nbg=
=r4J0
-----END PGP SIGNATURE-----

--------------enigF64AE6B17239FA8E7F63AC2D--
