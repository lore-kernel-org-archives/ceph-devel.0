From: Loic Dachary <loic@dachary.org>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 05 May 2015 16:36:46 +0200
Message-ID: <5548D57E.3050406@dachary.org>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xAiPtjpT59krRFHH6BCHf0f17QTX8ou3I"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57875 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993204AbbEEOg4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 10:36:56 -0400
In-Reply-To: <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Kefu Chai <kchai@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xAiPtjpT59krRFHH6BCHf0f17QTX8ou3I
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/05/2015 16:31, Gregory Farnum wrote:
> On Tue, May 5, 2015 at 1:34 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Kefu,
>>
>> In the context of https://github.com/ceph/ceph/pull/4449 and https://g=
ithub.com/ceph/ceph/pull/4544 I see you're going out of your way to imple=
ment mechanisms that make it possible to require less dependencies when r=
unning
>>
>>    ./configure
>>
>> than what is required by
>>
>>    ./make check
>>
>> I think the right solution is to require the same set of dependencies,=
 regardless. It can easily be done by running ./install-deps.sh[1].
>>
>> This script is already used in jenkins.ceph.com and saved us from the =
recurring pain of manually updating the jenkins slaves every time a depen=
dency was added to either ceph.spec.in or debian/control.
>>
>> Although it is possible to run ./configure with a subset of the depend=
encies that are required to run make check, it trades automatic installat=
ion of packages for significant manual maintenance. It saves a little dis=
k and bandwidth every time a dependency is modified in the ceph.spec.in o=
r debian/control files, which happens a few times a months at most. The w=
ork items to manually maintain this difference:
>>
>> * the set of dependencies that ./configure requires needs to be manual=
ly maintained, it is not listed anywhere at the moment. It changes less o=
ften than ceph.spec.in or debian/control but it does change from time to =
time
>> * the configure script has to be engineered to only require dependenci=
es (assuming these dependencies are listed somewhere). In other word, eve=
ry time you change the configure script you have to be extra careful to n=
ot introduce a new dependency, even when it would help implement what you=
're after in a simpler way.
>> * the configure script dependencies in the context of CI actually chan=
ge every time you consider using --enable-something because it modifies t=
he set of files your tarbal is made of. If the corresponding something is=
 not installed, the configure will likely not do what you want and you'll=
 have to add something manually on the CI machine (or use install-deps.sh=
 but that would defeat the purpose of separating configure dependencies f=
rom make dependencies)
>> * to avoid adding dependencies to configure, it is tempting to forbid =
file generation when preparing the tarbal (I'm thinking .8 generation spe=
cifically), although it is legitimate for the tarbal generation to involv=
e some processing and transformation of the sources that require tools to=
 run
>> * it is very unlikely a new developer will remember configure dependen=
cies and make dependencies are different and mistakes will be done all th=
e time, creating needless frustration
>=20
> Maybe I'm missing something, but...

The bit of context I forgot to mention is that ./configure is often used =
for the sole purpose of running make dist (with the risk of bundling stuf=
f that does not actually build or run but that's not too much of a concer=
n if the build is done immediately afterward, using the tarbal created by=
 make dist).

>=20
> configure's purpose in life is to set up the build system so that Ceph
> will successfully build on the current system. If configure assumes
> that you have stuff installed that you don't need to have installed to
> build, then it is not doing its job.
> Similarly, if "make check" won't run on a system that otherwise builds
> Ceph, that's a problem with "make check", not a problem with configure
> or the rest of Ceph. If we require *extra* dependencies to support
> make check that's very bad =E2=80=94 it's becoming more popular for ven=
dors to
> build Ceph on more exotic architectures and systems, and the chances
> are good that they'll do the minimal porting job, and simply skip
> running "make check" if it requires extra bits.
>=20
> Now, there are times when we decide something is important so we have
> configure default to one configuration and require a flag to change
> it. But in general that's not what we want to do, and IIRC there was
> an issue where configure was actually failing despite it being
> perfectly fine to build without some library or other.
>=20
> Etc etc.
> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--xAiPtjpT59krRFHH6BCHf0f17QTX8ou3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVI1X4ACgkQ8dLMyEl6F21IEQCfVBvwHEPywtZRWDcg5zJmhJ72
IOwAnif3N96pG3x/qX6X/XHz7+v0zWaX
=XzdW
-----END PGP SIGNATURE-----

--xAiPtjpT59krRFHH6BCHf0f17QTX8ou3I--
