From: Loic Dachary <loic@dachary.org>
Subject: Re: GCC -msse2 portability question
Date: Wed, 26 Mar 2014 19:24:13 +0100
Message-ID: <53331B4D.8030901@dachary.org>
References: <532F3B0E.2050204@dachary.org>	<5331D41B.5040001@dachary.org>	<CA+AFVBhpOZEPehsd4qHCBr4aRzv60ZW8LzRwKsduUrZmLV1wxQ@mail.gmail.com>	<5331D738.9030409@dachary.org>	<CANP1eJFMRN5=-N0jJm=5XgJ+veKFWBR1P=TpKncfw2_XeHGE=A@mail.gmail.com>	<CA+AFVBgOEz8_fv9H-8_kOuVSJNL3KQ+36b5kscfjnRMs09DZ6Q@mail.gmail.com>	<53327E59.7060408@dachary.org> <CANP1eJG9xoCPkFs19KXG1RPUqc-D3aO_0SBOM=4WWFRN2JtX=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cxlQOU7k20jWoU7vUSO7vnx4RpsadWVVi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:55305 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbaCZSYU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 14:24:20 -0400
In-Reply-To: <CANP1eJG9xoCPkFs19KXG1RPUqc-D3aO_0SBOM=4WWFRN2JtX=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cxlQOU7k20jWoU7vUSO7vnx4RpsadWVVi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 26/03/2014 18:40, Milosz Tanski wrote:
> Loic,
>=20
> I don't mean to be redundant since I posted this comment already in
> the github on commit comments but I'm not sure if you saw this.

Thanks for posting it : your comment got lost by a rebase ( github's not =
good at that ... ).

> Instead of doing cpuid manually you can use builtins provided in gcc
> (and in clang). There's a cpuid.h header you can include. This
> stackoverflow answer has a good summary of it:
> http://stackoverflow.com/questions/14266772/how-do-i-call-cpuid-in-linu=
x?answertab=3Dvotes#tab-top

It is a nice improvement to have indeed. Created http://tracker.ceph.com/=
issues/7869

Cheers

> On Wed, Mar 26, 2014 at 3:14 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Kevin & Milosz,
>>
>> So it would be
>>
>> if(sse4 & sse3) =3D> use a plugin compiled with sse + sse3 + sse4 acti=
vated
>> else if(sse3) =3D> use a plugin with sse2 + sse3 activated but not sse=
4
>> else =3D> fallback to not using sse at all
>>
>> like so:
>>
>> https://github.com/dachary/ceph/commit/b6e4307bd2ee1de6e8bbda0ced370d4=
84d512114#diff-5249f49580782dfe95a1cbcc986ee5deR113
>>
>> If I understand Laurent correctly, the right approach would be to semi=
-transparently generate and select the code path depending on the feature=
s at runtime. But that would require more work and I created a ticket to =
track this : http://tracker.ceph.com/issues/7865
>>
>> Does that sound right ?
>>
>> On 25/03/2014 22:31, Kevin Greenan wrote:
>>> Hey Loic,
>>>
>>> I think we want something closer to what Milosz is proposing (3 cut-o=
ffs instead of 2) .  The shuffle instruction is part of SSSE3 and is the =
basis for the SSE split table techniques, which are super fast.  By doing=
 all-or-nothing, it is possible many users would not be able to take adva=
ntage of it when they are capable.
>>>
>>> Make sense?
>>>
>>> -kevin
>>>
>>>
>>> On Tue, Mar 25, 2014 at 12:46 PM, Milosz Tanski <milosz@adfin.com <ma=
ilto:milosz@adfin.com>> wrote:
>>>
>>>     It gets a bit more tricky with x86_64 since the arch dictates tha=
t the
>>>     base line has SSE2 (but not necessarily later).
>>>
>>>     I would do is both support SSE2 (maybe in core without dlopen) an=
d
>>>     then support all the others in a SSE4 version (including SSE4_PCM=
UL).
>>>     I'm glossing over x86-32 here, but you could something similar.
>>>
>>>     Best
>>>     - Milosz
>>>
>>>     On Tue, Mar 25, 2014 at 3:21 PM, Loic Dachary <loic@dachary.org <=
mailto:loic@dachary.org>> wrote:
>>>     >
>>>     >
>>>     > On 25/03/2014 20:13, Kevin Greenan wrote:
>>>     >> +1
>>>     >>
>>>     >> Yeah, that sounds better...  Let's keep this as simple as poss=
ible.
>>>     >
>>>     > I'll rework the https://bitbucket.org/jimplank/gf-complete/pull=
-request/4/defer-the-decision-to-use-a-given-sse accordingly.
>>>     >
>>>     > Would it be sensible to compile with SSE optimizations only if =
all are available ( SSE2, SSSE3, SSE4, SSE4_PCMUL ) and not attempt to di=
stinguish betweel SSSE3 being available but not SSE4_PCMUL etc. From what=
 I understand at this point that kind of distinction is going to be diffi=
cult to manage anyway.
>>>     >
>>>     > Is it too simplistic ?
>>>     >
>>>     >>
>>>     >> -kevin
>>>     >>
>>>     >>
>>>     >> On Tue, Mar 25, 2014 at 12:08 PM, Loic Dachary <loic@dachary.o=
rg <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachar=
y.org>>> wrote:
>>>     >>
>>>     >>     Andreas Peters suggested another approach, which makes sen=
se to me : have one plugin with SSE optimizations enabled, another withou=
t them and chose at runtime between the two.
>>>     >>
>>>     >>     What do you think ?
>>>     >>
>>>     >>     On 23/03/2014 20:50, Loic Dachary wrote:
>>>     >>     > Hi Laurent,
>>>     >>     >
>>>     >>     > In the context of optimizing erasure code functions impl=
emented by Kevin Greenan (cc'ed) and James Plank at https://bitbucket.org=
/jimplank/gf-complete/ we ran accross a question you may have the answer =
to: can gcc -msse2 (or -msse* for that matter ) have a negative impact on=
 the portability of the compiled binary code ?
>>>     >>     >
>>>     >>     > In other words, if a code is compiled without -msse* and=
 runs fine on all intel processors it targets, could it be that adding -m=
sse* to the compilation of the same source code generate a binary that wo=
uld fail on some processors ? This is assuming no sse specific functions =
were used in the source code.
>>>     >>     >
>>>     >>     > In gf-complete, all sse specific instructions are carefu=
lly protected to not be run on a CPU that does not support them. The runt=
ime detection is done by checking CPU id bits ( see https://bitbucket.org=
/jimplank/gf-complete/pull-request/7/probe-intel-sse-features-at-runtime/=
diff#Lsrc/gf_intel.cT28 )
>>>     >>     >
>>>     >>     > The corresponding thread is at:
>>>     >>     >
>>>     >>     > https://bitbucket.org/jimplank/gf-complete/pull-request/=
4/defer-the-decision-to-use-a-given-sse/diff#comment-1479296
>>>     >>     >
>>>     >>     > Cheers
>>>     >>     >
>>>     >>
>>>     >>     --
>>>     >>     Lo=EFc Dachary, Artisan Logiciel Libre
>>>     >>
>>>     >>
>>>     >
>>>     > --
>>>     > Lo=EFc Dachary, Artisan Logiciel Libre
>>>     >
>>>
>>>
>>>
>>>     --
>>>     Milosz Tanski
>>>     CTO
>>>     10 East 53rd Street, 37th floor
>>>     New York, NY 10022
>>>
>>>     p: 646-253-9055 <tel:646-253-9055>
>>>     e: milosz@adfin.com <mailto:milosz@adfin.com>
>>>
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--cxlQOU7k20jWoU7vUSO7vnx4RpsadWVVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMzG1EACgkQ8dLMyEl6F23tkQCfSlxFjNBbhaKXUettPLcxJHgu
xiAAoJt4PL3nJrznPb3uuX39d8CiMvCK
=vXgU
-----END PGP SIGNATURE-----

--cxlQOU7k20jWoU7vUSO7vnx4RpsadWVVi--
