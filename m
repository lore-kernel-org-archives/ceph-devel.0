From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: [ceph-users] Crushmap ruleset for rack aware PG placement
Date: Thu, 18 Sep 2014 02:03:36 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC020BD242@shsmsx102.ccr.corp.intel.com>
References: <CADgBPFCVUVQZtHNkSsuMhskL2X-FTBTYy6zcav3CRpNCBGHJgg@mail.gmail.com>
 <alpine.DEB.2.00.1409150826060.513@cobra.newdream.net>
 <lv91s9$4j2$1@ger.gmane.org> <54184711.3080002@dachary.org>
 <lv9p5b$1h1$1@ger.gmane.org> <D03E84B7.B8D%johnugeo@cisco.com>
 <541945F8.60001@dachary.org> <D03EEB71.BBF%johnugeo@cisco.com>
 <5419B25B.3010508@dachary.org> <D03F35D4.BDC%johnugeo@cisco.com>
 <5419EB00.70307@dachary.org> <D03F5B09.BFE%johnugeo@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33367 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755705AbaIRCDs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 22:03:48 -0400
In-Reply-To: <D03F5B09.BFE%johnugeo@cisco.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Johnu George (johnugeo)" <johnugeo@cisco.com>, Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

The rule has max_size, can we just use that value?

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Johnu George (johnugeo)
Sent: Thursday, September 18, 2014 6:41 AM
To: Loic Dachary; ceph-devel
Subject: Re: [ceph-users] Crushmap ruleset for rack aware PG placement

In such a case, we can initialize scratch array in
crush/CrushWrapper.h#L919 with maximum number of osds that can be selec=
ted. Since we know the rule no, it should be possible to calculate the =
maximum osds that can be selected.

Johnu

On 9/17/14, 1:11 PM, "Loic Dachary" <loic@dachary.org> wrote:

>
>
>On 17/09/2014 22:03, Johnu George (johnugeo) wrote:
>> Loic,
>>       You are right.  Are we planning to support configurations wher=
e =20
>>replica number is different from the number of osds selected from a=20
>>rule?
>
>I think crush should support it, yes. If a rule can provide 10 OSDs=20
>there is no reason for it to fail to provide just one.
>
>Cheers
>
>> If not, One solution is to add a validation check when a rule is=20
>>activated  for a pool of a specific replica.
>>=20
>> Johnu
>>=20
>> On 9/17/14, 9:10 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>=20
>>> Hi,
>>>
>>> If the number of replica desired is 1, then
>>>
>>> https://github.com/ceph/ceph/blob/firefly/src/crush/CrushWrapper.h#=
L
>>> 915
>>>
>>> will be called with maxout =3D 1 and scratch will be maxout * 3. Bu=
t=20
>>>if the  rule always selects 4 items, then it overflows. Is it what=20
>>>you also read ?
>>>
>>> Cheers
>>>
>>> On 17/09/2014 16:42, Johnu George (johnugeo) wrote:
>>>> Adding ceph-devel
>>>>
>>>> On 9/17/14, 1:27 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>>>
>>>>>
>>>>> Could you resend with ceph-devel in cc ? It's better for archive=20
>>>>> purposes
>>>>> ;-)
>>>>>
>>>>> On 17/09/2014 09:37, Johnu George (johnugeo) wrote:
>>>>>> Hi Sage,
>>>>>>          I was looking at the crash that was reported in this=20
>>>>>>mail  chain.
>>>>>> I am seeing that the crash happens when number of replicas=20
>>>>>>configured  is  less than total number of osds to be selected as=20
>>>>>>per rule. This is  because, the crush temporary buffers are=20
>>>>>>allocated as per num_rep  size.
>>>>>> (scratch array has size num_rep * 3) So, when number of osds to=20
>>>>>>be  selected is more, buffer overflow happens and it causes=20
>>>>>>error/crash. I  saw  your earlier comment in this mail  where you=
=20
>>>>>>asked to create a rule  that  selects two osds per rack(2 racks)=20
>>>>>>with num_rep=3D3. I feel that buffer  overflow issue should happe=
n=20
>>>>>>in this situation too, that can cause  'out  of  array' access. A=
m=20
>>>>>>I wrong somewhere or am I missing something?
>>>>>>
>>>>>> Johnu
>>>>>>
>>>>>> On 9/16/14, 9:39 AM, "Daniel Swarbrick"
>>>>>> <daniel.swarbrick@profitbricks.com> wrote:
>>>>>>
>>>>>>> Hi Loic,
>>>>>>>
>>>>>>> Thanks for providing a detailed example. I'm able to run the=20
>>>>>>>example  that you provide, and also got my own live crushmap to=20
>>>>>>>produce some  results, when I appended the "--num-rep 3" option=20
>>>>>>>to the command.
>>>>>>> Without that option, even your example is throwing segfaults -=20
>>>>>>>maybe  a  bug in crushtool?
>>>>>>>
>>>>>>> One other area I wasn't sure about - can the final "chooseleaf"
>>>>>>>step
>>>>>>> specify "firstn 0" for simplicity's sake (and to automatically =
=20
>>>>>>>handle a  larger pool size in future) ? Would there be any=20
>>>>>>>downside to this?
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> On 16/09/14 16:20, Loic Dachary wrote:
>>>>>>>> Hi Daniel,
>>>>>>>>
>>>>>>>> When I run
>>>>>>>>
>>>>>>>> crushtool --outfn crushmap --build --num_osds 100 host straw 2=
=20
>>>>>>>>rack  straw 10 default straw 0  crushtool -d crushmap -o=20
>>>>>>>>crushmap.txt  cat >> crushmap.txt <<EOF  rule myrule {
>>>>>>>> 	ruleset 1
>>>>>>>> 	type replicated
>>>>>>>> 	min_size 1
>>>>>>>> 	max_size 10
>>>>>>>> 	step take default
>>>>>>>> 	step choose firstn 2 type rack
>>>>>>>> 	step chooseleaf firstn 2 type host
>>>>>>>> 	step emit
>>>>>>>> }
>>>>>>>> EOF
>>>>>>>> crushtool -c crushmap.txt -o crushmap  crushtool -i crushmap=20
>>>>>>>>--test --show-utilization --rule 1 --min-x 1  --max-x 10=20
>>>>>>>>--num-rep 3
>>>>>>>>
>>>>>>>> I get
>>>>>>>>
>>>>>>>> rule 1 (myrule), x =3D 1..10, numrep =3D 3..3 CRUSH rule 1 x 1=
=20
>>>>>>>> [79,69,10] CRUSH rule 1 x 2 [56,58,60] CRUSH rule 1 x 3=20
>>>>>>>> [30,26,19] CRUSH rule 1 x 4 [14,8,69] CRUSH rule 1 x 5 [7,4,88=
]=20
>>>>>>>> CRUSH rule 1 x 6 [54,52,37] CRUSH rule 1 x 7 [69,67,19] CRUSH=20
>>>>>>>> rule 1 x 8 [51,46,83] CRUSH rule 1 x 9 [55,56,35] CRUSH rule 1=
=20
>>>>>>>> x 10 [54,51,95]
>>>>>>>> rule 1 (myrule) num_rep 3 result size =3D=3D 3:	10/10
>>>>>>>>
>>>>>>>> What command are you running to get a core dump ?
>>>>>>>>
>>>>>>>> Cheers
>>>>>>>>
>>>>>>>> On 16/09/2014 12:02, Daniel Swarbrick wrote:
>>>>>>>>> On 15/09/14 17:28, Sage Weil wrote:
>>>>>>>>>> rule myrule {
>>>>>>>>>> 	ruleset 1
>>>>>>>>>> 	type replicated
>>>>>>>>>> 	min_size 1
>>>>>>>>>> 	max_size 10
>>>>>>>>>> 	step take default
>>>>>>>>>> 	step choose firstn 2 type rack
>>>>>>>>>> 	step chooseleaf firstn 2 type host
>>>>>>>>>> 	step emit
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> That will give you 4 osds, spread across 2 hosts in each rac=
k.
>>>>>>>>>> The
>>>>>>>>>> pool
>>>>>>>>>> size (replication factor) is 3, so RADOS will just use the=20
>>>>>>>>>> first three (2 hosts in first rack, 1 host in second rack).
>>>>>>>>> I have a similar requirement, where we currently have four=20
>>>>>>>>>nodes,  two  in  each fire zone, with pool size 3. At the=20
>>>>>>>>>moment, due to the number  of  nodes, we are guaranteed at=20
>>>>>>>>>least one replica in each fire zone  (which  we represent with=
=20
>>>>>>>>>bucket type "room"). If we add more nodes in  future,  the=20
>>>>>>>>>current ruleset may cause all three replicas of a PG to land =20
>>>>>>>>>in a  single zone.
>>>>>>>>>
>>>>>>>>> I tried the ruleset suggested above (replacing "rack" with=20
>>>>>>>>>"room"),  but  when testing it with crushtool --test=20
>>>>>>>>>--show-utilization, I simply  get  segfaults. No amount of=20
>>>>>>>>>fiddling around seems to make it work -  even  adding two new=20
>>>>>>>>>hypothetical nodes to the crushmap doesn't help.
>>>>>>>>>
>>>>>>>>> What could I perhaps be doing wrong?
>>>>>>>>>
>>>>>>>>> _______________________________________________
>>>>>>>>> ceph-users mailing list
>>>>>>>>> ceph-users@lists.ceph.com
>>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> ceph-users mailing list
>>>>>>>> ceph-users@lists.ceph.com
>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> ceph-users mailing list
>>>>>>> ceph-users@lists.ceph.com
>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>
>>>>>
>>>>> --
>>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>>
>>>>
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>=20
>
>--
>Lo=EFc Dachary, Artisan Logiciel Libre
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
