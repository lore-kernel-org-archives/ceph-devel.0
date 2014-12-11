From: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Subject: RE: performance latency analysis with LTTng
Date: Thu, 11 Dec 2014 06:54:54 +0000
Message-ID: <3649A15A2562B54294DE14BCE5AC79120AB1432F@FMSMSX106.amr.corp.intel.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB119F0@FMSMSX106.amr.corp.intel.com>
 <20141204102524.663f3804@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38514 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933864AbaLKGy5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Dec 2014 01:54:57 -0500
In-Reply-To: <20141204102524.663f3804@doppio>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Andreas,  Thanks for providing this info last week.  I've reviewed the data, the annotated spreadsheet is very helpful to interpret the results.    I do think we're seeing similar measurements even though I'm characterizing a more simplified environment.  The key differences are that I'm running with no replication (pool has size=1) and memstore backend.  The client (smallio_bench) in this environment, with a single OSD, qd of 1 (t=1), is seeing a latency on average of about 1200us.  My goal was to account for 100% of this latency via traces in order to determine where to focus  (with other tools, profilers, etc).  So far I'm covering about 750us of the 1200us, missing the time the commit message takes to be dispatched (received) by the client.  

In order to do this, I had to run the client on the same node as the OSD, and Vishal Verma on my team added some additional traces to the librados code.  In queue_aio_write, I don't think there's a transaction ID yet so we traced the OID in several places, and then used a script written in perl to attempt to correlate things and process the results.  

Beyond that, I think the analysis data is very similar to yours, I need to annotate it. I opted to trace out the time as "delta since last trace" instead of time since start of transaction, and so the entries with higher elapsed times indicate whatever was between those traces took a long time, not necessarily the code at the tracepoint. 

I haven't yet accounted for the entire time seen by the client.  From the time the aio_write is queued, until ms_fast_dispatch, I have about 300us of time.. quite large.   I didn't trace the pipe:reader/writer, and I see for you that's ~90us of time.     So that would cover about a third of it.    Additionally, I would like to be able to trace the dispatch of the commit ack (complete_aio_write) but at that point I don't have an OID or tid to correlate to. 

One question about the tracing code:  I am a bit concerned about using static sized arrays on the stack to populate with timing..  The reason is, any change by adding a tracepoint to a function would require updating a #define for the index, the array size, and the tracepoint (3 spots).  If one of those is missed it could result in a stack overwrite.  Is the reason for this to reduce the # of traces, or is it to make correlating times easier?  

Anyone have any ideas about the relatively high time spent between the client & pipe reader in the OSD?

Thanks,

Stephen



-----Original Message-----
From: Andreas Bluemle [mailto:andreas.bluemle@itxperts.de] 
Sent: Thursday, December 4, 2014 2:25 AM
To: Blinick, Stephen L
Cc: Ceph Development
Subject: Re: performance latency analysis with LTTng

Hi Stephen,

as mentioned yesterday at the the performance meeting, I had doing similar things as you did.

I have attached a sample from the
  - csv, which I generate from the raw lttng trace output
    using a python script.
  - ods, i.e. imported the csv file into libreoffice,
    added some headlines, reordered some things and
    added some comments to explain the whole thing.
  - pdf generated from above spreadsheet.

So what this shows is
  - information about complete individual transactions
  - some of the thread and cpu switches
  - statistical information collected by the python script
    while aggregating the original LTTng tracepoints into
    transactions

For a detailed interpretation, the source code is required; the sample was collected based on
    https://www.github.com/andreas-bluemle/ceph
    commit 13e505b19977194d65abe0a939304e4506e1c46d


Regards

Andreas Bluemle


On Wed, 3 Dec 2014 22:14:44 +0000
"Blinick, Stephen L" <stephen.l.blinick@intel.com> wrote:

> 
> [trying a 2nd time without attachments]
> 
> This is a follow-on to the discussion in the 12/3 performance
> meeting.   I wanted to share what we've done with IO path analysis
> and LTTng so far, I'd like to see if we can establish a general 
> methodology we could use to go after different areas.
> 
> We've been characterizing memstore IO path for a while, using VTune 
> and other tools.  The idea with this tracing was to get a high level
> a->b->c set of points and timings and drill down in areas which are
> larger contributors to latency.   Looking from the point of view of
> the client (i.e. rados bench), there's still some gaps in the latency 
> being totaled up by the trace processing script.  Basically:
> 
> 
> 1)  Instrument code, install, run benchmark w/ lttng tracing enabled 
> ............ qd=1, single osd, memstore, logging disabled, 4K writes 
> .......
> 
> 	Total time run:         20.001899
> 	Total writes made:      16136
> 	Write size:             4096
> 	Bandwidth (MB/sec):     3.151 
> 
> 	Stddev Bandwidth:       0.721435
> 	Max bandwidth (MB/sec): 3.39453
> 	Min bandwidth (MB/sec): 0
> 	Average Latency:        0.00123722
> 	Stddev Latency:         0.000103216
> 	Max latency:            0.002637
> 	Min latency:            0.000401
> 
> 2)  Grab the lttng trace: 
> 
> [09:34:23.661871204] (+0.000003133) cephtestnode1
> ioctximpl:aio_write: { cpu_id = 12 }, { pthread_id =
> 140262776686656 }, { oid =
> "benchmark_data_cephtestnode1_37038_object16" } [09:34:23.661873274]
> (+0.000002070) cephtestnode1 ioctximpl:queue_aio_write: { cpu_id =
> 12 }, { pthread_id = 140262776686656 }, { num = 0 } .....
> [09:34:23.662166430] (+0.000206888) cephtestnode1
> osd:ms_fast_dispatch: { cpu_id = 19 }, { pthread_id =
> 139986434324224 }, { oid =
> "benchmark_data_cephtestnode1_37038_object16", type = 8, num = 4107, 
> tid = 17, inc = 0 } [09:34:23.662176713] (+0.000010283) cephtestnode1
> oprequest:set_rmw_flags: { cpu_id = 19 }, { pthread_id =
> 139986434324224 }, { type = 8, num = 4107, tid = 17, inc = 0, flag = 
> 0x4, old_rmw_flags = 0x0, new_rmw_flags = 0x4 } [09:34:23.662193699]
> (+0.000016986) cephtestnode1 osd:enqueue_op: { cpu_id = 19 }, { 
> pthread_id = 139986434324224 }, { oid = 
> "benchmark_data_cephtestnode1_37038_object16" } ......
> 
> 3) Process it with a perl script, using the OID (traced in some
> spots) to track a single op.  When an op completes (hits the last 
> trace point that we have instrumented) we grab all the time stamps for 
> the previous tracepoints and gather the following info, which shows 
> the thread ID, and the delta in time (microseconds) since the
> last trace.    Example: Op Transition list for
> benchmark_data_cephtestnode1_37038_object53, 18 states
> 	  - [ ThrID   us ]
> 	  - [ 86656 +0000] Start-> ioctximpl:aio_write:
> 	  - [ 86656 +0010]     -> ioctximpl:queue_aio_write:
> 	  - [ 24224 +0300]     -> osd:ms_fast_dispatch:
> 	  - [ 24224 +0011]     -> oprequest:set_rmw_flags:
> 	  - [ 24224 +0017]     -> osd:enqueue_op:
> 	  - [ 24224 +0006]     -> osd:shard_index_enqueue:
> 	  - [ 24224 +0013]     -> pg:queue_op:
> 	  - [ 94688 +0068]     -> osd:opwq_process_start:
> 	  - [ 94688 +0005]     -> osd:dequeue_op:
> 	  - [ 94688 +0003]     -> mark_flagpt:reached_pg
> 	  - [ 94688 +0049]     -> mark_flagpt:started
> 	  - [ 94688 +0005]     -> mark_flagpt:started_2
> 	  - [ 94688 +0005]     -> osd:prepare_tx_enter:
> 	  - [ 94688 +0003]     -> osd:do_osd_op_pre:
> 	  - [ 94688 +0002]     -> osd:do_osd_op_pre_write:
> 	  - [ 94688 +0015]     -> osd:do_osd_op_post:
> 	  - [ 94688 +0026]     -> osd:prepare_tx_exit:
> 	  - [ 94688 +0188]     -> osd:opwq_process_finish:
> 	  === > Total: 726 us
> 
> 
> In order to see a trace of the entire run (vs just looking at 1 op or 
> an average across thousands) I generated a CSV with all of the ops as 
> well, and stuck them in a graph.
> 
> The total time tracked by the script is about 750us and rados bench 
> reports an average latency of about 1.2ms.  So there's still some 
> missing parts, I believe a fair amount is in the commit being seen by
> the client.    The IOPS measured by the script (counting the
> 'process_finish' traces) match closely with what rados bench is 
> reporting.
> 
> We have a lot of stuff turned off by using single replica and 
> memstore, but it seems the latency tracked here will still contribute
> to those configurations.   Any thoughts on how to better track a
> single op back to the client thread would be welcomed, as well as any 
> other ways of doing stuff.. Thanks!
> 
> I've attached some files with more detail but I've had troubles in the 
> past with attachments so not sure they'll go through.
> 
> Thanks,
> 
> Stephen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
