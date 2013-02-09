From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: Unable to mount cephfs - can't read superblock
Date: Sat, 09 Feb 2013 21:25:46 +1000
Message-ID: <kf5bnp$mhb$1@ger.gmane.org>
References: <kf5920$1de$1@ger.gmane.org> <51162831.1070506@42on.com> <kf5ajp$c1o$1@ger.gmane.org> <51162E6F.5010405@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35367 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878Ab3BIL0G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Feb 2013 06:26:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1U48ZW-0006Ql-LM
	for ceph-devel@vger.kernel.org; Sat, 09 Feb 2013 12:26:18 +0100
Received: from 124-170-93-254.dyn.iinet.net.au ([124.170.93.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 12:26:18 +0100
Received: from a.nielsen by 124-170-93-254.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 12:26:18 +0100
In-Reply-To: <51162E6F.5010405@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> Ah, I see you only have one OSD, where the default replication level is 2.
> Also, pools don't work by default if only one replica is left.
>
> You better add a second OSD or just do a mkcephfs again with a second OSD in
> the configuration.

Ah ok.  From my earlier post I think I can add the second OSD on the same disk 
since it is mounted on /var/lib/ceph/.  Are there likely to be any problems 
with this, going into production?  (I mean having two OSDs on the same node.) 
  I will eventually have a second node, but I know only having two isn't ideal.

> Just a reminder, it's also in the docs, but CephFS is still in beta, so expect
> weird things to happen. It can however not hurt to play with it!

Thanks for the reminder - but I only plan to use CephFS to store backup copies 
of things until it becomes stable, so hopefully I can give it some testing and 
survive if it breaks :-)

> P.S.: There's also a new and shiny ceph-users list since two days ago, might
> want to subscribe there.

I will use that list as soon as it appears on GMane, since I find their NNTP 
interface a lot easier than managing a bunch of mailing list subscriptions! 
Maybe someone with more authority than myself can add it?

   http://gmane.org/subscribe.php

Cheers,
Adam.


