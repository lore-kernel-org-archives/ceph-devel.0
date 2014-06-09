From: Loic Dachary <loic@dachary.org>
Subject: Re: Locally repairable code description revisited (was Pyramid ...)
Date: Mon, 09 Jun 2014 23:40:30 +0200
Message-ID: <539629CE.8090409@dachary.org>
References: <538A0CF8.8030501@dachary.org>	<53907935.9010009@dachary.org>	<3472A07E6605974CBC9BC573F1BC02E4AE730544@CERNXCHG44.cern.ch>	<5391D069.30701@dachary.org>	<CAPYLRzgEhTRohS9Jb9dZHnTL8_TpgDvF8sJkzn_NoY2kc4DmbA@mail.gmail.com> <CA+4uBUbc3PtmLU3GetzQCm5r=SXA8cxq=bsayZOnvLFR2Sja8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uBv2Vx4dJJohJe0sNhskcuQPgV6Dd0Am3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:38885 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbaFIVke (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jun 2014 17:40:34 -0400
In-Reply-To: <CA+4uBUbc3PtmLU3GetzQCm5r=SXA8cxq=bsayZOnvLFR2Sja8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uBv2Vx4dJJohJe0sNhskcuQPgV6Dd0Am3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sam, Greg,

A simpler proposal is documented at :

    https://github.com/dachary/ceph/commit/ff11902bdc26aa35c70dd2f4d9de31=
f4cd207519#diff-5518964bc98a094a784ce2d17a5b0cc1R1

which is part of the proposed implementation for locally repairable code

    https://github.com/ceph/ceph/pull/1921

Hopefully it makes sense ;-)

Cheers

On 09/06/2014 22:38, Samuel Just wrote:
> I'm finding that I don't really understand how the LRC specification
> works.  Is there a doc somewhere I can read?
> -Sam
>=20
> On Mon, Jun 9, 2014 at 1:18 PM, Gregory Farnum <greg@inktank.com> wrote=
:
>> On Fri, Jun 6, 2014 at 7:30 AM, Loic Dachary <loic@dachary.org> wrote:=

>>> Hi Andreas,
>>>
>>> On 06/06/2014 13:46, Andreas Joachim Peters wrote:> Hi Loic,
>>>> the basic implementation looks very clean.
>>>>
>>>> I have few comments/ideas:
>>>>
>>>> - the reconstruction strategy using the three levels is certainly ef=
ficient enough for standard cases but does not guarantee always the minim=
um decoding (in cases where one layer is not enough to reconstruct) since=
 your third algorithm is just brute-force to reconstruct everything throu=
gh all layers until we have what we need ...
>>>
>>> The third strategy is indeed brute force. Do you think it is worth ch=
anging to be minimal ? It would be nice to quantify the percent of cases =
it addresses. Do you know how to do that ? It looks like a very small per=
centage but there is no proof it is small ;-)
>>>
>>>> - the whole LRC configuration actually does not describe the placeme=
nt - it still looks disconnected from the placement strategy/crush rules =
=2E.. wouldn't it make sense to have the crush rule implicit in the descr=
iption or a function to derive it automatically based on the LRC configur=
ation? Maybe you have this already done in another way and I didn't see i=
t ...
>>>
>>> Good catch.
>>>
>>> What about this:
>>>
>>>       "  [ \"_aAAA_aAA_\", \"set choose datacenter 2\","
>>>       "    \"_aXXX_aXX_\" ],"
>>>       "  [ \"b_BBB_____\", \"set choose host 5\","
>>>       "    \"baXXX_____\" ],"
>>>       "  [ \"_____cCCC_\", \"\","
>>>       "    \"baXXXcaXX_\" ],"
>>>       "  [ \"_____DDDDd\", \"\","
>>>       "    \"baXXXcaXXd\" ],"
>>>
>>> Which translates into
>>>
>>> take root
>>> set choose datacenter 2
>>> set choose host 5
>>>
>>> In other words, the ruleset is created by concatenating the strings f=
rom the description, without any kind of smart computation. It is up to t=
he person who creates the description to add the ruleset near a descripti=
on that makes sense. There is going to be minimal checking to make sure t=
he ruleset can actually be used to get the required number of chunks.
>>>
>>> It probably is very difficult and very confusing to automate the gene=
ration of the ruleset. If it is implicit rather than explicit as above, t=
he operator will have to somehow understand and learn how it is computed =
to make sure it does what is desired. With an explicit set of crush rules=
 loosely coupled to chunk mapping, the operator can read the crush docume=
ntation instead of guessing.
>>
>> I think I'm missing some context for this discussion (maybe I haven't
>> been reading other threads closely enough); can you discuss this in
>> more detail?
>> Matching up CRUSH rulesets and the EC plugin formulas is very
>> important and demonstrated to be difficult, but I don't really
>> understand what you're suggesting here, which makes me think it's not
>> quite the right idea. ;)
>>
>>>
>>>> -  should the plug-in have the ability to select reconstruction on p=
roximity or this should be up-to the higher layer to provide chunks in a =
way that reconstruction would select the 'closest' layer? The relevance o=
f the question you will understand better in the next point ....
>>>>
>>>> - I remember we had this 3 data centre example with (8,4) where you =
can reconstruct every object if 2 data centres are up. Another appealing =
example avoiding remote access when reading an object is that you have 2 =
data centres having a replication of e.g. (4,2) encoded objects. Can you =
describe in your LRC configuration language to store the same chunk twice=
 like    __ABCCBA__ ?
>>>
>>> Unless I'm mistaken that would require the caller of the plugin to su=
pport duplicate data chunks and provide a kind of proximity check. Since =
this is not currently supported by the OSD logic, it is difficult to figu=
re out how an erasure code plugin could provide support for this use case=
=2E
>>
>> I haven't looked at the EC plugin interface at all, but I thought the
>> OSD told the plugin what chunks it could access, and the plugin tells
>> it which ones to fetch. So couldn't the plugin simply output duplicate=

>> chunks, and not have the OSD retrieve both of them?
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uBv2Vx4dJJohJe0sNhskcuQPgV6Dd0Am3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOWKc8ACgkQ8dLMyEl6F22Q5QCgnq90dyfnngiGFqJtNNgPV4gu
nEcAn3zKLBYwEu5GEzgc4lTOTqMWt8P8
=IRXy
-----END PGP SIGNATURE-----

--uBv2Vx4dJJohJe0sNhskcuQPgV6Dd0Am3--
