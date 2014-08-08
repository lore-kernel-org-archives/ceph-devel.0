From: Loic Dachary <loic@dachary.org>
Subject: Re: Resolving the ruleno / ruleset confusion
Date: Fri, 08 Aug 2014 17:10:41 +0200
Message-ID: <53E4E871.6040907@dachary.org>
References: <53E4D2C5.8050600@dachary.org> <alpine.DEB.2.00.1408080703370.18917@cobra.newdream.net>,<53E4DFEB.40105@dachary.org> <125EBE20-6632-496D-AD2D-7E553C7E13CE@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cP1wawkofAaUNG3p48Cn99aHNFA3LWEOB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56220 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756322AbaHHPKs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 11:10:48 -0400
In-Reply-To: <125EBE20-6632-496D-AD2D-7E553C7E13CE@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Sage Weil <sweil@redhat.com>, Ma Jianpeng <majianpeng@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cP1wawkofAaUNG3p48Cn99aHNFA3LWEOB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I guess most users just think of ruleset and never finds out there are tw=
o different numbers with slightly different semantic.=20

For me the use case is, 100% of the time : creating a rule via the comman=
d line and get the ruleset via dump OR create and update a rule via dump =
/ load the osdmap, in which case I diligently (for no reason, just becaus=
e it seemed right) increment the ruleset and keep them in order.

I have no use of rule ids and only use rulesets.

Cheers

On 08/08/2014 16:54, Chen, Xiaoxi wrote:
> I think before we start bug fix or try to get rid of ruleset concept, w=
e can start with define a reasonable use case. How we expect user to play=
 with rule and pools.  there is no CLI to create/modify a ruleset, even w=
orse , you are not able to get the ruleset id without dump a rule.=20
>=20
> currently the logic of command flow is really strange, user writes a ru=
le, when he wants to use the rule,he need to find out the ruleset who con=
tains the rule, and specified the ruleset to a pool. If the ruleset only =
contains a rule, the concept of ruleset is  confusing and useless, if the=
 ruleset contains more than one rules, user may have the risk that ceph s=
elect a rule in the ruleset, but not the one he want...
>=20
>=20
>=20
> =E5=9C=A8 2014-8-8=EF=BC=8C22:34=EF=BC=8C"Loic Dachary" <loic@dachary.o=
rg> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>>
>>
>> On 08/08/2014 16:12, Sage Weil wrote:
>>> On Fri, 8 Aug 2014, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> As you noticed, there are places where ruleset and ruleno / ruleid a=
re used interchangeably although they are not. This is a source of subtle=
 bugs that can be hard to trace. By default ruleid and ruleset are the sa=
me, but dumping a crush map including
>>>>
>>>> rule data {
>>>>        ruleset 0
>>>>        type replicated
>>>>        min_size 1
>>>>        max_size 10
>>>>        step take default
>>>>        step chooseleaf firstn 0 type host
>>>>        step emit
>>>> }
>>>> rule metadata {
>>>>        ruleset 1
>>>>        type replicated
>>>>        min_size 1
>>>>        max_size 10
>>>>        step take default
>>>>        step chooseleaf firstn 0 type host
>>>>        step emit
>>>> }
>>>>
>>>> and swapping the rules as follows
>>>>
>>>> rule metadata {
>>>>        ruleset 1
>>>>        type replicated
>>>>        min_size 1
>>>>        max_size 10
>>>>        step take default
>>>>        step chooseleaf firstn 0 type host
>>>>        step emit
>>>> }
>>>>
>>>> rule data {
>>>>        ruleset 0
>>>>        type replicated
>>>>        min_size 1
>>>>        max_size 10
>>>>        step take default
>>>>        step chooseleaf firstn 0 type host
>>>>        step emit
>>>> }
>>>>
>>>> will have ruleset 1 with rule id 0 and ruleset 0 with rule id 1
>>>>
>>>> Since the ruleset is the only reliable number, from the user point o=
f=20
>>>> view, we could simply change CrushWrapper.h to never return the rule=
 id=20
>>>> and assume only ruleset are given in argument, even where it current=
ly=20
>>>> claims to be a rule id.
>>>
>>> I'm worried about making that sort of change in an internal interface=
=2E =20
>>> And, more generally, about CRUSH maps in the wild that may have odd=20
>>> mappings that we don't want to break with subtle changes (even fixes)=
=2E  :/
>>>
>>>> The downside is that looking up the ruleset implies iterating over a=
ll=20
>>>> the rules, but that's probably not an issue.
>>>>
>>>> What do you think ?
>>>
>>> I sat down a few months ago and tried to figure out if we could get r=
id of=20
>>> the ruleset concept entirely and simply map pools directly to rules=20
>>> (which are the things the user conceptually thinks about, we name, et=
c.). =20
>>> The original motivation for a ruleset was to be able to adjust the po=
ol=20
>>> replication factor and have the system adjust the placement behavior =

>>> accordingly, but in reality that is a pretty useless capability: num_=
rep=20
>>> rarely changes, and when it does you can simply adjust the placement =
rule=20
>>> at the same time.  Unfortunately, I didn't come up with any easy and =

>>> clean way to do it and gave up.
>>>
>>> I think we should try again.  Getting rid of this particular wart wil=
l=20
>>> save us a lot of confusion and complexity and improve the user/admin =

>>> experience significantly...
>>>
>>> My suspicion is that we may need to have a explicit 'upgrade' validat=
ion=20
>>> step that rejiggers an existing CRUSH map to remap ruleids and rulese=
ts to=20
>>> map to each other, and enforce that constraint on the cluster.  Then =
we=20
>>> could get away with renaming the field and clean up all the admin too=
ls=20
>>> and such based on that constraint.  Then, in a year or two, we can ch=
ange=20
>>> the actual placement code to drop the ruleset logic.  Otherwise we'll=
 need=20
>>> to set incompatible feature bits and force clients to update and so o=
n,=20
>>> which we want to avoid...
>>
>> Understood. Even before going into this, it looks like we need a way t=
o find all bugs like http://tracker.ceph.com/issues/9044 and fix them. Re=
ading the code won't be enough I'm afraid. What about changing ruleno and=
 ruleset into structs so that compilation shows where they are used inter=
changeably when they should not ?=20
>>
>> Cheers
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--cP1wawkofAaUNG3p48Cn99aHNFA3LWEOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPk6HEACgkQ8dLMyEl6F20kGgCgl8fbvSKkhVzK3M4Y/CKwB2gb
WUcAoIqli01TG7glqf/7AXQ1fXQrJ69s
=2dN1
-----END PGP SIGNATURE-----

--cP1wawkofAaUNG3p48Cn99aHNFA3LWEOB--
