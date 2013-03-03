From: Xing Lin <xinglin@cs.utah.edu>
Subject: When ceph synchronizes journal to disk?
Date: Sun, 03 Mar 2013 05:36:40 -0700
Message-ID: <513343D8.8050402@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:49924 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab3CCMgn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Mar 2013 07:36:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id DED87650677
	for <ceph-devel@vger.kernel.org>; Sun,  3 Mar 2013 05:36:42 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9iWX6txtZul for <ceph-devel@vger.kernel.org>;
	Sun,  3 Mar 2013 05:36:42 -0700 (MST)
Received: from [192.168.1.100] (unknown [116.231.167.128])
	by smtps.cs.utah.edu (Postfix) with ESMTPSA id 32B6765066F
	for <ceph-devel@vger.kernel.org>; Sun,  3 Mar 2013 05:36:42 -0700 (MST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

There were some discussions about this before on the mailing list but I 
am still confused with this. I thought Ceph would flush data from the 
journal to disk when either the journal is full or when the time to do 
synchronization is due. In my test experiment, I used 24 osds(one osd 
for each disk). I used a 10 GB tmpfs file as the journal disk for each 
osd. Then for testing, I delayed the synchronization between the journal 
and disk on purpose. I increased the 'journal min sync interval' to be 
60 s and 'journal max sync interval' to be 300 s. Then I created a rbd 
and then started a 4M sequential write workload with fio for 30 seconds. 
I was expecting that no IO should happen to disks, unless we have filled 
240 GB data (10G*24). However, 'iostat' showed there was data
started to be written into disks (at about 20 MB/s per disk), right 
after I started the sequential workload. Could someone help to explain 
this situation? Thanks,

I am running 0.48.2. The related configuration is as follows.
-----------------
[osd]
         osd journal size = 10000
         osd journal = /dev/shm/journal/$name-journal
         journal dio = false
         filestore xattr use omap = true

         # The maximum interval in seconds for synchronizing the filestore.
         filestore min sync interval = 60
         filestore max sync interval = 300
-------------

Xing
