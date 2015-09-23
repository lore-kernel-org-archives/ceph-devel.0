From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: perf counters from a performance discrepancy
Date: Wed, 23 Sep 2015 11:25:57 -0700
Message-ID: <CAJ4mKGavY4ZdutpjnKduQ1AcpCpHDeWST8NyOa_RT19W+DvrNQ@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com>
	<alpine.DEB.2.00.1509231116580.13265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37257 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbbIWS0A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 14:26:00 -0400
Received: by wicfx3 with SMTP id fx3so81869018wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 11:25:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509231116580.13265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Deneau, Tom" <tom.deneau@amd.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 11:19 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 23 Sep 2015, Deneau, Tom wrote:
>> Hi all --
>>
>> Looking for guidance with perf counters...
>> I am trying to see whether the perf counters can tell me anything ab=
out the following discrepancy
>>
>> I populate a number of 40k size objects in each of two pools, poolA =
and poolB.
>> Both pools cover osds on a single node, 5 osds total.
>>
>>    * Config 1 (1p):
>>       * use single rados bench client with 32 threads to do seq read=
 of 20000 objects from poolA.
>>
>>    * Config 2 (2p):
>>       * use two concurrent rados bench clients (running on same clie=
nt node) with 16 threads each,
>>            one reading 10000 objects from poolA,
>>            one reading 10000 objects from poolB,
>>
>> So in both configs, we have 32 threads total and the number of objec=
ts read is the same.
>> Note: in all cases, we drop the caches before doing the seq reads
>>
>> The combined bandwidth (MB/sec) for the 2 clients in config 2 is abo=
ut 1/3 of the bandwidth for
>> the single client in config 1.
>
> How were the object written?  I assume the cluster is backed by spinn=
ing
> disks?
>
> I wonder if this is a disk layout issue.  If the 20,000 objects are
> written in order, they willb e roughly sequential on disk, and the 32
> thread case will read them in order.  In the 2x 10,000 case, the two
> clients are reading two sequences of objects written at different
> times, and the disk arms will be swinging around more.
>
> My guess is that if the reads were reading the objects in a random or=
der
> the performance would be the same... I'm not sure that rados bench do=
es
> that though?
>
> sage
>
>>
>>
>> I gathered perf counters before and after each run and looked at the=
 difference of
>> the before and after counters for both the 1p and 2p cases.  Here ar=
e some things I noticed
>> that are different between the two runs.  Can someone take a look an=
d let me know
>> whether any of these differences are significant.  In particular, fo=
r the
>> throttle-msgr_dispatch_throttler ones, since I don't know the detail=
ed definitions of these fields.
>> Note: these are the numbers for one of the 5 osds, the other osds ar=
e similar...
>>
>> * The field osd/loadavg is always about 3 times higher on the 2p c
>>
>> some latency-related counters
>> ------------------------------
>> osd/op_latency/sum 1p=3D6.24801117205061, 2p=3D579.722513078945
>> osd/op_process_latency/sum 1p=3D3.48506945394911, 2p=3D42.6278494549=
915
>> osd/op_r_latency/sum 1p=3D6.2480111719924, 2p=3D579.722513079003
>> osd/op_r_process_latency/sum 1p=3D3.48506945399276, 2p=3D42.62784945=
50061

So, yep, the individual read ops are taking much longer in the
two-client case. Naively that's pretty odd.

>>
>>
>> and some throttle-msgr_dispatch_throttler related counters
>> ----------------------------------------------------------
>> throttle-msgr_dispatch_throttler-client/get 1p=3D1337, 2p=3D1339, di=
ff=3D2
>> throttle-msgr_dispatch_throttler-client/get_sum 1p=3D222877, 2p=3D22=
3088, diff=3D211
>> throttle-msgr_dispatch_throttler-client/put 1p=3D1337, 2p=3D1339, di=
ff=3D2
>> throttle-msgr_dispatch_throttler-client/put_sum 1p=3D222877, 2p=3D22=
3088, diff=3D211
>> throttle-msgr_dispatch_throttler-hb_back_server/get 1p=3D58, 2p=3D13=
4, diff=3D76
>> throttle-msgr_dispatch_throttler-hb_back_server/get_sum 1p=3D2726, 2=
p=3D6298, diff=3D3572
>> throttle-msgr_dispatch_throttler-hb_back_server/put 1p=3D58, 2p=3D13=
4, diff=3D76
>> throttle-msgr_dispatch_throttler-hb_back_server/put_sum 1p=3D2726, 2=
p=3D6298, diff=3D3572
>> throttle-msgr_dispatch_throttler-hb_front_server/get 1p=3D58, 2p=3D1=
34, diff=3D76
>> throttle-msgr_dispatch_throttler-hb_front_server/get_sum 1p=3D2726, =
2p=3D6298, diff=3D3572
>> throttle-msgr_dispatch_throttler-hb_front_server/put 1p=3D58, 2p=3D1=
34, diff=3D76
>> throttle-msgr_dispatch_throttler-hb_front_server/put_sum 1p=3D2726, =
2p=3D6298, diff=3D3572
>> throttle-msgr_dispatch_throttler-hbclient/get 1p=3D168, 2p=3D252, di=
ff=3D84
>> throttle-msgr_dispatch_throttler-hbclient/get_sum 1p=3D7896, 2p=3D11=
844, diff=3D3948
>> throttle-msgr_dispatch_throttler-hbclient/put 1p=3D168, 2p=3D252, di=
ff=3D84
>> throttle-msgr_dispatch_throttler-hbclient/put_sum 1p=3D7896, 2p=3D11=
844, diff=3D3948

IIRC these are just saying how many times the dispatch throttler was
accessed on each messenger =E2=80=94 nothing here is surprising, you're=
 doing
basically the same number of messages on the client messengers, and
the heartbeat messengers are passing more because the test takes
longer.

I'd go with Sage's idea for what is actually causing this, or try and
look at how the latency changes over time =E2=80=94 if you're going to =
two
pools instead of one, presumably you're doubling the amount of
metadata that needs to be read into memory during the run? Perhaps
that's just a significant enough effect with your settings that you're
seeing a bunch of extra directory lookups impact your throughput more
than expected... :/
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
