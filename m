From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: A different Ceph benchmark - pgbench
Date: Fri, 31 Aug 2012 17:53:58 +1200
Message-ID: <50405176.6050907@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:45133 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab2HaFyB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 01:54:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 066AA33388
	for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 17:54:00 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0qf0JTVSBI5a for <ceph-devel@vger.kernel.org>;
	Fri, 31 Aug 2012 17:53:59 +1200 (NZST)
Received: from [192.168.1.64] (122-60-64-230.jetstream.xtra.co.nz [122.60.64.230])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 305F033237
	for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 17:53:59 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I think I had previously mentioned that I am interested in using RBD for 
data backing a database. With the recent notable improvements in IO 
performance for smaller block sizes that came with 0.50 and 0.51 
versions I decided to do some benchmarking with Postgresql.

So here it is:

System : 4x (hyperthread) i3 3.3 Ghz 8G, 2x 128G Crucial M4
Ceph 0.51, 1x osd on 1 M4, 20G journal on the other, ext4 filesystems
Postgresql 9.2 with minimal tuning (shared_buffers = 1G, 
checkpoint_segments = 128)
1x RBD for postgres data, 1x RBD for postgres transaction log, ext4 
filesystems

Scale 300 (approx 5G)

connections | tx per second
------------+--------------
   4          |  287
   8          |  422
   16         |  591
   32         |  779
   64         |  866


Now this is quite an acceptable result (previous attempts had maxed out 
at 4 tx per sec). While it does not compare favourably with running the 
same setup directly on the attached drives (4000 tx per sec with 64 
connections), the difference is a 'mere' factor of 4 instead of orders 
of magnitude, so I am greatly encouraged!

By default Postgreql does IO in 8K blocks using library functions read 
and write - so this *was* a completely pessimal performance test - so it 
is really nice to see how things are improving - keep up the good work!

Regards

Mark

