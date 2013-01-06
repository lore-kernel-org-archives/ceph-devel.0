From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Filesystem size inconsistance problem
Date: Sun, 6 Jan 2013 13:59:40 +0800
Message-ID: <CAJiejCTmQYy7DpY-p27oseEAbbeNiFcxonL2pZGTofnwz1D79A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:48853 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3AFGAC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:00:02 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so10583828qcq.14
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jan 2013 22:00:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

Some times ago, I did ceph upgrade offline, then ethernet bonding
while ceph online, and also I removed some OSDs, the cluster
experienced big movements, after sometime it calms down finally. When
I verify the consistance, I found that the filesystem size by 'ceph
-s'(true size) and mounted size is different. What's the problem?

It's still usable, and the used percent is right too, but the wrong
size displayed looks really uncomfortable !!!

log3 ~ # mount -t ceph log3:/ /mnt/temp/
log3 ~ # df -t ceph
Filesystem      Size  Used Avail Use% Mounted on
10.205.119.2:/  404G   62G  343G  16% /mnt/temp
log3 ~ # ceph -s
   health HEALTH_OK
   monmap e1: 3 mons at
{log21=10.205.118.21:6789/0,log3=10.205.119.2:6789/0,squid86-log12=150.164.100.218:6789/0},
election epoch 376, quorum 0,1,2 log21,log3,squid86-log12
   osdmap e15719: 37 osds: 37 up, 37 in
    pgmap v383025: 9224 pgs: 9224 active+clean; 7829 GB data, 15731 GB
used, 87614 GB / 100 TB avail
   mdsmap e283: 1/1/1 up {0=log3=up:active}, 1 up:standby
