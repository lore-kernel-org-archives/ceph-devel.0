From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: dump_historic_ops, slow requests
Date: Tue, 13 Oct 2015 21:25:43 -0700
Message-ID: <CAJ4mKGY946cdLPTWPSPwu9TsV=FsSaKJNnkWBEcaVrxXaOMv6g@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192520164@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38889 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbJNEZp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 00:25:45 -0400
Received: by wieq12 with SMTP id q12so62737758wie.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 21:25:44 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192520164@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Oct 12, 2015 at 2:22 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> I have a small ceph cluster (3 nodes, 5 osds each, journals all just partitions
> on the spinner disks) and I have noticed that when I hit it with a bunch of
> rados bench clients all doing writes of large (40M objects) with --no-cleanup,
> the rados bench commands seem to finish OK but I often get health warnings like
>     HEALTH_WARN 4 requests are blocked > 32 sec;
>                 2 osds have slow requests 3 ops are blocked > 32.768 sec on osd.9
>                 1 ops are blocked > 32.768 sec on osd.10
>                 2 osds have slow requests
> After a couple of minutes, health goes to HEALTH_OK.
>
> But if I go to the node containing osd.10 for example and do dump_historic_ops
> I do get lots of around 20-sec durations but nothing over 32 sec.
>
> The 20-sec or so ops are always  "ack+ondisk+write+known_if_redirected"
> with type_data = "commit sent: apply or cleanup"
> and the following are typical event timings
>
>                                initiated: 14:06:58.205937
>                               reached_pg: 14:07:01.823288, gap=  3617.351
>                                  started: 14:07:01.823359, gap=     0.071
>                waiting for subops from 3: 14:07:01.855259, gap=    31.900
>          commit_queued_for_journal_write: 14:07:03.132697, gap=  1277.438
>           write_thread_in_journal_buffer: 14:07:03.143356, gap=    10.659
>              journaled_completion_queued: 14:07:04.175863, gap=  1032.507
>                                op_commit: 14:07:04.585040, gap=   409.177
>                               op_applied: 14:07:04.589751, gap=     4.711
>                 sub_op_commit_rec from 3: 14:07:14.682925, gap= 10093.174
>                              commit_sent: 14:07:14.683081, gap=     0.156
>                                     done: 14:07:14.683119, gap=     0.038
>
> Should I expect to see a historic op with duration greater than 32 sec?

IIRC, the historic ops generally consist of up to the N longest
operations in the last Y time period, on a rolling basis. Something
like 20 ops from the last 6 minutes. So if you get a report of a
32-second blocked op and immediately go to the OSD, it should have
that op in either in-progress or historic ops.

One possibility is that if you've got peering happening, it's got ops
blocked on that but they get thrown out because the OSD turns out not
to be responsible for them.
-Greg
