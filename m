From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: To upgrade the ceph version(v0.26)
Date: Fri, 8 Apr 2011 10:16:03 +0800
Message-ID: <BANLkTin3Cqw0=_yy2EQjNgk41_GAT6KQZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64693 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab1DHCQE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 22:16:04 -0400
Received: by pvg12 with SMTP id 12so1084360pvg.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2011 19:16:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph <ceph-devel@vger.kernel.org>

Hi,

MY current version is v0.24.3, I want to upgrade version to v 0.26.
And my  Linux OS is Fedora 14.

I want to know my step is correctly or not?
Here is my upgraded steps:
1) We stop the current system (v0.24.3)by "/etc/init.d/ceph -a stop "
2) We start to download the newest version(v0.26) and install it.
3) Then we mkcephfs (by "mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
-k keyring.bin") and start it(by " /etc/init.d/init-ceph -a -c
/etc/ceph/ceph.conf start").

But there's a problem I met when I was started the Ceph.
The system stops running and it shows the error messages as shown below:


=== mds.0 ===
Starting Ceph mds0 on host4...
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
 what():  buffer::end_of_buffer
bash: line 1: 24409 Segmentation fault      (core dumped)
/usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135
failed: 'ssh host4  /usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135 '

PLEASE HELP me to solve this problem!!!!!!!
THANK YOU~~

The second question is when we upgrate the ceph successfully.
Is there any tool to transfer the existing data (which from the old
ceph system) to the newest system?
Because we thought the data in the older version(eg. 0.24.3) is
slightly different from the newer version(eg. 0.26)?
I want to know the data will be still correctly?

=====================================================================================

By the way  , here is my ceph.conf :

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



Thank you very much !!!!!!!!!!!!!!!


--
Best Regards,
Stefanie Chen
