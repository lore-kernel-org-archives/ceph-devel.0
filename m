From: Sage Weil <sweil@redhat.com>
Subject: ceph perf command?
Date: Sat, 10 Jan 2015 21:26:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501102121410.18957@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbbAKF07 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 11 Jan 2015 00:26:59 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0B5QxZ3027088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Sun, 11 Jan 2015 00:26:59 -0500
Received: from redhat.com ([10.3.112.19])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t0B5QwIx023479
	for <ceph-devel@vger.kernel.org>; Sun, 11 Jan 2015 00:26:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ceph is collecting all kinds of metrics internally that are exposed 
through the admin socket or via the 'ceph perf dump' command.  There's no 
convenient way to watch these values from the command line, though.

A while back I wrote script/perf-watch.py that tries to provide something 
that spits out a line every second (ala vmstat, iostat, etc) of whatever 
metrics you specify.  It's a bit kludgey but look something like this:

$ script/perf-watch.py -s out/osd.0.asok filestore.bytes osd.wr filestore.commitcycle osd.op osd.op_rw
# filestore.bytes filestore.commitcycle   osd.op osd.op_rw
                0                     0        0         0
                0                     0        0         0
                0                     0        0         0
         29375672                     0        1         0
         37768744                     0        6         0
         33572224                     0        4         0
                0                     0        0         0
         46161808                     1        3         0
                0                     0        0         0
                0                     0        0         0
# filestore.bytes filestore.commitcycle   osd.op osd.op_rw
                0                     0        0         0
                0                     0        0         0
         25179152                     1        2         0
         37768736                     0        6         0
                0                     1        0         0
                0                     0        0         0
...

You can specify either individual metrics ('osd.op') or a full category 
(just 'osd').  The problem is usually that there are so many metrics that 
doing the full set requires a *really* wide monitor to be useful.

Anyway, two thoughts:

1) We could incorporate this into the normal 'ceph' cli tool.  Maybe a 
'ceph perf <daemon or asok> <metrics ...>', which works similar to 
'ceph daemon ...'.

2) We could mark certain metrics as the 'interesting' ones and make it 
default to showing those when no others are specified.  And/or possibly do 
the same for each group (osd, filestore, etc.).  That would steer 
admins towards the ones that are actually helpful in telling what the 
cluster is doing.

Thoughts?
sage

