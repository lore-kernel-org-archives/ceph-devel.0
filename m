From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Crash of almost full ceph
Date: Sat, 04 Aug 2012 20:07:48 +0930
Message-ID: <501CFB7C.1040601@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:48185 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab2HDKhz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Aug 2012 06:37:55 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q74AbmMM025647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Sat, 4 Aug 2012 20:07:49 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

Yesterday finally I have managed to screw up my installation of ceph! :)

My ceph was at 80% capacity. I have rebooted one of OSDs remotely and 
managed to screw up with fstab. Host failed to come up and while I was 
driving from home to my office ceph took recovery action. But it meant 
that it has filled up another OSDs completely and it has failed. Ceph 
continued to recover and killed other OSDs in the same fashion. Not 
quite good. Attempt to restart OSDs was in vain: they were unable to 
test for xattrs because file system was full and only growing file 
system allowed them to restart.

Now this leads me to a question/proposal: is there a feature which 
allows ceph to halt recovery process if any of live OSDs exceeding say 
95% percent capacity? It is quite distinct from what is considered full 
or near full OSD as any writes when OSD is near full or full coming from 
clients and inability to write leads to client lock up. But halting 
recovery should allow clients to continue even so ceph is in degraded 
state. It does not make sense to me to allow ceph go from degraded state 
to crashed state when no client needs it.

Regards,
Vladimir
