From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure code properties in OSDMap
Date: Wed, 12 Mar 2014 15:40:11 +0100
Message-ID: <532071CB.6030307@dachary.org>
References: <531C5AD5.9060109@cloudwatt.com>	<CAGd4Wr0_Bre-VXckOjkomoeyG8kCx9V_Q6CqSgYWDVhTAn2-sg@mail.gmail.com>	<531F17B0.4080506@cloudwatt.com>	<CAGd4Wr1-effipjF4zCvT15YtC-XMpNvepeA+2L2EYPL5nBn=Wg@mail.gmail.com>	<53205CC1.20401@dachary.org> <CAGd4Wr36gcFPTpkkkz2DY=DsLiTTxVweNJ3wRWjXe7hccLH9zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="V4maODRI4SCldVMA8b8pmvwi8kGfev7iB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41003 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbaCLOkP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 10:40:15 -0400
In-Reply-To: <CAGd4Wr36gcFPTpkkkz2DY=DsLiTTxVweNJ3wRWjXe7hccLH9zQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V4maODRI4SCldVMA8b8pmvwi8kGfev7iB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 12/03/2014 15:35, John Spray wrote:
> OK, in chatting about this I've been convinced that it's legitimately
> separate, because the CRUSH ruleset is mutable during the lifetime of
> a pool but the EC settings are not.  I suppose the way we could
> explain the logical separation for users is to say that the CRUSH
> ruleset is mainly about location selection, whereas the EC settings
> tell you about encoding within those locations.
>=20
> Can we call this something more descriptive like "EC profile" to avoid
> confusion?  "properties" is very generic.

That makes a lot of sense :-) I'll need to ask Sage or Sam during todays'=
 standup to have their opinion about http://tracker.ceph.com/issues/7662#=
note-2 . If that approach sound sensible to them I'll provide an implemen=
tation for review in the next few days.

Cheers

>=20
> Cheers,
> John
>=20
>=20
>=20
> On Wed, Mar 12, 2014 at 1:10 PM, Loic Dachary <loic@dachary.org> wrote:=

>> On 12/03/2014 13:39, John Spray wrote:
>>> I am sure all of that will work, but it doesn't explain why these
>>> properties must be stored and named separately to crush rulesets.  To=

>>> flesh this out one also needs "get" and "list" operations for the set=
s
>>> of properties, which feels like overkill if there is an existing plac=
e
>>> we could be storing these things.  The reason I'm taking such an
>>> interest in what may seem something minor is that once this has been
>>> added, we will be stuck with it for some time once external tools
>>> start depending on the interface.
>>>
>>> The ruleset-based approach doesn't have to be more complicated for CL=
I
>>> users, we would essentially replace any "myproperties" above with a
>>> ruleset name instead.
>>>
>>> osd pool create mypool <pgnum> <pgpnum> <ruleset>
>>> osd set ruleset-properties <ruleset> <key>=3D<val> [<key>=3D<val>...]=

>>>
>>> The simple default cases of "pool create mypool <pgnum> <pgpnum>
>>> erasure" could be handled by making sure there exist default rulesets=

>>> called "erasure" and "replicated" rather than having these be magic
>>> words to the commands that cause ruleset creation.  Rulesets currentl=
y
>>> just have numbers instead of names, but it would be simpler to add
>>> names to rulesets than to introduce a whole new type of object to the=

>>> interface.
>> Here are the default parameters
>>
>> OPTION(osd_pool_default_erasure_code_properties,
>>        OPT_STR,
>>        "erasure-code-plugin=3Djerasure "
>>        "erasure-code-technique=3Dreed_sol_van "
>>        "erasure-code-k=3D4 "
>>        "erasure-code-m=3D2 "
>>        ) // default properties of osd pool create
>>
>> The k and m parameters have a clear relationship with the pool size. A=
nd they also define the minimum number of items the crush ruleset must be=
 able to provide. The other parameters relate to the code/decode function=
s and are better understood in the context of the OSD than crush. This is=
 the reason why I don't see these properties as being exclusively linked =
to the crush ruleset or the OSD. By introducing a new set of properties a=
ssociated to the erasure code feature there is no need to chose.
>>
>> Does that make sense ?
>>>
>>> John
>>>
>>> On Tue, Mar 11, 2014 at 2:03 PM, Loic Dachary
>>> <loic.dachary@cloudwatt.com> wrote:
>>>> On 11/03/2014 13:21, John Spray wrote:
>>>>> From a high level view, what is the logical difference between the
>>>>> crush ruleset and the properties object?  I'm thinking about how th=
is
>>>>> is exposed to users and tools, and it seems like both would be defi=
ned
>>>>> as "the settings about data placement and encoding".  I certainly
>>>>> understand the separation internally, I am just concerned about mak=
ing
>>>>> the interface we expose upwards more complicated by adding a new ty=
pe
>>>>> of object.
>>>>>
>>>>> Is there really a need for a new type of properties object, instead=
 of
>>>>> storing these properties under the existing ruleset ID?
>>>> These properties are used to configure the new feature that was intr=
oduced in Firefly : erasure coded pools. From a user point of view the si=
mplest would be to
>>>>
>>>> ceph osd pool create mypool erasure
>>>>
>>>> and rely on the fact that a default ruleset will be created using th=
e default erasure code plugin with the default parameters.
>>>>
>>>> If the sysadmin wants to tweak the K+M factors (s)he could:
>>>>
>>>> ceph osd set properties myproperties k=3D10 m=3D4
>>>>
>>>> and then
>>>>
>>>> ceph osd pool create mypool erasure myproperties
>>>>
>>>> which would implicitly ask the default erasure code plugin to create=
 a ruleset named "mypool-ruleset" after configuring it with myproperties.=

>>>>
>>>> If the sysadmin wants to share rulesets between pools instead of rel=
ying on their implicit creation, (s)he could
>>>>
>>>> ceph osd create-serasure myruleset myproperties
>>>>
>>>> and then ceph osd set crush_ruleset as per usual. And if (s)he reall=
y wants fine tuning, manually adding the ruleset is also possible.
>>>>
>>>> I feel confortable explaining this but I'm probably much too familia=
r with the subject to be a good judge of what makes sense to someone new =
or not ;-)
>>>>
>>>> Cheers
>>>>
>>>>> John
>>>>>
>>>>>
>>>>> On Sun, Mar 9, 2014 at 12:13 PM, Loic Dachary
>>>>> <loic.dachary@cloudwatt.com> wrote:
>>>>>> Hi Sage & Sam,
>>>>>>
>>>>>> I quickly sketched the replacement of the pg_pool_t::properties ma=
p with a OSDMap::properties list of maps at https://github.com/dachary/ce=
ph/commit/fe3819a62eb139fc3f0fa4282b4d22aecd8cd398 and explained how I se=
e it at http://tracker.ceph.com/issues/7662#note-2
>>>>>>
>>>>>> It indeed makes things simpler, more consistent and easier to expl=
ain. I can provide an implementation this week if this seems reasonable t=
o you.
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>> --
>>>>>> Lo=C4=8Fc Dachary, Senior Developer
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html=

>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Senior Developer
>>>>
>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--V4maODRI4SCldVMA8b8pmvwi8kGfev7iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMgccwACgkQ8dLMyEl6F20OvACgsdAyFqp4yZU6nEMtqTQ6Sm8D
f4UAoKLmrRae1x9gc2Xb/8pKBPqF4NDS
=1r97
-----END PGP SIGNATURE-----

--V4maODRI4SCldVMA8b8pmvwi8kGfev7iB--
