From: Samuel Just <sjust@redhat.com>
Subject: Re: perf counters from a performance discrepancy
Date: Wed, 23 Sep 2015 13:28:24 -0700
Message-ID: <CAN=+7FUJv4nweu5bNcVDWYJQANBMaogA1Dm6Ufuqtxw3=dqR0Q@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com>
	<alpine.DEB.2.00.1509231116580.13265@cobra.newdream.net>
	<CAJ4mKGavY4ZdutpjnKduQ1AcpCpHDeWST8NyOa_RT19W+DvrNQ@mail.gmail.com>
	<5602F298.7060609@redhat.com>
	<BC97738F8E7C8742BABED7F06FB9DF9192500B92@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36671 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbIWU2Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 16:28:25 -0400
Received: by ioii196 with SMTP id i196so55654455ioi.3
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 13:28:24 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192500B92@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Mark Nelson <mnelson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just to eliminate a variable, can you reproduce this on master, first
with the simple messenger, and then with the async messenger? (make
sure to switch the messengers on all daemons and clients, just put it
in the [global] section on all configs).
-Sam

On Wed, Sep 23, 2015 at 1:05 PM, Deneau, Tom <tom.deneau@amd.com> wrote=
:
>
>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Wednesday, September 23, 2015 1:43 PM
>> To: Gregory Farnum; Sage Weil
>> Cc: Deneau, Tom; ceph-devel@vger.kernel.org
>> Subject: Re: perf counters from a performance discrepancy
>>
>>
>>
>> On 09/23/2015 01:25 PM, Gregory Farnum wrote:
>> > On Wed, Sep 23, 2015 at 11:19 AM, Sage Weil <sage@newdream.net> wr=
ote:
>> >> On Wed, 23 Sep 2015, Deneau, Tom wrote:
>> >>> Hi all --
>> >>>
>> >>> Looking for guidance with perf counters...
>> >>> I am trying to see whether the perf counters can tell me anythin=
g
>> >>> about the following discrepancy
>> >>>
>> >>> I populate a number of 40k size objects in each of two pools, po=
olA
>> and poolB.
>> >>> Both pools cover osds on a single node, 5 osds total.
>> >>>
>> >>>     * Config 1 (1p):
>> >>>        * use single rados bench client with 32 threads to do seq=
 read
>> of 20000 objects from poolA.
>> >>>
>> >>>     * Config 2 (2p):
>> >>>        * use two concurrent rados bench clients (running on same
>> client node) with 16 threads each,
>> >>>             one reading 10000 objects from poolA,
>> >>>             one reading 10000 objects from poolB,
>> >>>
>> >>> So in both configs, we have 32 threads total and the number of o=
bjects
>> read is the same.
>> >>> Note: in all cases, we drop the caches before doing the seq read=
s
>> >>>
>> >>> The combined bandwidth (MB/sec) for the 2 clients in config 2 is
>> >>> about 1/3 of the bandwidth for the single client in config 1.
>> >>
>> >> How were the object written?  I assume the cluster is backed by
>> >> spinning disks?
>> >>
>> >> I wonder if this is a disk layout issue.  If the 20,000 objects a=
re
>> >> written in order, they willb e roughly sequential on disk, and th=
e 32
>> >> thread case will read them in order.  In the 2x 10,000 case, the =
two
>> >> clients are reading two sequences of objects written at different
>> >> times, and the disk arms will be swinging around more.
>> >>
>> >> My guess is that if the reads were reading the objects in a rando=
m
>> >> order the performance would be the same... I'm not sure that rado=
s
>> >> bench does that though?
>> >>
>> >> sage
>> >>
>> >>>
>> >>>
>> >>> I gathered perf counters before and after each run and looked at=
 the
>> >>> difference of the before and after counters for both the 1p and =
2p
>> >>> cases.  Here are some things I noticed that are different betwee=
n
>> >>> the two runs.  Can someone take a look and let me know whether a=
ny
>> >>> of these differences are significant.  In particular, for the
>> throttle-msgr_dispatch_throttler ones, since I don't know the detail=
ed
>> definitions of these fields.
>> >>> Note: these are the numbers for one of the 5 osds, the other osd=
s are
>> similar...
>> >>>
>> >>> * The field osd/loadavg is always about 3 times higher on the 2p=
 c
>> >>>
>> >>> some latency-related counters
>> >>> ------------------------------
>> >>> osd/op_latency/sum 1p=3D6.24801117205061, 2p=3D579.722513078945
>> >>> osd/op_process_latency/sum 1p=3D3.48506945394911, 2p=3D42.627849=
4549915
>> >>> osd/op_r_latency/sum 1p=3D6.2480111719924, 2p=3D579.722513079003
>> >>> osd/op_r_process_latency/sum 1p=3D3.48506945399276,
>> >>> 2p=3D42.6278494550061
>> >
>> > So, yep, the individual read ops are taking much longer in the
>> > two-client case. Naively that's pretty odd.
>> >
>> >>>
>> >>>
>> >>> and some throttle-msgr_dispatch_throttler related counters
>> >>> ----------------------------------------------------------
>> >>> throttle-msgr_dispatch_throttler-client/get 1p=3D1337, 2p=3D1339=
, diff=3D2
>> >>> throttle-msgr_dispatch_throttler-client/get_sum 1p=3D222877,
>> >>> 2p=3D223088, diff=3D211 throttle-msgr_dispatch_throttler-client/=
put
>> >>> 1p=3D1337, 2p=3D1339, diff=3D2
>> >>> throttle-msgr_dispatch_throttler-client/put_sum 1p=3D222877,
>> >>> 2p=3D223088, diff=3D211
>> >>> throttle-msgr_dispatch_throttler-hb_back_server/get 1p=3D58, 2p=3D=
134,
>> >>> diff=3D76 throttle-msgr_dispatch_throttler-hb_back_server/get_su=
m
>> >>> 1p=3D2726, 2p=3D6298, diff=3D3572
>> >>> throttle-msgr_dispatch_throttler-hb_back_server/put 1p=3D58, 2p=3D=
134,
>> >>> diff=3D76 throttle-msgr_dispatch_throttler-hb_back_server/put_su=
m
>> >>> 1p=3D2726, 2p=3D6298, diff=3D3572
>> >>> throttle-msgr_dispatch_throttler-hb_front_server/get 1p=3D58, 2p=
=3D134,
>> >>> diff=3D76 throttle-msgr_dispatch_throttler-hb_front_server/get_s=
um
>> >>> 1p=3D2726, 2p=3D6298, diff=3D3572
>> >>> throttle-msgr_dispatch_throttler-hb_front_server/put 1p=3D58, 2p=
=3D134,
>> >>> diff=3D76 throttle-msgr_dispatch_throttler-hb_front_server/put_s=
um
>> >>> 1p=3D2726, 2p=3D6298, diff=3D3572
>> >>> throttle-msgr_dispatch_throttler-hbclient/get 1p=3D168, 2p=3D252=
,
>> >>> diff=3D84 throttle-msgr_dispatch_throttler-hbclient/get_sum 1p=3D=
7896,
>> >>> 2p=3D11844, diff=3D3948 throttle-msgr_dispatch_throttler-hbclien=
t/put
>> >>> 1p=3D168, 2p=3D252, diff=3D84
>> >>> throttle-msgr_dispatch_throttler-hbclient/put_sum 1p=3D7896, 2p=3D=
11844,
>> >>> diff=3D3948
>> >
>> > IIRC these are just saying how many times the dispatch throttler w=
as
>> > accessed on each messenger =E2=80=94 nothing here is surprising, y=
ou're doing
>> > basically the same number of messages on the client messengers, an=
d
>> > the heartbeat messengers are passing more because the test takes
>> > longer.
>> >
>> > I'd go with Sage's idea for what is actually causing this, or try =
and
>> > look at how the latency changes over time =E2=80=94 if you're goin=
g to two
>> > pools instead of one, presumably you're doubling the amount of
>> > metadata that needs to be read into memory during the run? Perhaps
>> > that's just a significant enough effect with your settings that yo=
u're
>> > seeing a bunch of extra directory lookups impact your throughput m=
ore
>> > than expected... :/
>>
>> FWIW, typically if I've seen an effect, it's been the opposite where
>> multiple rados bench processes are slightly faster (maybe simply rel=
ated
>> to the client side implementation).  Running collectl or iostat woul=
d show
>> various interval statistics that would help diagnose if this is rela=
ted to
>> slower accesses on the disks.  blktrace of course would give a more
>> nuanced view.  Might be worth doing if there are extra metadata acce=
sses.
>>
>> A couple of other random thoughts:
>>
>> - Are any of the reads coming from buffer cache?
>> - Readahead not working well?
>> - Were the pools recreated between tests?
>> - If not, what were the total number of objects and PGs for each poo=
l (Is
>> it possible that the per-pg directory hirearchy was deeper for the 2=
nd set
>> of tests?)
>> - If the pools still exist, what does the following script say about=
 them?
>>
>> https://github.com/ceph/cbt/blob/master/tools/readpgdump.py
>>
>>
>
> Thanks Sage, Greg and Mark for the suggestions --
>
> The objects in the pools were created by running two simultaneous
> client rados bench write processes, one to each pool.  I started with
> empty osd disks.  The pools both cover the same osds and since
> there was a replication factor of 2, so I would have expected that no=
t
> all the primary objects in each pool would be sequential on the disk.
>
> But when I changed the read test to do rados bench rand rather than
> seq, both the 1p and 2p configs went down in bandwidth, so clearly th=
e
> disk layout had something to do with it.  With random reads, 1p is no=
w
> "only" 40% faster than 2p.
>
> Mark had mentioned that he's often seen the opposite effect, ie, more
> client processes increasing the bandwidth, and we have seen the same,
> which is why I started using multiple clients.  In fact if I do the
> same configuration tests as above but with 4M objects rather than 40K=
,
> I see the 2p beats 1p by 30% or so. (and I've seen 4p help even more)=
=2E
>
> So there's something about smaller object sizes that gets hurt by
> multiple clients vs. 1 client.
>
> I will try to look into this with some of the low level stat tools
> that Mark mentioned.
>
> -- Tom
>
>> > -Greg
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>> > in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>> > info at  http://vger.kernel.org/majordomo-info.html
>> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
