From: Loic Dachary <loic@dachary.org>
Subject: Re: Scaling Ceph reviews and testing
Date: Thu, 26 Nov 2015 00:31:56 +0100
Message-ID: <565644EC.4080903@dachary.org>
References: <CAJ4mKGbW56LFJy+_Swc=EF8AxbutBvCw5fei0kv_HUBnkhxLsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9L5SjeqWQsp3nrg4dAWJCINq1g0bPqOIl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39098 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750972AbbKYXb6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Nov 2015 18:31:58 -0500
In-Reply-To: <CAJ4mKGbW56LFJy+_Swc=EF8AxbutBvCw5fei0kv_HUBnkhxLsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9L5SjeqWQsp3nrg4dAWJCINq1g0bPqOIl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg & Sam & Josh & Sage & Yehuda,

It would be most helpful to validate that the current ceph-qa-suite tests=
 pass on master with the teuthology OpenStack backend, using the lab setu=
p by Zack. The problems, if any, are usually easy to resolve and progress=
 is being made in that direction[1].=20

Even seasoned contributors struggle to understand the logic behind teutho=
logy. Knowing for certain that a given job is known to pass with OpenStac=
k is a major enabler. When a job is supposed to pass with OpenStack but h=
as never been actually verified, it quickly becomes a blocker because the=
 contributor can hardly differentiate that from a bug in his pull request=
=2E For instance, today Piotr Dalek had to patiently run a rados/thrash j=
ob four times to sort out if the machine crashing came from his pull requ=
est or from a lack of memory (8GB by default).

At present I'm confident that the following suites run fine on OpenStack =
on hammer:

  * upgrade/hammer
  * rados
  * rbd
  * ceph-disk

As part of the work done for the infernalis backports, Abhishek Varshney =
is running the rados suite on OpenStack and we're figuring out problems t=
ogether, one at a time. We're making steady but slow progress because it'=
s not our main focus.

The problem, when a job fails with OpenStack, is usually a timing issue (=
because virtual machines tend to be slower than bare metal) that requires=
 a fix of the test, or a resource issue (because virtual machines are by =
default 8GB RAM, 40GB disk, 2 cpu and no disk attached) that require the =
addition of a yaml file like[2]:

openstack:
   - machine:
       ram: 15000
     volumes:
       count: 2
       size: 10

to set the ram of the machines to at least 15GB instead of 8GB and attach=
 two disks, 10GB each to each machine.

Cheers

[1] openstack: rbd/{thrash,qemu}: allocate three disks, always https://gi=
thub.com/ceph/ceph-qa-suite/pull/727 etc.
[2] Defining instances flavor and volumes https://github.com/dachary/teut=
hology/tree/openstack#defining-instances-flavor-and-volumes

On 25/11/2015 23:14, Gregory Farnum wrote:
> Everybody,
> Ceph is popular! The global community of developers is growing
> quickly, and that=E2=80=99s leading to some challenges for our leads an=
d core
> development team as we try to absorb incoming pull requests. Over the
> past few weeks our leads have discussed (internally and with a few
> external contributors) how to improve things, and we wanted to share
> some conclusions.
>=20
> It has been a long-standing requirement that all code be tested by
> teuthology before being merged to master. In the past leads have
> shouldered a lot of this burden through integration and testing
> branches, but it=E2=80=99s become unsustainable in present form: some P=
Rs
> which are intended as RFCs are being mistakenly identified as final;
> some PRs are submitted which pass cursory sniff tests but fail under
> recovery conditions that the teuthology suites cover. To prevent that,
> please comment on exactly what testing you=E2=80=99ve performed when
> submitting a PR and a justification why that is sufficient to promote
> it to integration testing. Be prepared for us to request more specific
> testing before doing a careful review if we think it=E2=80=99s warrante=
d: in
> general, a run through the applicable regression suite (with new tests
> added in a branch if applicable) will be required. Individual teams
> and leads will develop specific regression testing requirements in the
> near future.
> For our most frequent and prolific contributors, we are going to start
> expecting that you perform the above testing on your own before we
> move on to a serious review or our own integration tests =E2=80=94 this=
 should
> be much easier thanks to Loic=E2=80=99s work on teuthology-openstack!
>=20
> It has also been policy that new features and bug fixes are
> accompanied by tests which 1) demonstrate functionality and 2) check
> failure cases. In this arena some of us have been lax, but nightly
> stability has suffered. Some of us have also written tests for
> external contributions, but this simply doesn=E2=80=99t scale and we ar=
e
> cutting back. If you believe that a patch you=E2=80=99ve submitted is a=
lready
> covered by tests, please point them out. If it=E2=80=99s not covered by=

> existing testing, write new ones! Specifically, the new feature (or
> bug) should be covered by the area=E2=80=99s regression suite.  In most=
 cases,
> this will involve an addition to the ceph-qa-suite.  You should link
> the branch with the change in the main ceph PR.  Your PR=E2=80=99s test=
ing
> should be performed with that ceph-qa-suite branch (since the existing
> ceph-qa-suite coverage is presumably insufficient). If you need
> guidance on how best to automate testing, ask! If you submit a PR
> without these, it will just get bounced back to you and slow everybody
> down.
>=20
> We believe that these adjustments to our merge habits and the workload
> distribution will increase code quality, increase throughput, allow
> faster merges, and prevent the frequent =E2=80=9Clost=E2=80=9D PRs requ=
iring rebases
> that have been appearing over the last year. That will make Ceph
> better for all of us.
>=20
> Thanks!
> -Greg
> -Sam
> -Yehuda
> -Sage
> -Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--9L5SjeqWQsp3nrg4dAWJCINq1g0bPqOIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZWROwACgkQ8dLMyEl6F20PZACcDtyZENwKvIkFWP3jKXRUrwff
G3gAn0fPpFN/ZHJPf4aQfVBFlw71sMUj
=Y77y
-----END PGP SIGNATURE-----

--9L5SjeqWQsp3nrg4dAWJCINq1g0bPqOIl--
