From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: CEPH IOPS Baseline Measurements with MemStore
Date: Tue, 24 Jun 2014 16:53:53 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F25D1997E@SACMBXIP01.sdcorp.global.sandisk.com>
References: <36031eee-ed15-448d-8f84-ae940f627dbc@mailpro>
	<ae132423-84b1-490c-b36e-e29ee226c8e5@mailpro>
	<CAPYLRzjzvE+1opqoEC6XNj-C+7diQsheNKwKYoNNoTtH5w5wmQ@mail.gmail.com>,<CANP1eJG2a1tg6wMs1o1HNL_nn3MWtpduot-X5HRxX6Vi11OBPQ@mail.gmail.com>
 <3472A07E6605974CBC9BC573F1BC02E4AE745C14@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:41494
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755516AbaFXRJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 13:09:58 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE745C14@CERNXCHG44.cern.ch>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Milosz Tanski <milosz@adfin.com>, Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Andres,
How many client instances you are running in parallel. For single client , you will not be seeing much difference with this sharded TP. Try to stress the cluster with more number of clients and you will be seeing throughput will not be increasing with firefly.
The aggregated output with one client and say 10 clients will be similar.
Now, I have not tested with memstore (hopefully no lock serialization within memstore)but in similar condition you may be seeing >6x or even more performance improvement with sharded TP. Try your experiment by disabling op tracker and disabling the throttle perf counters. Can't remember exact options.
I have tested this with FileStore but the fileStore fixes to make it happen are under review and hopefully it will be in mainstream soon. After that, you can try your experiment with filestore and small amount of workload compare to your system memory.
This should be similar to memstore + extra cpu hops since xfs should be serving small workload entirely from page cache.

Here may the reason for degradation.
1. _mark_event() is doing some extra work now(not there in firefly). It is printing the entire message in the latest master and thus the degradation may be. I saw this degradation and prohibit ceph osd from scaling .
2. But, disabling op tracking should not improve that since it will be still calling _mark_event() during op creation. But it is helping to reduce lock (ops_in_flight_lock) contention.
3. Now, less contention in upstream , so, sharded TP is getting more ops and sharded TP is able to generate more parallelism in the backend. Thus you are seeing significant improvement.

If you are running with default shard numbers and number of shard/thread, may be you need to tune it based on the system you are using. Try running 1 thread/shard. I have 20 cpu core system and I am getting optimal performance with ~25 shards and 1 thread/shard.

Hope this helps.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Andreas Joachim Peters
Sent: Tuesday, June 24, 2014 5:14 AM
To: Milosz Tanski; Gregory Farnum
Cc: Alexandre DERUMIER; ceph-devel
Subject: RE: CEPH IOPS Baseline Measurements with MemStore

I made the same MemStore measurements with the master branch.
It seems that the sharded write queue has no visible performance impact for this low latency backend.

On the contrary I observe a general performance regression ( e.g. 70 kHz => 44 kHz for rOP) in comparison to firefly.

If I disable the ops tracking in firefly I move from 75 => 80 kHz, in master I move from 44 => 84kHz. Maybe you know where this might come from.

Attached is the OPS tracking for -t 1 idle case  and the loaded 4x -t 10 case with the master branch.

Is there some presentation/drawing explaining the details of the OP pipelining in the OSD daemon drawing all thread pools,queues and an explanation which tuning parameters modify the behaviour of this threads/queues?

Cheers Andreas.


======================================================================================

Single wOP in fligth:

{ "time": "2014-06-24 12:06:20.499832",
                      "event": "initiated"},
                    { "time": "2014-06-24 12:06:20.500019",
                      "event": "reached_pg"},
                    { "time": "2014-06-24 12:06:20.500050",
                      "event": "started"},
                    { "time": "2014-06-24 12:06:20.500056",
                      "event": "started"},
                    { "time": "2014-06-24 12:06:20.500169",
                      "event": "op_applied"},
                    { "time": "2014-06-24 12:06:20.500187",
                      "event": "op_commit"},
                    { "time": "2014-06-24 12:06:20.500194",
                      "event": "commit_sent"},
                    { "time": "2014-06-24 12:06:20.500202",
                      "event": "done"}]]}]}

40 wOPS in flight:
                    { "time": "2014-06-24 12:09:07.313460",
                      "event": "initiated"},
                    { "time": "2014-06-24 12:09:07.316255",
                      "event": "reached_pg"},
                    { "time": "2014-06-24 12:09:07.317314",
                      "event": "started"},
                    { "time": "2014-06-24 12:09:07.317830",
                      "event": "started"},
                    { "time": "2014-06-24 12:09:07.320276",
                      "event": "op_applied"},
                    { "time": "2014-06-24 12:09:07.320346",
                      "event": "op_commit"},
                    { "time": "2014-06-24 12:09:07.320363",
                      "event": "commit_sent"},
                    { "time": "2014-06-24 12:09:07.320372",
                      "event": "done"}]]}]}




________________________________________
From: Milosz Tanski [milosz@adfin.com]
Sent: 23 June 2014 22:33
To: Gregory Farnum
Cc: Alexandre DERUMIER; Andreas Joachim Peters; ceph-devel
Subject: Re: CEPH IOPS Baseline Measurements with MemStore

I'm working on getting mutrace going on the OSD to profile the hot contented lock paths in master. Hopefully I'll have something soon.

On Mon, Jun 23, 2014 at 1:41 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Fri, Jun 20, 2014 at 12:41 AM, Alexandre DERUMIER
> <aderumier@odiso.com> wrote:
>> They are also a tracker here
>> http://tracker.ceph.com/issues/7191
>> "Replace Mutex to RWLock with fdcache_lock in FileStore"
>>
>> seem to be done, but I'm not sure it's already is the master branch ?
>
> I believe this particular patch is still not merged (reviews etc on it
> and some related things are in progress), but some other pieces of the
> puzzle are in master (but not being backported to Firefly). In
> particular, we've enabled an "ms_fast_dispatch" mechanism which
> directly queues ops from the Pipe thread into the "OpWQ" (rather than
> going through a DispatchQueue priority queue first), and we've sharded
> the OpWQ. In progress but coming soonish are patches that should
> reduce the CPU cost of lfn_find and related FileStore calls, as well
> as sharding the fdcache lock (unless that one's merged already; I
> forget).
> And it turns out the "xattr spillout" patches to avoid doing so many
> LevelDB accesses were broken, and those are fixed in master (being
> backported to Firefly shortly).
>
> So there's a fair bit of work going on to address most all of those
> noted bottlenecks; if you're interested in it you probably want to run
> tests against master and try to track the conversations on the Tracker
> and ceph-devel. :) -Greg Software Engineer #42 @ http://inktank.com |
> http://ceph.com



--
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

