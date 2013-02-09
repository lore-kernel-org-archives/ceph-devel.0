From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: mkcephfs error: cannot remove `/var/lib/ceph/osd/ceph-0'
Date: Sat, 09 Feb 2013 15:39:57 +1000
Message-ID: <kf4nfb$6ge$1@ger.gmane.org>
References: <kf4gdf$nn4$1@ger.gmane.org> <alpine.DEB.2.00.1302082055130.5874@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54853 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab3BIFkN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Feb 2013 00:40:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1U43Aq-0004g9-H4
	for ceph-devel@vger.kernel.org; Sat, 09 Feb 2013 06:40:28 +0100
Received: from 124-170-93-254.dyn.iinet.net.au ([124.170.93.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 06:40:28 +0100
Received: from a.nielsen by 124-170-93-254.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 06:40:28 +0100
In-Reply-To: <alpine.DEB.2.00.1302082055130.5874@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>> $ mkcephfs --init-local-daemons mon -d /tmp/foo
>
> Not sure if this is the problem, but: you're creating the mon...
>
>> === mon.0 ===
>> rm: cannot remove `/var/lib/ceph/osd/ceph-0': Device or resource busy
>
> ..but the path is /var/lib/ceph/osd/...?  Did you override the paths in
> your ceph.conf?

Ah yes I did, I see the problem now.  What I wanted to do was to put *all* 
Ceph data onto the same disk (since I am booting the machine off an SD card so 
there is not enough space for much else.)

What's the best solution in this case?  Should I override the mon path and put 
it as /var/lib/ceph/osd/ceph-0/mon/ for example, or should I mount my disk as 
/var/lib/ceph instead?

Many thanks,
Adam.


