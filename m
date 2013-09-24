From: Sage Weil <sage@inktank.com>
Subject: Re: Object Write Latency
Date: Tue, 24 Sep 2013 08:20:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309240817120.23531@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch> <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net> <CABZ+qqnXbycX4C_brF4eiRVb0PeA4SKf2kW_d3g8RYxwD6xFDg@mail.gmail.com> <3472A07E6605974CBC9BC573F1BC02E4A52736BE@PLOXCHG03.cern.ch>
 <5240666E.7010009@inktank.com> <3472A07E6605974CBC9BC573F1BC02E4A527376E@PLOXCHG03.cern.ch> <CABZ+qqkfo6v3TBY4vpvTGba8+L1y3k2xBU5oAHpARxMC91zZjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42779 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab3IXPUS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 11:20:18 -0400
In-Reply-To: <CABZ+qqkfo6v3TBY4vpvTGba8+L1y3k2xBU5oAHpARxMC91zZjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 24 Sep 2013, Dan van der Ster wrote:
> Hi,
> Yes, the journal is a file on same XFS partition as the data.
> 
> I have some results from a rados bench to a single-copy pool on the JBOD disks.
> 
> [root@p05151113777233 ~]# rados bench -p test 30 write -t 1 -b 5
> ...
>  Total time run:         30.027296
> Total writes made:      612
> Write size:             5
> Bandwidth (MB/sec):     0.000
> 
> Stddev Bandwidth:       1.92864e-05
> Max bandwidth (MB/sec): 0.000119209
> Min bandwidth (MB/sec): 0
> Average Latency:        0.0490627
> Stddev Latency:         0.0197453
> Max latency:            0.136101
> Min latency:            0.003991
> 
> The osd log and dump of historic ops are here:
>  http://box.cern.ch/owncloud/public.php?service=files&t=a53c229bab2179c9e1a03899a859129f
> 
> The logs are quite verbose for me, but the journal do_write latencies
> certainly stand out:
> 
> 2013-09-24 10:28:52.853011 7f03b78dd700 20 journal do_write latency 0.044686
> 2013-09-24 10:28:56.610670 7f03b78dd700 20 journal do_write latency 0.025085
> 2013-09-24 10:29:09.273017 7f03b78dd700 20 journal do_write latency 0.031082
> 2013-09-24 10:29:22.703697 7f03b78dd700 20 journal do_write latency 0.045090
> 
> If you confirm that that really is the journal write+sync latency (and
> not including the final commit to disk in that time), then I'll find
> some new boxes where I can try out the direct IO to a partitioned
> journal.

Yes.. this is write(2) and then fdatasync(2) to the journal file only.  
With a partition (well, raw block device) you will get direct-io and aio 
(several in-flight requests at once), so these latencies should go down 
quite a bit.  On a standalone disk and lots of writes you should be able 
to see the rotational timing (either sub-ms latencies or ~6-9ms or 
whatever).  For a partition, you're competing with the fs so it will be 
noisier than that.

sage

> 
> Cheers, Dan
> 
> 
> On Mon, Sep 23, 2013 at 11:40 PM, Andreas Joachim Peters
> <Andreas.Joachim.Peters@cern.ch> wrote:
> > Here is the output for one write_full on the in-memory OSD (the others look more or less the same e.g. most time is waiting for op_applied/op_commit):
> >
> > { "description": "osd_op(client.1764910.0:1 eos-root--0 [writefull 0~5] 15.fef59585 e3818)",
> >           "rmw_flags": 4,
> >           "received_at": "2013-09-23 23:33:16.536547",
> >           "age": "3.698191",
> >           "duration": "0.002225",
> >           "flag_point": "commit sent; apply or cleanup",
> >           "client_info": { "client": "client.1764910",
> >               "tid": 1},
> >           "events": [
> >                 { "time": "2013-09-23 23:33:16.536706",
> >                   "event": "waiting_for_osdmap"},
> >                 { "time": "2013-09-23 23:33:16.536807",
> >                   "event": "reached_pg"},
> >                 { "time": "2013-09-23 23:33:16.536915",
> >                   "event": "started"},
> >                 { "time": "2013-09-23 23:33:16.536936",
> >                   "event": "started"},
> >                 { "time": "2013-09-23 23:33:16.537029",
> >                   "event": "waiting for subops from [1056,1057]"},
> >                 { "time": "2013-09-23 23:33:16.537110",
> >                   "event": "commit_queued_for_journal_write"},
> >                 { "time": "2013-09-23 23:33:16.537158",
> >                   "event": "write_thread_in_journal_buffer"},
> >                 { "time": "2013-09-23 23:33:16.537242",
> >                   "event": "journaled_completion_queued"},
> >                 { "time": "2013-09-23 23:33:16.537269",
> >                   "event": "op_commit"},
> >                 { "time": "2013-09-23 23:33:16.538547",
> >                   "event": "sub_op_commit_rec"},
> >                 { "time": "2013-09-23 23:33:16.538573",
> >                   "event": "op_applied"},
> >                 { "time": "2013-09-23 23:33:16.538715",
> >                   "event": "sub_op_commit_rec"},
> >                 { "time": "2013-09-23 23:33:16.538754",
> >                   "event": "commit_sent"},
> >                 { "time": "2013-09-23 23:33:16.538772",
> >                   "event": "done"}]},
> >
> > We should probably look at the same output for the JBOD configuration ...
> >
> > Cheers Andreas.
> >
> > ________________________________________
> > From: Mark Nelson [mark.nelson@inktank.com]
> > Sent: 23 September 2013 18:03
> > To: Andreas Joachim Peters
> > Cc: Dan van der Ster; Sage Weil; ceph-devel@vger.kernel.org
> > Subject: Re: Object Write Latency
> >
> > On 09/23/2013 10:38 AM, Andreas Joachim Peters wrote:
> >> We deployed 3 OSDs with an EXT4 using RapidDisk in-memory.
> >>
> >> The FS does 140k/s append+sync and the latency is now:
> >>
> >> ~1 ms for few byte objects with single replica
> >> ~2 ms for few byte objects three replica  (instead of 65-80ms)
> >
> > Interesting!  If you look at the slowest operations in the ceph admin
> > socket now with dump_historic_ops, where are those operations spending
> > their time?
> >
> >>
> >> This gives probably the base-line of the best you can do with the current implementation.
> >>
> >> ==> the 80ms are probably just a 'feature' of the hardware (JBOD disks/controller) and we might try to find some tuning parameters to improve the latency slightly.
> >
> > Hardware definitely plays a huge part in terms of Ceph performance.  You
> > can run Ceph on just about anything, but it's surprising how different
> > two roughly similar systems can perform.
> >
> >>
> >> Could you just explain how the async api functions (is_complete, is_safe) map to the three states
> >>
> >> 1) object is transferred from client to all OSDs and is present in memory there
> >> 2) object is written to the OSD journal
> >> 3) object is committed from OSD journal to the OSD filesystem
> >>
> >> Is it correct that the object is visible by clients only when 3) has happened?
> >
> > Yes, afaik.
> >
> >>
> >> Thanks for your help,
> >> Andreas.
> >>
> >>
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> 
> 
