From: Sage Weil <sage@newdream.net>
Subject: Re: sync Ceph 0.37 with Debian
Date: Tue, 1 Nov 2011 12:59:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1111011258480.20159@cobra.newdream.net>
References: <1320137969.22458.173.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39545 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab1KAT7y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2011 15:59:54 -0400
In-Reply-To: <1320137969.22458.173.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

Hi Laszlo,

Thanks for these.  I committed everything to the wip-debian branch.. can 
you verify they are correct before I merge to master?

Thanks!
sage

On Tue, 1 Nov 2011, Laszlo Boszormenyi wrote:

> Hi all,
> 
> There are some mistakes and difference with Debian packages and your
> work.
> Please add debian/watch (attached).
> libceph packages are renamed to libcephfs , but the related packager
> files are not. The following should fix this:
> git mv debian/libceph1.install debian/libcephfs1.install
> git mv debian/libceph1.postinst debian/libcephfs1.postinst
> git mv debian/libceph1.postrm debian/libcephfs1.postrm
> git mv debian/libceph-dev.install debian/libcephfs-dev.install
> 
> Still on the renames, some conflicts-replaces are needed (attached).
> 
> As I see, the primary VCS location changed to github, state this in
> debian/control as well (attached).
> 
> Either add the logrotate_missingok.patch (attached) or add missingok
> to src/logrotate.conf [1].
> 
> Per policy and multiarch support, Debian packages have to empty their
> dependency_libs in *.la files (attached).
> 
> Thanks,
> Laszlo/GCS
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=645651
> 
