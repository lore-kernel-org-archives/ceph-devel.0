From: Loic Dachary <loic@dachary.org>
Subject: Re: announcing bc-ceph-reweight-by-utilization.py and Re: Calculating
 the expected PGs distribution
Date: Wed, 10 May 2017 14:35:56 +0200
Message-ID: <687b16ee-c828-6d9d-2274-9fef1deb7b03@dachary.org>
References: <4538c9b9-18a2-11b9-e5f1-00a0243c1d88@dachary.org>
 <CAJRHzqn5D24EDts1RbJfP0Kn60Y+1E2MQDMdY1_M0Y2zaJxhqg@mail.gmail.com>
 <443c9da8-54a7-7e3c-0603-3887865628fa@dachary.org>
 <ca0b9821-fc03-9bbe-423f-568827d5ff96@dachary.org>
 <f2e21f6e-5373-25de-f000-43a713902896@dachary.org>
 <491efe42-07f3-5142-e181-fad958a860bf@villaneau.fr>
 <07685bf4-61fc-fd56-d128-838ed5692965@dachary.org>
 <2f41da86-3909-02d9-7ab9-d67b9a712f67@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38188 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdEJMgF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 08:36:05 -0400
In-Reply-To: <2f41da86-3909-02d9-7ab9-d67b9a712f67@brockmann-consult.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Maloney <peter.maloney@brockmann-consult.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Peter,

You are on the right path with https://github.com/petermaloney/misc/blob/master/ceph/bc-ceph-reweight-by-utilization.py. One important aspect is missing though: you need to fix the weights starting from the top of the crush hierarchy. An OSD may be too full because the host it contains is also too full and changing the weight of the OSD alone won't fix that problem.

You may want to take a look at the experimental code at http://libcrush.org/dachary/python-crush/blob/c6af9bbcbef7123af84ee4d75d63dd1b967213a2/tests/test_analyze.py#L39 for an example of a recursive optimization.

Cheers

On 05/10/2017 12:33 PM, Peter Maloney wrote:
> On 05/10/17 08:45, Loic Dachary wrote:
>>
>> On 05/10/2017 05:31 AM, Xavier Villaneau wrote:
>>> On 05/09/2017 at 12:23 PM, Loic Dachary wrote:
>>>
>>>> Here is what I have so far:
>>>>
>>>> For N replicas, the weight of the item i (Wi) must be capped to 1/N if
>>>> Wi > 1/N.
>>>>
>>>> The difference (Wi - 1 / N) is the remainder Ri and it must
>>>> be distributed evenly among the remaining items.
>>>>
>>>> There can be at most M = N - 1 overweight items.
>>>>
>>>> R = sum of all remainder Ri
>>>>
>>>> for each overweight item, distribute the remainder to all items that are not overweight and that are not already at the maximum weight in proportion of their weight Wj += R * Wj * M
>>>>
>>>> as a result of the redistribution an item that was not overweight could become overweight and the same process must be repeated until there are no more overweight items
>>>>
>>>> I realize this is a bit naïve...
>>> Hello Loïc,
>>>
>>> Sorry if I missed some previous discussions where the context of this was explained, but I'm not sure I understand the goal of that calculation. Are you trying to predict a distribution from a set of weights, or trying to find how to rectify a distribution to make it closer to some target weights?
>> I was trying to rectify a distribution that has overweight items.
>>> If you're trying to predict a distribution, then there is actually no such thing as an "overweighted", the distribution are what they are and the same calculations apply regardless of if the weights are "unreachable" or not. If you want, I can give a detail of what I did for the 5-1-1-1-1 case (and maybe another "regular" case); it's just a question of adding up the right probabilities in the right order.
>> Understood.
>>
>>> If the goal is to achieve a target distribution, then it's a bit more tricky. This would require the algorithm to:
>>> 1. Identify cases where a given target distribution has "overweighted" items
>>> 2. If that's the case, identify the limit (i.e. "best" distribution possible) and use it to decide on a new target distribution that's within the space of reachable distributions
>>> 3. From there, a "regular" approach could apply.
>>> Maybe there are other approaches to that issue too.
>>>
>>> Just one last question: Is there a requirement to solve this problem with inexpensive calculations? Otherwise, couldn't calls to libcrush be used to get an estimate of the distribution or to do trial-and-error re-balancing?
>>>
>>> Sorry if I'm asking about stuff that was answered before; I'm lacking the context of this talk.
>> You're not actually: this was not discussed in any context so far (unless I missed something in the distant past which is possible ;-).
>>
>> The problem with 5 1 1 1 1 is that the admin who set this weights expects a distribution that cannot happen. The 5TB disk will always be underfull and the 1TB disks will always be overfull, even if the probability bias is fixed. I was hoping that we could find a way to set the weights so that an even distribution is achieved and the sysadmin does not have to know about that corner case. It does not need to be inexpensive.
>>
>> Thinking a bit more about it, there does not seem to be any way to get an even distribution. It's not a matter of tweaking the weights, as you explained in your previous mail even with an infinite weight the overweight item will still miss the desired number of PGs. The best we can do is to lower the weight of the overweight item to get a set of weights that can lead to an even distribution. We cannot fix the fact that the overweight item will be underfilled. But by fixing the weights we can fix the fact that the other items are overfilled which is what causes problems to the sysadmin.
>>
>> In our example (with 2 replicas)
>>
>> ( 5 + 1 + 1 + 1 + 1 ) / 2 = 4.5 therefore all items with a weight > 4.5 are overweight
>>
>> we remove the overweight items and sum the weight of the remaining items:
>>
>> ( 1 + 1 + 1 + 1 ) = 4
>>
>> and we divide by the number of replicas minus the number of overweight items
>>
>> 4 / ( 2 - 1 ) = 4
>>
>> and we set the weight of the overweight item to this number
>>
>> ( 4 + 1 + 1 + 1 + 1 ) / 2 = 4 therefore all items are <= maximum weight
>>
>> With three replicas:
>>
>> ( 7 + 7 + 1 + 1 + 1 + 1 + 1 + 1 ) / 3 = 6.66
>>
>> we set the weight to ( 1 + 1 + 1 + 1 + 1 + 1 ) /  ( 3 - 2 ) = 6 
>>
>> ( 6 + 6 + 1 + 1 + 1 + 1 + 1 + 1 ) / 3 = 6
>>
>> With four replicas:
>>
>> (7 + 7 + 7 + 3 + 3) / 4 = 6.75
>>
>> we set the weight to ( 3 + 3 ) / ( 4 - 3 ) = 6
>>
>> (6 + 6 + 6 + 3 + 3) / 4 = 6
>>
>> With four replicas again:
>>
>> (5 + 5 + 3 + 3 + 3) / 4 = 4.75
>>
>> we set the weight to ( 3 + 3 + 3 ) / ( 4 - 2 ) = 4.5
>>
>> (4.5 + 4.5 + 3 + 3 + 3) / 4 = 4.5
>>
>> Does that make sense ?
>>
> 
> I have been reading your thread and not really following too well... I
> thought maybe you were reimplementing the CRUSH algorithm so you can
> calculate the actual result of your weight changes. But I am not sure if
> you are saying it uses CRUSH (which would be great and could be combined
> with my ideas below) or just simulates it (which I think will fail just
> like all my attempts at calculating).
> 
> But seems at this point you haven't firmly chosen some particular
> strategy, so I wanted to add my story and strategy...
> 
> First I tried `ceph osd reweight-by-utilization` and had bad results.
> 
> Here's before I tried it (let's call this df1):
> 
>> root@ceph3:~ # ceph osd df | sort -k7n
>> ID WEIGHT   REWEIGHT SIZE   USE    AVAIL  %USE  VAR  PGS
>> 21  2.00029  1.00000  1862G   530G  1331G 28.51 0.64  48
>> 17  2.00029  1.00000  1862G   553G  1308G 29.72 0.67  48
>> 14  2.00029  1.00000  1862G   597G  1264G 32.09 0.72  48
>> 15  2.00029  1.00000  1862G   597G  1264G 32.09 0.72  45
>>  9  2.00029  1.00000  1862G   594G  1267G 31.94 0.72  49
>>  8  4.00069  1.00000  3724G  1238G  2485G 33.26 0.75 105
>>  2  4.00069  1.00000  3724G  1340G  2383G 36.00 0.81  97
>> 10  2.00029  1.00000  1862G   672G  1189G 36.10 0.81  55
>>  6  4.00069  1.00000  3724G  1442G  2281G 38.73 0.87 113
>> 19  2.00029  1.00000  1862G   749G  1112G 40.25 0.90  59
>> 24  2.00029  1.00000  1862G   782G  1080G 42.00 0.94  45
>>  5  4.00069  1.00000  3724G  1601G  2123G 42.99 0.96 109
>>  4  4.00069  1.00000  3724G  1662G  2061G 44.65 1.00 120
>> 25  2.00029  1.00000  1862G   843G  1018G 45.29 1.02  49
>>  0  4.00069  1.00000  3724G  1727G  1997G 46.37 1.04 115
>> 13  2.00029  1.00000  1862G   893G   968G 48.00 1.08  55
>> 12  2.00029  1.00000  1862G   903G   958G 48.51 1.09  59
>> 11  2.00029  1.00000  1862G   908G   953G 48.81 1.10  63
>> 16  2.00029  1.00000  1862G   918G   944G 49.30 1.11  60
>>  7  4.00069  1.00000  3724G  1874G  1849G 50.33 1.13 128
>> 26  2.00029  1.00000  1862G   943G   918G 50.65 1.14  50
>> 18  2.00029  1.00000  1862G   975G   886G 52.40 1.18  60
>> 23  2.00029  1.00000  1862G   978G   883G 52.53 1.18  58
>> 22  2.00029  1.00000  1862G  1044G   817G 56.12 1.26  75
>> 20  2.00029  1.00000  1862G  1053G   808G 56.59 1.27  69
>>  3  4.00069  1.00000  3724G  2190G  1533G 58.82 1.32 125
>>  1  4.00069  1.00000  3724G  2257G  1466G 60.62 1.36 141
>>                TOTAL 67035G 29876G 37159G 44.57                        
>> MIN/MAX VAR: 0.64/1.36  STDDEV: 9.21
> And after rerunning it for something like 2 days (with a script that ran
> it, waited until HEALTH_OK, ran again ,etc.), it was barely any better
> (df2):
> 
>> root@ceph3:~ # ceph osd df | sort -k7n
>> ID WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE  VAR  PGS
>> 21 2.00029  1.00000  1862G   534G  1327G 28.73 0.64  48
>> 17 2.00029  1.00000  1862G   557G  1304G 29.94 0.66  48
>>  9 2.00029  1.00000  1862G   598G  1263G 32.16 0.71  50
>> 15 2.00029  1.00000  1862G   602G  1259G 32.37 0.72  45
>> 14 2.00029  1.00000  1862G   603G  1258G 32.40 0.72  48
>>  8 4.00069  1.00000  3724G  1250G  2473G 33.59 0.75 105
>> 10 2.00029  1.00000  1862G   690G  1172G 37.06 0.82  58
>>  2 4.00069  1.00000  3724G  1422G  2301G 38.19 0.85  98
>>  6 4.00069  1.00000  3724G  1457G  2266G 39.13 0.87 113
>> 19 2.00029  1.00000  1862G   788G  1073G 42.36 0.94  62
>> 24 2.00029  1.00000  1862G   803G  1058G 43.16 0.96  47
>>  5 4.00069  1.00000  3724G  1631G  2092G 43.81 0.97 110
>> 13 2.00029  0.99001  1862G   837G  1024G 45.00 1.00  54
>> 25 2.00029  1.00000  1862G   853G  1008G 45.83 1.02  49
>>  4 4.00069  0.99001  3724G  1725G  1998G 46.34 1.03 119
>>  0 4.00069  0.99001  3724G  1759G  1964G 47.24 1.05 116
>> 11 2.00029  0.99001  1862G   918G   943G 49.30 1.09  63
>> 18 2.00029  0.99001  1862G   930G   931G 49.96 1.11  60
>> 26 2.00029  0.99001  1862G   946G   916G 50.80 1.13  50
>> 16 2.00029  0.99001  1862G   950G   911G 51.05 1.13  62
>>  7 4.00069  0.99001  3724G  1905G  1818G 51.18 1.14 129
>> 12 2.00029  0.99001  1862G   991G   870G 53.27 1.18  61
>> 23 2.00029  0.99001  1862G  1001G   860G 53.79 1.19  59
>> 22 2.00029  0.95001  1862G  1033G   828G 55.50 1.23  72
>>  3 4.00069  0.93002  3724G  2144G  1579G 57.59 1.28 122
>>  1 4.00069  0.91003  3724G  2163G  1561G 58.08 1.29 133
>> 20 2.00029  0.93002  1862G  1114G   747G 59.84 1.33  67
>>               TOTAL 67035G 30218G 36816G 45.08        
>> MIN/MAX VAR: 0.64/1.33  STDDEV: 9.04
> 
> And worst was that I could see some osds get more data at one time (see
> how comparing the above, osd.20 which was already too full at 56.59% is
> now fuller at 59.84%, also osd.23), and get less data another run,
> re-moving possibly the same data over and over. And each move was a few
> % of the data, so it was quite a lot overall. I didn't record the %
> misplaced numbers, but I remember them like 3-7% and some 1.5% maybe. So
> this is why I decided this strategy could never be optimal.
> 
> So then I tried calculating and estimating something like you describe
> here, but far simpler and likely more wrong, but it never acts like I
> predict. Like if I have an osd with 80 pgs and I want it to have 79 pgs,
> if I multiply the weight by 1/80, it is random whether it moves 0 pgs,
> or even up to 4 or 5 sometimes (based on ceph osd df it looks random,
> but CRUSH is not random). It didn't work well, taking more of my
> attention, but was far faster than ceph osd reweight-by-utilization. And
> here's what I ended up with before moving on to another idea (df3):
> 
>> root@ceph3:~ # ceph osd df | sort -k7n
>> ID WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE  VAR  PGS
>>  3 4.00069  0.50418  3724G  1835G  1888G 49.30 0.79  93
>> 23 2.00029  0.71783  1862G   935G   926G 50.22 0.81  55
>>  1 4.00069  0.57999  3724G  1882G  1841G 50.55 0.81  96
>> 11 2.00029  0.59999  1862G   995G   866G 53.45 0.86  54
>> 17 2.00029  1.00000  1862G  1006G   855G 54.06 0.87  61
>>  7 4.00069  0.79726  3724G  2059G  1664G 55.31 0.89 120
>>  9 2.00029  0.99001  1862G  1113G   748G 59.82 0.96  78
>>  4 4.00069  0.71181  3724G  2254G  1469G 60.55 0.97 122
>>  5 4.00069  0.81999  3724G  2295G  1429G 61.63 0.99 123
>>  8 4.00069  1.00000  3724G  2310G  1413G 62.04 1.00 147
>> 14 2.00029  1.00000  1862G  1169G   692G 62.83 1.01  68
>> 16 2.00029  0.90533  1862G  1194G   667G 64.13 1.03  72
>>  6 4.00069  0.97174  3724G  2394G  1329G 64.30 1.03 147
>> 22 2.00029  0.74290  1862G  1198G   663G 64.35 1.03  68
>> 10 2.00029  0.79999  1862G  1204G   657G 64.68 1.04  66
>>  2 4.00069  1.00000  3724G  2410G  1313G 64.73 1.04 140
>> 25 2.00029  0.85004  1862G  1213G   648G 65.17 1.05  60
>> 20 2.00029  0.89999  1862G  1222G   639G 65.64 1.05  81
>> 21 2.00029  1.00000  1862G  1228G   633G 65.99 1.06  73
>>  0 4.00069  0.81006  3724G  2464G  1259G 66.18 1.06 135
>> 15 2.00029  1.00000  1862G  1239G   622G 66.56 1.07  67
>> 24 2.00029  0.94699  1862G  1263G   598G 67.85 1.09  64
>> 18 2.00029  0.76999  1862G  1304G   557G 70.06 1.12  77
>> 26 2.00029  0.87448  1862G  1307G   554G 70.22 1.13  67
>> 13 2.00029  0.90002  1862G  1318G   543G 70.82 1.14  72
>> 12 2.00029  0.96999  1862G  1436G   425G 77.15 1.24  78
>> 19 2.00029  0.92999  1862G  1488G   373G 79.94 1.28  84
>>               TOTAL 67035G 41749G 25286G 62.28
>> MIN/MAX VAR: 0.79/1.28  STDDEV: 7.25
> 
> 
> So I decided maybe I'll just use CRUSH and not bother implementing it
> myself, but just let ceph do the normal peering. So I thought I could
> just look at the pg dump and the up vs acting OSDs, and total up the
> bytes in the pgs to estimate the space used now (acting) and in the
> future (up) by each osd (doesn't include filesystem overhead, leveldb,
> xattrs...don't know what else). And then I could change the weights all
> I want until I'm happy with the future result, then let it recover once,
> not over and over repeating the same data moving often.
> 
> So I wrote a script and use it this way:
> - optionally set recovery to low priority
>     osd max backfills = 1
>     osd recovery max active = 1
>     osd recovery op priority = 1
>     osd recover max single start = 1
>     osd op threads = ...
>     # I don't recommend this one...it slows it lots but doesn't seem to
> prevent blocked requests, unlike deep scrub sleep which is very significant.
>     # osd recovery sleep = ...
> - optionally set   ceph osd set norecover   so it will do peering, but
> not recovery... highly recommended for the first balance run, or
> testing. (for testing, also save output of ceph osd df if you want to
> undo the reweights).
> - optionally but recommended to set   ceph osd set noscrub ; ceph osd
> set nodeep-scrub
> - ./bc-ceph-reweight-by-utilization.py -al  (get the script at 
> https://github.com/petermaloney/misc/blob/master/ceph/bc-ceph-reweight-by-utilization.py
> )
> - wait until it either gets stuck (lowest becomes highest, then lowest
> again, etc. because the pg it moves is too large to be possible to hit
> the target balance), or is at your target (set by -o which is default
> 1.03), which I guess takes about 15min for a badly balanced cluster
> - check the misplaced % in ceph -s output (for me I think it was around
> 15% to go from df3 to df4)
> - if you set norecover, unset it now
> - when done, unset whatever flags you set
> 
> or just run the script always and forget the rest if you know how your
> cluster behaves with it already, including if an osd fails which I
> didn't test.
> 
> pros:
> - move way less data overall
> - and be able to see the future result right away (but slightly
> imprecise...does not include filesystem overhead)
> - has an option -l to do a loop combined with -a so you don't have to
> script something to rerun it until it's done... it looks at cluster
> health and things like that for you
> cons:
> - move all data at the same time, not "gently" ... but I don't consider
> this very important since the gentlest you can do (in theory 1 whole pg
> at a time) still takes a long time all at once, and you can set conf to
> slow it down.
> - due to doing peering so often, it would in theory make the cluster
> store many more osdmap epochs that might add some overhead to the
> cluster and clients... but I don't notice any effect.
> - probably doesn't handle some cases like osds that went down during the
> loop
> neutral:
> - probably have to rerun it after adding or removing new disks to get
> balance to be right after recovery, and each time it would add more data
> movement than without balancing
> - because it uses reweight, remember that when an osd is set out, it
> resets the weight to 1. kraken 11.2.0 should no longer do this "mon:
> preserve osd weight when marking osd out, then in (pr#11293, Sage Weil)"
> bugs:
> - when ceph osd df has "-nan" in the output (such as with an osd that is
> in the crush map but doesn't really exist), the json output is invalid
> so the python json.loads(...) function throws an exception
> 
> after recovery, here is what it looked like (df4):
> 
>> root@ceph3:~ # ceph osd df | sort -k7n
>> ID WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE  VAR  PGS
>>  9 2.00029  1.00000  1862G  1116G   745G 59.98 0.96  77
>> 10 2.00029  0.67000  1862G  1118G   743G 60.06 0.96  63
>> 17 2.00029  1.00000  1862G  1132G   729G 60.80 0.97  67
>>  8 4.00069  1.00000  3724G  2267G  1456G 60.90 0.98 140
>> 14 2.00029  0.84999  1862G  1139G   722G 61.18 0.98  65
>> 18 2.00029  0.69249  1862G  1141G   720G 61.30 0.98  67
>> 15 2.00029  0.83749  1862G  1142G   719G 61.35 0.98  62
>>  4 4.00069  0.71181  3724G  2286G  1437G 61.41 0.98 125
>>  5 4.00069  0.79999  3724G  2288G  1436G 61.44 0.98 124
>> 20 2.00029  0.89999  1862G  1152G   709G 61.88 0.99  78
>>  7 4.00069  0.90250  3724G  2325G  1398G 62.44 1.00 136
>>  0 4.00069  0.73000  3724G  2330G  1393G 62.59 1.00 125
>> 16 2.00029  0.87000  1862G  1166G   695G 62.64 1.00  77
>> 23 2.00029  0.85950  1862G  1170G   691G 62.87 1.01  64
>>  3 4.00069  0.64249  3724G  2343G  1380G 62.93 1.01 116
>>  1 4.00069  0.68449  3724G  2344G  1379G 62.95 1.01 122
>> 21 2.00029  0.87849  1862G  1173G   688G 63.04 1.01  70
>> 11 2.00029  0.75999  1862G  1174G   687G 63.07 1.01  67
>> 13 2.00029  0.81000  1862G  1174G   687G 63.09 1.01  67
>>  6 4.00069  0.97174  3724G  2349G  1374G 63.10 1.01 143
>> 12 2.00029  0.79500  1862G  1180G   681G 63.40 1.02  71
>>  2 4.00069  0.87949  3724G  2361G  1362G 63.41 1.02 129
>> 24 2.00029  0.92000  1862G  1187G   674G 63.75 1.02  60
>> 19 2.00029  0.80849  1862G  1188G   673G 63.83 1.02  70
>> 26 2.00029  0.74550  1862G  1188G   673G 63.83 1.02  56
>> 25 2.00029  0.84250  1862G  1193G   668G 64.10 1.03  59
>> 22 2.00029  0.70999  1862G  1201G   661G 64.50 1.03  68
>>               TOTAL 67035G 41841G 25194G 62.42        
>> MIN/MAX VAR: 0.96/1.03  STDDEV: 1.22
>>
> My largest PGs were about 120GB, so if you look at the lowest used 2TB
> disk above (1116G used) and add 120GB (1230 GB), you'll see it is
> probably worse (compared to osd.22 with only 1201 GB, and the fullest
> osd drives the total free space, so we would rather the highest be lower
> than the lowest be more average), so this is very close to the best I
> can do without adding more pgs.
> 
> 
> And today (at least 3 weeks later), after adding disks and data, it
> stays balanced easily, with short reruns of the script. And my largest
> pg is now 102GB, so it is slightly better balanced (df5).
> 
>> root@ceph3:~ # ceph osd df | sort -k7n
>> ID WEIGHT  REWEIGHT SIZE  USE    AVAIL  %USE  VAR  PGS
>> 15 2.00029  0.45050 1862G  1102G   759G 59.20 0.96  38
>>  9 2.00029  0.94865 1862G  1123G   738G 60.32 0.98  49
>>  3 4.00069  0.44760 3724G  2247G  1476G 60.36 0.98  72
>> 12 2.00029  0.57643 1862G  1128G   733G 60.60 0.98  41
>> 31 6.00110  0.68811 5587G  3390G  2197G 60.68 0.98 111
>>  6 4.00069  0.87955 3724G  2261G  1463G 60.71 0.98  95
>> 20 2.00029  0.34117 1862G  1135G   726G 61.00 0.99  27
>> 35 6.00110  0.76208 5587G  3419G  2167G 61.21 0.99 131
>> 27 4.00069  0.62904 3724G  2280G  1443G 61.23 0.99  88
>>  7 4.00069  0.75883 3724G  2283G  1440G 61.33 0.99  83
>> 18 2.00029  0.67392 1862G  1142G   719G 61.35 0.99  43
>> 16 2.00029  0.67917 1862G  1142G   719G 61.36 0.99  46
>>  2 4.00069  0.62636 3724G  2291G  1432G 61.53 1.00  70
>> 32 6.00110  0.62749 5587G  3441G  2145G 61.60 1.00 110
>> 25 2.00029  0.73212 1862G  1148G   713G 61.66 1.00  36
>>  1 4.00069  0.49037 3724G  2302G  1421G 61.82 1.00  74
>>  5 4.00069  0.62141 3724G  2304G  1419G 61.89 1.00  75
>> 30 6.00110  0.53374 5587G  3459G  2127G 61.92 1.00 104
>> 21 2.00029  0.63028 1862G  1153G   708G 61.94 1.00  37
>> 17 2.00029  0.95152 1862G  1157G   705G 62.14 1.00  45
>> 14 2.00029  0.78682 1862G  1157G   704G 62.16 1.01  39
>> 23 2.00029  0.94708 1862G  1158G   703G 62.21 1.01  43
>> 19 2.00029  0.38724 1862G  1158G   703G 62.22 1.01  35
>>  4 4.00069  0.61388 3724G  2317G  1407G 62.22 1.01  88
>> 26 2.00029  0.62029 1862G  1159G   702G 62.29 1.01  33
>> 10 2.00029  0.68456 1862G  1162G   699G 62.43 1.01  50
>> 13 2.00029  0.67427 1862G  1164G   697G 62.52 1.01  48
>> 29 4.00069  0.66026 3724G  2328G  1395G 62.52 1.01  72
>> 33 6.00110  0.75240 5587G  3495G  2091G 62.57 1.01 125
>>  8 4.00069  0.88206 3724G  2332G  1391G 62.64 1.01  91
>> 28 4.00069  0.72832 3724G  2333G  1390G 62.67 1.01  85
>>  0 4.00069  0.52428 3724G  2340G  1383G 62.85 1.02  72
>> 34 6.00110  0.69791 5587G  3513G  2073G 62.89 1.02 109
>> 22 2.00029  0.74596 1862G  1171G   690G 62.91 1.02  42
>> 11 2.00029  0.60620 1862G  1185G   677G 63.64 1.03  36
>> 24 2.00029  0.56110 1862G  1192G   669G 64.04 1.04  25
>>               TOTAL  109T 69088G 42641G 61.84         
>> MIN/MAX VAR: 0.96/1.04  STDDEV: 0.92
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
