From: Sage Weil <sage@inktank.com>
Subject: Re: mkcephfs error: cannot remove `/var/lib/ceph/osd/ceph-0'
Date: Fri, 8 Feb 2013 20:55:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302082055130.5874@cobra.newdream.net>
References: <kf4gdf$nn4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46670 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760653Ab3BIEz5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 23:55:57 -0500
In-Reply-To: <kf4gdf$nn4$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

On Sat, 9 Feb 2013, Adam Nielsen wrote:
> Hi all,
> 
> I'm trying to set up a test Ceph node, but mkcephfs is failing because it's
> trying to erase my mount point, which it can't do because the disk I want to
> use with Ceph is mounted there.  I finally found some manual installation
> steps in the mkcephfs manpage (I think these really should be included in the
> online docs!) and this is the bit that fails:
> 
> $ mkcephfs --init-local-daemons mon -d /tmp/foo

Not sure if this is the problem, but: you're creating the mon...

> === mon.0 ===
> rm: cannot remove `/var/lib/ceph/osd/ceph-0': Device or resource busy

..but the path is /var/lib/ceph/osd/...?  Did you override the paths in 
your ceph.conf?

sage

> /usr/bin/ceph-mon: error creating monfs: (5) Input/output error
> 2013-02-09 13:17:24.941676 b7358710 -1 store(/var/lib/ceph/osd/ceph-0/)
> MonitorStore::mkfs: failed to remove /var/lib/ceph/osd/ceph-0/: rm returned
> run_cmd(rm): exited with status 1
> 2013-02-09 13:17:24.941746 b7358710 -1 mon.0@-1(probing) e0 store->mkfs failed
> with: (5) Input/output error
> 
> What am I doing wrong?  I am going off the ceph.com docs[1], which says "If
> you are running multiple OSDs per host and one hard disk per OSD, you should
> mount the disk under the OSD data directory (if you haven?t done so already)".
> I am only running one OSD on this host, does this mean I shouldn't mount the
> disk before running mkcephfs?  Won't that just create all the files on the
> wrong disk?
> 
> I'm running Debian Squeeze with the debian-bobtail packages installed as per
> the ceph.com Debian instructions[2].
> 
> Any suggestions?
> 
> Many thanks,
> Adam.
> 
> [1] http://ceph.com/docs/master/rados/deployment/mkcephfs/
> [2] http://ceph.com/docs/master/install/debian/
> 
> P.S. I would've posted on ceph-users except it's not carried on GMane yet.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
