From: Lenz Grimmer <lgrimmer@suse.com>
Subject: Re: Building dashboard_v2
Date: Tue, 13 Feb 2018 17:32:51 +0100
Message-ID: <875f7a8e-18e9-aae6-4dc3-3c590647f2e2@suse.com>
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="msLaanGJJs2QmSIlcvr55B2idwPkwkbyW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39269 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965181AbeBMQc4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:32:56 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 534BEAE63
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 16:32:55 +0000 (UTC)
In-Reply-To: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--msLaanGJJs2QmSIlcvr55B2idwPkwkbyW
Content-Type: multipart/mixed; boundary="flNqwgkhCaDuPlCPJDo9ZBhGBbweLmfHc";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer@suse.com>
To: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <875f7a8e-18e9-aae6-4dc3-3c590647f2e2@suse.com>
Subject: Re: Building dashboard_v2
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
In-Reply-To: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>

--flNqwgkhCaDuPlCPJDo9ZBhGBbweLmfHc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi John,

thanks for the feedback!

On 02/13/2018 04:29 PM, John Spray wrote:

> Having just built the awesome new dashboard code
> (https://github.com/ceph/ceph/pull/20103) in my dev environment for
> the first time, I'll share my notes...
>=20
> When building on Ubuntu 16.04, which does not have a recent enough
> node.js for the build -- had to get one from an external source.  It
> looks like Fedora and EPEL do have more recent ones.  Not sure if
> there is a sufficiently trusted third party Ubuntu repo to add to
> install_deps.sh.

There are some hints on how to get a recent version of Node.js installed
on Ubuntu, using either an upstream PPA or nvm:

https://www.digitalocean.com/community/tutorials/how-to-install-node-js-o=
n-ubuntu-16-04


> My fedora 26 machine had a sufficiently recent node/npm, so building
> there was simpler.  Just had to install the python2-bcrypt package (in
> addition to what is already covered in install_deps).

Good to know. Most of the developers currently working on the Dashboard
v2 use a Docker build environment based on this:

https://github.com/ricardoasmarques/ceph-dev-docker/

> The frontend build only takes 25 seconds, which I think is pretty
> good.  The resulting dist/ dir is 18M at the moment, which is very
> similar to the existing dashboard static files size.  I would suggest
> we can decrease that a bit by restricting the font formats included:
> by default we're getting eog/svg/ttf output, but we probably only need
> WOFF.

We'll take a look at that, to check what the "production" build will
include.

> I didn't need a virtualenv or any pip-installed things to run the
> dashboard in development (presumably would have needed that to run
> unit tests on the backend python code).
>=20
> Detailed notes below.
>=20
>=20
> On Ubuntu 16.04 (aka senta04)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Had to symlink /usr/bin/nodejs to /usr/bin/node (one of the
> dependencies depends on it)

Yes, that's a common annoyance on Ubuntu - you can install the package
"nodejs-legacy" to create that symlink automatically.

> The distro comes with node 4.2.6.  The dashboard_v2 code requires node
>> =3D 6.9.0 (per tmelo) -- that isn't being explicitly checked, so if
> your node is old then you just get a nasty syntax error during "npm
> run build".
>=20
> Angular CLI depends on node >=3D 6.9.0 and npm >=3D 3 (according to its=
 README).
>=20
> Repo with a more recent node is here:
> curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
> This is linked from the nodejs official page, but I have no idea of
> provenance beyond that.
>=20
> If you had already tried "npm run build" with an older node before
> installing the newer one, do a "npm rebuild node-sass" after
> installing the new node before trying to build dashboard frontend
> again.
>=20
> Had to install python-bcrypt.
>=20
> Fedora 26 (aka my laptop)
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This distro appears to come with node 6.12.
>=20
> dnf install python2-bcrypt

Thanks for the notes! I'll see if I can incorporate some of that into
the README/HACKING documents included in that directory.

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)


--flNqwgkhCaDuPlCPJDo9ZBhGBbweLmfHc--

--msLaanGJJs2QmSIlcvr55B2idwPkwkbyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWoMTMwAKCRBJUOEqsnKR
8o2dAJ0UJEisrqhLhV2axYND63ALShwfKwCfcpTOjWiO15PomwWKolA7rxMk7+k=
=FXlj
-----END PGP SIGNATURE-----

--msLaanGJJs2QmSIlcvr55B2idwPkwkbyW--
