From: Loic Dachary <loic@dachary.org>
Subject: Re: Criteria to become a Ceph project
Date: Tue, 28 Jul 2015 11:27:08 +0200
Message-ID: <55B74AEC.1030709@dachary.org>
References: <CAC6JEv9wTCkb6XEtSSN0e-9MNuLF=2V_OEk_AnxP33t=3nG+tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="L2akFfKPXVm9TQrVfmfjOcQ4l1E85adxP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57330 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750844AbbG1J1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 05:27:14 -0400
In-Reply-To: <CAC6JEv9wTCkb6XEtSSN0e-9MNuLF=2V_OEk_AnxP33t=3nG+tw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L2akFfKPXVm9TQrVfmfjOcQ4l1E85adxP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28/07/2015 10:44, Gregory Farnum wrote:
> On Tue, Jul 28, 2015 at 7:38 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ceph,
>>
>> The title sounds a little strange (Citerias to become a Ceph project) =
because I'm not aware of projects initiated by someone external to Ceph t=
hat later became part of the Ceph nebula of projects (as found at http://=
tracker.ceph.com/projects/ or http://github.com/ceph/). I can however ima=
gine that a piece of software developed with no interaction with the Ceph=
 development community could be contributed and become a valuable additio=
n (port to non GNU/Linux Operating Systems, monitoring applications for m=
obile devices etc.).
>>
>> Although publishing the code of such a component under a Free Software=
 license is a natural first step, there is more to do before it becomes p=
art of what we (the community of Ceph developers) care for on a regular b=
asis. Borrowing the OpenStack requirements ( at http://governance.opensta=
ck.org/reference/new-projects-requirements.html ), it could be expressed =
as:
>>
>>     Free Software:
>>         The proposed project uses a Free Software license as published=
 at http://www.gnu.org/licenses/license-list.html#SoftwareLicenses
>>         Project must have no library dependencies which effectively re=
strict how the project may be distributed or deployed
>>     Open Community:
>>         The leadership is chosen by the contributors to the project
>>         The project has regular public meetings on IRC and those meeti=
ngs are logged and published
>>     Open Development:
>>         The project uses public code reviews
>>         The project has core reviewers and adopts a test-driven gate
>>         The project provides liaisons that serve as contacts for the w=
ork of cross-project teams in Ceph
>>         Where it makes sense, the project cooperates with existing pro=
jects rather than gratuitously competing or reinventing the wheel
>>         Where appropriate, the project adopts technology and patterns =
used by existing Ceph projects
>>     Open Design:
>>         The project direction is discussed at the Ceph Design Summit a=
nd/or on public forums
>>         The project uses the ceph-devel ML to discuss issues
>>
>> These requirements are formal in the case of OpenStack but they could =
also be used in the context of Ceph, not as requirements but as a guideli=
ne.
>>
>> What do you think ?
>=20
> Several small projects have been added to the Ceph constellation
> despite being initially implemented outside of our systems. Mostly
> things like rados-java and phprados.
>=20
> Obviously those are small and related to Ceph, and the process was
> "let's add this to the Ceph Github?" "Okay." I think if we need more
> formal rules we can invent them as we go; Ceph is not OpenStack and
> isn't going to be supervising the same volume nor breadth of
> individual groups.

Maybe these could be "Guidelines to become a Ceph project" ? It seems to =
me that there is a big gap between the dynamic of phprados and say, rados=
gw-agent. By reading the guidelines, someone willing to contribute code t=
o Ceph understands it's not just about pushing code to a publicly availab=
le repository.

Does that make sense ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--L2akFfKPXVm9TQrVfmfjOcQ4l1E85adxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW3SuwACgkQ8dLMyEl6F23URQCcDk7kXFXauPLWy6ecE3PVIjTV
bagAnR3Y9BGqkly//fPdRtdTp6IzQrji
=OOf/
-----END PGP SIGNATURE-----

--L2akFfKPXVm9TQrVfmfjOcQ4l1E85adxP--
