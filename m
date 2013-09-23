From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Object Write Latency
Date: Mon, 23 Sep 2013 21:40:45 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A527376E@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
 <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net>,<CABZ+qqnXbycX4C_brF4eiRVb0PeA4SKf2kW_d3g8RYxwD6xFDg@mail.gmail.com>
 <3472A07E6605974CBC9BC573F1BC02E4A52736BE@PLOXCHG03.cern.ch>,<5240666E.7010009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx32.cern.ch ([137.138.144.178]:43442 "EHLO
	CERNMX32.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab3IWVku convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 17:40:50 -0400
In-Reply-To: <5240666E.7010009@inktank.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Dan van der Ster <dan@vanderster.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Here is the output for one write_full on the in-memory OSD (the others look more or less the same e.g. most time is waiting for op_applied/op_commit):

{ "description": "osd_op(client.1764910.0:1 eos-root--0 [writefull 0~5] 15.fef59585 e3818)",
          "rmw_flags": 4,
          "received_at": "2013-09-23 23:33:16.536547",
          "age": "3.698191",
          "duration": "0.002225",
          "flag_point": "commit sent; apply or cleanup",
          "client_info": { "client": "client.1764910",
              "tid": 1},
          "events": [
                { "time": "2013-09-23 23:33:16.536706",
                  "event": "waiting_for_osdmap"},
                { "time": "2013-09-23 23:33:16.536807",
                  "event": "reached_pg"},
                { "time": "2013-09-23 23:33:16.536915",
                  "event": "started"},
                { "time": "2013-09-23 23:33:16.536936",
                  "event": "started"},
                { "time": "2013-09-23 23:33:16.537029",
                  "event": "waiting for subops from [1056,1057]"},
                { "time": "2013-09-23 23:33:16.537110",
                  "event": "commit_queued_for_journal_write"},
                { "time": "2013-09-23 23:33:16.537158",
                  "event": "write_thread_in_journal_buffer"},
                { "time": "2013-09-23 23:33:16.537242",
                  "event": "journaled_completion_queued"},
                { "time": "2013-09-23 23:33:16.537269",
                  "event": "op_commit"},
                { "time": "2013-09-23 23:33:16.538547",
                  "event": "sub_op_commit_rec"},
                { "time": "2013-09-23 23:33:16.538573",
                  "event": "op_applied"},
                { "time": "2013-09-23 23:33:16.538715",
                  "event": "sub_op_commit_rec"},
                { "time": "2013-09-23 23:33:16.538754",
                  "event": "commit_sent"},
                { "time": "2013-09-23 23:33:16.538772",
                  "event": "done"}]},

We should probably look at the same output for the JBOD configuration ...

Cheers Andreas.

________________________________________
From: Mark Nelson [mark.nelson@inktank.com]
Sent: 23 September 2013 18:03
To: Andreas Joachim Peters
Cc: Dan van der Ster; Sage Weil; ceph-devel@vger.kernel.org
Subject: Re: Object Write Latency

On 09/23/2013 10:38 AM, Andreas Joachim Peters wrote:
> We deployed 3 OSDs with an EXT4 using RapidDisk in-memory.
>
> The FS does 140k/s append+sync and the latency is now:
>
> ~1 ms for few byte objects with single replica
> ~2 ms for few byte objects three replica  (instead of 65-80ms)

Interesting!  If you look at the slowest operations in the ceph admin
socket now with dump_historic_ops, where are those operations spending
their time?

>
> This gives probably the base-line of the best you can do with the current implementation.
>
> ==> the 80ms are probably just a 'feature' of the hardware (JBOD disks/controller) and we might try to find some tuning parameters to improve the latency slightly.

Hardware definitely plays a huge part in terms of Ceph performance.  You
can run Ceph on just about anything, but it's surprising how different
two roughly similar systems can perform.

>
> Could you just explain how the async api functions (is_complete, is_safe) map to the three states
>
> 1) object is transferred from client to all OSDs and is present in memory there
> 2) object is written to the OSD journal
> 3) object is committed from OSD journal to the OSD filesystem
>
> Is it correct that the object is visible by clients only when 3) has happened?

Yes, afaik.

>
> Thanks for your help,
> Andreas.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

