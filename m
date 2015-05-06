From: Loic Dachary <loic@dachary.org>
Subject: Re: release notes script dependencies
Date: Wed, 06 May 2015 16:55:17 +0200
Message-ID: <554A2B55.8050203@dachary.org>
References: <55491259.4010003@dachary.org> <CAEw75dOCcdafHQhdc6uv+HsQVnOVE+rD8VdAAYFALFfFSEq2cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="V1hDhXgsGWacksn3xFHgT4lKtFJRbnLiX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58601 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638AbbEFOzU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 10:55:20 -0400
In-Reply-To: <CAEw75dOCcdafHQhdc6uv+HsQVnOVE+rD8VdAAYFALFfFSEq2cg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V1hDhXgsGWacksn3xFHgT4lKtFJRbnLiX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Abhishek,

On 06/05/2015 06:27, Abhishek L wrote:
> On Wed, May 6, 2015 at 12:26 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Abhishek,
>>
>> It would be useful to add instructions on what dependencies to pull to=
 run http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_=
release_notes. Something like
>>
>> virtualenv /tmp/foo
>> . /tmp/foo/bin/activate
>> pip install GitPython # I recognized the library from the import ;-)
>> pip install ?? # I tried half a dozen but could not find one that matc=
hes the import github semantic
>=20
> The module was githubpy (I agree there are too many of github python
> modules around :-)) I added a basic argparser for the script; I've put
> it up as a github repo at
> https://github.com/theanalyst/ceph-release-helper
>=20
> Let me know if you're facing any problems using it

It works :-) http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_wr=
ite_the_release_notes amended accordingly.

Cheers

>=20
> Regards
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--V1hDhXgsGWacksn3xFHgT4lKtFJRbnLiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVKK1UACgkQ8dLMyEl6F22L9wCghNb4I12bXTkEWVTb5sK2DA54
+P0An0eSksUC+JWeenZZ1uDj9Gusdorl
=EW/G
-----END PGP SIGNATURE-----

--V1hDhXgsGWacksn3xFHgT4lKtFJRbnLiX--
