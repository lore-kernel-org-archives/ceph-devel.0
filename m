From: Samuel Just <sam.just@inktank.com>
Subject: Re: Improving latency and ordering of the backfilling workload
Date: Wed, 17 Dec 2014 16:54:23 -0800
Message-ID: <CA+4uBUbjvDSjibZquJqFEkcNiAohTgKSAPXJaZYvov86fXX=RQ@mail.gmail.com>
References: <548EEF2C.1010703@dachary.org>
	<alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net>
	<548F15E5.2030304@dachary.org>
	<alpine.DEB.2.00.1412150913400.5263@cobra.newdream.net>
	<548F1EDF.5020401@dachary.org>
	<alpine.DEB.2.00.1412150959150.22847@cobra.newdream.net>
	<548F24BA.8080401@dachary.org>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:40905 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaLRAyY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Dec 2014 19:54:24 -0500
Received: by mail-la0-f44.google.com with SMTP id gd6so154799lab.17
        for <ceph-devel@vger.kernel.org>; Wed, 17 Dec 2014 16:54:23 -0800 (PST)
In-Reply-To: <548F24BA.8080401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

I think the concern is that the priority information might be obsolete
by the time it gets the remote reservation.  We might need to refresh
the reservation periodically if, for example, the number of pgs
requiring backfill on a particular osd is increasing.
-Sam

On Mon, Dec 15, 2014 at 10:13 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 15/12/2014 19:03, Sage Weil wrote:
>> On Mon, 15 Dec 2014, Loic Dachary wrote:
>>> On 15/12/2014 18:20, Sage Weil wrote:
>>>> On Mon, 15 Dec 2014, Loic Dachary wrote:
>>>>> Hi Sage,
>>>>>
>>>>> On 15/12/2014 17:44, Sage Weil wrote:
>>>>>> On Mon, 15 Dec 2014, Loic Dachary wrote:
>>>>>>> Hi Sam,
>>>>>>>
>>>>>>> Here is what could be done (in the context of http://tracker.ce=
ph.com/issues/9566
>>>>>>> ), please let me know if that makes sense:
>>>>>>>
>>>>>>> * ordering:
>>>>>>>
>>>>>>>   * when dequeuing a pending local reservation, chose one that =
contains
>>>>>>> a PG that belongs to the busiest OSD (i.e. the OSD for which th=
ere are
>>>>>>> more PGs waiting for a local reservation than any other)
>>>>>>
>>>>>> I'm worried the reservation count won't be an accurate enough pr=
oxy for
>>>>>> the amount of work the remote OSD has to do.
>>>>>
>>>>> Are you thinking about taking into account the number and size of
>>>>> objects in a given PGs ? The length of the local reservation queu=
e
>>>>> accurately reflects the number of PGs that need work (because the=
 length
>>>>> of the reservation queue is not bounded). But it does not reflect=
 the
>>>>> content of the PGs at all, indeed.
>>>>
>>>> Including that information could help, yeah, but the main thing is=
 that
>>>> any estimate of "the busiest OSD" based on local information is go=
ing to
>>>> be weak if it's only based on info reservation requests.
>>>
>>> What other information would be relevant in addition to the number =
of
>>> PGs that need to backfill and their size (objects & bytes) ?
>>
>> Maybe the background client workload?  If an OSD is more heavily loa=
ded
>> than others than it should probably start it's recovery sooner as it=
s rate
>> of progress will be a bit lower.
>>
>>>> Unless that
>>>> information is refreshed periodically by the requesting OSD (I thi=
nk we
>>>> also discussed that a bit last week).
>>>
>>> I tried to take that into account by proposing to calculate the pri=
ority
>>> when the reservation is dequeued from the waiting list instead of w=
hen
>>> it is added to the waiting list. When the local reservation is dequ=
eued,
>>> it gets one of the osd_max_backfill slots in the AsyncReserver and =
will
>>> then get work to do : the delay between calculating the priority an=
d
>>> actual backfilling is minimum. The delay actually is the latency be=
tween
>>> when the remote reservation is sent and when it comes back successf=
ully.
>>> By adding the priority to the remote reservation request, we make t=
he
>>> peer OSD aware of the local priority and compare it with the priori=
ty of
>>> the other OSDs asking for a remote reservation. The peer OSD will b=
e
>>> grant us a remote reservation quickly if we are the OSD declaring t=
o
>>> have most work to do.
>>>
>>> I sense you have something else in mind in terms of algorithm and/o=
r
>>> data sources. Hopefully this explanation will allow you to see what=
 I'm
>>> missing and guide me ;-)
>>
>> Oh, I see.  That sounds very reasonable.  I suspect even with this
>> approach though it will help to periodically refresh that reservatio=
n,
>> though, as the remote OSD may have lots of people contending for rec=
overy.
>> Whoever is not first in line will be there for a while and their pri=
ority
>> will likely be less than accurate by the time the next item is deque=
ued
>> there?
>
> The priority is attached to each reservation and is relative to one P=
G reservation request. The remote reservation priority will be reconsid=
ered each time a new PG asks for a remote reservation (because it will =
use the priority queues of the AsyncReserver). If we want to revise the=
 priority during the backfilling of a given PG that already has a local=
+remote slot allocated to it, it means we should periodically consider =
cancelling an on going backfill operation to give a chance to an other,=
 maybe busier, OSD.
>
> Am I following ?
>
>>
>> Sorry if my drive-by suggestions aren't helping; I'm only half follo=
wing
>> this discussion!
>
> It's helping a lot !
>
>> sage
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
