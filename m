From: Loic Dachary <loic@dachary.org>
Subject: Re: Backport tracker migration complete
Date: Fri, 22 May 2015 12:31:01 +0200
Message-ID: <555F0565.6010704@dachary.org>
References: <555EEC40.3040106@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PcuHjjtndqimujrrsbK59cnmEOdt8VakG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49094 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945985AbbEVKbG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 06:31:06 -0400
In-Reply-To: <555EEC40.3040106@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PcuHjjtndqimujrrsbK59cnmEOdt8VakG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/05/2015 10:43, Loic Dachary wrote:
> Hi,
>=20
> The Backport tracker should now be fully populated. There are new custo=
m queries for:
>=20
>   hammer backports http://tracker.ceph.com/projects/ceph/issues?query_i=
d=3D78
>   firefly backports http://tracker.ceph.com/projects/ceph/issues?query_=
id=3D79
>=20
> and you can quickly see which one are assigned or not, scheduled for th=
e next point release or not etc.=20
>=20
> To see all issues that are Pending Backport, the former queries still w=
ork:
>=20
>   hammer http://tracker.ceph.com/projects/ceph/issues?query_id=3D77
>   firefly http://tracker.ceph.com/projects/ceph/issues?query_id=3D75
>=20
> but you can now see links to the corresponding backports in the "Relate=
d issues" column. It makes it convenient to visually check which issues h=
ave been backported to all desired targets: there related issues are clos=
ed.
>=20
> I'll update the documentation at http://tracker.ceph.com/projects/ceph-=
releases/wiki/HOWTO accordingly.
>=20

The backporter manual has been updated at http://tracker.ceph.com/project=
s/ceph-releases/wiki/HOWTO and deserves proofreading. The most significan=
t changes are at:

HOWTO schedule an issue for backporting http://tracker.ceph.com/projects/=
ceph-releases/wiki/HOWTO_schedule_an_issue_for_backporting in which there=
 now is the part where we need to create additional issues. It won't burd=
en the developer but I think we'll get tired of it quickly and we'll need=
 a snippet to do it for us ;-)

HOWTO backport commits http://tracker.ceph.com/projects/ceph-releases/wik=
i/HOWTO_backport_commits changes very little: instead of adding a link to=
 the pull request as a comment to the original issue, we set the URL as t=
he description of the issue, in the same way we set the URL to the issue =
in the description of the pull request.

HOWTO resolve issues that are Pending Backport http://tracker.ceph.com/pr=
ojects/ceph-releases/wiki/HOWTO_resolve_issues_that_are_Pending_Backport =
is the step that benefits most from the change. It was tedious and is cou=
ld now trivially be automated via a snippet.

> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--PcuHjjtndqimujrrsbK59cnmEOdt8VakG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVfBWUACgkQ8dLMyEl6F22xJgCfVEPuMBBvp+3ldY8lT9Jtc+s8
hxcAnAuhDEu9LDSXlsGrmE81HmVxvyzk
=o5Iy
-----END PGP SIGNATURE-----

--PcuHjjtndqimujrrsbK59cnmEOdt8VakG--
