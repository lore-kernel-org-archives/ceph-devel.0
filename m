From: Gregory Farnum <greg@inktank.com>
Subject: Re: Unable to mount cephfs - can't read superblock
Date: Sat, 9 Feb 2013 08:37:39 -0800
Message-ID: <0B1D23900A8348E28C15A00BCA12877D@inktank.com>
References: <kf5920$1de$1@ger.gmane.org> <51162831.1070506@42on.com>
 <kf5ajp$c1o$1@ger.gmane.org> <51162E6F.5010405@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:34322 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758148Ab3BIQhn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Feb 2013 11:37:43 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so2243902dan.23
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 08:37:42 -0800 (PST)
In-Reply-To: <51162E6F.5010405@42on.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Adam Nielsen <a.nielsen@shikadi.net>, ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

On Saturday, February 9, 2013 at 3:09 AM, Wido den Hollander wrote:
> On 02/09/2013 12:06 PM, Adam Nielsen wrote:
> > Thanks for your quick reply!
> > 
> > > Could you show the output of "ceph -s"
> > 
> > $ ceph -s
> > health HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean
> > monmap e1: 1 mons at {0=192.168.0.6:6789/0}, election epoch 0,
> > quorum 0 0
> > osdmap e3: 1 osds: 1 up, 1 in
> > pgmap v119: 192 pgs: 192 active+degraded; 0 bytes data, 10204 MB
> > used, 2740 GB / 2750 GB avail
> > mdsmap e1: 0/0/1 up
> 
> 
> 
> Ah, I see you only have one OSD, where the default replication level is 
> 2. Also, pools don't work by default if only one replica is left.

Actually that shouldn't be a problem with a size 2 pool. They'll work as long as at least half of their assigned replica count is available. :) (There was a brief period in development releases where that wasn't the case, but it didn't last very long!)

In any case, this output indicates that your MDS isn't actually running, Adam, or at least isn't connected. Check and see if the process is still going?
You should also have minimal logging by default in /var/lib/ceph/mds*; you might find some output there that could be useful.
-Greg

 
> 
> You better add a second OSD or just do a mkcephfs again with a second 
> OSD in the configuration.
> 
> Just a reminder, it's also in the docs, but CephFS is still in beta, so 
> expect weird things to happen. It can however not hurt to play with it!
> 
> P.S.: There's also a new and shiny ceph-users list since two days ago, 
> might want to subscribe there.
> 
> Wido
> 
> > > Also, which version of Ceph are you using under which OS?
> > 
> > The latest stable Debian release from ceph.com (http://ceph.com) (bobtail AFAIK).
> > 
> > Thanks,
> > Adam.
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> 
> -- 
> Wido den Hollander
> 42on B.V.
> 
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



