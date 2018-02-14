From: Lenz Grimmer <lgrimmer@suse.com>
Subject: Re: Disabling the "old" dashboard in the dashboard v2 pull request?
Date: Wed, 14 Feb 2018 17:34:11 +0100
Message-ID: <f2e933fd-5c8b-22d8-1030-041e94968833@suse.com>
References: <8dfb4e57-8413-8fa1-6712-2ed31a8ba6a1@suse.com>
 <1f16b6b9-5f02-6232-b344-05233908f987@suse.de>
 <CALe9h7cBT6WEiZ-cxhs4Kwq9TDVotQU+dJnqE7gw-W=xFHK_Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LHjZmFtvnMill8EOih7w7K72eiM2Vwqtw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032282AbeBNQeR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:34:17 -0500
In-Reply-To: <CALe9h7cBT6WEiZ-cxhs4Kwq9TDVotQU+dJnqE7gw-W=xFHK_Xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Joao Eduardo Luis <joao@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LHjZmFtvnMill8EOih7w7K72eiM2Vwqtw
Content-Type: multipart/mixed; boundary="A0E0Mm9ltZBwgq96NYbVITwLx7LpAnMoL";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer@suse.com>
To: John Spray <jspray@redhat.com>, Joao Eduardo Luis <joao@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <f2e933fd-5c8b-22d8-1030-041e94968833@suse.com>
Subject: Re: Disabling the "old" dashboard in the dashboard v2 pull request?
References: <8dfb4e57-8413-8fa1-6712-2ed31a8ba6a1@suse.com>
 <1f16b6b9-5f02-6232-b344-05233908f987@suse.de>
 <CALe9h7cBT6WEiZ-cxhs4Kwq9TDVotQU+dJnqE7gw-W=xFHK_Xw@mail.gmail.com>
In-Reply-To: <CALe9h7cBT6WEiZ-cxhs4Kwq9TDVotQU+dJnqE7gw-W=xFHK_Xw@mail.gmail.com>

--A0E0Mm9ltZBwgq96NYbVITwLx7LpAnMoL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi John,

On 02/14/2018 04:48 PM, John Spray wrote:

> On Wed, Feb 14, 2018 at 2:40 PM, Joao Eduardo Luis <joao@suse.de>=20
> wrote:
>=20
>> Instead, I'd suggest the initial PR to perform a
>>=20
>> `git mv dashboard dashboard_legacy`
>>=20
>> or something similar, and introduce dashboard_v2 as the new=20
>> dashboard. Once that's merged, then we can have a PR removing the=20
>> current dashboard or whatever people are comfortable doing.
>=20
> Seems reasonable to me.  I'm happy for the "v1" dashboard code to go=20
> away quickly, but yeah, there's no need to literally have all the=20
> removal LOC in the same PR.

OK. We'll then perform the move of the original dashboard in our branch
and prepare a removal PR afterwards.

> Yep, this came up yesterday -- I'm expecting that the new dashboard=20
> will just use the same setting names where it makes sense, and=20
> magically inherit the configuration.

Yes, this is already the case. Dashboard v2 uses "server_addr",
"server_port" and "url_prefix" in the same way that the original
dashboard does it. Currently, we add "username", "password" and
"session-expire".

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)


--A0E0Mm9ltZBwgq96NYbVITwLx7LpAnMoL--

--LHjZmFtvnMill8EOih7w7K72eiM2Vwqtw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWoRlAwAKCRBJUOEqsnKR
8tjPAJ9fbFEA4n8Cu27yem8z5I/LFwM1EQCfecG+SqUb+2IisCEYYmeEINvwxCM=
=c1yh
-----END PGP SIGNATURE-----

--LHjZmFtvnMill8EOih7w7K72eiM2Vwqtw--
