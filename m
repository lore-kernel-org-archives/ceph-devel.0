From: "Johnu George (johnugeo)" <johnugeo@cisco.com>
Subject: Re: [ceph-users] Crushmap ruleset for rack aware PG placement
Date: Wed, 17 Sep 2014 14:42:45 +0000
Message-ID: <D03EEB71.BBF%johnugeo@cisco.com>
References: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg@mail.gmail.com>
 <alpine.DEB.2.00.1409150826060.513@cobra.newdream.net>
 <lv91s9$4j2$1@ger.gmane.org> <54184711.3080002@dachary.org>
 <lv9p5b$1h1$1@ger.gmane.org> <D03E84B7.B8D%johnugeo@cisco.com>
 <541945F8.60001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:52029 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbaIQOmr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 10:42:47 -0400
In-Reply-To: <541945F8.60001@dachary.org>
Content-Language: en-US
Content-ID: <E077811EFF251B46A5A6601BDAC68A5F@emea.cisco.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <loic@dachary.org>

Adding ceph-devel=20

On 9/17/14, 1:27 AM, "Loic Dachary" <loic@dachary.org> wrote:

>
>Could you resend with ceph-devel in cc ? It's better for archive purpo=
ses
>;-)
>
>On 17/09/2014 09:37, Johnu George (johnugeo) wrote:
>> Hi Sage,
>>          I was looking at the crash that was reported in this mail
>>chain.
>> I am seeing that the crash happens when number of replicas configure=
d is
>> less than total number of osds to be selected as per rule. This is
>> because, the crush temporary buffers are allocated as per num_rep si=
ze.
>> (scratch array has size num_rep * 3) So, when number of osds to be
>> selected is more, buffer overflow happens and it causes error/crash.=
 I
>>saw
>> your earlier comment in this mail  where you asked to create a rule =
that
>> selects two osds per rack(2 racks) with num_rep=3D3. I feel that buf=
fer
>> overflow issue should happen in this situation too, that can cause '=
out
>>of
>> array' access. Am I wrong somewhere or am I missing something?
>>=20
>> Johnu
>>=20
>> On 9/16/14, 9:39 AM, "Daniel Swarbrick"
>> <daniel.swarbrick@profitbricks.com> wrote:
>>=20
>>> Hi Loic,
>>>
>>> Thanks for providing a detailed example. I'm able to run the exampl=
e
>>> that you provide, and also got my own live crushmap to produce some
>>> results, when I appended the "--num-rep 3" option to the command.
>>> Without that option, even your example is throwing segfaults - mayb=
e a
>>> bug in crushtool?
>>>
>>> One other area I wasn't sure about - can the final "chooseleaf" ste=
p
>>> specify "firstn 0" for simplicity's sake (and to automatically hand=
le a
>>> larger pool size in future) ? Would there be any downside to this?
>>>
>>> Cheers
>>>
>>> On 16/09/14 16:20, Loic Dachary wrote:
>>>> Hi Daniel,
>>>>
>>>> When I run
>>>>
>>>> crushtool --outfn crushmap --build --num_osds 100 host straw 2 rac=
k
>>>> straw 10 default straw 0
>>>> crushtool -d crushmap -o crushmap.txt
>>>> cat >> crushmap.txt <<EOF
>>>> rule myrule {
>>>> 	ruleset 1
>>>> 	type replicated
>>>> 	min_size 1
>>>> 	max_size 10
>>>> 	step take default
>>>> 	step choose firstn 2 type rack
>>>> 	step chooseleaf firstn 2 type host
>>>> 	step emit
>>>> }
>>>> EOF
>>>> crushtool -c crushmap.txt -o crushmap
>>>> crushtool -i crushmap --test --show-utilization --rule 1 --min-x 1
>>>> --max-x 10 --num-rep 3
>>>>
>>>> I get
>>>>
>>>> rule 1 (myrule), x =3D 1..10, numrep =3D 3..3
>>>> CRUSH rule 1 x 1 [79,69,10]
>>>> CRUSH rule 1 x 2 [56,58,60]
>>>> CRUSH rule 1 x 3 [30,26,19]
>>>> CRUSH rule 1 x 4 [14,8,69]
>>>> CRUSH rule 1 x 5 [7,4,88]
>>>> CRUSH rule 1 x 6 [54,52,37]
>>>> CRUSH rule 1 x 7 [69,67,19]
>>>> CRUSH rule 1 x 8 [51,46,83]
>>>> CRUSH rule 1 x 9 [55,56,35]
>>>> CRUSH rule 1 x 10 [54,51,95]
>>>> rule 1 (myrule) num_rep 3 result size =3D=3D 3:	10/10
>>>>
>>>> What command are you running to get a core dump ?
>>>>
>>>> Cheers
>>>>
>>>> On 16/09/2014 12:02, Daniel Swarbrick wrote:
>>>>> On 15/09/14 17:28, Sage Weil wrote:
>>>>>> rule myrule {
>>>>>> 	ruleset 1
>>>>>> 	type replicated
>>>>>> 	min_size 1
>>>>>> 	max_size 10
>>>>>> 	step take default
>>>>>> 	step choose firstn 2 type rack
>>>>>> 	step chooseleaf firstn 2 type host
>>>>>> 	step emit
>>>>>> }
>>>>>>
>>>>>> That will give you 4 osds, spread across 2 hosts in each rack.  =
The
>>>>>> pool=20
>>>>>> size (replication factor) is 3, so RADOS will just use the first
>>>>>> three (2=20
>>>>>> hosts in first rack, 1 host in second rack).
>>>>> I have a similar requirement, where we currently have four nodes,=
 two
>>>>> in
>>>>> each fire zone, with pool size 3. At the moment, due to the numbe=
r of
>>>>> nodes, we are guaranteed at least one replica in each fire zone
>>>>>(which
>>>>> we represent with bucket type "room"). If we add more nodes in
>>>>>future,
>>>>> the current ruleset may cause all three replicas of a PG to land =
in a
>>>>> single zone.
>>>>>
>>>>> I tried the ruleset suggested above (replacing "rack" with "room"=
),
>>>>>but
>>>>> when testing it with crushtool --test --show-utilization, I simpl=
y
>>>>>get
>>>>> segfaults. No amount of fiddling around seems to make it work - e=
ven
>>>>> adding two new hypothetical nodes to the crushmap doesn't help.
>>>>>
>>>>> What could I perhaps be doing wrong?
>>>>>
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users@lists.ceph.com
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20
>
>--=20
>Lo=EFc Dachary, Artisan Logiciel Libre
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
