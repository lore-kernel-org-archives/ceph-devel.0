From: Kai Wagner <kwagner@suse.com>
Subject: Re: Building dashboard_v2
Date: Wed, 14 Feb 2018 07:24:25 +0100
Message-ID: <c01bb9d0-72d2-d0e9-9acf-492ef1a98b71@suse.com>
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <CALqRxCy37KJeaFn5Zq-vYByKonPXOFZ_ETGoaYo2fGH8GZiCKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pUcEkMF69d62XqC31dNXkXiLkfHwKMlNA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40147 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752585AbeBNGY3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Feb 2018 01:24:29 -0500
In-Reply-To: <CALqRxCy37KJeaFn5Zq-vYByKonPXOFZ_ETGoaYo2fGH8GZiCKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pUcEkMF69d62XqC31dNXkXiLkfHwKMlNA
Content-Type: multipart/mixed; boundary="dK4UgJahjmbyMGdFl4a0BBtRHx7chTIuW";
 protected-headers="v1"
From: Kai Wagner <kwagner@suse.com>
To: Ken Dreyer <kdreyer@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <c01bb9d0-72d2-d0e9-9acf-492ef1a98b71@suse.com>
Subject: Re: Building dashboard_v2
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <CALqRxCy37KJeaFn5Zq-vYByKonPXOFZ_ETGoaYo2fGH8GZiCKg@mail.gmail.com>
In-Reply-To: <CALqRxCy37KJeaFn5Zq-vYByKonPXOFZ_ETGoaYo2fGH8GZiCKg@mail.gmail.com>

--dK4UgJahjmbyMGdFl4a0BBtRHx7chTIuW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 02/13/2018 09:35 PM, Ken Dreyer wrote:
> On Tue, Feb 13, 2018 at 8:29 AM, John Spray <jspray@redhat.com> wrote:
>> Not sure if
>> there is a sufficiently trusted third party Ubuntu repo to add to
>> install_deps.sh.
> Instead of adding another repository dependency, we could not build
> the dashboard on Xenial, and target Ubuntu >=3D 18.04 for that.
>
> https://packages.ubuntu.com/bionic/nodejs
You're right, but we should make sure to at least support 16.04 as well.
Lot's of folks won't be updating their underlaying OS immediately after
it's released and also it's not officially released, so we should
support the latest LTS release in my mind.
>
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--=20
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)



--dK4UgJahjmbyMGdFl4a0BBtRHx7chTIuW--

--pUcEkMF69d62XqC31dNXkXiLkfHwKMlNA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJag9YZAAoJEB6MkVYW48RuB9UIAIvY7jJ/V23TNmhR+jcPsZDy
yUtWiKBH1QLW7RRL7YIW5JemutAoddrKjxrP7UIvIfFHOSbpQ43B3WPfq0D7vUgN
YJDGPXPljb5vb7dPeEbNAWvP1XPJApTwZUv3DWLVMwMDQxJkqgiMHEi+qP0DVVJR
4wzeB0uSOcewAADeVXLrSVHX3/nKTdQdZUDKbRV6WFFzynYefpNyowrk2s5I8Piv
3SsKCqMuFIWwmzwUtl2dyTkOcZYdWOD2hbZ9x8H9OMHRmsJ64ivMiV9vBW0i9hE/
59G4is5Btbyb5azkQq8FsB3DDqazoQJcT/iEw53/Mgqll9sY/eWkdwogdYZixgQ=
=x/CX
-----END PGP SIGNATURE-----

--pUcEkMF69d62XqC31dNXkXiLkfHwKMlNA--
