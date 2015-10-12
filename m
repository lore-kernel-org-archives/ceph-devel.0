From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: dump_historic_ops, slow requests
Date: Mon, 12 Oct 2015 21:22:46 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9192520164@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0084.outbound.protection.outlook.com ([207.46.100.84]:57197
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751658AbbJLVWw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 17:22:52 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 26A05CAE666
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 17:22:46 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have a small ceph cluster (3 nodes, 5 osds each, journals all just partitions
on the spinner disks) and I have noticed that when I hit it with a bunch of
rados bench clients all doing writes of large (40M objects) with --no-cleanup,
the rados bench commands seem to finish OK but I often get health warnings like
    HEALTH_WARN 4 requests are blocked > 32 sec;
                2 osds have slow requests 3 ops are blocked > 32.768 sec on osd.9
                1 ops are blocked > 32.768 sec on osd.10
                2 osds have slow requests
After a couple of minutes, health goes to HEALTH_OK.

But if I go to the node containing osd.10 for example and do dump_historic_ops
I do get lots of around 20-sec durations but nothing over 32 sec.

The 20-sec or so ops are always  "ack+ondisk+write+known_if_redirected"
with type_data = "commit sent: apply or cleanup"
and the following are typical event timings

                               initiated: 14:06:58.205937
                              reached_pg: 14:07:01.823288, gap=  3617.351
                                 started: 14:07:01.823359, gap=     0.071
               waiting for subops from 3: 14:07:01.855259, gap=    31.900
         commit_queued_for_journal_write: 14:07:03.132697, gap=  1277.438
          write_thread_in_journal_buffer: 14:07:03.143356, gap=    10.659
             journaled_completion_queued: 14:07:04.175863, gap=  1032.507
                               op_commit: 14:07:04.585040, gap=   409.177
                              op_applied: 14:07:04.589751, gap=     4.711
                sub_op_commit_rec from 3: 14:07:14.682925, gap= 10093.174
                             commit_sent: 14:07:14.683081, gap=     0.156
                                    done: 14:07:14.683119, gap=     0.038

Should I expect to see a historic op with duration greater than 32 sec?

-- Tom Deneau

