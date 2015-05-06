From: Loic Dachary <loic@dachary.org>
Subject: Re: release notes script dependencies
Date: Wed, 06 May 2015 18:35:23 +0200
Message-ID: <554A42CB.8050201@dachary.org>
References: <55491259.4010003@dachary.org> <CAEw75dOCcdafHQhdc6uv+HsQVnOVE+rD8VdAAYFALFfFSEq2cg@mail.gmail.com> <554A2B55.8050203@dachary.org> <alpine.DEB.2.00.1505060918340.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xDwxa52okhJDvPUcDuaiPTsTfpgOHsoAx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58660 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752094AbbEFQf0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 12:35:26 -0400
In-Reply-To: <alpine.DEB.2.00.1505060918340.28239@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xDwxa52okhJDvPUcDuaiPTsTfpgOHsoAx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 06/05/2015 18:19, Sage Weil wrote:
> On Wed, 6 May 2015, Loic Dachary wrote:
>>
>> Hi Abhishek,
>>
>> On 06/05/2015 06:27, Abhishek L wrote:
>>> On Wed, May 6, 2015 at 12:26 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi Abhishek,
>>>>
>>>> It would be useful to add instructions on what dependencies to pull =
to run http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_th=
e_release_notes. Something like
>>>>
>>>> virtualenv /tmp/foo
>>>> . /tmp/foo/bin/activate
>>>> pip install GitPython # I recognized the library from the import ;-)=

>>>> pip install ?? # I tried half a dozen but could not find one that ma=
tches the import github semantic
>>>
>>> The module was githubpy (I agree there are too many of github python
>>> modules around :-)) I added a basic argparser for the script; I've pu=
t
>>> it up as a github repo at
>>> https://github.com/theanalyst/ceph-release-helper
>>>
>>> Let me know if you're facing any problems using it
>>
>> It works :-) http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO=
_write_the_release_notes amended accordingly.
>=20
> Could we put the script in ceph.git/src/scripts or similar instead of a=
=20
> separate repo?  One less thing to clone...

+1

>=20
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--xDwxa52okhJDvPUcDuaiPTsTfpgOHsoAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVKQssACgkQ8dLMyEl6F22tTgCfR5ZJ9tu2xeJJM+e2HjlFSyWV
+w8An0VGtWpg48d2sraiPAh7SMc+L+AR
=SuCa
-----END PGP SIGNATURE-----

--xDwxa52okhJDvPUcDuaiPTsTfpgOHsoAx--
