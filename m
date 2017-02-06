From: Dan van der Ster <dan@vanderster.com>
Subject: Re: crush multipick anomaly
Date: Mon, 6 Feb 2017 17:53:00 +0100
Message-ID: <CABZ+qq=hVXfV=FVpaje=2oR57W6zWsLH6mpZgTNd+MRfCESqrw@mail.gmail.com>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <e5f376bb-925b-17df-ae6e-abc07058f67b@dachary.org> <6a7b52c8-a0fd-41a6-fbf1-fb2af3e347d8@dachary.org>
 <alpine.DEB.2.11.1702031443400.3654@piezo.novalocal> <CABZ+qqn13kR+4FjSmWKgt4Fee0+8B2Gi-qJjT8MaXpu2e6=2Ew@mail.gmail.com>
 <CABZ+qqnHh+iJFbaLE7b-Kn4VSidHrDT8LuW4oB5wDD3=c=QG3Q@mail.gmail.com>
 <267c8448-a3f0-e21e-f5e6-dffb3ffdf836@dachary.org> <CABZ+qq=E783Uma3jvBoDKP_ni6q09XcyZjK3jNOcu+BzEo+eoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33587 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdBFQxo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 11:53:44 -0500
Received: by mail-wr0-f180.google.com with SMTP id i10so24678323wrb.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 08:53:43 -0800 (PST)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id v67sm2421342wrc.45.2017.02.06.08.53.41
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 08:53:42 -0800 (PST)
Received: by mail-wm0-f42.google.com with SMTP id c85so128607536wmi.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 08:53:41 -0800 (PST)
In-Reply-To: <CABZ+qq=E783Uma3jvBoDKP_ni6q09XcyZjK3jNOcu+BzEo+eoQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Szymon Datko <szymon.datko@gmail.com>, Tomasz Kuzemko <tomasz@kuzemko.net>

On Mon, Feb 6, 2017 at 10:13 AM, Dan van der Ster <dan@vanderster.com> wrot=
e:
> Hi Loic,
>
> Here's my current understanding of the problem. (Below I work with the
> example having four OSDs with weights 3, 3, 3, 1, respectively).
>
> I'm elaborating on the observation that for every replication "round",
> the PG ratios for each and every OSD must be equal to the "target" or
> goal weight of that OSD. So, for an OSD that should get 10% of PGs,
> that OSD gets 10% in round 1, 10% in round 2, etc... But we need to
> multiply each of these ratios by the probability that this OSD is
> still available in Round r.
>
> Hence I believe we have this loop invariant:
>
>    P(OSD.x still available in Round r) * (Weight of OSD.x in Round r)
> / (Total sum of all weights in Round r) =3D=3D (Original "target" Weight
> of OSD.x) / (Total sum of all target weights)
>
> I simplify all these terms:
>   P(OSD.x still available for Round r) =3D P_x_r
>   Weight of OSD.x in Round r =3D W_x_r
>   Total sum of all weights in Round r =3D T_r
>   Original "target" Weight of OSD.x =3D W_x
>   Total sum of all target weights =3D T
>
> So rewriting the equation, we have:
>
>   P_x_r * W_x_r / T_r =3D=3D W_x / T
>
> We then calculate the needed weight of OSD.x in Round r. W_x_r is what
> we're trying to solve for!!
>
>   W_x_r =3D W_x / T  *  T_r / P_x_r
>
> The first term W_x / T is a constant and easy to compute. (For my
> example small OSD, W_x / T =3D 0.1)
>
> P_x_r is also -- I believe -- simple to compute. P_x_r gets smaller
> for each round and is a function of what happened in the previous
> round:
>
>   Round 1: P_x_1 =3D 1.0
>   Round 2: P_x_2 =3D P_x_1 * (1 - W_x_1 / T_1)
>   Round 3: P_x_3 =3D P_x_2 * (1 - W_x_2 / T_2)
>   ...
>
> But T_r is a challenge -- T_r is the sum of W_x_r for all x in round
> r. Hence, the problem is that we don't know T_r until *after* we
> compute all W_x_r's for that round. I tried various ways to estimate
> T_r but didn't make any progress.
>
> Do you think this formulation is correct? Any clever ideas where to go ne=
xt?
>

Something is wrong, because the system of equations that this gives is
unsolvable.

In round 2 for the 3,3,3,1 OSD set, assuming the first, weight 3,
OSD.0 was chosen in the first round, we have:

P_1_2 =3D (1-3/10) =3D 0.7
P_2_2 =3D (1-3/10) =3D 0.7
P_3_2 =3D (1-1/10) =3D 0.9

And we know:

W_1 / T =3D 3/10 =3D 0.3
W_2 / T =3D 3/10 =3D 0.3
W_3 / T =3D 1/10 =3D 0.1

So we can describe the whole round:

W_1_2 =3D W_1 / T * T_2 / P_1_2 =3D 0.3 * T_2 / 0.7 =3D 0.4286 T_2
W_2_2 =3D W_2 / T * T_2 / P_2_2 =3D 0.3 * T_2 / 0.7 =3D 0.4286 T_2
W_3_2 =3D W_3 / T * T_2 / P_3_2 =3D 0.1 * T_2 / 0.9 =3D 0.1111 T_2
W_1_2 + W_2_2 + W_3_2 =3D T_2

Putting this all into a solver gives 0.9683 * T_2 =3D T_2, which is nonsens=
e.

-- Dan

> Cheers, Dan
>
>
>
>
> On Mon, Feb 6, 2017 at 9:31 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Dan,
>>
>> Your script turns out to be a nice self contained problem statement :-) =
Tomasz & Szymon discussed it today @ FOSDEM and I was enlightened by the wa=
y Szymon described how to calculate P(E|A) using a probability tree (see th=
e picture at http://dachary.org/loic/crush-probability-schema.jpg).
>>
>> Cheers
>>
>> On 02/03/2017 06:37 PM, Dan van der Ster wrote:
>>> Anyway, here's my simple simulation. It might be helpful for testing
>>> ideas quickly: https://gist.github.com/anonymous/929d799d5f80794b293783=
acb9108992
>>>
>>> Below is the output using the P(pick small | first pick not small)
>>> observation, using OSDs having weights 3, 3, 3, & 1 respectively. It
>>> seems to *almost* work, but only when we have just one small OSD.
>>>
>>> See the end of the script for other various ideas.
>>>
>>> -- Dan
>>>
>>>> python mpa.py
>>> OSDs (id: weight): {0: 3, 1: 3, 2: 3, 3: 1}
>>>
>>> Expected PGs per OSD:       {0: 90000, 1: 90000, 2: 90000, 3: 30000}
>>>
>>> Simulating with existing CRUSH
>>>
>>> Observed:                   {0: 85944, 1: 85810, 2: 85984, 3: 42262}
>>> Observed for Nth replica:   [{0: 29936, 1: 30045, 2: 30061, 3: 9958},
>>> {0: 29037, 1: 29073, 2: 29041, 3: 12849}, {0: 26971, 1: 26692, 2:
>>> 26882, 3: 19455}]
>>>
>>> Now trying your new algorithm
>>>
>>> Observed:                   {0: 89423, 1: 89443, 2: 89476, 3: 31658}
>>> Observed for Nth replica:   [{0: 30103, 1: 30132, 2: 29805, 3: 9960},
>>> {0: 29936, 1: 29964, 2: 29796, 3: 10304}, {0: 29384, 1: 29347, 2:
>>> 29875, 3: 11394}]
>>>
>>>
>>> On Fri, Feb 3, 2017 at 4:26 PM, Dan van der Ster <dan@vanderster.com> w=
rote:
>>>> On Fri, Feb 3, 2017 at 3:47 PM, Sage Weil <sweil@redhat.com> wrote:
>>>>> On Fri, 3 Feb 2017, Loic Dachary wrote:
>>>>>> On 01/26/2017 12:13 PM, Loic Dachary wrote:
>>>>>>> Hi Sage,
>>>>>>>
>>>>>>> Still trying to understand what you did :-) I have one question bel=
ow.
>>>>>>>
>>>>>>> On 01/26/2017 04:05 AM, Sage Weil wrote:
>>>>>>>> This is a longstanding bug,
>>>>>>>>
>>>>>>>>    http://tracker.ceph.com/issues/15653
>>>>>>>>
>>>>>>>> that causes low-weighted devices to get more data than they should=
. Loic's
>>>>>>>> recent activity resurrected discussion on the original PR
>>>>>>>>
>>>>>>>>    https://github.com/ceph/ceph/pull/10218
>>>>>>>>
>>>>>>>> but since it's closed and almost nobody will see it I'm moving the
>>>>>>>> discussion here.
>>>>>>>>
>>>>>>>> The main news is that I have a simple adjustment for the weights t=
hat
>>>>>>>> works (almost perfectly) for the 2nd round of placements.  The sol=
ution is
>>>>>>>> pretty simple, although as with most probabilities it tends to mak=
e my
>>>>>>>> brain hurt.
>>>>>>>>
>>>>>>>> The idea is that, on the second round, the original weight for the=
 small
>>>>>>>> OSD (call it P(pick small)) isn't what we should use.  Instead, we=
 want
>>>>>>>> P(pick small | first pick not small).  Since P(a|b) (the probabili=
ty of a
>>>>>>>> given b) is P(a && b) / P(b),
>>>>>>>
>>>>>>> >From the record this is explained at https://en.wikipedia.org/wiki=
/Conditional_probability#Kolmogorov_definition
>>>>>>>
>>>>>>>>
>>>>>>>>  P(pick small | first pick not small)
>>>>>>>>  =3D P(pick small && first pick not small) / P(first pick not smal=
l)
>>>>>>>>
>>>>>>>> The last term is easy to calculate,
>>>>>>>>
>>>>>>>>  P(first pick not small) =3D (total_weight - small_weight) / total=
_weight
>>>>>>>>
>>>>>>>> and the && term is the distribution we're trying to produce.
>>>>>>>
>>>>>>> https://en.wikipedia.org/wiki/Conditional_probability describs A &&=
 B (using a non ascii symbol...) as the "probability of the joint of events=
 A and B". I don't understand what that means. Is there a definition somewh=
ere ?
>>>>>>>
>>>>>>>> For exmaple,
>>>>>>>> if small has 1/10 the weight, then we should see 1/10th of the PGs=
 have
>>>>>>>> their second replica be the small OSD.  So
>>>>>>>>
>>>>>>>>  P(pick small && first pick not small) =3D small_weight / total_we=
ight
>>>>>>>>
>>>>>>>> Putting those together,
>>>>>>>>
>>>>>>>>  P(pick small | first pick not small)
>>>>>>>>  =3D P(pick small && first pick not small) / P(first pick not smal=
l)
>>>>>>>>  =3D (small_weight / total_weight) / ((total_weight - small_weight=
) / total_weight)
>>>>>>>>  =3D small_weight / (total_weight - small_weight)
>>>>>>>>
>>>>>>>> This is, on the second round, we should adjust the weights by the =
above so
>>>>>>>> that we get the right distribution of second choices.  It turns ou=
t it
>>>>>>>> works to adjust *all* weights like this to get hte conditional pro=
bability
>>>>>>>> that they weren't already chosen.
>>>>>>>>
>>>>>>>> I have a branch that hacks this into straw2 and it appears to work
>>>>>>>
>>>>>>> This is https://github.com/liewegas/ceph/commit/wip-crush-multipick
>>>>>>
>>>>>> In
>>>>>>
>>>>>> https://github.com/liewegas/ceph/commit/wip-crush-multipick#diff-0df=
13ad294f6585c322588cfe026d701R316
>>>>>>
>>>>>> double neww =3D oldw / (bucketw - oldw) * bucketw;
>>>>>>
>>>>>> I don't get why we need  "* bucketw" at the end ?
>>>>>
>>>>> It's just to keep the values within a reasonable range so that we don=
't
>>>>> lose precision by dropping down into small integers.
>>>>>
>>>>> I futzed around with this some more last week trying to get the third
>>>>> replica to work and ended up doubting that this piece is correct.  Th=
e
>>>>> ratio between the big and small OSDs in my [99 99 99 99 4] example va=
ries
>>>>> slightly from what I would expect from first principles and what I ge=
t out
>>>>> of this derivation by about 1%.. which would explain the bias I as se=
eing.
>>>>>
>>>>> I'm hoping we can find someone with a strong stats/probability backgr=
ound
>>>>> and loads of free time who can tackle this...
>>>>>
>>>>
>>>> I'm *not* that person, but I gave it a go last weekend and realized a
>>>> few things:
>>>>
>>>> 1. We should add the additional constraint that for all PGs assigned
>>>> to an OSD, 1/N of them must be primary replicas, 1/N must be
>>>> secondary, 1/N must be tertiary, etc. for N replicas/stripes. E.g. for
>>>> a 3 replica pool, the "small" OSD should still have the property that
>>>> 1/3rd are primaries, 1/3rd are secondary, 1/3rd are tertiary.
>>>>
>>>> 2. I believe this is a case of the balls-into-bins problem -- we have
>>>> colored balls and weighted bins. I didn't find a definition of the
>>>> problem where the goal is to allow users to specify weights which must
>>>> be respected after N rounds.
>>>>
>>>> 3. I wrote some quick python to simulate different reweighting
>>>> algorithms. The solution is definitely not obvious - I often thought
>>>> I'd solved it (e.g. for simple OSD weight sets like 3, 3, 3, 1) - but
>>>> changing the OSDs weights to e.g. 3, 3, 1, 1 completely broke things.
>>>> I can clean up and share that python if it's can help.
>>>>
>>>> My gut feeling is that because CRUSH trees and rulesets can be
>>>> arbitrarily complex, the most pragmatic & reliable way to solve this
>>>> problem is to balance the PGs with a reweight-by-pg loop at crush
>>>> compilation time. This is what admins should do now -- we should just
>>>> automate it.
>>>>
>>>> Cheers, Dan
>>>>
>>>> P.S. -- maybe these guys can help: http://math.stackexchange.com/
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
