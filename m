From: Sage Weil <sage@newdream.net>
Subject: Re: measure performance / latency in blustore
Date: Thu, 14 Dec 2017 14:02:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712141401550.2838@piezo.novalocal>
References: <71b773a4-18a1-c206-2fe4-83b51cdf368c@profihost.ag> <231b2674-d2b6-b66a-ae29-72c0f2a7f1a0@profihost.ag> <alpine.DEB.2.11.1712141221340.2838@piezo.novalocal> <ad0d5df9-e75e-e4ea-6344-61f584e32dbf@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:53391 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdLNOCl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Dec 2017 09:02:41 -0500
In-Reply-To: <ad0d5df9-e75e-e4ea-6344-61f584e32dbf@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 14 Dec 2017, Stefan Priebe - Profihost AG wrote:
> 
> Am 14.12.2017 um 13:22 schrieb Sage Weil:
> > On Thu, 14 Dec 2017, Stefan Priebe - Profihost AG wrote:
> >> Hello,
> >>
> >> Am 21.11.2017 um 11:06 schrieb Stefan Priebe - Profihost AG:
> >>> Hello,
> >>>
> >>> to measure performance / latency for filestore we used:
> >>> filestore:apply_latency
> >>> filestore:commitcycle_latency
> >>> filestore:journal_latency
> >>> filestore:queue_transaction_latency_avg
> >>>
> >>> What are the correct ones for bluestore?
> >>
> >> really nobody? Does nobody track the latency under bluestore?
> > 
> > I forget the long names off the top of my head, but the interesting 
> > latency measures are marked with a low priority and come up (with a wide 
> > terminal) when you do 'ceph daemonperf osd.N'. You can see the metrics, 
> > pririties, and descriptions with 'ceph daemon osd.N perf schema'.
> 
> uhuh very long list. Any idea which ones are relevant?
> 
> ceph daemon osd.8 perf dump

If you do 'perf schema' you'll see a 'priority' property that calls out 
the important ones.  That's how the daemonperf command decides which ones 
to show (based on terminal width and priorities).

sage


 > 
> shows me a lot of stuff and even a lot of wait or latancy values.
> 
> ceph daemon osd.8 perf dump | egrep "wait|lat"
>         "kv_flush_lat": {
>         "kv_commit_lat": {
>         "kv_lat": {
>         "state_prepare_lat": {
>         "state_aio_wait_lat": {
>         "state_io_done_lat": {
>         "state_kv_queued_lat": {
>         "state_kv_commiting_lat": {
>         "state_kv_done_lat": {
>         "state_deferred_queued_lat": {
>         "state_deferred_aio_wait_lat": {
>         "state_deferred_cleanup_lat": {
>         "state_finishing_lat": {
>         "state_done_lat": {
>         "throttle_lat": {
>         "submit_lat": {
>         "commit_lat": {
>         "read_lat": {
>         "read_onode_meta_lat": {
>         "read_wait_aio_lat": {
>         "compress_lat": {
>         "decompress_lat": {
>         "csum_lat": {
>         "complete_latency": {
>         "complete_latency": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "op_latency": {
>         "op_process_latency": {
>         "op_prepare_latency": {
>         "op_r_latency": {
>         "op_r_process_latency": {
>         "op_r_prepare_latency": {
>         "op_w_latency": {
>         "op_w_process_latency": {
>         "op_w_prepare_latency": {
>         "op_rw_latency": {
>         "op_rw_process_latency": {
>         "op_rw_prepare_latency": {
>         "op_before_queue_op_lat": {
>         "op_before_dequeue_op_lat": {
>         "subop_latency": {
>         "subop_w_latency": {
>         "subop_pull_latency": {
>         "subop_push_latency": {
>         "osd_tier_flush_lat": {
>         "osd_tier_promote_lat": {
>         "osd_tier_r_lat": {
>         "initial_latency": {
>         "started_latency": {
>         "reset_latency": {
>         "start_latency": {
>         "primary_latency": {
>         "peering_latency": {
>         "backfilling_latency": {
>         "waitremotebackfillreserved_latency": {
>         "waitlocalbackfillreserved_latency": {
>         "notbackfilling_latency": {
>         "repnotrecovering_latency": {
>         "repwaitrecoveryreserved_latency": {
>         "repwaitbackfillreserved_latency": {
>         "reprecovering_latency": {
>         "activating_latency": {
>         "waitlocalrecoveryreserved_latency": {
>         "waitremoterecoveryreserved_latency": {
>         "recovering_latency": {
>         "recovered_latency": {
>         "clean_latency": {
>         "active_latency": {
>         "replicaactive_latency": {
>         "stray_latency": {
>         "getinfo_latency": {
>         "getlog_latency": {
>         "waitactingchange_latency": {
>         "incomplete_latency": {
>         "down_latency": {
>         "getmissing_latency": {
>         "waitupthru_latency": {
>         "notrecovering_latency": {
>         "get_latency": {
>         "submit_latency": {
>         "submit_sync_latency": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
>         "wait": {
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
