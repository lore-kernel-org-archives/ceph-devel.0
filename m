From: Loic Dachary <loic@dachary.org>
Subject: Re: revisiting uneven CRUSH distributions
Date: Tue, 16 May 2017 10:14:30 +0200
Message-ID: <161f2288-931d-64d3-b380-585f54389103@dachary.org>
References: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
 <c2237c5e-165e-20be-1c9e-c239d8792c37@profihost.ag>
 <10f4d4b3-56a4-35de-ac0e-c68bb7fd182f@dachary.org>
 <1ac6382d-d963-7aed-2f31-f8b5dbe8fdf3@profihost.ag>
 <172cefc2-1189-99e8-b793-1d85fcaf6441@dachary.org>
 <d221e0d7-0b4b-3b12-b8f0-1aff391dfee9@profihost.ag>
 <ca860a8b-7ff1-4628-8a7d-f56ca02e3b82@dachary.org>
 <a3792889-8f6c-b819-5f7c-2355c5e73fbf@dachary.org>
 <92165564-0de1-67b8-eb55-ca3cdea3d0e5@profihost.ag>
 <b0afb438-e7af-c1a9-0879-5a3cfb59a3eb@dachary.org>
 <e082ee2c-9436-0bab-824d-e359b922ac9a@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46997 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdEPIOg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 May 2017 04:14:36 -0400
In-Reply-To: <e082ee2c-9436-0bab-824d-e359b922ac9a@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Stefan,

On 05/16/2017 08:15 AM, Stefan Priebe - Profihost AG wrote:
> Hello Loic,
> 
> thanks for clarification. Sounds good so far. It it planned to get
> packages out of the repo so we do not need to have pip and a compiler
> installed on the systems?

With pip 8.1+ you can get binary wheels for python-crush and its dependencies, there is no need for a compiler. I'm not sure how exactly it will be packaged though.

Cheers

> 
> Greets,
> Stefan
> 
> Am 15.05.2017 um 22:35 schrieb Loic Dachary:
>>
>>
>> On 05/15/2017 09:08 PM, Stefan Priebe - Profihost AG wrote:
>>> Hello Loic,
>>>
>>> sounds good but my initial question was if this shouldn't be integrated
>>> in ceph-deploy - so when you add OSDs it also does the correct reweight?
>>
>> Ideally it should be fully transparent and we can forget the problem ever existed. I think we'll get there, maybe with a ceph-mgr task running on a regular basis to gradually optimize when it can't be done in real time. It won't be ready for Luminous but it could be for M*.
>>
>> Cheers
>>
>>> Greets,
>>> Stefan
>>>
>>> Am 14.05.2017 um 19:46 schrieb Loic Dachary:
>>>> Hi Stefan,
>>>>
>>>> A new python-crush[1] subcommand will be available next week that you could use to rebalance your clusters. You give it a crushmap and it optimizes the weights to fix the uneven distribution. It can produce a series of crushmaps, each with a small modification so that you can gradually improve the situation and better control how many PGs are moving.
>>>>
>>>> Would that be useful for the clusters you have ?
>>>>
>>>> Cheers
>>>>
>>>> [1] http://crush.readthedocs.io/
>>>>
>>>> On 05/02/2017 09:32 AM, Loic Dachary wrote:
>>>>>
>>>>>
>>>>> On 05/02/2017 07:43 AM, Stefan Priebe - Profihost AG wrote:
>>>>>> Hi Loic,
>>>>>>
>>>>>> yes i didn't changed them to straw2 as i didn't saw any difference. I
>>>>>> switched to straw2 now but it didn't change anything at all.
>>>>>
>>>>> straw vs straw2 is not responsible for the uneven distribution you're seeing. I meant to say the optimization only works on straw2 buckets, it is not implemented for straw buckets.
>>>>>
>>>>>> If i use those weights manuall i've to adjust them on every crush change
>>>>>> on the cluster? That's something i don't really like to do.
>>>>>
>>>>> This is not practical indeed :-) I'm hoping python-crush can automate that.
>>>>>
>>>>> Cheers
>>>>>
>>>>>> Greets,
>>>>>> Stefan
>>>>>>
>>>>>> Am 02.05.2017 um 01:12 schrieb Loic Dachary:
>>>>>>> It is working, with straw2 (your cluster still is using straw).
>>>>>>>
>>>>>>> For instance for one host it goes from:
>>>>>>>
>>>>>>>         ~expected~  ~objects~  ~over/under used %~  ~delta~  ~delta%~
>>>>>>> ~name~
>>>>>>> osd.24         149        159                 6.65     10.0      6.71
>>>>>>> osd.29         149        159                 6.65     10.0      6.71
>>>>>>> osd.0           69         77                11.04      8.0     11.59
>>>>>>> osd.2           69         69                -0.50      0.0      0.00
>>>>>>> osd.42         149        148                -0.73     -1.0     -0.67
>>>>>>> osd.1           69         62               -10.59     -7.0    -10.14
>>>>>>> osd.23          69         62               -10.59     -7.0    -10.14
>>>>>>> osd.36         149        132               -11.46    -17.0    -11.41
>>>>>>>
>>>>>>> to
>>>>>>>
>>>>>>>         ~expected~  ~objects~  ~over/under used %~  ~delta~  ~delta%~
>>>>>>> ~name~
>>>>>>> osd.0           69         69                -0.50      0.0      0.00
>>>>>>> osd.23          69         69                -0.50      0.0      0.00
>>>>>>> osd.24         149        149                -0.06      0.0      0.00
>>>>>>> osd.29         149        149                -0.06      0.0      0.00
>>>>>>> osd.36         149        149                -0.06      0.0      0.00
>>>>>>> osd.1           69         68                -1.94     -1.0     -1.45
>>>>>>> osd.2           69         68                -1.94     -1.0     -1.45
>>>>>>> osd.42         149        147                -1.40     -2.0     -1.34
>>>>>>>
>>>>>>> By changing the weights to
>>>>>>>
>>>>>>> [0.6609248140022604, 0.9148542821020436, 0.8174711575190294, 0.8870680217468655, 1.6031393139865695, 1.5871079208467038, 1.8784764188501162, 1.7308530904776616]
>>>>>>>
>>>>>>> And you could set these weights on the crushmap, there would be no need for backporting.
>>>>>>>
>>>>>>>
>>>>>>> On 05/01/2017 08:06 PM, Stefan Priebe - Profihost AG wrote:
>>>>>>>> Am 01.05.2017 um 19:47 schrieb Loic Dachary:
>>>>>>>>> Hi Stefan,
>>>>>>>>>
>>>>>>>>> On 05/01/2017 07:15 PM, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>> That sounds amazing! Is there any chance this will be backported to jewel?
>>>>>>>>>
>>>>>>>>> There should be ways to make that work with kraken and jewel. It may not even require a backport. If you know of a cluster with an uneven distribution, it would be great if you could send the crushmap so that I can test the algorithm. I'm still not sure this is the right solution and it would help confirm that.
>>>>>>>>
>>>>>>>> I've lots of them ;-)
>>>>>>>>
>>>>>>>> Will sent you one via private e-mail in some minutes.
>>>>>>>>
>>>>>>>> Greets,
>>>>>>>> Stefan
>>>>>>>>
>>>>>>>>> Cheers
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Greets,
>>>>>>>>>> Stefan
>>>>>>>>>>
>>>>>>>>>> Am 30.04.2017 um 16:15 schrieb Loic Dachary:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> Ideally CRUSH distributes PGs evenly on OSDs so that they all fill in
>>>>>>>>>>> the same proportion. If an OSD is 75% full, it is expected that all
>>>>>>>>>>> other OSDs are also 75% full.
>>>>>>>>>>>
>>>>>>>>>>> In reality the distribution is even only when more than 100,000 PGs
>>>>>>>>>>> are distributed in a pool of size 1 (i.e. no replication).
>>>>>>>>>>>
>>>>>>>>>>> In small clusters there are a few thousands PGs and it is not enough
>>>>>>>>>>> to get an even distribution. Running the following with
>>>>>>>>>>> python-crush[1], shows a 15% difference when distributing 1,000 PGs on
>>>>>>>>>>> 6 devices. Only with 1,000,000 PGs does the difference drop under 1%.
>>>>>>>>>>>
>>>>>>>>>>>   for PGs in 1000 10000 100000 1000000 ; do
>>>>>>>>>>>     crush analyze --replication-count 1 \
>>>>>>>>>>>                   --type device \
>>>>>>>>>>>                   --values-count $PGs \
>>>>>>>>>>>                   --rule data \
>>>>>>>>>>>                   --crushmap tests/sample-crushmap.json
>>>>>>>>>>>   done
>>>>>>>>>>>
>>>>>>>>>>> In larger clusters, even though a greater number of PGs are
>>>>>>>>>>> distributed, there are at most a few dozens devices per host and the
>>>>>>>>>>> problem remains. On a machine with 24 OSDs each expected to handle a
>>>>>>>>>>> few hundred PGs, a total of a few thousands PGs are distributed which
>>>>>>>>>>> is not enough to get an even distribution.
>>>>>>>>>>>
>>>>>>>>>>> There is a secondary reason for the distribution to be uneven, when
>>>>>>>>>>> there is more than one replica. The second replica must be on a
>>>>>>>>>>> different device than the first replica. This conditional probability
>>>>>>>>>>> is not taken into account by CRUSH and would create an uneven
>>>>>>>>>>> distribution if more than 10,000 PGs were distributed per OSD[2]. But
>>>>>>>>>>> a given OSD can only handle a few hundred PGs and this conditional
>>>>>>>>>>> probability bias is dominated by the uneven distribution caused by the
>>>>>>>>>>> low number of PGs.
>>>>>>>>>>>
>>>>>>>>>>> The uneven CRUSH distributions are always caused by a low number of
>>>>>>>>>>> samples, even in large clusters. Since this noise (i.e. the difference
>>>>>>>>>>> between the desired distribution and the actual distribution) is
>>>>>>>>>>> random, it cannot be fixed by optimizations methods.  The
>>>>>>>>>>> Nedler-Mead[3] simplex converges to a local minimum that is far from
>>>>>>>>>>> the optimal minimum in many cases. Broyden–Fletcher–Goldfarb–Shanno[4]
>>>>>>>>>>> fails to find a gradient that would allow it to converge faster. And
>>>>>>>>>>> even if it did, the local minimum found would be as often wrong as
>>>>>>>>>>> with Nedler-Mead, only it would go faster. A least mean squares
>>>>>>>>>>> filter[5] is equally unable to suppress the noise created by the
>>>>>>>>>>> uneven distribution because no coefficients can model a random noise.
>>>>>>>>>>>
>>>>>>>>>>> With that in mind, I implemented a simple optimization algorithm[6]
>>>>>>>>>>> which was first suggested by Thierry Delamare a few weeks ago. It goes
>>>>>>>>>>> like this:
>>>>>>>>>>>
>>>>>>>>>>>     - Distribute the desired number of PGs[7]
>>>>>>>>>>>     - Subtract 1% of the weight of the OSD that is the most over used
>>>>>>>>>>>     - Add the subtracted weight to the OSD that is the most under used
>>>>>>>>>>>     - Repeat until the Kullback–Leibler divergence[8] is small enough
>>>>>>>>>>>
>>>>>>>>>>> Quoting Adam Kupczyk, this works because:
>>>>>>>>>>>
>>>>>>>>>>>   "...CRUSH is not random proces at all, it behaves in numerically
>>>>>>>>>>>    stable way.  Specifically, if we increase weight on one node, we
>>>>>>>>>>>    will get more PGs on this node and less on every other node:
>>>>>>>>>>>    CRUSH([10.1, 10, 10, 5, 5]) -> [146(+3), 152, 156(-2), 70(-1), 76]"
>>>>>>>>>>>
>>>>>>>>>>> A nice side effect of this optimization algorithm is that it does not
>>>>>>>>>>> change the weight of the bucket containing the items being
>>>>>>>>>>> optimized. It is local to a bucket with no influence on the other
>>>>>>>>>>> parts of the crushmap (modulo the conditional probability bias).
>>>>>>>>>>>
>>>>>>>>>>> In all tests the situation improves at least by an order of
>>>>>>>>>>> magnitude. For instance when there is a 30% difference between two
>>>>>>>>>>> OSDs, it is down to less than 3% after optimization.
>>>>>>>>>>>
>>>>>>>>>>> The tests for the optimization method can be run with
>>>>>>>>>>>
>>>>>>>>>>>    git clone -b wip-fix-2 http://libcrush.org/dachary/python-crush.git
>>>>>>>>>>>    tox -e py27 -- -s -vv -k test_fix tests/test_analyze.py
>>>>>>>>>>>
>>>>>>>>>>> If anyone think of a reason why this algorithm won't work in some
>>>>>>>>>>> cases, please speak up :-)
>>>>>>>>>>>
>>>>>>>>>>> Cheers
>>>>>>>>>>>
>>>>>>>>>>> [1] python-crush http://crush.readthedocs.io/
>>>>>>>>>>> [2] crush multipick anomaly http://marc.info/?l=ceph-devel&m=148539995928656&w=2
>>>>>>>>>>> [3] Nedler-Mead https://en.wikipedia.org/wiki/Nelder%E2%80%93Mead_method
>>>>>>>>>>> [4] L-BFGS-B https://docs.scipy.org/doc/scipy-0.18.1/reference/optimize.minimize-lbfgsb.html#optimize-minimize-lbfgsb
>>>>>>>>>>> [5] Least mean squares filter https://en.wikipedia.org/wiki/Least_mean_squares_filter
>>>>>>>>>>> [6] http://libcrush.org/dachary/python-crush/blob/c6af9bbcbef7123af84ee4d75d63dd1b967213a2/tests/test_analyze.py#L39
>>>>>>>>>>> [7] Predicting Ceph PG placement http://dachary.org/?p=4020
>>>>>>>>>>> [8] Kullback–Leibler divergence https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence
>>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>
>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
