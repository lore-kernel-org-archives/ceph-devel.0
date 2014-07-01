From: Loic Dachary <loic@dachary.org>
Subject: Re: state model diagram
Date: Tue, 01 Jul 2014 19:30:10 +0200
Message-ID: <53B2F022.1060002@dachary.org>
References: <CACUN8h3uudxbkxBNQYZX8_UV1WYOXfBjoivBGCZJhO4N2yZdKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hEgKxurAn4Q1hUL4aQRrvjVLpHI3wI2tx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34140 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755193AbaGARaQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jul 2014 13:30:16 -0400
In-Reply-To: <CACUN8h3uudxbkxBNQYZX8_UV1WYOXfBjoivBGCZJhO4N2yZdKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hEgKxurAn4Q1hUL4aQRrvjVLpHI3wI2tx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hi koleofuscus,

I took a look at https://wiki.ceph.com/Development/Add_erasure_coding_to_=
the_durability_model/Technical_details_on_the_model and it makes sense to=
 me. However I wonder why you would want to go into that level of detail =
? Could you point me where you would encode such details events in the cu=
rrent code ?

Cheers

On 26/06/2014 02:29, Koleos Fuscus wrote:
> Hi,
>=20
> I found a state model diagram in the page that explains peering
> (http://ceph.com/docs/firefly/dev/peering/). The image cannot be
> visualised correctly. I build the docs and could open the image in an
> appropriate size using graphviz but still the layout is too complex
> and messy.
> I decided to do my own state model to collaborate in the understanding
> of ceph. Actually, it helps me to measure my own understanding of the
> system. Using the diagram facilitates the decision of modeling one
> event or skip another. You can find the diagram here:
> https://wiki.ceph.com/Development/Add_erasure_coding_to_the_durability_=
model/Technical_details_on_the_model
>=20
> Please give me your comments.
>=20
> koleosfuscus
>=20
> ________________________________________________________________
> "My reply is: the software has no known bugs, therefore it has not
> been updated."
> Wietse Venema
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--hEgKxurAn4Q1hUL4aQRrvjVLpHI3wI2tx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOy8CIACgkQ8dLMyEl6F21eDgCdEUTlnx9bhA5qfShczSvsKusY
lTwAnRIVGSAlZrFO5Hn8wTuf6SJtjqP/
=/CSd
-----END PGP SIGNATURE-----

--hEgKxurAn4Q1hUL4aQRrvjVLpHI3wI2tx--
