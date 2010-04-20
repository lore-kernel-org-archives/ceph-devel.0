From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Re: Problem with Ceph installation inside Amazon EC2
Date: Tue, 20 Apr 2010 17:18:35 +0200
Message-ID: <201004201718.35784.cray@unix-ag.uni-kl.de>
References: <201004201538.34232.cray@unix-ag.uni-kl.de> <1271773294.1905.75.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:45106 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0DTPS4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Apr 2010 11:18:56 -0400
In-Reply-To: <1271773294.1905.75.camel@wido-desktop>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wido@pcextreme.nl
Cc: ceph-devel@vger.kernel.org

Hi,

I have just these logfiles in /var/log/ceph:

# ls -l /var/log/ceph/
total 4
-rw-r--r-- 1 root root 940 2010-04-20 15:12 ip-10-194-145-203.12134
lrwxrwxrwx 1 root root  23 2010-04-20 15:12 osd1 -> ip-10-194-145-203.12134

# cat ip-10-194-145-203.12134 
10.04.20 15:12:06.702434 --- opened log /var/log/ceph/ip-10-194-145-203.12134 ---
ceph version 0.19.1 (7d7f925bcd03630778e36fe633efaf92768925c7)
10.04.20 15:12:06.702550 ---- renamed symlink /var/log/ceph/osd1 -> /var/log/ceph/osd1.0 ----
10.04.20 15:12:06.702573 ---- created symlink /var/log/ceph/osd1 -> ip-10-194-145-203.12134 ----
10.04.20 15:12:06.702674 7fd59e775720 -- :/12134 messenger.start
10.04.20 15:12:06.702726 7fd59e775720 -- :/12134 shutdown complete.
10.04.20 15:12:06.702788 7fd59e775720 filestore(/srv/ceph/osd) mkfs in /srv/ceph/osd
10.04.20 15:12:06.717191 7fd59e775720 filestore(/srv/ceph/osd) mkfs done in /srv/ceph/osd
10.04.20 15:12:06.717467 7fd59e775720 filestore(/srv/ceph/osd) mount btrfs TRANS_START ioctl is supported
10.04.20 15:12:06.717481 7fd59e775720 filestore(/srv/ceph/osd) mount btrfs CLONE_RANGE ioctl is supported
10.04.20 15:12:06.717488 7fd59e775720 filestore(/srv/ceph/osd) mount detected btrfs

There is no mon0 logfile.

"ceph -w" says the same as "ceph start"

# ceph -w
10.04.20 15:14:31.755364 7fc9f7329720 -- :/12154 messenger.start
10.04.20 15:14:31.755598 7fc9f7329720 -- :/12154 --> mon0 10.194.145.203:6789/0 -- auth(proto 0 30 bytes) -- ?+0 0xc99de0
10.04.20 15:14:31.755777 7fc9f45aa710 -- :/12154 >> 10.194.145.203:6789/0 pipe(0xc9d2f0 sd=-1 pgs=0 cs=0 l=0).fault first fault

# mount -t ceph 10.194.145.203:/ /mnt/ceph/
mount: 10.194.145.203:/: can't read superblock

Best Regards,
   Christian 




Am Dienstag, 20. April 2010 schrieb Wido den Hollander:
> Hi,
> 
> What does "ceph -w" show?
> 
> Do you get some "xauth" messages in your mon0 logfiles?
> 


