From: Loic Dachary <loic@dachary.org>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 05 May 2015 21:07:24 +0200
Message-ID: <554914EC.6000102@dachary.org>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VRFUA1RR6nwQRITDjLP816vIhbf5DKsga"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58063 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756706AbbEETHc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 15:07:32 -0400
In-Reply-To: <55491307.8010203@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VRFUA1RR6nwQRITDjLP816vIhbf5DKsga
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/05/2015 20:59, Ken Dreyer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> On 05/05/2015 08:36 AM, Loic Dachary wrote:
>>
>>
>> On 05/05/2015 16:31, Gregory Farnum wrote:
>>> On Tue, May 5, 2015 at 1:34 AM, Loic Dachary <loic@dachary.org>
>>> wrote:
>>>> Hi Kefu,
>>>>
>>>> In the context of https://github.com/ceph/ceph/pull/4449 and
>>>> https://github.com/ceph/ceph/pull/4544 I see you're going out
>>>> of your way to implement mechanisms that make it possible to
>>>> require less dependencies when running
>>>>
>>>> ./configure
>>>>
>>>> than what is required by
>>>>
>>>> ./make check
>>>>
>>>> I think the right solution is to require the same set of
>>>> dependencies, regardless. It can easily be done by running
>>>> ./install-deps.sh[1].
>>>>
>>>> This script is already used in jenkins.ceph.com and saved us
>>>> from the recurring pain of manually updating the jenkins slaves
>>>> every time a dependency was added to either ceph.spec.in or
>>>> debian/control.
>>>>
>>>> Although it is possible to run ./configure with a subset of the
>>>> dependencies that are required to run make check, it trades
>>>> automatic installation of packages for significant manual
>>>> maintenance. It saves a little disk and bandwidth every time a
>>>> dependency is modified in the ceph.spec.in or debian/control
>>>> files, which happens a few times a months at most. The work
>>>> items to manually maintain this difference:
>>>>
>>>> * the set of dependencies that ./configure requires needs to be
>>>> manually maintained, it is not listed anywhere at the moment.
>>>> It changes less often than ceph.spec.in or debian/control but
>>>> it does change from time to time * the configure script has to
>>>> be engineered to only require dependencies (assuming these
>>>> dependencies are listed somewhere). In other word, every time
>>>> you change the configure script you have to be extra careful to
>>>> not introduce a new dependency, even when it would help
>>>> implement what you're after in a simpler way. * the configure
>>>> script dependencies in the context of CI actually change every
>>>> time you consider using --enable-something because it modifies
>>>> the set of files your tarbal is made of. If the corresponding
>>>> something is not installed, the configure will likely not do
>>>> what you want and you'll have to add something manually on the
>>>> CI machine (or use install-deps.sh but that would defeat the
>>>> purpose of separating configure dependencies from make
>>>> dependencies) * to avoid adding dependencies to configure, it
>>>> is tempting to forbid file generation when preparing the tarbal
>>>> (I'm thinking .8 generation specifically), although it is
>>>> legitimate for the tarbal generation to involve some processing
>>>> and transformation of the sources that require tools to run *
>>>> it is very unlikely a new developer will remember configure
>>>> dependencies and make dependencies are different and mistakes
>>>> will be done all the time, creating needless frustration
>>>
>>> Maybe I'm missing something, but...
>>
>> The bit of context I forgot to mention is that ./configure is often
>> used for the sole purpose of running make dist (with the risk of
>> bundling stuff that does not actually build or run but that's not
>> too much of a concern if the build is done immediately afterward,
>> using the tarbal created by make dist).
>>
>=20
> I think the long-term solution to Kefu's issue is that we need to
> remove the requirement to run through a full "./configure" invocation
> just to get a tarball. All the RPM and Debian packages internally run
> ./configure, so running it a second time slows things down. I think it
> makes sense to implement the tarball-generation functionality using a
> simpler script at the root of the ceph.git tree. The operation should
> be about as fast as "git archive".

I agree. It's going to be significant work but it's worth it.

> The "ceph.spec.in" -> "ceph.spec" suffers from a similar issue. It
> takes a full "./configure" run to get to a point where Make can write
> the proper version numbers into that file. Ideally we could skip all
> of that and simply do the variable interpolation with sed or something.=

>=20
> - - Ken
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--VRFUA1RR6nwQRITDjLP816vIhbf5DKsga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVJFOwACgkQ8dLMyEl6F20uQQCfVj/p6Ggbkv0Ktl+MUlSakp9J
jzQAoMZzCK4yDF387TipYBsZcsmdKBAE
=0zpI
-----END PGP SIGNATURE-----

--VRFUA1RR6nwQRITDjLP816vIhbf5DKsga--
