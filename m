From: Sylar Shen <kimulaaa@gmail.com>
Subject: NFS of Gluster and Ceph
Date: Thu, 10 Mar 2011 09:32:03 +0800
Message-ID: <AANLkTikxqzhANs3tHufbuNjOxh+CQhxqE6pG2nL=DVTH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48559 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab1CJBcF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2011 20:32:05 -0500
Received: by bwz15 with SMTP id 15so1143897bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2011 17:32:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I know that Ceph can re-export nfs protocol.
So I want to compare the speed differences between Ceph and Gluster.
I use  Linux command "dd" to make a write test. Here is the command I used.
"dd if=/dev/zero of=/mnt/test1.dbf bs=8k count=100000"
The hardware conditions are the same.
I set Gluster as 20 servers and Ceph as 1 MDS, 19 OSDes and 1 MON(MDS
and Mon are on the same server).
I have one physical server as a client.
The results are as follows:
1. with oflag=dsync
Gluster=166KB/s
Ceph=174KB/s
2. without oflag=dsync
Gluster=39.3MB/s
Ceph=46.6MB/s

This confuses me. Because I thought Ceph should be a lot faster than Gluster.
But it seems not according the results.
Could someone tell me if I did something wrong or the result is OK?
Thanks in advance!
-- 
Best Regards,
Sylar Shen
