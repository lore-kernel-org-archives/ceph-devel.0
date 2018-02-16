From: Kai Wagner <kwagner@suse.com>
Subject: Re: Building dashboard_v2
Date: Fri, 16 Feb 2018 07:24:09 +0100
Message-ID: <0c2f6305-1e43-62ca-4c60-aefcb7a8e4ed@suse.com>
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <1419a76e-dc93-ab50-6c74-27efd1bcf4fe@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C3j9ScuHH8u2ROjVL1efa7vFm5bCof3sx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54799 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753254AbeBPGYM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Feb 2018 01:24:12 -0500
In-Reply-To: <1419a76e-dc93-ab50-6c74-27efd1bcf4fe@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: John Spray <jspray@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C3j9ScuHH8u2ROjVL1efa7vFm5bCof3sx
Content-Type: multipart/mixed; boundary="UlKFflbjCk4vcnnlXaEz7UNWAhsOpmM47";
 protected-headers="v1"
From: Kai Wagner <kwagner@suse.com>
To: Ricardo Dias <rdias@suse.com>,
 Ceph Development <ceph-devel@vger.kernel.org>
Cc: John Spray <jspray@redhat.com>
Message-ID: <0c2f6305-1e43-62ca-4c60-aefcb7a8e4ed@suse.com>
Subject: Re: Building dashboard_v2
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <1419a76e-dc93-ab50-6c74-27efd1bcf4fe@suse.com>
In-Reply-To: <1419a76e-dc93-ab50-6c74-27efd1bcf4fe@suse.com>

--UlKFflbjCk4vcnnlXaEz7UNWAhsOpmM47
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hey,

I tested the build on ubuntu-16.04 and 18.04 without any problems.

Well done!

Kai


On 02/14/2018 05:34 PM, Ricardo Dias wrote:
> Hi,
>
> The PR https://github.com/openattic/ceph/pull/91 updates
> install-deps.sh script to install the development dependencies
> required by dashboard_v2.
>
> Since I can only test this in openSUSE based distros in a reliable way
> I ask if there are some volunteers that can test this in other distros.=

>
> Thanks,=20

--=20
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)



--UlKFflbjCk4vcnnlXaEz7UNWAhsOpmM47--

--C3j9ScuHH8u2ROjVL1efa7vFm5bCof3sx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJahnkJAAoJEB6MkVYW48RuWJwH/R6y/6E1ErjklxZWtVmCsXcc
YTXLlA2T1nl19ciOzoNs4qpF3I7zXRhmSLIvwGYlQbbV0eXPtmKnFB+/SUcG6h8/
qsS4wZ5MmpwP80DIu71bsbo5TMazPIYcDo5oh0BOVCHWV03Nud+K8n2brng+aw48
Bc9l82iVFsEeXADfwEb5kZFnf+kUBgCTZnMrgfZpXNYqhFip57YsqFzeFQQhyJOj
pyQiT3LQf0bgINR0+OtcG9jLvuya8p/VAjBezOJ2Y9fDt99Bb7F69Q559vxJHneU
Rh3afpj4voZ2mvYIKtlC9UH3N1U1hmhl8F9gKsv08FRU7R8WwYT0YeZ/qk1/iMk=
=hhhh
-----END PGP SIGNATURE-----

--C3j9ScuHH8u2ROjVL1efa7vFm5bCof3sx--
