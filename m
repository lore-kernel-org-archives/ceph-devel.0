From: Tomoki BENIYA <beniya@bit-isle.co.jp>
Subject: Always creating PGs
Date: Thu, 10 May 2012 18:17:33 +0900
Message-ID: <20120510175036.FC97.33BC0F0F@bit-isle.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57658 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932075Ab2EJJRc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 May 2012 05:17:32 -0400
Received: by pbbrr4 with SMTP id rr4so1581924pbb.9
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 02:17:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all

I created Ceph file system using Debian7 of 64bit.

I found that PGs of 'creating' status are never finished.

# ceph pg stat
v17596: 1204 pgs: 8 creating, 1196 active+clean; 25521 MB data, 77209 MB used, 2223 GB / 2318 GB avail
                  ~~~~~~~~~~
                  always creating, why?

# ceph pg dump|grep creating
1.1p6   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000
0.1p7   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000
1.1p7   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000
0.1p6   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000
1.1p8   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000
0.1p9   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000
1.1p9   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000
0.1p8   0       0       0       0       0       0       0       creating        0.000000        0'0     0'0     []      []      0'0     0.000000

Configuration is wrong?
How to resolve this problem?

========================================
[global]
        auth supported = cephx
        max open files = 131072
        log_to_syslog = true
        pid file = /var/run/ceph/$name.pid
        keyring = /etc/ceph/keyring.bin

[mon]
        mon data = /ceph/$name

[mon.0]
        host = mon0
        mon addr = 192.168.233.81:6789

[mon.1]
        host = mon1
        mon addr = 192.168.233.82:6789

[mon.2]
        host = mon2
        mon addr = 192.168.233.83:6789

[mds]
        keyring = /etc/ceph/keyring.$name

[mds.0]
        host = mds0

[osd]
        osd journal = /var/journal
        osd journal size = 1000
        keyring = /etc/ceph/keyring.$name

[osd.0]
        host = osd0
        btrfs devs = /dev/sdb1
        osd data = /ceph0
        osd journal = /var/journal0

[osd.1]
        host = osd0
        btrfs devs = /dev/sdc1
        osd data = /ceph1
        osd journal = /var/journal1

[osd.2]
        host = osd1
        btrfs devs = /dev/sdb1
        osd data = /ceph0
        osd journal = /var/journal0

[osd.3]
        host = osd1
        btrfs devs = /dev/sdc1
        osd data = /ceph1
        osd journal = /var/journal1

[osd.4]
        host = osd2
        btrfs devs = /dev/sdb1
        osd data = /ceph0
        osd journal = /var/journal0

[osd.5]
        host = osd2
        btrfs devs = /dev/sdc1
        osd data = /ceph1
        osd journal = /var/journal1

[osd.6]
        host = osd3
        btrfs devs = /dev/sdb1
        osd data = /ceph0
        osd journal = /var/journal0

[osd.7]
        host = osd3
        btrfs devs = /dev/sdc1
        osd data = /ceph1
        osd journal = /var/journal1

[osd.8]
        host = osd4
        btrfs devs = /dev/sdb1
        osd data = /ceph0
        osd journal = /var/journal0

[osd.9]
        host = osd4
        btrfs devs = /dev/sdc1
        osd data = /ceph1
        osd journal = /var/journal1
========================================

Thanks.

-- 
Tomoki BENIYA <beniya@bit-isle.co.jp>

