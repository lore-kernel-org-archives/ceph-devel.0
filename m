From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Pg stuck stale...why?
Date: Wed, 11 Jul 2012 13:11:08 +1200
Message-ID: <4FFCD2AC.3040809@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:41265 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab2GKBLL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 21:11:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id A8B63328F7
	for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 13:11:09 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91ZooqrQJLR5 for <ceph-devel@vger.kernel.org>;
	Wed, 11 Jul 2012 13:11:09 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:6108:63c7:84a8:708b] (unknown [IPv6:2404:130:0:1000:6108:63c7:84a8:708b])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id F12D0328B6
	for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 13:11:08 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am seeing this:

# ceph -s
    health HEALTH_WARN 256 pgs stale; 256 pgs stuck stale
    monmap e1: 3 mons at 
{ved1=192.168.122.11:6789/0,ved2=192.168.122.12:6789/0,ved3=192.168.122.13:6789/0}, 
election epoch 18, quorum 0,1,2 ved1,ved2,ved3
    osdmap e62: 4 osds: 4 up, 4 in
     pgmap v47148: 768 pgs: 512 active+clean, 256 stale+active+clean; 
2224 MB data, 15442 MB used, 86907 MB / 102350 MB avail
    mdsmap e1: 0/0/1

In particular 256 pgs stuck stale - I've tried a) waiting a while 
(overnight),  b) a rolling restart of all 4 osd's,  c) restarting all 
ceph services on all 4 nodes. All without changing this.

As far as I understand what stuck state means, I can't see why they need 
to stay that way, given all osd's and mon's are up. (I have no mds 
configured)....any ideas? Or is this just expected?

Regards

Mark




