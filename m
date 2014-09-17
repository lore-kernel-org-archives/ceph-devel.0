From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] Crushmap ruleset for rack aware PG placement
Date: Wed, 17 Sep 2014 22:11:44 +0200
Message-ID: <5419EB00.70307@dachary.org>
References: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg@mail.gmail.com> <alpine.DEB.2.00.1409150826060.513@cobra.newdream.net> <lv91s9$4j2$1@ger.gmane.org> <54184711.3080002@dachary.org> <lv9p5b$1h1$1@ger.gmane.org> <D03E84B7.B8D%johnugeo@cisco.com> <541945F8.60001@dachary.org> <D03EEB71.BBF%johnugeo@cisco.com> <5419B25B.3010508@dachary.org> <D03F35D4.BDC%johnugeo@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8as3MFhUkVvUmNxdOQgBgXFacvJbuOnqd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54526 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755939AbaIQULx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 16:11:53 -0400
In-Reply-To: <D03F35D4.BDC%johnugeo@cisco.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Johnu George (johnugeo)" <johnugeo@cisco.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8as3MFhUkVvUmNxdOQgBgXFacvJbuOnqd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 17/09/2014 22:03, Johnu George (johnugeo) wrote:
> Loic,
>       You are right.  Are we planning to support configurations where
> replica number is different from the number of osds selected from a  ru=
le?

I think crush should support it, yes. If a rule can provide 10 OSDs there=
 is no reason for it to fail to provide just one.

Cheers

> If not, One solution is to add a validation check when a rule is activa=
ted
> for a pool of a specific replica.
>=20
> Johnu
>=20
> On 9/17/14, 9:10 AM, "Loic Dachary" <loic@dachary.org> wrote:
>=20
>> Hi,
>>
>> If the number of replica desired is 1, then
>>
>> https://github.com/ceph/ceph/blob/firefly/src/crush/CrushWrapper.h#L91=
5
>>
>> will be called with maxout =3D 1 and scratch will be maxout * 3. But i=
f the
>> rule always selects 4 items, then it overflows. Is it what you also re=
ad ?
>>
>> Cheers
>>
>> On 17/09/2014 16:42, Johnu George (johnugeo) wrote:
>>> Adding ceph-devel
>>>
>>> On 9/17/14, 1:27 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>>
>>>>
>>>> Could you resend with ceph-devel in cc ? It's better for archive
>>>> purposes
>>>> ;-)
>>>>
>>>> On 17/09/2014 09:37, Johnu George (johnugeo) wrote:
>>>>> Hi Sage,
>>>>>          I was looking at the crash that was reported in this mail
>>>>> chain.
>>>>> I am seeing that the crash happens when number of replicas configur=
ed
>>>>> is
>>>>> less than total number of osds to be selected as per rule. This is
>>>>> because, the crush temporary buffers are allocated as per num_rep
>>>>> size.
>>>>> (scratch array has size num_rep * 3) So, when number of osds to be
>>>>> selected is more, buffer overflow happens and it causes error/crash=
=2E I
>>>>> saw
>>>>> your earlier comment in this mail  where you asked to create a rule=

>>>>> that
>>>>> selects two osds per rack(2 racks) with num_rep=3D3. I feel that bu=
ffer
>>>>> overflow issue should happen in this situation too, that can cause
>>>>> 'out
>>>>> of
>>>>> array' access. Am I wrong somewhere or am I missing something?
>>>>>
>>>>> Johnu
>>>>>
>>>>> On 9/16/14, 9:39 AM, "Daniel Swarbrick"
>>>>> <daniel.swarbrick@profitbricks.com> wrote:
>>>>>
>>>>>> Hi Loic,
>>>>>>
>>>>>> Thanks for providing a detailed example. I'm able to run the examp=
le
>>>>>> that you provide, and also got my own live crushmap to produce som=
e
>>>>>> results, when I appended the "--num-rep 3" option to the command.
>>>>>> Without that option, even your example is throwing segfaults - may=
be
>>>>>> a
>>>>>> bug in crushtool?
>>>>>>
>>>>>> One other area I wasn't sure about - can the final "chooseleaf" st=
ep
>>>>>> specify "firstn 0" for simplicity's sake (and to automatically
>>>>>> handle a
>>>>>> larger pool size in future) ? Would there be any downside to this?=

>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>> On 16/09/14 16:20, Loic Dachary wrote:
>>>>>>> Hi Daniel,
>>>>>>>
>>>>>>> When I run
>>>>>>>
>>>>>>> crushtool --outfn crushmap --build --num_osds 100 host straw 2 ra=
ck
>>>>>>> straw 10 default straw 0
>>>>>>> crushtool -d crushmap -o crushmap.txt
>>>>>>> cat >> crushmap.txt <<EOF
>>>>>>> rule myrule {
>>>>>>> 	ruleset 1
>>>>>>> 	type replicated
>>>>>>> 	min_size 1
>>>>>>> 	max_size 10
>>>>>>> 	step take default
>>>>>>> 	step choose firstn 2 type rack
>>>>>>> 	step chooseleaf firstn 2 type host
>>>>>>> 	step emit
>>>>>>> }
>>>>>>> EOF
>>>>>>> crushtool -c crushmap.txt -o crushmap
>>>>>>> crushtool -i crushmap --test --show-utilization --rule 1 --min-x =
1
>>>>>>> --max-x 10 --num-rep 3
>>>>>>>
>>>>>>> I get
>>>>>>>
>>>>>>> rule 1 (myrule), x =3D 1..10, numrep =3D 3..3
>>>>>>> CRUSH rule 1 x 1 [79,69,10]
>>>>>>> CRUSH rule 1 x 2 [56,58,60]
>>>>>>> CRUSH rule 1 x 3 [30,26,19]
>>>>>>> CRUSH rule 1 x 4 [14,8,69]
>>>>>>> CRUSH rule 1 x 5 [7,4,88]
>>>>>>> CRUSH rule 1 x 6 [54,52,37]
>>>>>>> CRUSH rule 1 x 7 [69,67,19]
>>>>>>> CRUSH rule 1 x 8 [51,46,83]
>>>>>>> CRUSH rule 1 x 9 [55,56,35]
>>>>>>> CRUSH rule 1 x 10 [54,51,95]
>>>>>>> rule 1 (myrule) num_rep 3 result size =3D=3D 3:	10/10
>>>>>>>
>>>>>>> What command are you running to get a core dump ?
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> On 16/09/2014 12:02, Daniel Swarbrick wrote:
>>>>>>>> On 15/09/14 17:28, Sage Weil wrote:
>>>>>>>>> rule myrule {
>>>>>>>>> 	ruleset 1
>>>>>>>>> 	type replicated
>>>>>>>>> 	min_size 1
>>>>>>>>> 	max_size 10
>>>>>>>>> 	step take default
>>>>>>>>> 	step choose firstn 2 type rack
>>>>>>>>> 	step chooseleaf firstn 2 type host
>>>>>>>>> 	step emit
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> That will give you 4 osds, spread across 2 hosts in each rack.
>>>>>>>>> The
>>>>>>>>> pool=20
>>>>>>>>> size (replication factor) is 3, so RADOS will just use the firs=
t
>>>>>>>>> three (2=20
>>>>>>>>> hosts in first rack, 1 host in second rack).
>>>>>>>> I have a similar requirement, where we currently have four nodes=
,
>>>>>>>> two
>>>>>>>> in
>>>>>>>> each fire zone, with pool size 3. At the moment, due to the numb=
er
>>>>>>>> of
>>>>>>>> nodes, we are guaranteed at least one replica in each fire zone
>>>>>>>> (which
>>>>>>>> we represent with bucket type "room"). If we add more nodes in
>>>>>>>> future,
>>>>>>>> the current ruleset may cause all three replicas of a PG to land=

>>>>>>>> in a
>>>>>>>> single zone.
>>>>>>>>
>>>>>>>> I tried the ruleset suggested above (replacing "rack" with "room=
"),
>>>>>>>> but
>>>>>>>> when testing it with crushtool --test --show-utilization, I simp=
ly
>>>>>>>> get
>>>>>>>> segfaults. No amount of fiddling around seems to make it work -
>>>>>>>> even
>>>>>>>> adding two new hypothetical nodes to the crushmap doesn't help.
>>>>>>>>
>>>>>>>> What could I perhaps be doing wrong?
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> ceph-users mailing list
>>>>>>>> ceph-users@lists.ceph.com
>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> ceph-users mailing list
>>>>>>> ceph-users@lists.ceph.com
>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> ceph-users mailing list
>>>>>> ceph-users@lists.ceph.com
>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>
>>>>
>>>> --=20
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>
>>>
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--8as3MFhUkVvUmNxdOQgBgXFacvJbuOnqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQZ6wEACgkQ8dLMyEl6F22j9gCgsQVujMqhzd/2hNGL8aTze8Ba
t1sAoL3m4IdxGkUhYT2miP0tCk+9kt0i
=Rtyr
-----END PGP SIGNATURE-----

--8as3MFhUkVvUmNxdOQgBgXFacvJbuOnqd--
