From: Sage Weil <sage@inktank.com>
Subject: Re: A problem with ceph-disk and ceph-deploy
Date: Fri, 25 Oct 2013 10:57:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310251056280.11294@cobra.newdream.net>
References: <CA+8ZFngUzk1_koBBkJjdrRje--0SJ_K0=xZ4SrnTL4GTiBTuKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49453 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab3JYR54 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Oct 2013 13:57:56 -0400
In-Reply-To: <CA+8ZFngUzk1_koBBkJjdrRje--0SJ_K0=xZ4SrnTL4GTiBTuKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "xan.peng" <xanpeng@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 26 Oct 2013, xan.peng wrote:
> Hi all,
> 
> I ran into a little problem when trying ceph-deploy, and I'm wondering
> it's a bug?
> 
> steps:
> 1) ./ceph-deploy -v osd prepare --fs-type ext4
> mon02:sdb:/mnt/cephjournal/journal0
> 2) ./ceph-deploy -v osd activate --fs-type ext4
> mon02:/dev/sdb1:/mnt/cephjournal/journal0
> "ERROR:ceph-disk:Failed to activate" shown.
> 
> solution:
> go to target node, run `ceph-disk -v activate --mark-init sysvinit
> --mount /dev/sdb1`, find that in maybe_mkdir()@/usr/sbin/ceph-disk,
> os.mkdir("/var/lib/ceph/osd/osd-1") is called.
> Right here should we use os.makedirs() instead of os.mkdir()? As
> makedirs will create all intermediate directories but mkdir will not.

You mean /var/lib/ceph/osd didn't already exist?  That directory should be 
created by the package.  I think this has actually come up before but we 
deliberately left it this way because if the directory is missing the 
package is broken or not installed.  What distro are you using?  Is ceph 
installed?

Thanks!
sage

