From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: The installation: "terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'"
Date: Wed, 6 Apr 2011 11:11:25 +0800
Message-ID: <BANLkTi=Bq8qpjzKpxMds8-KHobNpO=hr4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55879 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1DFDL0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 23:11:26 -0400
Received: by vws1 with SMTP id 1so802553vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 20:11:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph <ceph-devel@vger.kernel.org>

Hi,
I set an environment of 7 servers which include 3 MONs(host1 host2
host3), 2 MDSs(host4 host5) and 2 OSDes(host6 host7).
My version is 0.25.2 and OS is Fedora 14.
There's a problem when I was installing the Ceph.
When I finished "mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
-k keyring.bin" .
I start the whole Ceph system.
But here is the problem I met:
The system stops running and it shows the error messages as shown below:

=== mds.0 ===
Starting Ceph mds0 on Ceph4...
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
  what():  buffer::end_of_buffer
bash: line 1: 24409 Segmentation fault      (core dumped)
/usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135
failed: 'ssh Ceph4  /usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135 '

The ceph.conf is shown below:

[global]
      pid file = /var/run/ceph/$name.pid
     debug ms =1
     auth supported = cephx

 [mon]
       mon data = /data1/mon$id

       ;debug ms = 1
       ;debug mon = 20
      ;debug paxos = 20
       ;debug auth = 20

 [mon0]
       host = host1
       mon addr = 192.168.200.201:6789

 [mon1]
        host = host2
        mon addr = 192.168.200.202:6789

 [mon2]
       host = host3
       mon addr = 192.168.200.203:6789

[mds]
       keyring = /etc/ceph/keyring.$name
       ;debug ms = 1
       ;debug mds = 20

 [mds0]
       host = host4
 [mds1]
       host = host5

 [osd]
       keyring = /etc/ceph/keyring.$name
       osd data = /mnt/btrfs/osd$id
       osd journal = /opt/osd/osd$id/journal
      ;osd journal = /data/osd$id/journal
        osd journal size = 512
      ;debug ms = 1
       ;debug osd = 20
       ;debug filestore = 20
       ;debug journal = 20

 [osd0]
       host = host6
       btrfs devs = /dev/sdb1

 [osd1]
       host = host6
       btrfs devs = /dev/sdc1

 [osd2]
       host = host6
       btrfs devs = /dev/sdd1

 [osd3]
       host = host7
       btrfs devs = /dev/sdb1

 [osd4]
       host = host7
       btrfs devs = /dev/sdc1

 [osd5]
       host = host7
       btrfs devs = /dev/sdd1


I want to know why  the system cannot run smoothly.
Thank you!!!!!!!!!!!!!!!


--
Best Regards,
Stefanie Chen
