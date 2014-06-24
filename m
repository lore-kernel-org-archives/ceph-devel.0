From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH IOPS Baseline Measurements with MemStore
Date: Tue, 24 Jun 2014 12:13:42 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE745C14@CERNXCHG44.cern.ch>
References: <36031eee-ed15-448d-8f84-ae940f627dbc@mailpro>
	<ae132423-84b1-490c-b36e-e29ee226c8e5@mailpro>
	<CAPYLRzjzvE+1opqoEC6XNj-C+7diQsheNKwKYoNNoTtH5w5wmQ@mail.gmail.com>,<CANP1eJG2a1tg6wMs1o1HNL_nn3MWtpduot-X5HRxX6Vi11OBPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:1287 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbaFXMNq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 08:13:46 -0400
In-Reply-To: <CANP1eJG2a1tg6wMs1o1HNL_nn3MWtpduot-X5HRxX6Vi11OBPQ@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>, Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

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

I'm working on getting mutrace going on the OSD to profile the hot
contented lock paths in master. Hopefully I'll have something soon.

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
> and ceph-devel. :)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com



--
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
