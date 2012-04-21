From: Andrey Korolyov <andrey@xdel.ru>
Subject: collectd and ceph plugin
Date: Sat, 21 Apr 2012 13:06:34 +0400
Message-ID: <CABYiri_+2qiPjqHOGBmfFK-LD7ZJtjdM=GC8-JrAVLJmjmcpBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:39021 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab2DUJGz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Apr 2012 05:06:55 -0400
Received: by wgbds11 with SMTP id ds11so1285225wgb.1
        for <ceph-devel@vger.kernel.org>; Sat, 21 Apr 2012 02:06:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everyone,

I have just tried ceph collectd fork on wheezy and noticed that all
logs for ceph plugin produce nothing but zeroes(see below) for all
types of nodes. Python cephtool works just fine. Collectd run as root
and there is no obvious errors like socket permissions and no tips
from its log. First of all, I don`t know if ceph plugin supposed to
work or not - there is no clearly state except tracker tickets :)

epoch,filestore.journal_queue_max_ops.type,filestore.journal_queue_ops.type,filestore.journal_ops.type,filestore.journal_queue_max_bytes.type,filestore.journal_queue_bytes.type,filestore.journal_bytes.type,filestore.journal_latency.type,filestore.op_queue_max_ops.type,filestore.op_queue_ops.type,filestore.ops.type,filestore.op_queue_max_bytes.type,filestore.op_queue_bytes.type,filestore.bytes.type,filestore.apply_latency.type,filestore.committing.type,filestore.commitcycle.type,filestore.commitcycle_interval.type,filestore.commitcycle_latency.type,filestore.journal_full.type,osd.opq.type,osd.op_wip.type,osd.op.type,osd.op_in_bytes.type,osd.op_out_bytes.type,osd.op_latency.type,osd.op_r.type,osd.op_r_out_bytes.type,osd.op_r_latency.type,osd.op_w.type,osd.op_w_in_bytes.type,osd.op_w_rlat.typ
 e,osd.op_w_latency.type,osd.op_rw.type,osd.op_rw_in_bytes.type,osd.op_rw_out_bytes.type,osd.op_rw_rlat.type,osd.op_rw_latency.type,osd.subop.type,osd.subop_in_bytes.type,osd.subop_latency.type,osd.subop_w.type,osd.subop_w_in_bytes.type,osd.subop_w_latency.type,osd.subop_pull.type,osd.subop_pull_latency.type,osd.subop_push.type,osd.subop_push_in_bytes.type,osd.subop_push_latency.type,osd.pull.type,osd.push.type,osd.push_out_bytes.type,osd.recovery_ops.type,osd.loadavg.type,osd.buffer_bytes.type,osd.numpg.type,osd.numpg_primary.type,osd.numpg_replica.type,osd.numpg_stray.type,osd.heartbeat_to_peers.type,osd.heartbeat_from_peers.type,osd.map_messages.type,osd.map_message_epochs.type,osd.map_message_epoch_dups.type
1334959476.043,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0,0,0.000000,0,0,0.000000,0,0,0.000000,0.000000,0,0,0,0.000000,0.000000,0,0,0.000000,0,0,0.000000,0,0.000000,0,0,0.000000,0,0,0,0,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0,0,0
1334959486.033,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0,0,0.000000,0,0,0.000000,0,0,0.000000,0.000000,0,0,0,0.000000,0.000000,0,0,0.000000,0,0,0.000000,0,0.000000,0,0,0.000000,0,0,0,0,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0,0,0
1334959496.038,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0.000000,0.000000,0,0,0,0.000000,0,0,0.000000,0,0,0.000000,0.000000,0,0,0,0.000000,0.000000,0,0,0.000000,0,0,0.000000,0,0.000000,0,0,0.000000,0,0,0,0,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0,0,0
