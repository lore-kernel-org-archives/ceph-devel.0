From: Sage Weil <sage@newdream.net>
Subject: Re: collectd and ceph plugin
Date: Sat, 21 Apr 2012 21:32:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204212124100.29786@cobra.newdream.net>
References: <CABYiri_+2qiPjqHOGBmfFK-LD7ZJtjdM=GC8-JrAVLJmjmcpBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35541 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2DVEcc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Apr 2012 00:32:32 -0400
In-Reply-To: <CABYiri_+2qiPjqHOGBmfFK-LD7ZJtjdM=GC8-JrAVLJmjmcpBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

On Sat, 21 Apr 2012, Andrey Korolyov wrote:
> Hello everyone,
> 
> I have just tried ceph collectd fork on wheezy and noticed that all
> logs for ceph plugin produce nothing but zeroes(see below) for all
> types of nodes. Python cephtool works just fine. Collectd run as root
> and there is no obvious errors like socket permissions and no tips
> from its log. First of all, I don`t know if ceph plugin supposed to
> work or not - there is no clearly state except tracker tickets :)
> 
> epoch,filestore.journal_queue_max_ops.type,filestore.journal_queue_ops.type,filestore.journal_ops.type,filestore.journal_queue_max_bytes.type,filestore.journal_queue_bytes.type,filestore.journal_bytes.type,filestore.journal_latency.type,filestore.op_queue_max_ops.type,filestore.op_queue_ops.type,filestore.ops.type,filestore.op_queue_max_bytes.type,filestore.op_queue_bytes.type,filestore.bytes.type,filestore.apply_latency.type,filestore.committing.type,filestore.commitcycle.type,filestore.commitcycle_interval.type,filestore.commitcycle_latency.type,filestore.journal_full.type,osd.opq.type,osd.op_wip.type,osd.op.type,osd.op_in_bytes.type,osd.op_out_bytes.type,osd.op_latency.type,osd.op_r.type,osd.op_r_out_bytes.type,osd.op_r_latency.type,osd.op_w.type,osd.op_w_in_bytes.type,osd.op_w_rlat.t
 ype,osd.op_w_latency.type,osd.op_rw.type,osd.op_rw_in_bytes.type,osd.op_rw_out_bytes.type,osd.op_rw_rlat.type,osd.op_rw_latency.type,osd.subop.type,osd.subop_in_bytes.type,osd.subop_latency.
 ty
>  pe,osd.subop_w.type,osd.subop_w_in_bytes.type,osd.subop_w_latency.type,osd.subop_pull.type,osd.subop_pull_latency.type,osd.subop_push.type,osd.subop_push_in_bytes.type,osd.subop_push_latency.type,osd.pull.type,osd.push.type,osd.push_out_bytes.type,osd.recovery_ops.type,osd.loadavg.type,osd.buffer_bytes.type,osd.numpg.type,osd.numpg_primary.type,osd.numpg_replica.type,osd.numpg_stray.type,osd.heartbeat_to_peers.type,osd.heartbeat_from_peers.type,osd.map_messages.type,osd.map_message_epochs.type,osd.map_message_epoch_dups.type
> 1334959476.043,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0,0,0.000000,0,0,0.000000,0,0,0.000000,0.000000,0,0,0,0.000000,0.000000,0,0,0.000000,0,0,0.000000,0,0.000000,0,0,0.000000,0,0,0,0,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0,0,0
> 1334959486.033,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0,0,0.000000,0,0,0.000000,0,0,0.000000,0.000000,0,0,0,0.000000,0.000000,0,0,0.000000,0,0,0.000000,0,0.000000,0,0,0.000000,0,0,0,0,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0,0,0
> 1334959496.038,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0,0,0.000000,0,0,0.000000,0,0,0.000000,0.000000,0,0,0,0.000000,0.000000,0,0,0.000000,0,0,0.000000,0,0.000000,0,0,0.000000,0,0,0,0,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0,0,0

My memory is hazy here, but I think you might be using an old version of 
the plugin.  The most recent version can be found at

	git://ceph.newdream.net/git/collectd-4.1.10.git

in the 'ceph' branch.  Note that this isn't an upstream collectd tree... 
it's based on a debian package source snapshot, and the ceph-full-history 
branch has a bunch of build-related crap in git that shouldn't be.  

We aren't using it anymore, but the code works.  If you or someone else 
wants to adopt it and get it upstream into collectd that would be great!  

FWIW, dh has moved to statsd instead: https://github.com/etsy/statsd

sage

