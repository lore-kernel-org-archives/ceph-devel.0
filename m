From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multipick anomaly
Date: Wed, 26 Apr 2017 23:08:13 +0200
Message-ID: <94618815-d061-28b0-6584-8cf652adb93f@dachary.org>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <cbcf592e-a0c0-bc5b-0f2a-11c4a110d485@dachary.org>
 <CAFdhnjcDfUG6Dzm2R_Fu16d7rT1z_h+mFy6ngYLUcLtURn_pVA@mail.gmail.com>
 <63256e6b-ec48-e369-afc3-6d65eb5230f8@dachary.org>
 <eca40695-44b3-6843-b1c3-8359231e4d87@dachary.org>
 <CAFdhnjfYK43=ZdQ-cPG0k8KzKnTZ=T5VNoYdfdSdPH8gRG_i+A@mail.gmail.com>
 <alpine.DEB.2.11.1703072259520.24356@piezo.novalocal>
 <CAFdhnjeAdCgqS3N7yvZXEanEc8c_q2hR_HciUD2gdFGcRyaZXQ@mail.gmail.com>
 <649a0116-6f61-0470-69bd-41f64214ad5a@dachary.org>
 <6b063525-eeec-bdf6-a926-af2e9276f34b@dachary.org>
 <7f03d75d-0dc7-086e-6f43-5b2717588345@dachary.org>
 <CAFdhnjcs5sZbnDWXH6qJBge9WYR-Cr+svhr=YZ9hZJrDvo=vxg@mail.gmail.com>
 <0ad9fa05-fc1c-9bd9-d826-a1dae693b67d@dachary.org>
 <CAFdhnjdQSZZJJ0BUG45-QWUj6enr+0ZPpOxVjNhijzFPXL9==Q@mail.gmail.com>
 <d60c247f-865f-03f7-1a5a-f692c666fa65@dachary.org>
 <CAFdhnjdr+8Dy3siX6Xjrrd40HGH0p47Ld81nRO8f3ToBFQXs8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38345 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967683AbdDZVIY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Apr 2017 17:08:24 -0400
In-Reply-To: <CAFdhnjdr+8Dy3siX6Xjrrd40HGH0p47Ld81nRO8f3ToBFQXs8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Pedro_L=c3=b3pez-Adeva?= <plopezadeva@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/25/2017 05:04 PM, Pedro López-Adeva wrote:
> Hi Loic,
> 
> Well, the results are better certainly! Some comments:
> 
> - I'm glad Nelder-Mead worked. It's not the one I would have chosen
> because but I'm not an expert in optimization either. I wonder how it
> will scale with more weights[1]. My attempt at using scipy's optimize
> didn't work because you are optimizing an stochastic function and this
> can make scipy's to decide that no further steps are possible. The
> field that studies this kind of problems is stochastic optimization
> [2]

You were right, it does not always work. Note that this is *not* about the conditional probability bias. This is about the uneven distribution due to the low number of values in the distribution. I think this case should be treated separately, with a different method. In Ceph clusters, large and small, the number of PGs per host is unlikely to be large enough to get enough samples. It is not an isolated problem, it's what happens most of the time.

Even in a case as simple as 12 devices starting with:

             ~expected~  ~actual~    ~delta~   ~delta%~  ~weight~
host1      2560.000000      2580  20.000000   0.781250        24
device12    106.666667       101  -5.666667  -5.312500         1
device13    213.333333       221   7.666667   3.593750         2
device14    320.000000       317  -3.000000  -0.937500         3
device15    106.666667       101  -5.666667  -5.312500         1
device16    213.333333       217   3.666667   1.718750         2
device17    320.000000       342  22.000000   6.875000         3
device18    106.666667       102  -4.666667  -4.375000         1
device19    213.333333       243  29.666667  13.906250         2
device20    320.000000       313  -7.000000  -2.187500         3
device21    106.666667        94 -12.666667 -11.875000         1
device22    213.333333       208  -5.333333  -2.500000         2
device23    320.000000       321   1.000000   0.312500         3

            res = minimize(crush, weights, method='nelder-mead',
                           options={'xtol': 1e-8, 'disp': True})

device weights [ 1.  3.  3.  2.  3.  2.  2.  1.  3.  1.  1.  2.]
device kl 0.00117274995028
...
device kl 0.00016530695476
Optimization terminated successfully.
         Current function value: 0.000165
         Iterations: 117
         Function evaluations: 470

we still get a 5% difference on device 21:

             ~expected~  ~actual~    ~delta~   ~delta%~  ~weight~
host1      2560.000000      2559 -1.000000 -0.039062  23.805183
device12    106.666667       103 -3.666667 -3.437500   1.016999
device13    213.333333       214  0.666667  0.312500   1.949328
device14    320.000000       325  5.000000  1.562500   3.008688
device15    106.666667       106 -0.666667 -0.625000   1.012565
device16    213.333333       214  0.666667  0.312500   1.976344
device17    320.000000       320  0.000000  0.000000   2.845135
device18    106.666667       102 -4.666667 -4.375000   1.039181
device19    213.333333       214  0.666667  0.312500   1.820435
device20    320.000000       324  4.000000  1.250000   3.062573
device21    106.666667       101 -5.666667 -5.312500   1.071341
device22    213.333333       212 -1.333333 -0.625000   2.039190
device23    320.000000       324  4.000000  1.250000   3.016468

 
> - I used KL divergence for the loss function. My first attempt was
> using as you standard deviation (more commonly known as L2 loss) with
> gradient descent, but it didn't work very well.
> 
> - Sum of differences sounds like a bad idea, +100 and -100 errors will
> cancel out. Worse still -100 and -100 will be better than 0 and 0.
> Maybe you were talking about the absolute value of the differences?
> 
> - Well, now that CRUSH can use multiple weight the problem that
> remains I think is seeing if the optimization problem is: a) reliable
> and b) fast enough
> 
> Cheers,
> Pedro.
> 
> [1] http://www.benfrederickson.com/numerical-optimization/
> [2] https://en.wikipedia.org/wiki/Stochastic_optimization
> 
> 2017-04-22 18:51 GMT+02:00 Loic Dachary <loic@dachary.org>:
>> Hi Pedro,
>>
>> I tried the optimize function you suggested and got it to work[1]! It is my first time with scipy.optimize[2] and I'm not sure this is done right. In a nutshell I chose the Nedler-Mead method[3] because it seemed simpler. The initial guess is set to the target weights and the loss function simply is the standard deviation of the difference between the expected object count per device and the actual object count returned by the simulation. I'm pretty sure this is not right but I don't know what else to do and it's not completely wrong either. The sum of the differences seems simpler and probably gives the same results.
>>
>> I ran the optimization to fix the uneven distribution we see when there are not enough samples, because the simulation runs faster than with the multipick anomaly. I suppose it could also work to fix the multipick anomaly. I assume it's ok to use the same method even though the root case of the uneven distribution is different because we're not using a gradient based optimization. But I'm not sure and maybe this is completely wrong...
>>
>> Before optimization the situation is:
>>
>>          ~expected~  ~objects~  ~delta~   ~delta%~
>> ~name~
>> dc1            1024       1024        0   0.000000
>> host0           256        294       38  14.843750
>> device0         128        153       25  19.531250
>> device1         128        141       13  10.156250
>> host1           256        301       45  17.578125
>> device2         128        157       29  22.656250
>> device3         128        144       16  12.500000
>> host2           512        429      -83 -16.210938
>> device4         128         96      -32 -25.000000
>> device5         128        117      -11  -8.593750
>> device6         256        216      -40 -15.625000
>>
>> and after optimization we have the following:
>>
>>          ~expected~  ~objects~  ~delta~  ~delta%~
>> ~name~
>> dc1            1024       1024        0  0.000000
>> host0           256        259        3  1.171875
>> device0         128        129        1  0.781250
>> device1         128        130        2  1.562500
>> host1           256        258        2  0.781250
>> device2         128        129        1  0.781250
>> device3         128        129        1  0.781250
>> host2           512        507       -5 -0.976562
>> device4         128        126       -2 -1.562500
>> device5         128        127       -1 -0.781250
>> device6         256        254       -2 -0.781250
>>
>> Do you think I should keep going in this direction ? Now that CRUSH can use multiple weights[4] we have a convenient way to use these optimized values.
>>
>> Cheers
>>
>> [1] http://libcrush.org/main/python-crush/merge_requests/40/diffs#614384bdef0ae975388b03cf89fc7226aa7d2566_58_180
>> [2] https://docs.scipy.org/doc/scipy/reference/tutorial/optimize.html
>> [3] https://docs.scipy.org/doc/scipy/reference/optimize.minimize-neldermead.html#optimize-minimize-neldermead
>> [4] https://github.com/ceph/ceph/pull/14486
>>
>> On 03/23/2017 04:32 PM, Pedro López-Adeva wrote:
>>> There are lot of gradient-free methods. I will try first to run the
>>> ones available using just scipy
>>> (https://docs.scipy.org/doc/scipy-0.18.1/reference/optimize.html).
>>> Some of them don't require the gradient and some of them can estimate
>>> it. The reason to go without the gradient is to run the CRUSH
>>> algorithm as a black box. In that case this would be the pseudo-code:
>>>
>>> - BEGIN CODE -
>>> def build_target(desired_freqs):
>>>     def target(weights):
>>>         # run a simulation of CRUSH for a number of objects
>>>         sim_freqs = run_crush(weights)
>>>         # Kullback-Leibler divergence between desired frequencies and
>>> current ones
>>>         return loss(sim_freqs, desired_freqs)
>>>    return target
>>>
>>> weights = scipy.optimize.minimize(build_target(desired_freqs))
>>> - END CODE -
>>>
>>> The tricky thing here is that this procedure can be slow if the
>>> simulation (run_crush) needs to place a lot of objects to get accurate
>>> simulated frequencies. This is true specially if the minimize method
>>> attempts to approximate the gradient using finite differences since it
>>> will evaluate the target function a number of times proportional to
>>> the number of weights). Apart from the ones in scipy I would try also
>>> optimization methods that try to perform as few evaluations as
>>> possible like for example HyperOpt
>>> (http://hyperopt.github.io/hyperopt/), which by the way takes into
>>> account that the target function can be noisy.
>>>
>>> This black box approximation is simple to implement and makes the
>>> computer do all the work instead of us.
>>> I think that this black box approximation is worthy to try even if
>>> it's not the final one because if this approximation works then we
>>> know that a more elaborate one that computes the gradient of the CRUSH
>>> algorithm will work for sure.
>>>
>>> I can try this black box approximation this weekend not on the real
>>> CRUSH algorithm but with the simple implementation I did in python. If
>>> it works it's just a matter of substituting one simulation with
>>> another and see what happens.
>>>
>>> 2017-03-23 15:13 GMT+01:00 Loic Dachary <loic@dachary.org>:
>>>> Hi Pedro,
>>>>
>>>> On 03/23/2017 12:49 PM, Pedro López-Adeva wrote:
>>>>> Hi Loic,
>>>>>
>>>>> >From what I see everything seems OK.
>>>>
>>>> Cool. I'll keep going in this direction then !
>>>>
>>>>> The interesting thing would be to
>>>>> test on some complex mapping. The reason is that "CrushPolicyFamily"
>>>>> is right now modeling just a single straw bucket not the full CRUSH
>>>>> algorithm.
>>>>
>>>> A number of use cases use a single straw bucket, maybe the majority of them. Even though it does not reflect the full range of what crush can offer, it could be useful. To be more specific, a crush map that states "place objects so that there is at most one replica per host" or "one replica per rack" is common. Such a crushmap can be reduced to a single straw bucket that contains all the hosts and by using the CrushPolicyFamily, we can change the weights of each host to fix the probabilities. The hosts themselves contain disks with varying weights but I think we can ignore that because crush will only recurse to place one object within a given host.
>>>>
>>>>> That's the work that remains to be done. The only way that
>>>>> would avoid reimplementing the CRUSH algorithm and computing the
>>>>> gradient would be treating CRUSH as a black box and eliminating the
>>>>> necessity of computing the gradient either by using a gradient-free
>>>>> optimization method or making an estimation of the gradient.
>>>>
>>>> By gradient-free optimization you mean simulated annealing or Monte Carlo ?
>>>>
>>>> Cheers
>>>>
>>>>>
>>>>>
>>>>> 2017-03-20 11:49 GMT+01:00 Loic Dachary <loic@dachary.org>:
>>>>>> Hi,
>>>>>>
>>>>>> I modified the crush library to accept two weights (one for the first disk, the other for the remaining disks)[1]. This really is a hack for experimentation purposes only ;-) I was able to run a variation of your code[2] and got the following results which are encouraging. Do you think what I did is sensible ? Or is there a problem I don't see ?
>>>>>>
>>>>>> Thanks !
>>>>>>
>>>>>> Simulation: R=2 devices capacity [10  8  6 10  8  6 10  8  6]
>>>>>> ------------------------------------------------------------------------
>>>>>> Before: All replicas on each hard drive
>>>>>> Expected vs actual use (20000 samples)
>>>>>>  disk 0: 1.39e-01 1.12e-01
>>>>>>  disk 1: 1.11e-01 1.10e-01
>>>>>>  disk 2: 8.33e-02 1.13e-01
>>>>>>  disk 3: 1.39e-01 1.11e-01
>>>>>>  disk 4: 1.11e-01 1.11e-01
>>>>>>  disk 5: 8.33e-02 1.11e-01
>>>>>>  disk 6: 1.39e-01 1.12e-01
>>>>>>  disk 7: 1.11e-01 1.12e-01
>>>>>>  disk 8: 8.33e-02 1.10e-01
>>>>>> it=    1 jac norm=1.59e-01 loss=5.27e-03
>>>>>> it=    2 jac norm=1.55e-01 loss=5.03e-03
>>>>>> ...
>>>>>> it=  212 jac norm=1.02e-03 loss=2.41e-07
>>>>>> it=  213 jac norm=1.00e-03 loss=2.31e-07
>>>>>> Converged to desired accuracy :)
>>>>>> After: All replicas on each hard drive
>>>>>> Expected vs actual use (20000 samples)
>>>>>>  disk 0: 1.39e-01 1.42e-01
>>>>>>  disk 1: 1.11e-01 1.09e-01
>>>>>>  disk 2: 8.33e-02 8.37e-02
>>>>>>  disk 3: 1.39e-01 1.40e-01
>>>>>>  disk 4: 1.11e-01 1.13e-01
>>>>>>  disk 5: 8.33e-02 8.08e-02
>>>>>>  disk 6: 1.39e-01 1.38e-01
>>>>>>  disk 7: 1.11e-01 1.09e-01
>>>>>>  disk 8: 8.33e-02 8.48e-02
>>>>>>
>>>>>>
>>>>>> Simulation: R=2 devices capacity [10 10 10 10  1]
>>>>>> ------------------------------------------------------------------------
>>>>>> Before: All replicas on each hard drive
>>>>>> Expected vs actual use (20000 samples)
>>>>>>  disk 0: 2.44e-01 2.36e-01
>>>>>>  disk 1: 2.44e-01 2.38e-01
>>>>>>  disk 2: 2.44e-01 2.34e-01
>>>>>>  disk 3: 2.44e-01 2.38e-01
>>>>>>  disk 4: 2.44e-02 5.37e-02
>>>>>> it=    1 jac norm=2.43e-01 loss=2.98e-03
>>>>>> it=    2 jac norm=2.28e-01 loss=2.47e-03
>>>>>> ...
>>>>>> it=   37 jac norm=1.28e-03 loss=3.48e-08
>>>>>> it=   38 jac norm=1.07e-03 loss=2.42e-08
>>>>>> Converged to desired accuracy :)
>>>>>> After: All replicas on each hard drive
>>>>>> Expected vs actual use (20000 samples)
>>>>>>  disk 0: 2.44e-01 2.46e-01
>>>>>>  disk 1: 2.44e-01 2.44e-01
>>>>>>  disk 2: 2.44e-01 2.41e-01
>>>>>>  disk 3: 2.44e-01 2.45e-01
>>>>>>  disk 4: 2.44e-02 2.33e-02
>>>>>>
>>>>>>
>>>>>> [1] crush hack http://libcrush.org/main/libcrush/commit/6efda297694392d0b07845eb98464a0dcd56fee8
>>>>>> [2] python-crush hack http://libcrush.org/dachary/python-crush/commit/d9202fcd4d17cd2a82b37ec20c1bd25f8f2c4b68
>>>>>>
>>>>>> On 03/19/2017 11:31 PM, Loic Dachary wrote:
>>>>>>> Hi Pedro,
>>>>>>>
>>>>>>> It looks like trying to experiment with crush won't work as expected because crush does not distinguish the probability of selecting the first device from the probability of selecting the second or third device. Am I mistaken ?
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> On 03/18/2017 10:21 AM, Loic Dachary wrote:
>>>>>>>> Hi Pedro,
>>>>>>>>
>>>>>>>> I'm going to experiment with what you did at
>>>>>>>>
>>>>>>>> https://github.com/plafl/notebooks/blob/master/replication.ipynb
>>>>>>>>
>>>>>>>> and the latest python-crush published today. A comparison function was added that will help measure the data movement. I'm hoping we can release an offline tool based on your solution. Please let me know if I should wait before diving into this, in case you have unpublished drafts or new ideas.
>>>>>>>>
>>>>>>>> Cheers
>>>>>>>>
>>>>>>>> On 03/09/2017 09:47 AM, Pedro López-Adeva wrote:
>>>>>>>>> Great, thanks for the clarifications.
>>>>>>>>> I also think that the most natural way is to keep just a set of
>>>>>>>>> weights in the CRUSH map and update them inside the algorithm.
>>>>>>>>>
>>>>>>>>> I keep working on it.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2017-03-08 0:06 GMT+01:00 Sage Weil <sage@newdream.net>:
>>>>>>>>>> Hi Pedro,
>>>>>>>>>>
>>>>>>>>>> Thanks for taking a look at this!  It's a frustrating problem and we
>>>>>>>>>> haven't made much headway.
>>>>>>>>>>
>>>>>>>>>> On Thu, 2 Mar 2017, Pedro López-Adeva wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> I will have a look. BTW, I have not progressed that much but I have
>>>>>>>>>>> been thinking about it. In order to adapt the previous algorithm in
>>>>>>>>>>> the python notebook I need to substitute the iteration over all
>>>>>>>>>>> possible devices permutations to iteration over all the possible
>>>>>>>>>>> selections that crush would make. That is the main thing I need to
>>>>>>>>>>> work on.
>>>>>>>>>>>
>>>>>>>>>>> The other thing is of course that weights change for each replica.
>>>>>>>>>>> That is, they cannot be really fixed in the crush map. So the
>>>>>>>>>>> algorithm inside libcrush, not only the weights in the map, need to be
>>>>>>>>>>> changed. The weights in the crush map should reflect then, maybe, the
>>>>>>>>>>> desired usage frequencies. Or maybe each replica should have their own
>>>>>>>>>>> crush map, but then the information about the previous selection
>>>>>>>>>>> should be passed to the next replica placement run so it avoids
>>>>>>>>>>> selecting the same one again.
>>>>>>>>>>
>>>>>>>>>> My suspicion is that the best solution here (whatever that means!)
>>>>>>>>>> leaves the CRUSH weights intact with the desired distribution, and
>>>>>>>>>> then generates a set of derivative weights--probably one set for each
>>>>>>>>>> round/replica/rank.
>>>>>>>>>>
>>>>>>>>>> One nice property of this is that once the support is added to encode
>>>>>>>>>> multiple sets of weights, the algorithm used to generate them is free to
>>>>>>>>>> change and evolve independently.  (In most cases any change is
>>>>>>>>>> CRUSH's mapping behavior is difficult to roll out because all
>>>>>>>>>> parties participating in the cluster have to support any new behavior
>>>>>>>>>> before it is enabled or used.)
>>>>>>>>>>
>>>>>>>>>>> I have a question also. Is there any significant difference between
>>>>>>>>>>> the device selection algorithm description in the paper and its final
>>>>>>>>>>> implementation?
>>>>>>>>>>
>>>>>>>>>> The main difference is the "retry_bucket" behavior was found to be a bad
>>>>>>>>>> idea; any collision or failed()/overload() case triggers the
>>>>>>>>>> retry_descent.
>>>>>>>>>>
>>>>>>>>>> There are other changes, of course, but I don't think they'll impact any
>>>>>>>>>> solution we come with here (or at least any solution can be suitably
>>>>>>>>>> adapted)!
>>>>>>>>>>
>>>>>>>>>> sage
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> Loïc Dachary, Artisan Logiciel Libre
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>>> Loïc Dachary, Artisan Logiciel Libre
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
