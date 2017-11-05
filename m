From: Ricardo Dias <rdias@suse.com>
Subject: Re: Messenger V2: multiple bind support
Date: Sun, 5 Nov 2017 10:48:13 -0700
Message-ID: <FA95FAF5-5C10-4804-BDB9-E122824AF956@suse.com>
References: <1508855817.10018.25.camel@suse.com>
 <add34139-4ed6-fcca-fdac-a05f58aff433@suse.de>
 <CAJ4mKGaQ2EDENqqNpDUH6XG2THGk-XnJ+oR4yu14pF7h+F6r1g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9014B9CF-01AF-40C8-9447-9E177C4CC0B4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60610 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKERsr (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Sun, 5 Nov 2017 12:48:47 -0500
In-Reply-To: <CAJ4mKGaQ2EDENqqNpDUH6XG2THGk-XnJ+oR4yu14pF7h+F6r1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Joao Eduardo Luis <joao@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>


--Apple-Mail=_9014B9CF-01AF-40C8-9447-9E177C4CC0B4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 1 Nov 2017, at 15:19, Gregory Farnum <gfarnum@redhat.com> wrote:
>=20
>=20
> There's sort of two pieces here, right?
> 1) =46rom the Dispatcher perspective, we want a single "Messenger" =
that
> it talks to. (At least, I'm pretty sure. Unless we need to be making
> routing decisions using internal data? I really hope that never comes
> up.) That could be set up by having multiple Messenger implementations
> behind a "UnifyingMessenger" abstraction layer with pretty minimal
> changes.

I agree, with the current code the solution would be to share the same =
dispatcher
across multiple messenger instances.

>=20
> 2) =46rom an implementation perspective, which data structures do we =
end
> up needing to share in order to have a daemon listening on multiple
> ports?
>=20
> So, from the SimpleMessenger perspective, I don't think we get much
> out of trying to build multi-bind into it. We'd basically get to
> eliminate the duplicated DIspatchQueue, which is not very interesting.
> (Modulo some flow control stuff, perhaps.) =46rom an AsyncMessenger
> implementation perspective, that calculus might shift since we're
> running on a thread pool, but I'm not deeply familiar with the code
> internals.
>=20
> But I'm curious what brings this up. I thought you were working on the
> v2 protocol =E2=80=94 does something in that somehow hinge on the =
server-side
> implementation of multiple networks?

I remembered this while talking with Joao about why the Mons bind to a =
single
network interface even if in ceph.conf the public_network value contains =
multiple
networks.
Then I thought that maybe the mons only bind to a single interface =
because
it would be too cumbersome to start a single messenger for each network
interface and manage the shared dispatcher. Therefore, since I was =
already
making changes to the async messenger implementation, I could see if
it was easy to support multiple-bind in the messenger code and make this
functionality available to other modules with minimal code changes.

The V2 protocol implementation does not depend on the multiple bind
functionality, so I would just implement it if people would find it very
useful.

> -Greg


--Apple-Mail=_9014B9CF-01AF-40C8-9447-9E177C4CC0B4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEzBAEBCgAdFiEEsK1ZtKJUswT08kqmdDkMV5vTe2gFAln/Tt0ACgkQdDkMV5vT
e2jF/Af9FKTSXg/5mx/8BOvGEFpVeXWoXC7jiHK9nVg8k9uMjQ51KhAkZaob62KR
29WFfKANXz0et08MTFX+FGU1LRMAjO8PH3I57TWJsEap83x3aDicJGSYe8BSvm2p
MCg2YQepeCMlDoqsXJRN0nnBpimSVG5Q3BtYcGM6S/EVo4E239R+MpRx3O8H06V+
eEHclNROHt/azxB7ifbNZv31Yh2QIM0w9szheJR9wx7bFSFM9yzdLX4HuGsqNSjN
zoJwsLbrG19/kI4MZc5NDqLfCb//OxBAgUGCH+0m7l9VUVxBIHy+qe8V2YaQczlQ
eIXsbTHFsjaaaDifNq+h3fGIJADEYg==
=egfC
-----END PGP SIGNATURE-----

--Apple-Mail=_9014B9CF-01AF-40C8-9447-9E177C4CC0B4--
