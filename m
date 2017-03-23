From: =?UTF-8?B?UGVkcm8gTMOzcGV6LUFkZXZh?= <plopezadeva@gmail.com>
Subject: Re: crush multipick anomaly
Date: Thu, 23 Mar 2017 16:32:55 +0100
Message-ID: <CAFdhnjdQSZZJJ0BUG45-QWUj6enr+0ZPpOxVjNhijzFPXL9==Q@mail.gmail.com>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <4dbab28a-220b-2cef-fcbc-aca4dd17ab3b@dachary.org> <CAFdhnjf=WPmC+CEwX1QWe_v1HXmZu2cv7983zHGG4muKR_G0jw@mail.gmail.com>
 <43736207-9e38-9389-4b99-d246716092ed@dachary.org> <CAFdhnjfGKdmOFnT-imHo55O7LLPCdOV=_pbU50ruxo1x9C3NDA@mail.gmail.com>
 <cbcf592e-a0c0-bc5b-0f2a-11c4a110d485@dachary.org> <CAFdhnjcDfUG6Dzm2R_Fu16d7rT1z_h+mFy6ngYLUcLtURn_pVA@mail.gmail.com>
 <63256e6b-ec48-e369-afc3-6d65eb5230f8@dachary.org> <eca40695-44b3-6843-b1c3-8359231e4d87@dachary.org>
 <CAFdhnjfYK43=ZdQ-cPG0k8KzKnTZ=T5VNoYdfdSdPH8gRG_i+A@mail.gmail.com>
 <alpine.DEB.2.11.1703072259520.24356@piezo.novalocal> <CAFdhnjeAdCgqS3N7yvZXEanEc8c_q2hR_HciUD2gdFGcRyaZXQ@mail.gmail.com>
 <649a0116-6f61-0470-69bd-41f64214ad5a@dachary.org> <6b063525-eeec-bdf6-a926-af2e9276f34b@dachary.org>
 <7f03d75d-0dc7-086e-6f43-5b2717588345@dachary.org> <CAFdhnjcs5sZbnDWXH6qJBge9WYR-Cr+svhr=YZ9hZJrDvo=vxg@mail.gmail.com>
 <0ad9fa05-fc1c-9bd9-d826-a1dae693b67d@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33296 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965340AbdCWPc5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 11:32:57 -0400
Received: by mail-qt0-f182.google.com with SMTP id i34so178722088qtc.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 08:32:56 -0700 (PDT)
In-Reply-To: <0ad9fa05-fc1c-9bd9-d826-a1dae693b67d@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

There are lot of gradient-free methods. I will try first to run the
ones available using just scipy
(https://docs.scipy.org/doc/scipy-0.18.1/reference/optimize.html).
Some of them don't require the gradient and some of them can estimate
it. The reason to go without the gradient is to run the CRUSH
algorithm as a black box. In that case this would be the pseudo-code:

- BEGIN CODE -
def build_target(desired_freqs):
    def target(weights):
        # run a simulation of CRUSH for a number of objects
        sim_freqs =3D run_crush(weights)
        # Kullback-Leibler divergence between desired frequencies and
current ones
        return loss(sim_freqs, desired_freqs)
   return target

weights =3D scipy.optimize.minimize(build_target(desired_freqs))
- END CODE -

The tricky thing here is that this procedure can be slow if the
simulation (run_crush) needs to place a lot of objects to get accurate
simulated frequencies. This is true specially if the minimize method
attempts to approximate the gradient using finite differences since it
will evaluate the target function a number of times proportional to
the number of weights). Apart from the ones in scipy I would try also
optimization methods that try to perform as few evaluations as
possible like for example HyperOpt
(http://hyperopt.github.io/hyperopt/), which by the way takes into
account that the target function can be noisy.

This black box approximation is simple to implement and makes the
computer do all the work instead of us.
I think that this black box approximation is worthy to try even if
it's not the final one because if this approximation works then we
know that a more elaborate one that computes the gradient of the CRUSH
algorithm will work for sure.

I can try this black box approximation this weekend not on the real
CRUSH algorithm but with the simple implementation I did in python. If
it works it's just a matter of substituting one simulation with
another and see what happens.

2017-03-23 15:13 GMT+01:00 Loic Dachary <loic@dachary.org>:
> Hi Pedro,
>
> On 03/23/2017 12:49 PM, Pedro L=C3=B3pez-Adeva wrote:
>> Hi Loic,
>>
>>>From what I see everything seems OK.
>
> Cool. I'll keep going in this direction then !
>
>> The interesting thing would be to
>> test on some complex mapping. The reason is that "CrushPolicyFamily"
>> is right now modeling just a single straw bucket not the full CRUSH
>> algorithm.
>
> A number of use cases use a single straw bucket, maybe the majority of th=
em. Even though it does not reflect the full range of what crush can offer,=
 it could be useful. To be more specific, a crush map that states "place ob=
jects so that there is at most one replica per host" or "one replica per ra=
ck" is common. Such a crushmap can be reduced to a single straw bucket that=
 contains all the hosts and by using the CrushPolicyFamily, we can change t=
he weights of each host to fix the probabilities. The hosts themselves cont=
ain disks with varying weights but I think we can ignore that because crush=
 will only recurse to place one object within a given host.
>
>> That's the work that remains to be done. The only way that
>> would avoid reimplementing the CRUSH algorithm and computing the
>> gradient would be treating CRUSH as a black box and eliminating the
>> necessity of computing the gradient either by using a gradient-free
>> optimization method or making an estimation of the gradient.
>
> By gradient-free optimization you mean simulated annealing or Monte Carlo=
 ?
>
> Cheers
>
>>
>>
>> 2017-03-20 11:49 GMT+01:00 Loic Dachary <loic@dachary.org>:
>>> Hi,
>>>
>>> I modified the crush library to accept two weights (one for the first d=
isk, the other for the remaining disks)[1]. This really is a hack for exper=
imentation purposes only ;-) I was able to run a variation of your code[2] =
and got the following results which are encouraging. Do you think what I di=
d is sensible ? Or is there a problem I don't see ?
>>>
>>> Thanks !
>>>
>>> Simulation: R=3D2 devices capacity [10  8  6 10  8  6 10  8  6]
>>> -----------------------------------------------------------------------=
-
>>> Before: All replicas on each hard drive
>>> Expected vs actual use (20000 samples)
>>>  disk 0: 1.39e-01 1.12e-01
>>>  disk 1: 1.11e-01 1.10e-01
>>>  disk 2: 8.33e-02 1.13e-01
>>>  disk 3: 1.39e-01 1.11e-01
>>>  disk 4: 1.11e-01 1.11e-01
>>>  disk 5: 8.33e-02 1.11e-01
>>>  disk 6: 1.39e-01 1.12e-01
>>>  disk 7: 1.11e-01 1.12e-01
>>>  disk 8: 8.33e-02 1.10e-01
>>> it=3D    1 jac norm=3D1.59e-01 loss=3D5.27e-03
>>> it=3D    2 jac norm=3D1.55e-01 loss=3D5.03e-03
>>> ...
>>> it=3D  212 jac norm=3D1.02e-03 loss=3D2.41e-07
>>> it=3D  213 jac norm=3D1.00e-03 loss=3D2.31e-07
>>> Converged to desired accuracy :)
>>> After: All replicas on each hard drive
>>> Expected vs actual use (20000 samples)
>>>  disk 0: 1.39e-01 1.42e-01
>>>  disk 1: 1.11e-01 1.09e-01
>>>  disk 2: 8.33e-02 8.37e-02
>>>  disk 3: 1.39e-01 1.40e-01
>>>  disk 4: 1.11e-01 1.13e-01
>>>  disk 5: 8.33e-02 8.08e-02
>>>  disk 6: 1.39e-01 1.38e-01
>>>  disk 7: 1.11e-01 1.09e-01
>>>  disk 8: 8.33e-02 8.48e-02
>>>
>>>
>>> Simulation: R=3D2 devices capacity [10 10 10 10  1]
>>> -----------------------------------------------------------------------=
-
>>> Before: All replicas on each hard drive
>>> Expected vs actual use (20000 samples)
>>>  disk 0: 2.44e-01 2.36e-01
>>>  disk 1: 2.44e-01 2.38e-01
>>>  disk 2: 2.44e-01 2.34e-01
>>>  disk 3: 2.44e-01 2.38e-01
>>>  disk 4: 2.44e-02 5.37e-02
>>> it=3D    1 jac norm=3D2.43e-01 loss=3D2.98e-03
>>> it=3D    2 jac norm=3D2.28e-01 loss=3D2.47e-03
>>> ...
>>> it=3D   37 jac norm=3D1.28e-03 loss=3D3.48e-08
>>> it=3D   38 jac norm=3D1.07e-03 loss=3D2.42e-08
>>> Converged to desired accuracy :)
>>> After: All replicas on each hard drive
>>> Expected vs actual use (20000 samples)
>>>  disk 0: 2.44e-01 2.46e-01
>>>  disk 1: 2.44e-01 2.44e-01
>>>  disk 2: 2.44e-01 2.41e-01
>>>  disk 3: 2.44e-01 2.45e-01
>>>  disk 4: 2.44e-02 2.33e-02
>>>
>>>
>>> [1] crush hack http://libcrush.org/main/libcrush/commit/6efda297694392d=
0b07845eb98464a0dcd56fee8
>>> [2] python-crush hack http://libcrush.org/dachary/python-crush/commit/d=
9202fcd4d17cd2a82b37ec20c1bd25f8f2c4b68
>>>
>>> On 03/19/2017 11:31 PM, Loic Dachary wrote:
>>>> Hi Pedro,
>>>>
>>>> It looks like trying to experiment with crush won't work as expected b=
ecause crush does not distinguish the probability of selecting the first de=
vice from the probability of selecting the second or third device. Am I mis=
taken ?
>>>>
>>>> Cheers
>>>>
>>>> On 03/18/2017 10:21 AM, Loic Dachary wrote:
>>>>> Hi Pedro,
>>>>>
>>>>> I'm going to experiment with what you did at
>>>>>
>>>>> https://github.com/plafl/notebooks/blob/master/replication.ipynb
>>>>>
>>>>> and the latest python-crush published today. A comparison function wa=
s added that will help measure the data movement. I'm hoping we can release=
 an offline tool based on your solution. Please let me know if I should wai=
t before diving into this, in case you have unpublished drafts or new ideas=
.
>>>>>
>>>>> Cheers
>>>>>
>>>>> On 03/09/2017 09:47 AM, Pedro L=C3=B3pez-Adeva wrote:
>>>>>> Great, thanks for the clarifications.
>>>>>> I also think that the most natural way is to keep just a set of
>>>>>> weights in the CRUSH map and update them inside the algorithm.
>>>>>>
>>>>>> I keep working on it.
>>>>>>
>>>>>>
>>>>>> 2017-03-08 0:06 GMT+01:00 Sage Weil <sage@newdream.net>:
>>>>>>> Hi Pedro,
>>>>>>>
>>>>>>> Thanks for taking a look at this!  It's a frustrating problem and w=
e
>>>>>>> haven't made much headway.
>>>>>>>
>>>>>>> On Thu, 2 Mar 2017, Pedro L=C3=B3pez-Adeva wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I will have a look. BTW, I have not progressed that much but I hav=
e
>>>>>>>> been thinking about it. In order to adapt the previous algorithm i=
n
>>>>>>>> the python notebook I need to substitute the iteration over all
>>>>>>>> possible devices permutations to iteration over all the possible
>>>>>>>> selections that crush would make. That is the main thing I need to
>>>>>>>> work on.
>>>>>>>>
>>>>>>>> The other thing is of course that weights change for each replica.
>>>>>>>> That is, they cannot be really fixed in the crush map. So the
>>>>>>>> algorithm inside libcrush, not only the weights in the map, need t=
o be
>>>>>>>> changed. The weights in the crush map should reflect then, maybe, =
the
>>>>>>>> desired usage frequencies. Or maybe each replica should have their=
 own
>>>>>>>> crush map, but then the information about the previous selection
>>>>>>>> should be passed to the next replica placement run so it avoids
>>>>>>>> selecting the same one again.
>>>>>>>
>>>>>>> My suspicion is that the best solution here (whatever that means!)
>>>>>>> leaves the CRUSH weights intact with the desired distribution, and
>>>>>>> then generates a set of derivative weights--probably one set for ea=
ch
>>>>>>> round/replica/rank.
>>>>>>>
>>>>>>> One nice property of this is that once the support is added to enco=
de
>>>>>>> multiple sets of weights, the algorithm used to generate them is fr=
ee to
>>>>>>> change and evolve independently.  (In most cases any change is
>>>>>>> CRUSH's mapping behavior is difficult to roll out because all
>>>>>>> parties participating in the cluster have to support any new behavi=
or
>>>>>>> before it is enabled or used.)
>>>>>>>
>>>>>>>> I have a question also. Is there any significant difference betwee=
n
>>>>>>>> the device selection algorithm description in the paper and its fi=
nal
>>>>>>>> implementation?
>>>>>>>
>>>>>>> The main difference is the "retry_bucket" behavior was found to be =
a bad
>>>>>>> idea; any collision or failed()/overload() case triggers the
>>>>>>> retry_descent.
>>>>>>>
>>>>>>> There are other changes, of course, but I don't think they'll impac=
t any
>>>>>>> solution we come with here (or at least any solution can be suitabl=
y
>>>>>>> adapted)!
>>>>>>>
>>>>>>> sage
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
