From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Fri, 25 May 2012 13:31:15 +0200
Message-ID: <4FBF6D83.20907@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <CAJCPpW+SKnnVUaDEAsCkKyZwMVrHCRJF2C8zqB4eORgwW5p=1Q@mail.gmail.com> <4FBE7ABC.5020502@profihost.ag> <4FBE838D.4000303@inktank.com> <4FBE8662.1070801@profihost.ag> <4FBEE5FF.7080907@inktank.com> <4FBF407C.70407@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57142 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546Ab2EYLa7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 07:30:59 -0400
In-Reply-To: <4FBF407C.70407@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Some speed tests with different Kernel Versions. The same applies to
other FS like btrfs.
I used "rados -p data bench 100 write -t 16" for all tests and a freshly
created FS. mount options were always: noatime,nodiratime,nobarrier.

3.0.30 with XFS

speed is always between 120 and 160MB/s

Total time run:        100.510061
Total writes made:     3605
Write size:            4194304
Bandwidth (MB/sec):    143.468

Average Latency:       0.445714
Max latency:           1.99929
Min latency:           0.084812

3.2.18 with XFS

speed is between 40 and 170MB/s

Total time run:        100.795653
Total writes made:     3384
Write size:            4194304
Bandwidth (MB/sec):    134.292

Average Latency:       0.476297
Max latency:           2.92075
Min latency:           0.084884

3.3.7 with XFS

!! speed heavily jumps between 0 and 170 MB/s !!

Total time run:        107.398166
Total writes made:     2455
Write size:            4194304
Bandwidth (MB/sec):    91.435

Average Latency:       0.699819
Max latency:           13.8117
Min latency:           0.084624

3.4 with XFS

!! speed heavily jumps between 0 and 130 MB/s - most if the time it's
near 0 !!

Total time run:        115.433531
Total writes made:     468
Write size:            4194304
Bandwidth (MB/sec):    16.217

Average Latency:       3.9452
Max latency:           53.4356
Min latency:           0.091276


Stefan
