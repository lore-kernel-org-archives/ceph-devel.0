From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Mon, 15 Apr 2013 09:42:23 -0700
Message-ID: <CAPYLRzgB_NiMJJh06Htpsxq_NbwY041uS2rhEOphcjK6gORmrg@mail.gmail.com>
References: <loom.20130412T055215-88@post.gmane.org>
	<51683184.9010301@inktank.com>
	<CAPYLRzh669x=0xb9YGVkzEObGXheHd2o2LPpwU3Cwhfnzsb5ng@mail.gmail.com>
	<0444D343-5F96-49E9-9FCE-1C223129A3B1@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:43910 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab3DOQm0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 12:42:26 -0400
Received: by mail-qa0-f44.google.com with SMTP id j8so541081qah.10
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 09:42:23 -0700 (PDT)
In-Reply-To: <0444D343-5F96-49E9-9FCE-1C223129A3B1@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, this is very much like DreamHost is doing with their
DreamCompute installation (you can find some talks about it online, I
believe, though I'm not sure how much detail they include there versus
in the Q&As).

On Fri, Apr 12, 2013 at 7:32 PM, Chen, Xiaoxi <xiaoxi.chen@intel.com> w=
rote:
> We are also discussing this internally, and come out with an idea to =
walk around it(Only for RBD case,havent think about Obj store),but not =
yet tested.  If Mark and Greg can provide some feedback,that would be g=
reat.
>
> We are trying to write a script to generate some pools,for rack A,the=
re is a pool A,which defined the crush ruleset to choose Osd in rackA a=
s the primary.so if we have 10 racks,we will have 10 pools and 10 rules=
=2E
>
> When the VM migrated to other rack,or the volume be detached and atta=
ched to another VM hosted in other rack,a data migration is needed.we a=
re thinking about how to smooth such migration

This is one of the use cases that layering is designed to handle (in
addition to standard cloning and snapshots). Just create a clone that
lives in the new pool, and either let it copy-up to the new position
lazily or run the command at a time when you know your network is less
busy.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

>
> =B7=A2=D7=D4=CE=D2=B5=C4 iPhone
>
> =D4=DA 2013-4-13=A3=AC0:20=A3=AC"Gregory Farnum" <greg@inktank.com> =D0=
=B4=B5=C0=A3=BA
>
>> I was in the middle of writing a response to this when Mark's email
>> came in, so I'll just add a few things:
>>
>> On Fri, Apr 12, 2013 at 9:08 AM, Mark Nelson <mark.nelson@inktank.co=
m> wrote:
>>> On 04/11/2013 10:59 PM, Matthias Urlichs wrote:
>>>>
>>>> As I understand it, in Ceph one can cluster storage nodes, but oth=
erwise
>>>> every node is essentially identical, so if three storage nodes hav=
e a
>>>> file,
>>>> ceph randomly uses one of them.
>>>
>>>
>>> Ceph clusters have the concept of pools, where each pool has a cert=
ain
>>> number of placement groups.  Placement groups are just collections =
of
>>> mappings to OSDs.  Each PG has a primary OSD and a number of second=
ary ones,
>>> based on the replication level you set when you make the pool. When=
 an
>>> object gets written to the cluster, CRUSH will determine which PG t=
he data
>>> should be sent to.  The data will first hit the primary OSD and the=
n
>>> replicated out to the other OSDs in the same placement group.
>>>
>>> Currently reads always come from the primary OSD in the placement g=
roup
>>> rather than a secondary even if the secondary is closer to the clie=
nt. I'm
>>> guessing there are probably some tricks that could be played here t=
o best
>>> determine which machines should service which clients, but it's not=
 exactly
>>> an easy problem.  In many cases spreading reads out over all of the=
 OSDs in
>>> the cluster is better than trying to optimize reads to only hit loc=
al OSDs.
>>> Ideally you probably want to prefer local OSDs first, but not exclu=
sively.
>>
>> In addition to just determining the locality (which we've started on
>> via external interfaces), this has a number of consistency challenge=
s
>> associated with it. The infrastructure we have to allow reading from
>> non-primaries tends to involve clients having different consistency
>> expectations, and it's not fully explored yet or set up so that
>> clients can choose to read from a specific non-primary =A1=AA the op=
tions
>> currently are "local if available and we can tell", "random", and
>> "primary".
>>
>>
>>>> This is not efficient use of network resources in a distributed da=
ta
>>>> center.
>>>> Or even in a multi-rack situation.
>>>>
>>>> I want to prefer accessing nodes which are "local".
>>>> The client in rack A should prefer to read from the storage nodes =
that are
>>>> also in rack A.
>>>> Ditto for rack B.
>>>> Ditto for s/rack/data center/.
>>
>> I do want to ask if you're sure this is as useful as you think it is=
=2E
>> There are use cases where it would be, but since writes have to
>> traverse these links (at a multiple of the actual write count) as we=
ll
>> you should be very certain. :)
>>
>>>> As far as I understand, the Ceph clients can't do that.
>>>> (Nor can Ceph nodes among each other, but I care less about that, =
as most
>>>> traffic is reading data.)
>>>>
>>>> I think this is an important feature for many high-reliability sit=
uations.
>>>>
>>>> What would be the next steps to get this feature, assuming I don't=
 have
>>>> time
>>>> to implement it myself? Persistently annoy this mailing list that =
people
>>>> need it? Offer to pay for implementing it? Shut up and look for so=
me other
>>>> solution -- which I already did, but I didn't find any that's as g=
ood as
>>>> Ceph, otherwise?
>>>
>>>
>>> I don't really have that much insight into the product roadmap, but=
 I assume
>>> that if you spoke to some of our business folks about paying for de=
velopment
>>> work you'd at least get a response.
>>
>> Yeah. It's not a feature in large enough demand right now that we ca=
n
>> see to be worth bumping up over other things, but I don't think
>> anybody's opposed to it existing. As with Mark I have no idea if
>> you're best off asking us or others to do things for money, but it
>> would certainly have to go through business channels. (If somebody
>> outside Inktank did want to implement this feature, I'd love to talk
>> to them about it on an informal but ongoing basis during development=
=2E)
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
