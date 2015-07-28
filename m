From: Loic Dachary <loic@dachary.org>
Subject: Citerias to become a Ceph project
Date: Tue, 28 Jul 2015 08:38:10 +0200
Message-ID: <55B72352.9010407@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GTL6f0PXwegju5X0DQ1GQKk7fCNT6K3vJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57238 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751374AbbG1GiS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 02:38:18 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 2A95E420B0
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 08:38:11 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GTL6f0PXwegju5X0DQ1GQKk7fCNT6K3vJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The title sounds a little strange (Citerias to become a Ceph project) bec=
ause I'm not aware of projects initiated by someone external to Ceph that=
 later became part of the Ceph nebula of projects (as found at http://tra=
cker.ceph.com/projects/ or http://github.com/ceph/). I can however imagin=
e that a piece of software developed with no interaction with the Ceph de=
velopment community could be contributed and become a valuable addition (=
port to non GNU/Linux Operating Systems, monitoring applications for mobi=
le devices etc.).

Although publishing the code of such a component under a Free Software li=
cense is a natural first step, there is more to do before it becomes part=
 of what we (the community of Ceph developers) care for on a regular basi=
s. Borrowing the OpenStack requirements ( at http://governance.openstack.=
org/reference/new-projects-requirements.html ), it could be expressed as:=


    Free Software:
        The proposed project uses a Free Software license as published at=
 http://www.gnu.org/licenses/license-list.html#SoftwareLicenses
        Project must have no library dependencies which effectively restr=
ict how the project may be distributed or deployed
    Open Community:
        The leadership is chosen by the contributors to the project
        The project has regular public meetings on IRC and those meetings=
 are logged and published
    Open Development:
        The project uses public code reviews=20
        The project has core reviewers and adopts a test-driven gate
        The project provides liaisons that serve as contacts for the work=
 of cross-project teams in Ceph
        Where it makes sense, the project cooperates with existing projec=
ts rather than gratuitously competing or reinventing the wheel
        Where appropriate, the project adopts technology and patterns use=
d by existing Ceph projects
    Open Design:
        The project direction is discussed at the Ceph Design Summit and/=
or on public forums
        The project uses the ceph-devel ML to discuss issues

These requirements are formal in the case of OpenStack but they could als=
o be used in the context of Ceph, not as requirements but as a guideline.=


What do you think ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--GTL6f0PXwegju5X0DQ1GQKk7fCNT6K3vJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW3I1IACgkQ8dLMyEl6F22cJACfdYDu9N2LJ1HjSrexYyX3TBlf
Uy0AoLyLFHv5jXCNCiL9FgZY+zchQW8T
=6Mkv
-----END PGP SIGNATURE-----

--GTL6f0PXwegju5X0DQ1GQKk7fCNT6K3vJ--
