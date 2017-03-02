From: =?UTF-8?B?UGVkcm8gTMOzcGV6LUFkZXZh?= <plopezadeva@gmail.com>
Subject: Re: crush multipick anomaly
Date: Thu, 2 Mar 2017 10:58:54 +0100
Message-ID: <CAFdhnjfYK43=ZdQ-cPG0k8KzKnTZ=T5VNoYdfdSdPH8gRG_i+A@mail.gmail.com>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org> <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal>
 <CAFdhnje5hJMsU8ZCSL8mFj=d4UH6b41=nnddNvcfemhyWXg6aw@mail.gmail.com>
 <4dbab28a-220b-2cef-fcbc-aca4dd17ab3b@dachary.org> <CAFdhnjf=WPmC+CEwX1QWe_v1HXmZu2cv7983zHGG4muKR_G0jw@mail.gmail.com>
 <43736207-9e38-9389-4b99-d246716092ed@dachary.org> <CAFdhnjfGKdmOFnT-imHo55O7LLPCdOV=_pbU50ruxo1x9C3NDA@mail.gmail.com>
 <cbcf592e-a0c0-bc5b-0f2a-11c4a110d485@dachary.org> <CAFdhnjcDfUG6Dzm2R_Fu16d7rT1z_h+mFy6ngYLUcLtURn_pVA@mail.gmail.com>
 <63256e6b-ec48-e369-afc3-6d65eb5230f8@dachary.org> <eca40695-44b3-6843-b1c3-8359231e4d87@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36094 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdCBJ64 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 04:58:56 -0500
Received: by mail-qk0-f178.google.com with SMTP id n186so111857008qkb.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 01:58:56 -0800 (PST)
In-Reply-To: <eca40695-44b3-6843-b1c3-8359231e4d87@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Hi,

I will have a look. BTW, I have not progressed that much but I have
been thinking about it. In order to adapt the previous algorithm in
the python notebook I need to substitute the iteration over all
possible devices permutations to iteration over all the possible
selections that crush would make. That is the main thing I need to
work on.

The other thing is of course that weights change for each replica.
That is, they cannot be really fixed in the crush map. So the
algorithm inside libcrush, not only the weights in the map, need to be
changed. The weights in the crush map should reflect then, maybe, the
desired usage frequencies. Or maybe each replica should have their own
crush map, but then the information about the previous selection
should be passed to the next replica placement run so it avoids
selecting the same one again.

I have a question also. Is there any significant difference between
the device selection algorithm description in the paper and its final
implementation?

Cheers,
Pedro.

2017-03-02 10:43 GMT+01:00 Loic Dachary <loic@dachary.org>:
> Hi Pedro,
>
> There is a new version of python-crush at https://pypi.python.org/pypi/cr=
ush which changes the layout of the crushmap and the documentation was upda=
ted accordingly at http://crush.readthedocs.io/. Sorry for the inconvenienc=
e.
>
> Cheers
>
> On 02/25/2017 10:02 AM, Loic Dachary wrote:
>>
>>
>> On 02/25/2017 09:41 AM, Pedro L=C3=B3pez-Adeva wrote:
>>> Great! Installed without problem and ran the example OK. I will
>>> convert what I already have to use the library and continue from
>>> there.
>>
>> Cool :-) http://crush.readthedocs.io/en/latest/api.html is a complete re=
ference of the crushmap structure, let me know if something is missing.
>>
>> Cheers
>>
>>>
>>> 2017-02-25 1:38 GMT+01:00 Loic Dachary <loic@dachary.org>:
>>>> Hi Pedro,
>>>>
>>>> On 02/22/2017 12:46 PM, Pedro L=C3=B3pez-Adeva wrote:
>>>>> That, for validation, would be great. Until weekend I don't think I'm
>>>>> going to have time to work on this anyway.
>>>>
>>>> An initial version of the module is ready and documented at http://cru=
sh.readthedocs.io/en/latest/.
>>>>
>>>> Cheers
>>>>
>>>>> 2017-02-22 12:38 GMT+01:00 Loic Dachary <loic@dachary.org>:
>>>>>>
>>>>>>
>>>>>> On 02/22/2017 12:26 PM, Pedro L=C3=B3pez-Adeva wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I think your description of my proposed solution is quite good.
>>>>>>>
>>>>>>> I had a first look at Sage's paper but not ceph's implementation. M=
y
>>>>>>> plan is to finish the paper and make an implementation in python th=
at
>>>>>>> mimicks more closely ceph's algorithm.
>>>>>>>
>>>>>>> Regarding your question about data movement:
>>>>>>>
>>>>>>> If I understood the paper correctly what is happening right now is
>>>>>>> that when weights change on the devices some of them will become
>>>>>>> overloaded and the current algorithm will try to correct for that b=
ut
>>>>>>> this approach, I think, is independent of how we compute the weight=
s
>>>>>>> for each device. My point is that the current data movement pattern
>>>>>>> will not be modified.
>>>>>>>
>>>>>>> Could the data movement algorithm be improved? Maybe. I don't know.
>>>>>>> Maybe by making the probabilities non-stationary with the new disk
>>>>>>> getting at first very high probability and after each replica
>>>>>>> placement decrease it until it stabilizes to it's final value. But =
I'm
>>>>>>> just guessing and I really don't know if this can be made to work i=
n a
>>>>>>> distributed manner as is currently the case and how would this fit =
in
>>>>>>> the current architecture. In any case it would be a problem as hard=
 at
>>>>>>> least as the current reweighting problem.
>>>>>>>
>>>>>>> So, to summarize, my current plans:
>>>>>>>
>>>>>>> - Have another look at the paper
>>>>>>> - Make an implementation in python that imitates more closely the
>>>>>>> current algorithm
>>>>>>
>>>>>> What about I provide you with a python module that includes the curr=
ent crush implementation (wrapping the C library into a python module) so y=
ou don't have to ? I think it would be generaly useful for experimenting an=
d worth the effort. I can have that ready this weekend.
>>>>>>
>>>>>>> - Make sure the new reweighting algorithm is fast and gives the des=
ired results
>>>>>>>
>>>>>>> I will give updates here when there are significant changes so
>>>>>>> everyone can have a look and suggest improvements.
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Pedro.
>>>>>>>
>>>>>>> 2017-02-22 8:52 GMT+01:00 Loic Dachary <loic@dachary.org>:
>>>>>>>> Hi Pedro,
>>>>>>>>
>>>>>>>> On 02/16/2017 11:04 PM, Pedro L=C3=B3pez-Adeva wrote:
>>>>>>>>> I have updated the algorithm to handle an arbitrary number of rep=
licas
>>>>>>>>> and arbitrary constraints.
>>>>>>>>>
>>>>>>>>> Notebook: https://github.com/plafl/notebooks/blob/master/replicat=
ion.ipynb
>>>>>>>>> PDF: https://github.com/plafl/notebooks/blob/master/converted/rep=
lication.pdf
>>>>>>>>
>>>>>>>> I'm very impressed :-) Thanks to friends who helped with the maths=
 parts that were unknown to me I think I now get the spirit of the solution=
 you found. Here it is, in my own words.
>>>>>>>>
>>>>>>>> You wrote a family of functions describing the desired outcome: eq=
ually filled disks when distributing objects replicas with a constraint. It=
's not a formula we can use to figure out which probability to assign to ea=
ch disk, there are two many unknowns. But you also proposed a function to m=
easure, for a given set of probabilities, how far from the best probabiliti=
es they are. That's the loss function[1].
>>>>>>>>
>>>>>>>> You implemented an abstract python interface to look for the best =
solution, using this loss function. Trying things at random would take way =
too much time. Instead you use the gradient[2] of the function to figure ou=
t in which direction the values should be modified (that's where the jacobi=
an[3] helps).
>>>>>>>>
>>>>>>>> This is part one of your document and in part two you focus on one=
 constraints: no two replica on the same disk. And with an implementation o=
f the abstract interface you show with a few examples that after iterating =
a number of times you get a set of probabilities that are close enough to t=
he solution. Not the ideal solution but less that 0.001 away from it.
>>>>>>>>
>>>>>>>> [1] https://en.wikipedia.org/wiki/Loss_function
>>>>>>>> [2] https://en.wikipedia.org/wiki/Gradient
>>>>>>>> [3] https://en.wikipedia.org/wiki/Jacobi_elliptic_functions#Jacobi=
_elliptic_functions_as_solutions_of_nonlinear_ordinary_differential_equatio=
ns
>>>>>>>>
>>>>>>>> From the above you can hopefully see how far off my understanding =
is. And I have one question below.
>>>>>>>>
>>>>>>>>> (Note: GitHub's renderization of the notebook and the PDF is quit=
e
>>>>>>>>> deficient, I recommend downloading/cloning)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> In the following by policy I mean the concrete set of probabiliti=
es of
>>>>>>>>> selecting the first replica, the second replica, etc...
>>>>>>>>> In practical terms there are several problems:
>>>>>>>>>
>>>>>>>>> - It's not practical for a high number of disks or replicas.
>>>>>>>>>
>>>>>>>>> Possible solution: approximate summation over all possible disk
>>>>>>>>> selections with a Monte Carlo method.
>>>>>>>>> the algorithm would be: we start with a candidate solution, we ru=
n a
>>>>>>>>> simulation and based on the results
>>>>>>>>> we update the probabilities. Repeat until we are happy with the r=
esult.
>>>>>>>>>
>>>>>>>>> Other solution: cluster similar disks together.
>>>>>>>>>
>>>>>>>>> - Since it's a non-linear optimization problem I'm not sure right=
 now
>>>>>>>>> about it's convergence properties.
>>>>>>>>> Does it converge to a global optimum? How fast does it converge?
>>>>>>>>>
>>>>>>>>> Possible solution: the algorithm always converges, but it can con=
verge
>>>>>>>>> to a locally optimum policy. I see
>>>>>>>>> no escape except by carefully designing the policy. All solutions=
 to
>>>>>>>>> the problem are going to be non linear
>>>>>>>>> since we must condition current probabilities on previous disk se=
lections.
>>>>>>>>>
>>>>>>>>> - Although it can handle arbitrary constraints it does so by reje=
cting
>>>>>>>>> disks selections that violate at least one constraint.
>>>>>>>>> This means that for bad policies it can spend all the time reject=
ing
>>>>>>>>> invalid disks selection candidates.
>>>>>>>>>
>>>>>>>>> Possible solution: the policy cannot be designed independently of=
 the
>>>>>>>>> constraints. I don't know what constraints
>>>>>>>>> are typical use cases but having a look should be the first step.=
 The
>>>>>>>>> constraints must be an input to the policy.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I hope it's of some use. Quite frankly I'm not a ceph user, I jus=
t
>>>>>>>>> found the problem an interesting puzzle.
>>>>>>>>> Anyway I will try to have a look at the CRUSH paper this weekend.
>>>>>>>>
>>>>>>>> In Sage's paper[1] as well as in the Ceph implementation[2] minimi=
zing data movement when a disk is added / removed is an important goal. Whe=
n looking for a disk to place an object, a mixture of hashing, recursive ex=
ploration of a hierarchy describing the racks/hosts/disks and higher probab=
ilities for bigger disks are used.
>>>>>>>>
>>>>>>>> [1] http://www.crss.ucsc.edu/media/papers/weil-sc06.pdf
>>>>>>>> [2] https://github.com/ceph/ceph/tree/master/src/crush
>>>>>>>>
>>>>>>>> Here is an example[1] showing how data move around with the curren=
t implementation when adding one disk to a 10 disk host (all disks have the=
 same probability of being chosen but no two copies of the same object can =
be on the same disk) with 100,000 objects and replica 2. The first line rea=
ds like this: 14 objects moved from disk 00 to disk 01, 17 objects moved fr=
om disk 00 to disk 02 ... 1800 objects moved from disk 00 to disk 10. The "=
before:" line shows how many objects were in each disk before the new one w=
as added, the "after:" line shows the distribution after the disk was added=
 and objects moved from the existing disks to the new disk.
>>>>>>>>
>>>>>>>>         00     01     02     03     04     05     06     07     08=
     09     10
>>>>>>>> 00:      0     14     17     14     19     23     13     22     21=
     20   1800
>>>>>>>> 01:     12      0     11     13     19     19     15     10     16=
     17   1841
>>>>>>>> 02:     17     27      0     17     15     15     13     19     18=
     11   1813
>>>>>>>> 03:     14     17     15      0     23     11     20     15     23=
     17   1792
>>>>>>>> 04:     14     18     16     25      0     27     13      8     15=
     16   1771
>>>>>>>> 05:     19     16     22     25     13      0      9     19     21=
     21   1813
>>>>>>>> 06:     18     15     21     17     10     18      0     10     18=
     11   1873
>>>>>>>> 07:     13     17     22     13     16     17     14      0     25=
     12   1719
>>>>>>>> 08:     23     20     16     17     19     18     11     12      0=
     18   1830
>>>>>>>> 09:     14     20     15     17     12     16     17     11     13=
      0   1828
>>>>>>>> 10:      0      0      0      0      0      0      0      0      0=
      0      0
>>>>>>>> before:  20164  19990  19863  19959  19977  20004  19926  20133  2=
0041  19943      0
>>>>>>>> after:   18345  18181  18053  18170  18200  18190  18040  18391  1=
8227  18123  18080
>>>>>>>>
>>>>>>>> About 1% of the data movement happens between existing disks and s=
erve no useful purpose but the rest are objects moving from existing disks =
to the new one which is what we need.
>>>>>>>>
>>>>>>>> [1] http://libcrush.org/dachary/libcrush/blob/wip-sheepdog/compare=
.c
>>>>>>>>
>>>>>>>> Would it be possible to somehow reconcile the two goals: equally f=
illed disks (which your solution does) and minimizing data movement (which =
crush does) ?
>>>>>>>>
>>>>>>>> Cheers
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2017-02-13 15:21 GMT+01:00 Sage Weil <sweil@redhat.com>:
>>>>>>>>>> On Mon, 13 Feb 2017, Loic Dachary wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> Dan van der Ster reached out to colleagues and friends and Pedr=
o
>>>>>>>>>>> L=C3=B3pez-Adeva Fern=C3=A1ndez-Layos came up with a well writt=
en analysis of the
>>>>>>>>>>> problem and a tentative solution which he described at :
>>>>>>>>>>> https://github.com/plafl/notebooks/blob/master/replication.ipyn=
b
>>>>>>>>>>>
>>>>>>>>>>> Unless I'm reading the document incorrectly (very possible ;) i=
t also
>>>>>>>>>>> means that the probability of each disk needs to take in accoun=
t the
>>>>>>>>>>> weight of all disks. Which means that whenever a disk is added =
/ removed
>>>>>>>>>>> or its weight is changed, this has an impact on the probability=
 of all
>>>>>>>>>>> disks in the cluster and objects are likely to move everywhere.=
 Am I
>>>>>>>>>>> mistaken ?
>>>>>>>>>>
>>>>>>>>>> Maybe (I haven't looked closely at the above yet).  But for comp=
arison, in
>>>>>>>>>> the normal straw2 case, adding or removing a disk also changes t=
he
>>>>>>>>>> probabilities for everything else (e.g., removing one out of 10 =
identical
>>>>>>>>>> disks changes the probability from 1/10 to 1/9).  The key proper=
ty that
>>>>>>>>>> straw2 *is* able to handle is that as long as the relative proba=
bilities
>>>>>>>>>> between two unmodified disks does not change, then straw2 will a=
void
>>>>>>>>>> moving any objects between them (i.e., all data movement is to o=
r from
>>>>>>>>>> the disk that is reweighted).
>>>>>>>>>>
>>>>>>>>>> sage
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Cheers
>>>>>>>>>>>
>>>>>>>>>>> On 01/26/2017 04:05 AM, Sage Weil wrote:
>>>>>>>>>>>> This is a longstanding bug,
>>>>>>>>>>>>
>>>>>>>>>>>>     http://tracker.ceph.com/issues/15653
>>>>>>>>>>>>
>>>>>>>>>>>> that causes low-weighted devices to get more data than they sh=
ould. Loic's
>>>>>>>>>>>> recent activity resurrected discussion on the original PR
>>>>>>>>>>>>
>>>>>>>>>>>>     https://github.com/ceph/ceph/pull/10218
>>>>>>>>>>>>
>>>>>>>>>>>> but since it's closed and almost nobody will see it I'm moving=
 the
>>>>>>>>>>>> discussion here.
>>>>>>>>>>>>
>>>>>>>>>>>> The main news is that I have a simple adjustment for the weigh=
ts that
>>>>>>>>>>>> works (almost perfectly) for the 2nd round of placements.  The=
 solution is
>>>>>>>>>>>> pretty simple, although as with most probabilities it tends to=
 make my
>>>>>>>>>>>> brain hurt.
>>>>>>>>>>>>
>>>>>>>>>>>> The idea is that, on the second round, the original weight for=
 the small
>>>>>>>>>>>> OSD (call it P(pick small)) isn't what we should use.  Instead=
, we want
>>>>>>>>>>>> P(pick small | first pick not small).  Since P(a|b) (the proba=
bility of a
>>>>>>>>>>>> given b) is P(a && b) / P(b),
>>>>>>>>>>>>
>>>>>>>>>>>>  P(pick small | first pick not small)
>>>>>>>>>>>>  =3D P(pick small && first pick not small) / P(first pick not =
small)
>>>>>>>>>>>>
>>>>>>>>>>>> The last term is easy to calculate,
>>>>>>>>>>>>
>>>>>>>>>>>>  P(first pick not small) =3D (total_weight - small_weight) / t=
otal_weight
>>>>>>>>>>>>
>>>>>>>>>>>> and the && term is the distribution we're trying to produce.  =
For exmaple,
>>>>>>>>>>>> if small has 1/10 the weight, then we should see 1/10th of the=
 PGs have
>>>>>>>>>>>> their second replica be the small OSD.  So
>>>>>>>>>>>>
>>>>>>>>>>>>  P(pick small && first pick not small) =3D small_weight / tota=
l_weight
>>>>>>>>>>>>
>>>>>>>>>>>> Putting those together,
>>>>>>>>>>>>
>>>>>>>>>>>>  P(pick small | first pick not small)
>>>>>>>>>>>>  =3D P(pick small && first pick not small) / P(first pick not =
small)
>>>>>>>>>>>>  =3D (small_weight / total_weight) / ((total_weight - small_we=
ight) / total_weight)
>>>>>>>>>>>>  =3D small_weight / (total_weight - small_weight)
>>>>>>>>>>>>
>>>>>>>>>>>> This is, on the second round, we should adjust the weights by =
the above so
>>>>>>>>>>>> that we get the right distribution of second choices.  It turn=
s out it
>>>>>>>>>>>> works to adjust *all* weights like this to get hte conditional=
 probability
>>>>>>>>>>>> that they weren't already chosen.
>>>>>>>>>>>>
>>>>>>>>>>>> I have a branch that hacks this into straw2 and it appears to =
work
>>>>>>>>>>>> properly for num_rep =3D 2.  With a test bucket of [99 99 99 9=
9 4], and the
>>>>>>>>>>>> current code, you get
>>>>>>>>>>>>
>>>>>>>>>>>> $ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 =
--max-x 40000000 --num-rep 2
>>>>>>>>>>>> rule 0 (data), x =3D 0..40000000, numrep =3D 2..2
>>>>>>>>>>>> rule 0 (data) num_rep 2 result size =3D=3D 2:       40000001/4=
0000001
>>>>>>>>>>>>   device 0:             19765965        [9899364,9866601]
>>>>>>>>>>>>   device 1:             19768033        [9899444,9868589]
>>>>>>>>>>>>   device 2:             19769938        [9901770,9868168]
>>>>>>>>>>>>   device 3:             19766918        [9898851,9868067]
>>>>>>>>>>>>   device 6:             929148  [400572,528576]
>>>>>>>>>>>>
>>>>>>>>>>>> which is very close for the first replica (primary), but way o=
ff for the
>>>>>>>>>>>> second.  With my hacky change,
>>>>>>>>>>>>
>>>>>>>>>>>> rule 0 (data), x =3D 0..40000000, numrep =3D 2..2
>>>>>>>>>>>> rule 0 (data) num_rep 2 result size =3D=3D 2:       40000001/4=
0000001
>>>>>>>>>>>>   device 0:             19797315        [9899364,9897951]
>>>>>>>>>>>>   device 1:             19799199        [9899444,9899755]
>>>>>>>>>>>>   device 2:             19801016        [9901770,9899246]
>>>>>>>>>>>>   device 3:             19797906        [9898851,9899055]
>>>>>>>>>>>>   device 6:             804566  [400572,403994]
>>>>>>>>>>>>
>>>>>>>>>>>> which is quite close, but still skewing slightly high (by a bi=
g less than
>>>>>>>>>>>> 1%).
>>>>>>>>>>>>
>>>>>>>>>>>> Next steps:
>>>>>>>>>>>>
>>>>>>>>>>>> 1- generalize this for >2 replicas
>>>>>>>>>>>> 2- figure out why it skews high
>>>>>>>>>>>> 3- make this work for multi-level hierarchical descent
>>>>>>>>>>>>
>>>>>>>>>>>> sage
>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
