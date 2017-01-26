From: kefu chai <tchaikov@gmail.com>
Subject: Re: crush multipick anomaly
Date: Thu, 26 Jan 2017 19:51:03 +0800
Message-ID: <CAJE9aONSVON3Y1Uieh470qn05=K6-5rnQP9tPoF2CmPtOq9mQg@mail.gmail.com>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal> <e5f376bb-925b-17df-ae6e-abc07058f67b@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37782 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdAZLvL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jan 2017 06:51:11 -0500
Received: by mail-wm0-f44.google.com with SMTP id c206so79810903wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jan 2017 03:51:10 -0800 (PST)
In-Reply-To: <e5f376bb-925b-17df-ae6e-abc07058f67b@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sage@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 26, 2017 at 7:13 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sage,
>
> Still trying to understand what you did :-) I have one question below.
>
> On 01/26/2017 04:05 AM, Sage Weil wrote:
>> This is a longstanding bug,
>>
>>       http://tracker.ceph.com/issues/15653
>>
>> that causes low-weighted devices to get more data than they should. Loic=
's
>> recent activity resurrected discussion on the original PR
>>
>>       https://github.com/ceph/ceph/pull/10218
>>
>> but since it's closed and almost nobody will see it I'm moving the
>> discussion here.
>>
>> The main news is that I have a simple adjustment for the weights that
>> works (almost perfectly) for the 2nd round of placements.  The solution =
is
>> pretty simple, although as with most probabilities it tends to make my
>> brain hurt.
>>
>> The idea is that, on the second round, the original weight for the small
>> OSD (call it P(pick small)) isn't what we should use.  Instead, we want
>> P(pick small | first pick not small).  Since P(a|b) (the probability of =
a
>> given b) is P(a && b) / P(b),
>
> From the record this is explained at https://en.wikipedia.org/wiki/Condit=
ional_probability#Kolmogorov_definition
>
>>
>>  P(pick small | first pick not small)
>>  =3D P(pick small && first pick not small) / P(first pick not small)
>>
>> The last term is easy to calculate,
>>
>>  P(first pick not small) =3D (total_weight - small_weight) / total_weigh=
t
>>
>> and the && term is the distribution we're trying to produce.
>
> https://en.wikipedia.org/wiki/Conditional_probability describs A && B (us=
ing a non ascii symbol...) as the "probability of the joint of events A and=
 B". I don't understand what that means. Is there a definition somewhere ?

a joint events of A and B means these two events occur together. Here,
A and B are two random variables. so, the notion of P(A && B) or
P(A=E2=88=A9B) stands for the probability of the event A and event B happen=
s
together. in our case, in our case, "a" denotes the event of "first
small", and "b" denotes "first pick not small". so P(a=E2=88=A9b) is the
probability of the first pick is not small **and** the resulting pick
is not small. maybe you can also reference
https://en.wikipedia.org/wiki/Joint_probability_distribution

>
>> For exmaple,
>> if small has 1/10 the weight, then we should see 1/10th of the PGs have
>> their second replica be the small OSD.  So
>>
>>  P(pick small && first pick not small) =3D small_weight / total_weight
>>
>> Putting those together,
>>
>>  P(pick small | first pick not small)
>>  =3D P(pick small && first pick not small) / P(first pick not small)
>>  =3D (small_weight / total_weight) / ((total_weight - small_weight) / to=
tal_weight)
>>  =3D small_weight / (total_weight - small_weight)
>>
>> This is, on the second round, we should adjust the weights by the above =
so
>> that we get the right distribution of second choices.  It turns out it
>> works to adjust *all* weights like this to get hte conditional probabili=
ty
>> that they weren't already chosen.
>>
>> I have a branch that hacks this into straw2 and it appears to work
>
> This is https://github.com/liewegas/ceph/commit/wip-crush-multipick
>
>> properly for num_rep =3D 2.  With a test bucket of [99 99 99 99 4], and =
the
>> current code, you get
>>
>> $ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 --max-x 40=
000000 --num-rep 2
>> rule 0 (data), x =3D 0..40000000, numrep =3D 2..2
>> rule 0 (data) num_rep 2 result size =3D=3D 2:       40000001/40000001
>>   device 0:             19765965        [9899364,9866601]
>>   device 1:             19768033        [9899444,9868589]
>>   device 2:             19769938        [9901770,9868168]
>>   device 3:             19766918        [9898851,9868067]
>>   device 6:             929148  [400572,528576]
>>
>> which is very close for the first replica (primary), but way off for the
>> second.  With my hacky change,
>>
>> rule 0 (data), x =3D 0..40000000, numrep =3D 2..2
>> rule 0 (data) num_rep 2 result size =3D=3D 2:       40000001/40000001
>>   device 0:             19797315        [9899364,9897951]
>>   device 1:             19799199        [9899444,9899755]
>>   device 2:             19801016        [9901770,9899246]
>>   device 3:             19797906        [9898851,9899055]
>>   device 6:             804566  [400572,403994]
>>
>> which is quite close, but still skewing slightly high (by a big less tha=
n
>> 1%).
>>
>> Next steps:
>>
>> 1- generalize this for >2 replicas
>> 2- figure out why it skews high
>> 3- make this work for multi-level hierarchical descent
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
