From: Qiang <wangqiang.hunan@gmail.com>
Subject: Iusse: Ceph osd rm one osd cause 30% objects degraded
Date: Wed, 19 Nov 2014 19:29:50 +0800
Message-ID: <546C7F2E.8020207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34196 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbaKSL3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Nov 2014 06:29:55 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so431095pdb.4
        for <ceph-devel@vger.kernel.org>; Wed, 19 Nov 2014 03:29:54 -0800 (PST)
Received: from [172.31.8.25] (ec2-175-41-180-19.ap-southeast-1.compute.amazonaws.com. [175.41.180.19])
        by mx.google.com with ESMTPSA id kk7sm1676791pab.31.2014.11.19.03.29.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2014 03:29:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, Dear ceph-devel

I met a issue:  Ceph osd rm one osd cause 30% objects degraded.

Step 1:
#created a ssd root
ceph osd crush add-bucket ssd root

Step 2: Installed a osd.100 failed:

94	1			osd.94	up	1	
95	1			osd.95	up	1	
96	1			osd.96	up	1	
97	1			osd.97	up	1	
98	1			osd.98	up	1	
99	1			osd.99	up	1	
100	0	osd.100	down	0

Step 3: Installed a osd.101 again successfully.  Move a host into root=ssd.
-12	1	root ssd
-13	1		host ssd-cephnode1
101	1			osd.101	up	1	
-1	100	root default
-2	10		host cephnode1
0	1			osd.0	up	1	
1	1			osd.1	up	1	
2	1			osd.2	up	1

Step 4: Then I ceph osd rm 100, but the the ceph health turned into 30% 
objects degraded. Then the io performance downgrade to very slow (1MB/s 
each clients).

Anybody know what is the root cause? Or some suggestions to finger it out?

Thank you very much.
