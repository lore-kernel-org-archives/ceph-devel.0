From: Lenz Grimmer <lgrimmer@suse.com>
Subject: Re: Building dashboard_v2
Date: Wed, 14 Feb 2018 09:54:05 +0100
Message-ID: <829ca7ca-8d40-adb0-d4ad-bd608a3fe351@suse.com>
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <CALqRxCy37KJeaFn5Zq-vYByKonPXOFZ_ETGoaYo2fGH8GZiCKg@mail.gmail.com>
 <c01bb9d0-72d2-d0e9-9acf-492ef1a98b71@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mGhYYFgdctWanKrlnNAPqFTvGSXaqCuk4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754257AbeBNIyL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:54:11 -0500
In-Reply-To: <c01bb9d0-72d2-d0e9-9acf-492ef1a98b71@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kai Wagner <kwagner@suse.com>, Ken Dreyer <kdreyer@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mGhYYFgdctWanKrlnNAPqFTvGSXaqCuk4
Content-Type: multipart/mixed; boundary="7wC3UZawLK7ZK7xxs40RRVYpHUvXSuZyN";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer@suse.com>
To: Kai Wagner <kwagner@suse.com>, Ken Dreyer <kdreyer@redhat.com>,
 John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <829ca7ca-8d40-adb0-d4ad-bd608a3fe351@suse.com>
Subject: Re: Building dashboard_v2
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <CALqRxCy37KJeaFn5Zq-vYByKonPXOFZ_ETGoaYo2fGH8GZiCKg@mail.gmail.com>
 <c01bb9d0-72d2-d0e9-9acf-492ef1a98b71@suse.com>
In-Reply-To: <c01bb9d0-72d2-d0e9-9acf-492ef1a98b71@suse.com>

--7wC3UZawLK7ZK7xxs40RRVYpHUvXSuZyN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02/14/2018 07:24 AM, Kai Wagner wrote:

> On 02/13/2018 09:35 PM, Ken Dreyer wrote:
>=20
>> On Tue, Feb 13, 2018 at 8:29 AM, John Spray <jspray@redhat.com>=20
>> wrote:
>>=20
>>> Not sure if there is a sufficiently trusted third party Ubuntu=20
>>> repo to add to install_deps.sh.
>>=20
>> Instead of adding another repository dependency, we could not
>> build the dashboard on Xenial, and target Ubuntu >=3D 18.04 for
>> that.
>>=20
>> https://packages.ubuntu.com/bionic/nodejs
>=20
> You're right, but we should make sure to at least support 16.04 as=20
> well. Lot's of folks won't be updating their underlaying OS=20
> immediately after it's released and also it's not officially=20
> released, so we should support the latest LTS release in my mind.

I think we need to differentiate between the platforms/version we
support for *building* the UI code vs *running* it. The current
discussion is about the availability of the required development
toolchain for a given platform.

The Dashboard v2 does not have any run-time dependencies on Node.JS.

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)


--7wC3UZawLK7ZK7xxs40RRVYpHUvXSuZyN--

--mGhYYFgdctWanKrlnNAPqFTvGSXaqCuk4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWoP5LQAKCRBJUOEqsnKR
8vBaAJ9SZd/oO8L52BPhhkHm9cVXPYlxKwCfYBnMvO6T5JELxTA0Is3IoxNVJBE=
=STGT
-----END PGP SIGNATURE-----

--mGhYYFgdctWanKrlnNAPqFTvGSXaqCuk4--
