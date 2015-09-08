From: Loic Dachary <loic@dachary.org>
Subject: Re: pull request labels : related to
Date: Tue, 08 Sep 2015 16:22:27 +0200
Message-ID: <55EEEF23.10403@dachary.org>
References: <55EC640C.7020700@dachary.org> <CAJ4mKGa8ELkQ85mzdQjqhriuGhxjR5uEUvT0ggQAS+k0ZaDcgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tEbWGjPFmCURoId8WXMGw9GdUb844wn1f"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51717 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755124AbbIHOWa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 10:22:30 -0400
In-Reply-To: <CAJ4mKGa8ELkQ85mzdQjqhriuGhxjR5uEUvT0ggQAS+k0ZaDcgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tEbWGjPFmCURoId8WXMGw9GdUb844wn1f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

You're right, it's a bad idea. I reverted the change.

Cheers

On 08/09/2015 15:46, Gregory Farnum wrote:
> On Sun, Sep 6, 2015 at 5:04 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
>>
>> I wen thru all pull request looking for those not related to anything =
(like having "bug fix" without "core" or "rgw"). Now that there are many =
labels, it's not trivial for someone not used to Ceph to sort out what's =
what. We really have three kinds of labels:
>>
>>  * those that relate the pull request to an area / component of Ceph (=
rgw, core, etc.)
>>  * those used to remember at what stage of QA the pull request is (wip=
-* and needs*qa)
>>  * those that describe the kind of pull request (cleanup, bug fix, per=
formance etc.)
>>
>> To help reading the label I prefixed the names of rgw, core, etc. with=
 "related to". If someone think that's not helpful or too long to read, f=
eel free to revert, it's just a proposal.
>=20
> You broke all my bookmarked searches. :( I've updated them now but I'm
> really not sure this change is helpful =E2=80=94 in particular, we don'=
t need
> these labels to make sense to people who aren't used to Ceph and it's
> impossible to have them quickly auto-complete now with a long shared
> prefix across them all...
> -Greg
>=20
>>
>> Cheers
>>
>> P.S. For backport snippets that set the component to "core" we'll need=
 to change that to "related to core" instead. Not too much of an inconven=
ience IMHO but ...
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tEbWGjPFmCURoId8WXMGw9GdUb844wn1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXu7yMACgkQ8dLMyEl6F21phACgs/pHqmJuCYJ+EURC7JBp7exW
UYYAn0o92TURtBW/UXmAQRxFiBhUoIo9
=Ct0+
-----END PGP SIGNATURE-----

--tEbWGjPFmCURoId8WXMGw9GdUb844wn1f--
