From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 23:04:41 +0200
Message-ID: <4FC539E9.4020403@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49579 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab2E2VEp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 17:04:45 -0400
In-Reply-To: <4FC50C4A.4090101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

Am 29.05.2012 19:50, schrieb Mark Nelson:
> Once I get these nodes up to 0.47 and get them switched over to 10GbE
> I'll redo the btrfs tests and try out xfs as well with longer running
> tests.
I always test on 1GE and see this proble no matter whether btrfs or xfs. 
So i think this is just a waste of time.

At least my test differ as i see this problem on ALL pools.

Mark should i try 0.46?

Thanks,
Stefan
