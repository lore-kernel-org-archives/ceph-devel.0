From: Qiang <wangqiang.hunan@gmail.com>
Subject: qemu-kvm guests hang on disk write with rbd storage
Date: Tue, 28 Oct 2014 21:32:37 +0800
Message-ID: <544F9AF5.1020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:58722 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaJ1Nck (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 09:32:40 -0400
Received: by mail-pd0-f174.google.com with SMTP id p10so710745pdj.5
        for <ceph-devel@vger.kernel.org>; Tue, 28 Oct 2014 06:32:40 -0700 (PDT)
Received: from [192.168.1.103] ([111.161.17.97])
        by mx.google.com with ESMTPSA id ir7sm1746595pbc.15.2014.10.28.06.32.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 06:32:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi, Dear All

I got an issue in my environment: qemu-kvm guests hang on disk write 
with rbd storage.

My environment:
ceph version: 0.80.7
ceph osds: 11(hosts) * 10(osd) = 110
qemu version: 2.0 +

my operating steps:
ceph osd crush add-bucket ssd root
ceph osd getcrushmap -o mycrushmap
crushtool -d mycrushmap -o mycrushmap_v1

#modify mycrushmap_v1
#add 4 of 11 hosts into root=ssd .
#meanwhile the 11 hosts are still in root=default.

crushtool -c mycrushmap_v1 -o mycrushmap_input
ceph osd setcrushmap -i mycrushmap_input
After I doing above steps

In my environment, qemu-kvm VMs which attached ceph rbd storage all 
hung.  The kernel log shows:
kernel: INFO: task jbd2/sdb1-8:623 blocked for more than 120 seconds.
kernel: Not tainted 2.6.32-431.3.1.el6.x86_64 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
message.
kernel: jbd2/sdb1-8 D 0000000000000001 0 623 2 0x00000000
kernel: ffff88011c44dc20 0000000000000046 ffff8801ffffffff 00000000cc70801d
kernel: ffff88011c44db90 ffff880119466980 00000000d127ef64 ffffffffac2de373
kernel: ffff880119538638 ffff88011c44dfd8 000000000000fbc8 ffff880119538638
kernel: Call Trace:

In the meantime the ceph.log shows everything working fine and the ceph 
health is ok. And The other guest VMs are fine which without ceph rbd 
storage.

I tried many times in my testing environment, But I cannot reproduce it. 
  So that maybe not a problem.

Is there any defect/bug relates to this issue?  Or any suggestion to 
help me find the root cause?

Thanks very much.
