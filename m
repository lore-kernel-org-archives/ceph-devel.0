From: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Subject: IO-based timing analysis on v0.93
Date: Wed, 1 Apr 2015 16:55:46 +0000
Message-ID: <3649A15A2562B54294DE14BCE5AC79120B51A46E@FMSMSX119.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27185 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbbDAQzt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 12:55:49 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "'sweil@redhat.com'" <sweil@redhat.com>, Mark Nelson <mnelson@redhat.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, "sjust@redhat.com" <sjust@redhat.com>

I'm sharing below the data from the timing analysis I mentioned in the performance meeting this morning.   Attachments are problematic so I'm trying Google docs.

The test is single node rados bench runs, 4k reads & writes, single OSD, memstore backend.    Hopefully the format is self-explanatory, but essentially key modules were modified with function entrance/exit traces and timing, as well as some traces marking the beginning and ending of a worker thread loop.  20-50K IOs are run, and then a script is used to 'detangle' the sequence of traces & timing of each individual op, using OID (tid is not available everywhere).  After the ops are detangled, which now includes the time that op spent not being processed (i.e. sitting between threads on a queue), any ops that have identical call paths are averaged together to get average times.   I then arbitrarily colored the groups of traces based on thread/major work area.

For each run, the QD was increased past the point where throughput no longer increases and only latency increases, each tab of the spreadsheet can be compared to see which component of the IO time increases.   The upper-right contains the IO time as guessed by the script vs what Rados Bench records (they are pretty similar, but Rados Bench is measuring a bit more beyond the last librados traces).

Summary Sheet (with links to the others)
https://docs.google.com/spreadsheets/d/14LplRzVKf_aM65ENJjghuY8DFGmVOIqn2n_ASAILsxo/edit?usp=sharing

Contains:
1) 100% Reads
2) 100% Writes
3) 100% Reads w/ auth=none
4) 100% writes w /auth=none

In #1 and #2, the bottleneck is in the simple messenger, and with auth turned off, for #4 that appears to move to the bottleneck to the time before the finisher begins to operate on an op after the Op Worker is done with it.   

I should be able to run w/ Filestore rather easily, as long as I tag what each thread is doing.  I'll also run w/ multiple clients.  Let me know if you have any comments or suggestions.

Thanks,

Stephen



