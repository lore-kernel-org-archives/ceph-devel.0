From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal,
 normal behaviour ?
Date: Mon, 18 Jun 2012 10:16:17 -0500
Message-ID: <4FDF4641.4070405@inktank.com>
References: <d8526549-5d30-4bc2-8dc3-9f08e4640466@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58366 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2FRPQV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:16:21 -0400
Received: by gglu4 with SMTP id u4so3749836ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 08:16:20 -0700 (PDT)
In-Reply-To: <d8526549-5d30-4bc2-8dc3-9f08e4640466@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On 6/18/12 9:47 AM, Alexandre DERUMIER wrote:
>>> Yeah, I just wanted to make sure that the constant writes weren't
>>> because the filestore was falling behind. You may want to take a look
>>> at some of the information that is provided by the admin socket for the
>>> OSD while the test is running. dump_ops_in_flight, perf schema, and perf
>>> dump are all useful.
>
>
> don't know which values to check in these big json reponses ;)
> But I have try with more osd, so write are splitted on more disks and and write are smaller, and the behaviour is same

No worries, there is a lot of data there!

>
>
> root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok dump_ops_in_flight
> { "num_ops": 1,
>    "ops": [
>          { "description": "osd_op(client.4179.0:83 kvmtest1_1006560_object82 [write 0~4194304] 3.9f5c55af)",
>            "received_at": "2012-06-18 16:41:17.995167",
>            "age": "0.406678",
>            "flag_point": "waiting for sub ops",
>            "client_info": { "client": "client.4179",
>                "tid": 83}}]}
>
>
> root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok perfcounters_dump
>
> {"filestore":{"journal_queue_max_ops":500,"journal_queue_ops":0,"journal_ops":2198,"journal_queue_max_bytes":104857600,"journal_queue_bytes":0,"journal_bytes":1012769525,"journal_latency":{"avgcount":2198,"sum":3.13569},"op_queue_max_ops":500,"op_queue_ops":0,"ops":2198,"op_queue_max_bytes":104857600,"op_queue_bytes":0,"bytes":1012757330,"apply_latency":{"avgcount":2198,"sum":290.27},"committing":0,"commitcycle":59,"commitcycle_interval":{"avgcount":59,"sum":300.04},"commitcycle_latency":{"avgcount":59,"sum":4.76299},"journal_full":0},"osd":{"opq":0,"op_wip":0,"op":127,"op_in_bytes":532692449,"op_out_bytes":0,"op_latency":{"avgcount":127,"sum":49.2627},"op_r":0,"op_r_out_bytes":0,"op_r_latency":{"avgcount":0,"sum":0},"op_w":127,"op_w_in_bytes":532692449,"op_w_rlat":{"avgcount":127,"sum":
 0},"op_w_latency":{"avgcount":127,"sum":49.2627},"op_rw":0,"op_rw_in_bytes":0,"op_rw_out_bytes":0,"op_rw_rlat":{"avgcount":0,"sum":0},"op_rw_latency":{"avgcount":0,"sum":0},"subop":114,"subop_in_byte
s":478212311,"subop_latency":{"avgcount":114,"sum":8.82174},"subop_w":0,"subop_w_in_bytes":478212311,"subop_w_latency":{"avgcount":114,"sum":8.82174},"subop_pull":0,"subop_pull_latency":{"avgcount":0,"sum":0},"subop_push":0,"subop_push_in_bytes":0,"subop_push_latency":{"avgcount":0,"sum":0},"pull":0,"push":0,"push_out_bytes":0,"recovery_ops":0,"loadavg":0.47,"buffer_bytes":0,"numpg":423,"numpg_primary":259,"numpg_replica":164,"numpg_stray":0,"heartbeat_to_peers":10,"heartbeat_from_peers":0,"map_messages":34,"map_message_epochs":44,"map_message_epoch_dups":24},"throttle-filestore_bytes":{"val":0,"max":104857600,"get":0,"get_sum":0,"get_or_fail_fail":0,"get_or_fail_success":0,"take":2198,"take_sum":1012769525,"put":1503,"put_sum":1012769525,"wait":{"avgcount":0,"sum":0}},"throttle-filestore_
 ops":{"val":0,"max":500,"get":0,"get_sum":0,"get_or_fail_fail":0,"get_or_fail_success":0,"take":2198,"take_sum":2198,"put":1503,"put_sum":2198,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_t
hrottler-client":{"val":4194469,"max":104857600,"get":243,"get_sum":536987810,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":242,"put_sum":532793341,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-cluster":{"val":0,"max":104857600,"get":1480,"get_sum":482051948,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":1480,"put_sum":482051948,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbclient":{"val":0,"max":104857600,"get":1077,"get_sum":50619,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":1077,"put_sum":50619,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbserver":{"val":0,"max":104857600,"get":972,"get_sum":45684,"get_or_fail_fail":0,"get_or_fail_success":0,"take
 ":0,"take_sum":0,"put":972,"put_sum":45684,"wait":{"avgcount":0,"sum":0}},"throttle-osd_client_bytes":{"val":4194469,"max":524288000,"get":128,"get_sum":536892019,"get_or_fail_fail":0,"get_or_fail_su
ccess":0,"take":0,"take_sum":0,"put":254,"put_sum":532697550,"wait":{"avgcount":0,"sum":0}}}
>
>
> root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok perfcounters_schema
>
> {"filestore":{"journal_queue_max_ops":{"type":2},"journal_queue_ops":{"type":2},"journal_ops":{"type":10},"journal_queue_max_bytes":{"type":2},"journal_queue_bytes":{"type":2},"journal_bytes":{"type":10},"journal_latency":{"type":5},"op_queue_max_ops":{"type":2},"op_queue_ops":{"type":2},"ops":{"type":10},"op_queue_max_bytes":{"type":2},"op_queue_bytes":{"type":2},"bytes":{"type":10},"apply_latency":{"type":5},"committing":{"type":2},"commitcycle":{"type":10},"commitcycle_interval":{"type":5},"commitcycle_latency":{"type":5},"journal_full":{"type":10}},"osd":{"opq":{"type":2},"op_wip":{"type":2},"op":{"type":10},"op_in_bytes":{"type":10},"op_out_bytes":{"type":10},"op_latency":{"type":5},"op_r":{"type":10},"op_r_out_bytes":{"type":10},"op_r_latency":{"type":5},"op_w":{"type":10},"op_w_in
 _bytes":{"type":10},"op_w_rlat":{"type":5},"op_w_latency":{"type":5},"op_rw":{"type":10},"op_rw_in_bytes":{"type":10},"op_rw_out_bytes":{"type":10},"op_rw_rlat":{"type":5},"op_rw_latency":{"type":5},
"subop":{"type":10},"subop_in_bytes":{"type":10},"subop_latency":{"type":5},"subop_w":{"type":10},"subop_w_in_bytes":{"type":10},"subop_w_latency":{"type":5},"subop_pull":{"type":10},"subop_pull_latency":{"type":5},"subop_push":{"type":10},"subop_push_in_bytes":{"type":10},"subop_push_latency":{"type":5},"pull":{"type":10},"push":{"type":10},"push_out_bytes":{"type":10},"recovery_ops":{"type":10},"loadavg":{"type":1},"buffer_bytes":{"type":2},"numpg":{"type":2},"numpg_primary":{"type":2},"numpg_replica":{"type":2},"numpg_stray":{"type":2},"heartbeat_to_peers":{"type":2},"heartbeat_from_peers":{"type":2},"map_messages":{"type":10},"map_message_epochs":{"type":10},"map_message_epoch_dups":{"type":10}},"throttle-filestore_bytes":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum"
 :{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-filestore_
ops":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_throttler-client":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_throttler-cluster":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"type":10},
 "wait":{"type":5}},"throttle-msgr_dispatch_throttler-hbclient":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type
":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_throttler-hbserver":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-osd_client_bytes":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"type":10},"wait":{"type":5}}}
>

Hrm, look at your journal_queue_max_ops, journal_queue_max_bytes, 
op_queue_max_ops, and op_queue_max_bytes.  Looks like you are set at 500 
ops and a maximum of 100MB.  With 1GigE you'd be able to max out the 
data in the journal really fast.  Try tweaking these up and see what 
happens.

>
>
>
>>> Nuts. Do you still see the little peaks/valleys every couple seconds?
> I see some little peak/valleys, but iostat is not precise enough if think, I'll try to do some seekwatcher movie.
>
>
> Do you have a seekwatcher movie of a normal write behaviour ?
> Do I need to see small peak period (when journal is flushed to osd) and long valley period ?
>

I think "normal" is not yet well defined. ;)  There's so many variables 
that can affect performance that it's hard to get a good bead on what 
people should expect to see.  Having said that, I've got some data I'm 
going to post to the mailing list later today that you can look at in 
comparison.

Mark
