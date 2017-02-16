From: =?UTF-8?B?UGVkcm8gTMOzcGV6LUFkZXZh?= <plopezadeva@gmail.com>
Subject: Re: crush multipick anomaly
Date: Thu, 16 Feb 2017 23:04:18 +0100
Message-ID: <CAFdhnje5hJMsU8ZCSL8mFj=d4UH6b41=nnddNvcfemhyWXg6aw@mail.gmail.com>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org> <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36435 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPWEU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 17:04:20 -0500
Received: by mail-qt0-f169.google.com with SMTP id k15so26783034qtg.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 14:04:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

I have updated the algorithm to handle an arbitrary number of replicas
and arbitrary constraints.

Notebook: https://github.com/plafl/notebooks/blob/master/replication.ipynb
PDF: https://github.com/plafl/notebooks/blob/master/converted/replication.p=
df

(Note: GitHub's renderization of the notebook and the PDF is quite
deficient, I recommend downloading/cloning)


In the following by policy I mean the concrete set of probabilities of
selecting the first replica, the second replica, etc...
In practical terms there are several problems:

- It's not practical for a high number of disks or replicas.

Possible solution: approximate summation over all possible disk
selections with a Monte Carlo method.
the algorithm would be: we start with a candidate solution, we run a
simulation and based on the results
we update the probabilities. Repeat until we are happy with the result.

Other solution: cluster similar disks together.

- Since it's a non-linear optimization problem I'm not sure right now
about it's convergence properties.
Does it converge to a global optimum? How fast does it converge?

Possible solution: the algorithm always converges, but it can converge
to a locally optimum policy. I see
no escape except by carefully designing the policy. All solutions to
the problem are going to be non linear
since we must condition current probabilities on previous disk selections.

- Although it can handle arbitrary constraints it does so by rejecting
disks selections that violate at least one constraint.
This means that for bad policies it can spend all the time rejecting
invalid disks selection candidates.

Possible solution: the policy cannot be designed independently of the
constraints. I don't know what constraints
are typical use cases but having a look should be the first step. The
constraints must be an input to the policy.


I hope it's of some use. Quite frankly I'm not a ceph user, I just
found the problem an interesting puzzle.
Anyway I will try to have a look at the CRUSH paper this weekend.


2017-02-13 15:21 GMT+01:00 Sage Weil <sweil@redhat.com>:
> On Mon, 13 Feb 2017, Loic Dachary wrote:
>> Hi,
>>
>> Dan van der Ster reached out to colleagues and friends and Pedro
>> L=C3=B3pez-Adeva Fern=C3=A1ndez-Layos came up with a well written analys=
is of the
>> problem and a tentative solution which he described at :
>> https://github.com/plafl/notebooks/blob/master/replication.ipynb
>>
>> Unless I'm reading the document incorrectly (very possible ;) it also
>> means that the probability of each disk needs to take in account the
>> weight of all disks. Which means that whenever a disk is added / removed
>> or its weight is changed, this has an impact on the probability of all
>> disks in the cluster and objects are likely to move everywhere. Am I
>> mistaken ?
>
> Maybe (I haven't looked closely at the above yet).  But for comparison, i=
n
> the normal straw2 case, adding or removing a disk also changes the
> probabilities for everything else (e.g., removing one out of 10 identical
> disks changes the probability from 1/10 to 1/9).  The key property that
> straw2 *is* able to handle is that as long as the relative probabilities
> between two unmodified disks does not change, then straw2 will avoid
> moving any objects between them (i.e., all data movement is to or from
> the disk that is reweighted).
>
> sage
>
>
>>
>> Cheers
>>
>> On 01/26/2017 04:05 AM, Sage Weil wrote:
>> > This is a longstanding bug,
>> >
>> >     http://tracker.ceph.com/issues/15653
>> >
>> > that causes low-weighted devices to get more data than they should. Lo=
ic's
>> > recent activity resurrected discussion on the original PR
>> >
>> >     https://github.com/ceph/ceph/pull/10218
>> >
>> > but since it's closed and almost nobody will see it I'm moving the
>> > discussion here.
>> >
>> > The main news is that I have a simple adjustment for the weights that
>> > works (almost perfectly) for the 2nd round of placements.  The solutio=
n is
>> > pretty simple, although as with most probabilities it tends to make my
>> > brain hurt.
>> >
>> > The idea is that, on the second round, the original weight for the sma=
ll
>> > OSD (call it P(pick small)) isn't what we should use.  Instead, we wan=
t
>> > P(pick small | first pick not small).  Since P(a|b) (the probability o=
f a
>> > given b) is P(a && b) / P(b),
>> >
>> >  P(pick small | first pick not small)
>> >  =3D P(pick small && first pick not small) / P(first pick not small)
>> >
>> > The last term is easy to calculate,
>> >
>> >  P(first pick not small) =3D (total_weight - small_weight) / total_wei=
ght
>> >
>> > and the && term is the distribution we're trying to produce.  For exma=
ple,
>> > if small has 1/10 the weight, then we should see 1/10th of the PGs hav=
e
>> > their second replica be the small OSD.  So
>> >
>> >  P(pick small && first pick not small) =3D small_weight / total_weight
>> >
>> > Putting those together,
>> >
>> >  P(pick small | first pick not small)
>> >  =3D P(pick small && first pick not small) / P(first pick not small)
>> >  =3D (small_weight / total_weight) / ((total_weight - small_weight) / =
total_weight)
>> >  =3D small_weight / (total_weight - small_weight)
>> >
>> > This is, on the second round, we should adjust the weights by the abov=
e so
>> > that we get the right distribution of second choices.  It turns out it
>> > works to adjust *all* weights like this to get hte conditional probabi=
lity
>> > that they weren't already chosen.
>> >
>> > I have a branch that hacks this into straw2 and it appears to work
>> > properly for num_rep =3D 2.  With a test bucket of [99 99 99 99 4], an=
d the
>> > current code, you get
>> >
>> > $ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 --max-x =
40000000 --num-rep 2
>> > rule 0 (data), x =3D 0..40000000, numrep =3D 2..2
>> > rule 0 (data) num_rep 2 result size =3D=3D 2:       40000001/40000001
>> >   device 0:             19765965        [9899364,9866601]
>> >   device 1:             19768033        [9899444,9868589]
>> >   device 2:             19769938        [9901770,9868168]
>> >   device 3:             19766918        [9898851,9868067]
>> >   device 6:             929148  [400572,528576]
>> >
>> > which is very close for the first replica (primary), but way off for t=
he
>> > second.  With my hacky change,
>> >
>> > rule 0 (data), x =3D 0..40000000, numrep =3D 2..2
>> > rule 0 (data) num_rep 2 result size =3D=3D 2:       40000001/40000001
>> >   device 0:             19797315        [9899364,9897951]
>> >   device 1:             19799199        [9899444,9899755]
>> >   device 2:             19801016        [9901770,9899246]
>> >   device 3:             19797906        [9898851,9899055]
>> >   device 6:             804566  [400572,403994]
>> >
>> > which is quite close, but still skewing slightly high (by a big less t=
han
>> > 1%).
>> >
>> > Next steps:
>> >
>> > 1- generalize this for >2 replicas
>> > 2- figure out why it skews high
>> > 3- make this work for multi-level hierarchical descent
>> >
>> > sage
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
