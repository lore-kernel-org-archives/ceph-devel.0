From: udit agarwal <fzdudit@gmail.com>
Subject: Re: iozone test crashed on ceph
Date: Fri, 1 Jun 2012 04:05:02 +0000 (UTC)
Message-ID: <loom.20120601T060302-726@post.gmane.org>
References: <loom.20120601T025228-787@post.gmane.org> <CA+4uBUYHGVEzwMsi014_Dp7oDkjWN0qob_5v=ut6rKe19e0aGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55150 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2FAEFT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Jun 2012 00:05:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SaJ6t-0003jK-Na
	for ceph-devel@vger.kernel.org; Fri, 01 Jun 2012 06:05:16 +0200
Received: from en-439-0215-006.esc.auckland.ac.nz ([130.216.209.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 06:05:11 +0200
Received: from fzdudit by en-439-0215-006.esc.auckland.ac.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 06:05:11 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
 thanks for your reply.
 The output of 'modinfo ceph' is as follows:
 filename:       /lib/modules/3.1.10-1.9-desktop/kernel/fs/ceph/ceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     AFEFF779535E750AFD4072D
depends:       
vermagic:       3.1.10-1.9-desktop SMP preempt mod_unload modversions

And my ceph.conf file is as follows:

[global]
   pid file = /var/run/ceph/$name.pid
   logger dir = /var/log/ceph
   log dir = /var/log/ceph
   user = root
[mon]
   mon data = /var/local/data/mon$id
;   debug ms = 1
;   debug mon = 20
;   debug paxos = 20
[mon.0]
   host = hp1
   mon addr = 192.168.20.6:6789
;[mon.1]
;   host = hp2
;   mon addr = 192.168.20.7:6789
;[mon.2]
;   host = bb1
;   mon addr = 192.168.20.2:6789
[mds]
;   debug ms = 1            ; message traffic
;   debug mds = 1           ; mds
;   debug mds balancer = 20 ; load balancing
;   debug mds log = 20      ; mds journaling
;   debug mds_migrator = 20 ; metadata migration
;   debug monc = 20         ; monitor interaction, startup
[mds.0]
   host = hp1
;[mds.1]
;   host = hp2
[osd]
   osd journal = /var/local/data/osd$id/journal
   osd journal size = 10000
   filestore journal writeahead = true
   osd data = /var/local/data/osd$id
;   debug ms = 1            ; message traffic
;   debug osd = 20
;   debug filestore = 20    ; local object storage
;   debug journal = 20      ; local journaling
;   debug monc = 20         ; monitor interaction, startup
[osd.0]
   host = el1
   btrfs devs = /dev/sda3
[osd.1]
   host = el1
   btrfs devs = /dev/sdb
[osd.2]
   host = bb1
   btrfs devs = /dev/sda3

No, I don't think so if any of them crashed.
Thanks in advance and let me know if you need further info.

--Udit

