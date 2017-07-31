From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: FW: Ceph dmClock
Date: Mon, 31 Jul 2017 17:21:11 -0400
Message-ID: <241e12a0-eb97-8957-f7e8-804ab447a492@redhat.com>
References: <116d5b63f1dc428998675dbe6e8c56eb@skt-tnetpmx1.SKT.AD>
 <3f6258a2100e4218a15023b82b9a156a@skt-tnetpmx1.SKT.AD>
 <e3321edabb3d42f2881c3e1ca30ad5b2@skt-tnetpmx1.SKT.AD>
 <CAKk8r1BnqHJt-EtP+9xBUE=oA8taO9ak+CdJk6BrjdhzHT3Ukw@mail.gmail.com>
 <d3e52b41-47b9-c660-1c96-6383609719ca@redhat.com>
 <CAKk8r1BadDo7KCVL0eA09TBxYLTXmtHLqzH=Tc6m8zZAVebFfw@mail.gmail.com>
 <CAKk8r1Dw1MACKhOUfyhzv5dQX5Ae+9S1B9T99qXUOGmQ4HyzWA@mail.gmail.com>
 <e2b99c22-ad7c-d0ae-6f9d-63c8d0322f20@redhat.com>
 <CAANLjFpyperAkB62s5G7bYMm2J8Z-SOu1S8imT2-QHq+AiVKaQ@mail.gmail.com>
 <CAKk8r1BH4FDBLgsVc5q8bmoWeiDXgUnaKNqNbBQCLyUWweFkrw@mail.gmail.com>
 <CANiZRW=NsZX45WieoLc6dPxiw5oSkGH2yM13aNqa42LobVniVA@mail.gmail.com>
 <CAKk8r1BFL+uaDEs7GeaybHHZLOfoka0T7Vs229tkGfZd5jjUnA@mail.gmail.com>
 <alpine.DEB.2.11.1703171420180.10776@piezo.novalocal>
 <CAKk8r1DF_LUVP=t1s8C5XsC1iOhu=yr7-LO8eKN6LP0QAs=14Q@mail.gmail.com>
 <CAKk8r1B6HM7HHQYcUWtFTjSFxOt7Ze9UvkEFhRG0xh-J8xiveQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35177 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdGaVVP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 17:21:15 -0400
Received: by mail-qt0-f170.google.com with SMTP id p3so113747806qtg.2
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jul 2017 14:21:14 -0700 (PDT)
In-Reply-To: <CAKk8r1B6HM7HHQYcUWtFTjSFxOt7Ze9UvkEFhRG0xh-J8xiveQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Byung Su Park <pbs1108@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Mark Nelson <mnelson@redhat.com>, =?UTF-8?B?67CV67OR7IiY?= <bspark8@sk.com>, =?UTF-8?B?6rmA7YOc7JuFL1NEUyBUZWNoLiBMYWI=?= <taewoong.kim@sk.com>, =?UTF-8?B?7JeE7KO86rSAL1NEUyBUZWNoLiBMYWI=?= <jugwan.eom@sk.com>, Matt Benjamin <mbenjamin@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Byungsu,

[Please note I removed from the email distribution both Sam Just (he
left Red Hat) and Trivikram Bollempalli (he graduated from UCSC). I've
added Mark Nelson since he most recently was working on the adaptive
throttle branch.]

Thank you for this excellent and exciting work. Your analysis of the
situation (first part of http://pad.ceph.com/p/throttler_for_qos) agrees
with ours. And I'm very interested in your alternative (OIO) adaptive
throttle.

I haven't worked on our adaptive throttle in a while. I recall Mark
Nelson was doing some testing with it, but I don't know where things
currently stand. But your throttle appears to have some nice qualities.

I will review your ceph/dmclock PRs #23 and #24 this week. Can you say
more about what near-term actions you're hoping from us w.r.t. your DNM
PR #16369?

Thank you,

Eric


On 07/31/2017 09:39 AM, Byung Su Park wrote:
> Hi Eric,
> 
> I would like to share what we have been doing recently with Ceph QoS.
> 
> *1. BlueStore Adaptive Throttle analysis*
> As we have seen each other in our last mail, there is a queue depth
> problem in the dmClock algorithm and we have agreed on the necessity of
> a throttle to solve it.
> 
> I have found that you have implemented Adaptive Throttle in the
> BlueStore layer (https://github.com/ceph/ceph/pull/14211). And I applied
> it to the client (pool) unit dmClock queue that we have done.
> (https://github.com/bspark8/ceph/tree/wip-dmc-bluestore-adaptive-throttle).
> 
> Detailed test results are shared through below URL.
> (1. BlueStore Adaptive Throttle,
> https://www.slideshare.net/ssusercee823/bluestore-oio-adaptivethrottleanalysis-78413363/2).
> 
> The results are summarized as follows.
> 1.A. Weight Test.
>   - There is trade off between weight QoS quality and overall
> performance when throttle is used.
>   - When using BlueStore Adaptive Throttle, about 57% reduction from
> original performance is required to achieve 1:1:10:10:10 weight.
> 1.B. Reservation Test.
>   - There is trade off between reservation QoS quality and overall
> performance when throttle is used.
>   - To guarantee Reservation, not only throttle but also additional work
> is necessary (That is, currently reservation doesn't work).
> 
> So it would be nice if we could get the current progress of bluestore
> adaptive throttle.
> (e.g. Block size / Request type unit throttle compensation, so on..). 
> 
> 
> *2. Outstanding IO based Adaptive Throttle*
> I would like to share about the Outstanding IO (OIO) based Adaptive
> Throttle that we are currently working on.
> 
> The main idea is to find the saturation performance of Ceph through the
> count of Outstanding IO in Ceph, then adaptively apply thorttle by using
> it. A more detailed design is described in the below pad URL.
> (Adaptive throttler design: http://pad.ceph.com/p/throttler_for_qos).
> 
> We also share our test results with the slide share below URL and
> summarized the results.
> (2. Outstanding IO(OIO) based Adaptive Throttle,
> https://www.slideshare.net/ssusercee823/bluestore-oio-daptivethrottleanalysis-78413363/8).
> 2.A. Weight Test.
>   - When using OIO Adaptive Throttle, about 80% reduction from original
> performance is required to achieve 1:1:10:10:10 weight.
> 2.B. Reservation.
>   - When OIO Adaptive Throttle is used, it almost guarantees a reserve
> of 40K and 30K of target value with 89% reduction in original performance.
> 
> The advantages of the proposed OIO based Adaptive throttle are as follows.
>   - No setting values for QoS (e.x. min/max latency, so on..).
>   - Good tradeoff rate between total IOPs and QoS quality.
> 
> Thus it would be great if we could get the feedback of our OIO adaptive
> throttle.
> 
> 
> *3. Currently ongoing PR*
> 3.A. Delivery of the dmclock delta, rho and phase parameter + Enabling
> the client service tracker (https://github.com/ceph/ceph/pull/16369).
>   - The work you have previously recommended is being going on in DNM PR
> format. It would be great if we could hear comments about this. It would
> be a good idea to precede this PR in order to provide per-client QoS.
> 
> 3.B. Fix delta & rho calculation for random server selection mode
> (https://github.com/ceph/dmclock/pull/23).
>   - We would like you to review this PR again to improve the QoS quality
> of the client dmClock algorithm. All tests we have done were based on
> this patch.
> 
> 3.C. Modify each client's QoS parameter applied time
> (https://github.com/ceph/dmclock/pull/24).
>   - We would like you to review this PR again too. To service QoS, it is
> necessary to the run time qos parameter change.
> 
> Thanks,
> Byungsu.
