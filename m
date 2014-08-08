From: Loic Dachary <loic@dachary.org>
Subject: Re: Resolving the ruleno / ruleset confusion
Date: Fri, 08 Aug 2014 16:34:19 +0200
Message-ID: <53E4DFEB.40105@dachary.org>
References: <53E4D2C5.8050600@dachary.org> <alpine.DEB.2.00.1408080703370.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Vw2ofLGPHmAbohdbdabDMA9A6CMGGVbn4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56199 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755485AbaHHOe0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 10:34:26 -0400
In-Reply-To: <alpine.DEB.2.00.1408080703370.18917@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ma Jianpeng <majianpeng@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vw2ofLGPHmAbohdbdabDMA9A6CMGGVbn4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 08/08/2014 16:12, Sage Weil wrote:
> On Fri, 8 Aug 2014, Loic Dachary wrote:
>> Hi,
>>
>> As you noticed, there are places where ruleset and ruleno / ruleid are=
 used interchangeably although they are not. This is a source of subtle b=
ugs that can be hard to trace. By default ruleid and ruleset are the same=
, but dumping a crush map including
>>
>> rule data {
>>         ruleset 0
>>         type replicated
>>         min_size 1
>>         max_size 10
>>         step take default
>>         step chooseleaf firstn 0 type host
>>         step emit
>> }
>> rule metadata {
>>         ruleset 1
>>         type replicated
>>         min_size 1
>>         max_size 10
>>         step take default
>>         step chooseleaf firstn 0 type host
>>         step emit
>> }
>>
>> and swapping the rules as follows
>>
>> rule metadata {
>>         ruleset 1
>>         type replicated
>>         min_size 1
>>         max_size 10
>>         step take default
>>         step chooseleaf firstn 0 type host
>>         step emit
>> }
>>
>> rule data {
>>         ruleset 0
>>         type replicated
>>         min_size 1
>>         max_size 10
>>         step take default
>>         step chooseleaf firstn 0 type host
>>         step emit
>> }
>>
>> will have ruleset 1 with rule id 0 and ruleset 0 with rule id 1
>>
>> Since the ruleset is the only reliable number, from the user point of =

>> view, we could simply change CrushWrapper.h to never return the rule i=
d=20
>> and assume only ruleset are given in argument, even where it currently=
=20
>> claims to be a rule id.
>=20
> I'm worried about making that sort of change in an internal interface. =
=20
> And, more generally, about CRUSH maps in the wild that may have odd=20
> mappings that we don't want to break with subtle changes (even fixes). =
 :/
>=20
>> The downside is that looking up the ruleset implies iterating over all=
=20
>> the rules, but that's probably not an issue.
>>
>> What do you think ?
>=20
> I sat down a few months ago and tried to figure out if we could get rid=
 of=20
> the ruleset concept entirely and simply map pools directly to rules=20
> (which are the things the user conceptually thinks about, we name, etc.=
). =20
> The original motivation for a ruleset was to be able to adjust the pool=
=20
> replication factor and have the system adjust the placement behavior=20
> accordingly, but in reality that is a pretty useless capability: num_re=
p=20
> rarely changes, and when it does you can simply adjust the placement ru=
le=20
> at the same time.  Unfortunately, I didn't come up with any easy and=20
> clean way to do it and gave up.
>=20
> I think we should try again.  Getting rid of this particular wart will =

> save us a lot of confusion and complexity and improve the user/admin=20
> experience significantly...
>=20
> My suspicion is that we may need to have a explicit 'upgrade' validatio=
n=20
> step that rejiggers an existing CRUSH map to remap ruleids and rulesets=
 to=20
> map to each other, and enforce that constraint on the cluster.  Then we=
=20
> could get away with renaming the field and clean up all the admin tools=
=20
> and such based on that constraint.  Then, in a year or two, we can chan=
ge=20
> the actual placement code to drop the ruleset logic.  Otherwise we'll n=
eed=20
> to set incompatible feature bits and force clients to update and so on,=
=20
> which we want to avoid...

Understood. Even before going into this, it looks like we need a way to f=
ind all bugs like http://tracker.ceph.com/issues/9044 and fix them. Readi=
ng the code won't be enough I'm afraid. What about changing ruleno and ru=
leset into structs so that compilation shows where they are used intercha=
ngeably when they should not ?=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Vw2ofLGPHmAbohdbdabDMA9A6CMGGVbn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPk3+sACgkQ8dLMyEl6F23E+QCbBkRafJJaiYozMwrar0l6XR1P
mjkAoIjqacDQx4mdKDAW4Rph7cnBQUoh
=o8Uv
-----END PGP SIGNATURE-----

--Vw2ofLGPHmAbohdbdabDMA9A6CMGGVbn4--
