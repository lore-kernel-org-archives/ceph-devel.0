From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: speedup ceph / scaling / find the bottleneck
Date: Fri, 29 Jun 2012 12:46:42 +0200
Message-ID: <4FED8792.1090905@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:48994 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab2F2Kqt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 06:46:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i've made some further testing and have the problem that ceph doesn't 
scale for me. I added a 4th osd server to my existing 3 node osd 
cluster. I also reformated all to be able to start with a clean system.

While doing random 4k writes from two VMs i see about 8% idle on the osd 
servers (Single Intel Xeon E5 8 cores 3,6Ghz). I believe that this is 
the limiting factor and also the reason why i don't see any improvement 
by adding osd servers.

3 nodes: 2VMS: 7000 IOp/s 4k writes osds: 7-15% idle
4 nodes: 2VMS: 7500 IOp/s 4k writes osds: 7-15% idle

Even the cpu is not the limiting factor i think it would be really 
important to lower the CPU usage while doing 4k writes. The CPU is only 
used by the ceph-osd process. I see nearly no usage by other processes 
(only 5% by kworker and 5% flush).

Could somebody recommand me a way to debug this? So we know where all 
this CPU usage goes?

Stefan
