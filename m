From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: Unable to mount cephfs - can't read superblock
Date: Sat, 09 Feb 2013 21:06:37 +1000
Message-ID: <kf5ajp$c1o$1@ger.gmane.org>
References: <kf5920$1de$1@ger.gmane.org> <51162831.1070506@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33563 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab3BILGt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Feb 2013 06:06:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1U48Gv-0002sY-2x
	for ceph-devel@vger.kernel.org; Sat, 09 Feb 2013 12:07:05 +0100
Received: from 124-170-93-254.dyn.iinet.net.au ([124.170.93.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 12:07:05 +0100
Received: from a.nielsen by 124-170-93-254.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 12:07:05 +0100
In-Reply-To: <51162831.1070506@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thanks for your quick reply!

> Could you show the output of "ceph -s"

$ ceph -s
    health HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean
    monmap e1: 1 mons at {0=192.168.0.6:6789/0}, election epoch 0, quorum 0 0
    osdmap e3: 1 osds: 1 up, 1 in
     pgmap v119: 192 pgs: 192 active+degraded; 0 bytes data, 10204 MB used, 
2740 GB / 2750 GB avail
    mdsmap e1: 0/0/1 up

> Also, which version of Ceph are you using under which OS?

The latest stable Debian release from ceph.com (bobtail AFAIK).

Thanks,
Adam.


