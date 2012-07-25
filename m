From: Florian Haas <florian@hastexo.com>
Subject: Re: Ceph Benchmark HowTo
Date: Wed, 25 Jul 2012 22:06:04 +0200
Message-ID: <CAPUexz-G2R_amz9_Eh7bisOVrOC66uowMqavvdg7n87XTz56QQ@mail.gmail.com>
References: <20120724144300.GA3317@mail.sileht.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:58080 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab2GYUGF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jul 2012 16:06:05 -0400
Received: by qcmv28 with SMTP id v28so747582qcm.11
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 13:06:05 -0700 (PDT)
In-Reply-To: <20120724144300.GA3317@mail.sileht.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mehdi Abaakouk <sileht@sileht.net>
Cc: ceph-devel@vger.kernel.org

Hi Mehdi,

great work! A few questions (for you, Mark, and anyone else watching
this thread) regarding the content of that wiki page:

For the OSD tests, which OSD filesystem are you testing on? Are you
using a separate journal device? If yes, what type?

For the RADOS benchmarks:

# rados bench -p pbench 900 seq
...
   611      16     17010     16994   111.241       104   1.05852  0.574897
   612      16     17037     17021   111.236       108   1.17321  0.574932
   613      16     17056     17040   111.178        76   1.01611  0.574903
 Total time run:        613.339616
Total reads made:     17056
Read size:            4194304
Bandwidth (MB/sec):    111.234

Average Latency:       0.575252
Max latency:           1.65182
Min latency:           0.07418

How meaningful is it to use a (arithmetic) average here, consisting
the min and max differ by a factor of 22? Aren't we being bitten by
outliers pretty severely here, and wouldn't, say, a median be much
more useful? (Actually, would the "max latency" include the initial
hunt for a mon and the mon/osdmap exchange?)



seekwatcher -t rbd-latency-write.trace -o rbd-latency-write.png -p 'dd
if=/dev/zero of=/dev/rbd0 bs=4M count=1000 oflag=direct' -d /dev/rbd0

Just making sure: are you getting the same numbers just with dd,
rather than dd invoked by seekwatcher?

Also, for your dd latency test of 4M direct I/O reads writes, you seem
to be getting 39 and 300 ms average latency, yet further down it says
"RBD latency read/write: 28ms and 114.5ms". Any explanation for the
write latency being cut in half on what was apparently a different
test run?

Also, were read and write caches cleared between tests? (echo 3 >
/proc/sys/vm/drop_caches)

Cheers,
Florian
